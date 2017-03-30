//
//  DropboxDetailViewModel.m
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "DropboxDetailViewModel.h"

@import ObjectiveDropboxOfficial;

@interface DropboxDetailViewModel ()

@property (nonatomic, strong) DBUserClient * client;

@end

@implementation DropboxDetailViewModel
@synthesize fileOnDisk = _fileOnDisk;
@synthesize json = _json;

-(instancetype)initWithFile: (DBFILESMetadata *) file client: (DBUserClient*) client {
	self = [super init];
	if (self) {
		self.file = file;
		self.client = client;
	}
	return  self;
}

#pragma mark - Dropbox Download

- (void) downloadFile:(void (^) (void)) done {

	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSURL *outputDirectory = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
	_fileOnDisk = [outputDirectory URLByAppendingPathComponent:self.file.pathLower];
    
    if ([fileManager fileExistsAtPath:[_fileOnDisk path]]) {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:[_fileOnDisk path]];
        NSError *error;
        self.json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        done();
    } else {
        [self downloadFileFromService:done];
    }
    
}

- (void) downloadFileFromService: (void (^) (void)) done {
    
    [[[self.client.filesRoutes downloadUrl:self.file.pathLower overwrite:YES destination:self.fileOnDisk] setResponseBlock:^(DBFILESFileMetadata * _Nullable response, DBFILESDownloadError * _Nullable routeError, DBRequestError * _Nullable error, NSURL * _Nonnull destination) {
        if (response) {
            NSData *data = [[NSFileManager defaultManager] contentsAtPath:[destination path]];
            NSError *error;
            self.json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            if (error != nil) {
                NSLog(@"%@", error);
            }
            
        } else {
            _fileOnDisk = nil;
            NSLog(@"%@\n%@\n", routeError, error);
        }
        done();
    }] setProgressBlock:^(int64_t bytesDownloaded, int64_t totalBytesDownloaded, int64_t totalBytesExpectedToDownload) {
        NSLog(@"%lld\n%lld\n%lld\n", bytesDownloaded, totalBytesDownloaded, totalBytesExpectedToDownload);
    }];
    
}

#pragma mark - Display Info

-(NSString *)fileName {
	return self.file.name;
}

@end
