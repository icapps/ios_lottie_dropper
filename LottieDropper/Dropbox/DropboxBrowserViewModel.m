//
//  DropboxBrowserViewModel.m
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "DropboxBrowserViewModel.h"
#import "LottieDropper-Swift.h"
#import "DropboxDetailViewModel.h"

@import Stella;

@interface DropboxBrowserViewModel ()

	// Dropbox file cache
@property (nonatomic, strong)  NSMutableArray<DBFILESMetadata *> *dropboxFileCache;

@property (readonly) NSArray <NSString*> * detailFileNames;

@property (nonatomic, strong) NSMutableArray<NSString *> *localEntries;

@property (readonly) NSURL *outputDirectory;
@property (readonly) NSFileManager *fileManager;

@end

@implementation DropboxBrowserViewModel

-(NSMutableArray<DropboxDetailViewModel *> *)fileDetails {
	if (_fileDetails == nil) {
		_fileDetails = [@[] mutableCopy];
	}
	return _fileDetails;
}

-(NSFileManager *)fileManager {
	return [NSFileManager defaultManager];
}

-(NSURL *)outputDirectory {
	return [self.fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
}

- (DBUserClient *)client {
	if (_client == nil) {
		NSString * accessToken = LottieDropperKeyChainBridge.shared.dropBoxAccessToken.accessToken;
		if (accessToken != nil) {
			_client = [[DBUserClient alloc] initWithAccessToken: accessToken];
		} else {
			NSLog(@" No Dropbox user client");
		}
	}
	return _client;
}

- (NSMutableArray<DBFILESMetadata *> *)dropboxFileCache {
	if (_dropboxFileCache == nil) {
		_dropboxFileCache = [@[] mutableCopy];
	}
	return  _dropboxFileCache;
}

-(NSArray<NSString *> *)detailFileNames {
	NSArray <DropboxDetailViewModel*> * dropboxDetails = [self fileDetails];

	NSMutableArray <NSString*> * dropboxFileList = [NSMutableArray arrayWithCapacity:[dropboxDetails count]] ;
	[self.dropboxFileCache enumerateObjectsUsingBlock:^(DBFILESMetadata * file, NSUInteger idx, BOOL *stop) {
		[dropboxFileList addObject: [[DropboxDetailViewModel alloc] initWithFile:file client:self.client].fileName.lowercaseString];
	}];
	return  dropboxFileList;
}


#pragma mark: - Access Dropbox for Client

- (void)initializeDropboxClient: (void (^)(void)) done  {

	if (self.client == nil) {
		NSLog(@" No Dropbox user client");
		return;
	}

	[self addDetailsFromLocalFiles];

	[self sort];
	done();

	[self fetchDropBoxFiles:^{
		[self sort];
		done();
	}];

}

- (void) sort {
	NSComparisonResult (^sortBlock)(id, id) = ^(DropboxDetailViewModel * obj1, DropboxDetailViewModel * obj2)
	{
	return [[obj1 fileName] compare: [obj2 fileName]];
	};
	[self.fileDetails sortUsingComparator:sortBlock];
}

- (void) fetchDropBoxFiles: (void (^)(void)) done {

	Connectivity *connectivity = [[Connectivity alloc]init];

		//2. Update from dropbox if needed
	if ([connectivity IsConnectionAvailable]) {
		[[self.client.filesRoutes listFolder:@""]
		 setResponseBlock:^(DBFILESListFolderResult *response, DBFILESListFolderError *routeError, DBRequestError *networkError) {

			 if (response) {
				 [self.dropboxFileCache addObjectsFromArray:response.entries];

					 // See if there is more to download.
				 NSString *cursor = response.cursor;
				 BOOL hasMore = [response.hasMore boolValue];

				 if (hasMore) {
					 NSLog(@"Folder is large enough where we need to call `listFolderContinue:`");

					 [self listFolderContinueWithClient:self.client cursor:cursor];
				 } else {
					 NSLog(@"List folder complete.");
					 [self addDetailsFromDropboxFileCache];

					// save empty files if needed.
					 NSArray <NSString *>* newFiles = [self getNewFiles];

					 if (newFiles.count != 0) {
						 for (NSString * filePath in newFiles) {
							 NSURL * url = [self.outputDirectory URLByAppendingPathComponent:filePath];
							 [self.fileManager createFileAtPath:url.path contents:nil attributes:nil];
						 }

						 [self addDetailsFromLocalFiles];
					 }
					 done();
				 }
			 } else {
				 NSLog(@"%@\n%@\n", routeError, networkError);
				 done();
			 }
		 }];
	} else {
		NSLog(@"No internet connection available");
	}

}

- (NSArray <NSString *>*)getNewFiles {
	NSArray <NSString*> * localFileList = [self fetchLocalFiles];

	NSMutableArray <NSString*>* newFiles = [@[] mutableCopy];
	NSArray <NSString*> *dropboxFileNames = self.detailFileNames;

	for (NSString *dropboxFileName in dropboxFileNames) {
		if (![localFileList containsObject:dropboxFileName]) {
			[newFiles addObject:dropboxFileName];
		}
	}

	return newFiles;
}

- (void)listFolderContinueWithClient:(DBUserClient *)client cursor:(NSString *)cursor {
	[[client.filesRoutes listFolderContinue:cursor]
	 setResponseBlock:^(DBFILESListFolderResult *response, DBFILESListFolderContinueError *routeError,
						DBRequestError *networkError) {
		 if (response) {
			 [self.dropboxFileCache addObjectsFromArray:response.entries];

			 NSString *cursor = response.cursor;
			 BOOL hasMore = [response.hasMore boolValue];

			 if (hasMore) {
				 [self listFolderContinueWithClient:client cursor:cursor];
			 } else {
				 NSLog(@"List folder complete.");
			 }
		 } else {
			 NSLog(@"%@\n%@\n", routeError, networkError);
		 }
	 }];
}

#pragma mark: - Fetch local files

- (NSArray <NSString *> *) fetchLocalFiles {

    NSError *error;
    NSArray <NSString*> * list = [self.fileManager contentsOfDirectoryAtPath:self.outputDirectory.path error:&error];
	if (error == nil) {
		return list;
	} else {
		NSLog(@"%@", error);
		return  nil;
	}
}

-(void) addDetailsFromLocalFiles {
	NSArray <NSString*> * localFilelist = [self fetchLocalFiles];

	for (NSString * file in localFilelist) {
		if (![self.detailFileNames containsObject:file]) {
			[self.fileDetails addObject:[[DropboxDetailViewModel alloc] initWithLocalFile:file client:self.client]];
		}
	}

}

#pragma mark: - File info

- (void)addDetailsFromDropboxFileCache {
	[self.dropboxFileCache enumerateObjectsUsingBlock:^(DBFILESMetadata * file, NSUInteger idx, BOOL *stop) {
		DropboxDetailViewModel * detail = [[DropboxDetailViewModel alloc] initWithFile:file client:self.client];
		if (![self.detailFileNames containsObject:detail.fileName]) {
			[self.fileDetails addObject: detail];
		}
	}];

}

- (DropboxDetailViewModel* _Nullable) fileDetailAtIndexPath:(NSIndexPath*) indexPath {
	if (indexPath.row > self.fileDetails.count) {
		return nil;
	}

	return self.fileDetails[indexPath.row];
}



@end
