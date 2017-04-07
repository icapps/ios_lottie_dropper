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

#pragma mark: - Access Dropbox for Client

- (void)initializeDropboxClient: (void (^)(void)) done  {

	if (self.client == nil) {
		NSLog(@" No Dropbox user client");
		return;
	}

	[self setupFileDetailsFromLocalFilenames];
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
                 self.dropboxFileCache = [response.entries mutableCopy];

					 // See if there is more to download.
				 NSString *cursor = response.cursor;
				 BOOL hasMore = [response.hasMore boolValue];

				 if (hasMore) {
					 NSLog(@"Folder is large enough where we need to call `listFolderContinue:`");

					 [self listFolderContinueWithClient:self.client cursor:cursor];
				 } else {
					 NSLog(@"List folder complete.");
                     [self setupFileDetailsFromLocalFilenames];
					 [self mergeDropboxFileListWithFileDetails];
					 
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

/// Makes list of file names from the outputDirectory
- (NSArray <NSString *> *) fetchFilenamesFromOutputDirectory {

    NSError *error;
    // TODO: filter out hidden filenames
    NSArray <NSString*> * list = [self.fileManager contentsOfDirectoryAtPath:self.outputDirectory.path error:&error];
	if (error == nil) {
		return list;
	} else {
		NSLog(@"%@", error);
		return  nil;
	}
}

/// 1. Load local file names
/// 2. Use file names to fill the fileDetails list
-(void) setupFileDetailsFromLocalFilenames {
	NSArray <NSString*> * localFilelist = [self fetchFilenamesFromOutputDirectory];

	for (NSString * fileName in localFilelist) {
		if ( ![fileName hasPrefix:@"."] && ![self fileDetailsContainsFileName:fileName]) {
			[self.fileDetails addObject:[[DropboxDetailViewModel alloc] initWithLocalFile:fileName client:self.client]];
		}
	}

}

#pragma mark: - File info

// 1. Iterates over all DBFILESMetadata received from Dropbox
// 2. Makes fileDetails if file not already loaded from local calls
// 3. Remove files not on dropbox
// 4. Add empty files for all dropbox files
- (void) mergeDropboxFileListWithFileDetails {
    
    // 1.
    [self.dropboxFileCache enumerateObjectsUsingBlock:^(DBFILESMetadata * file, NSUInteger idx, BOOL *stop) {
        // 2.
        if (![self fileDetailsContainsFileName:file.name]) {
            DropboxDetailViewModel * detail = [[DropboxDetailViewModel alloc] initWithLocalFile:file.name client:self.client];
            [self.fileDetails addObject: detail];
        }
        
    }];
    
    // 3.
    for (int i = 0; i < self.fileDetails.count; i++) {
        
        if (![self dropboxFileCacheContainsFileName:[self.fileDetails[i] fileName]]) {
            [self removeFileFromOutputDirectoryWithFileName:[self.fileDetails[i] fileName]];
            [self.fileDetails removeObjectAtIndex:i];
        }
    }
    
    //4.
    for (DropboxDetailViewModel * fileDetail in self.fileDetails) {
        if (![self.fileManager fileExistsAtPath: [self.outputDirectory URLByAppendingPathComponent:fileDetail.fileName.lowercaseString].path]) {
            NSURL * url = [self.outputDirectory URLByAppendingPathComponent:fileDetail.fileName.lowercaseString];
            [self.fileManager createFileAtPath:url.path contents:nil attributes:nil];
        }
    }

}

- (void) removeFileFromOutputDirectoryWithFileName: (NSString *) fileName {
    NSError * error;
//    [self.fileManager removeItemAtPath:[self.outputDirectory URLByAppendingPathComponent:fileName.lowercaseString].path error:&error];
    [self.fileManager removeItemAtURL:[self.outputDirectory URLByAppendingPathComponent:fileName.lowercaseString] error:&error];
    if (error != nil) {
        NSLog(@"%@", error);
    }
}

- (BOOL) dropboxFileCacheContainsFileName: (NSString *) fileName {
    for (DBFILESMetadata *dropboxFile in self.dropboxFileCache) {
        if ([dropboxFile.name.lowercaseString isEqualToString:fileName.lowercaseString]) {
            return true;
        }
    }
    return false;
}

- (BOOL) fileDetailsContainsFileName: (NSString *) fileName {
    for (DropboxDetailViewModel *fileDetail in self.fileDetails) {
        if ([fileDetail.fileName.lowercaseString isEqualToString:fileName.lowercaseString]) {
            return true;
        }
    }
    return false;
}

- (DropboxDetailViewModel *) dropboxDetailForFileName: (NSString *) fileName {
    
    for (DropboxDetailViewModel *fileDetail in self.fileDetails) {
        if (fileDetail.fileName == fileName) {
            return fileDetail;
        }
    }
    
    return nil;
}

- (DropboxDetailViewModel* _Nullable) fileDetailAtIndexPath:(NSIndexPath*) indexPath {
	if (indexPath.row > self.fileDetails.count) {
		return nil;
	}

	return self.fileDetails[indexPath.row];
}

@end
