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

@property (nonatomic, strong)  NSMutableArray<DBFILESMetadata *> *entries;
@property (nonatomic, strong) NSMutableArray<NSString *> *localEntries;

@end

@implementation DropboxBrowserViewModel

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

- (NSMutableArray<DBFILESMetadata *> *)entries {
	if (_entries == nil) {
		_entries = [@[] mutableCopy];
	}
	return  _entries;
}


#pragma mark: - Access Dropbox for Client

- (void)initializeDropboxClient: (void (^)(void)) done  {

	if (self.client == nil) {
		NSLog(@" No Dropbox user client");
		return;
	}
    
    Connectivity *connectivity = [[Connectivity alloc]init];
    if ([connectivity IsConnectionAvailable]) {
        // Internet connection available
        [self fetchDropBoxFiles:done];
    } else {
        NSLog(@"No internet connection available");
        // TODO: - Log message to user "No internet connection available"
        [self fetchLocalFiles];
    }

}

- (void) fetchDropBoxFiles: (void (^)(void)) done {
    [[self.client.filesRoutes listFolder:@""]
     setResponseBlock:^(DBFILESListFolderResult *response, DBFILESListFolderError *routeError, DBRequestError *networkError) {
       
         if (response) {
             [self.entries addObjectsFromArray:response.entries];
             
             // See if there is more to download.
             NSString *cursor = response.cursor;
             BOOL hasMore = [response.hasMore boolValue];
             
             if (hasMore) {
                 NSLog(@"Folder is large enough where we need to call `listFolderContinue:`");
                 
                 [self listFolderContinueWithClient:self.client cursor:cursor];
             } else {
                 NSLog(@"List folder complete.");
                 done();
             }
         } else {
             NSLog(@"%@\n%@\n", routeError, networkError);
             done();
         }
     }];
}

- (void)listFolderContinueWithClient:(DBUserClient *)client cursor:(NSString *)cursor {
	[[client.filesRoutes listFolderContinue:cursor]
	 setResponseBlock:^(DBFILESListFolderResult *response, DBFILESListFolderContinueError *routeError,
						DBRequestError *networkError) {
		 if (response) {
			 [self.entries addObjectsFromArray:response.entries];

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

- (void) fetchLocalFiles {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *outputDirectory = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    NSError *error;
    NSArray *directoryContent = [fileManager contentsOfDirectoryAtPath:outputDirectory.path error:&error];
    // Create file for each content in the directoryContent and add it to the entries.
    for (NSString *content in directoryContent) {
        DBFILESMetadata * file = [[DBFILESMetadata alloc]initWithName:content];
        [self.entries addObject:file];
    }
    NSLog(@"Displaying entries: %@", self.entries);
}

#pragma mark: - File info

- (NSArray<DropboxDetailViewModel *> *)fileDetails {
	NSMutableArray <DropboxDetailViewModel *> *mapped = [NSMutableArray arrayWithCapacity:[self.entries count]];
	[self.entries enumerateObjectsUsingBlock:^(DBFILESMetadata * file, NSUInteger idx, BOOL *stop) {
		[mapped addObject: [[DropboxDetailViewModel alloc] initWithFile:file client:self.client]];
	}];

	NSComparisonResult (^sortBlock)(id, id) = ^(DropboxDetailViewModel * obj1, DropboxDetailViewModel * obj2)
	{
		return [[obj1 fileName] compare: [obj2 fileName]];
	};
	return [mapped sortedArrayUsingComparator:sortBlock];
}

- (DropboxDetailViewModel* _Nullable) fileDetailAtIndexPath:(NSIndexPath*) indexPath {
	if (indexPath.row > self.fileDetails.count) {
		return nil;
	}

	return self.fileDetails[indexPath.row];
}

@end
