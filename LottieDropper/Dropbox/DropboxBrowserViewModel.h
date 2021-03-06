//
//  DropboxBrowserViewModel.h
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@import ObjectiveDropboxOfficial;

@class DropboxDetailViewModel;
@class DBFILESMetadata;

#pragma mark: - Access Dropbox for Client

/// If a client has been authorized the client stored in the keychain will be loaded to load files from a folder
/// If a client is provided then that client will be used.
@interface DropboxBrowserViewModel : NSObject

@property (nonatomic, strong) DBUserClient * client;

- (void)initializeDropboxClient: (void (^)(void)) done;

#pragma mark: - File info

@property (nonatomic, strong) NSMutableArray <DropboxDetailViewModel*> * fileDetails;

- (DropboxDetailViewModel* _Nullable) fileDetailAtIndexPath:(NSIndexPath*) indexPath;

- (void) sort;

#pragma mark: - Local Files

- (NSArray <NSString *> *) fetchFilenamesFromOutputDirectory;
-(void) setupFileDetailsFromLocalFilenames;

#pragma mark: - Dropbox
@property (nonatomic, strong)  NSMutableArray<DBFILESMetadata *> *dropboxFileCache;

- (void) fetchDropBoxFiles: (void (^)(void)) done;
- (void) mergeDropboxFileListWithFileDetails;

@end

NS_ASSUME_NONNULL_END
