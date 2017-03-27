//
//  DropBoxBrowserViewController.m
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "DropBoxBrowserViewController.h"
#import "LottieDropper-Swift.h"

@import ObjectiveDropboxOfficial;

@interface DropBoxBrowserViewController ()

@end

@implementation DropBoxBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
		// Initialize with manually retrieved auth token
	NSString * accessToken = LottieDropperKeyChainBridge.shared.dropBoxAccessToken.accessToken;
	if (accessToken != nil) {
		DBUserClient *client = [[DBUserClient alloc] initWithAccessToken: accessToken];

		[[client.filesRoutes listFolder:@""]
		 setResponseBlock:^(DBFILESListFolderResult *response, DBFILESListFolderError *routeError, DBRequestError *networkError) {
			 if (response) {
				 NSArray<DBFILESMetadata *> *entries = response.entries;
				 NSString *cursor = response.cursor;
				 BOOL hasMore = [response.hasMore boolValue];

				 [self printEntries:entries];

				 if (hasMore) {
					 NSLog(@"Folder is large enough where we need to call `listFolderContinue:`");

					 [self listFolderContinueWithClient:client cursor:cursor];
				 } else {
					 NSLog(@"List folder complete.");
				 }
			 } else {
				 NSLog(@"%@\n%@\n", routeError, networkError);
			 }
		 }];


	}
}

- (void)listFolderContinueWithClient:(DBUserClient *)client cursor:(NSString *)cursor {
	[[client.filesRoutes listFolderContinue:cursor]
	 setResponseBlock:^(DBFILESListFolderResult *response, DBFILESListFolderContinueError *routeError,
						DBRequestError *networkError) {
		 if (response) {
			 NSArray<DBFILESMetadata *> *entries = response.entries;
			 NSString *cursor = response.cursor;
			 BOOL hasMore = [response.hasMore boolValue];

			 [self printEntries:entries];

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

- (void)printEntries:(NSArray<DBFILESMetadata *> *)entries {
	for (DBFILESMetadata *entry in entries) {
		if ([entry isKindOfClass:[DBFILESFileMetadata class]]) {
			DBFILESFileMetadata *fileMetadata = (DBFILESFileMetadata *)entry;
			NSLog(@"File data: %@\n", fileMetadata);
		} else if ([entry isKindOfClass:[DBFILESFolderMetadata class]]) {
			DBFILESFolderMetadata *folderMetadata = (DBFILESFolderMetadata *)entry;
			NSLog(@"Folder data: %@\n", folderMetadata);
		} else if ([entry isKindOfClass:[DBFILESDeletedMetadata class]]) {
			DBFILESDeletedMetadata *deletedMetadata = (DBFILESDeletedMetadata *)entry;
			NSLog(@"Deleted data: %@\n", deletedMetadata);
		}
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
