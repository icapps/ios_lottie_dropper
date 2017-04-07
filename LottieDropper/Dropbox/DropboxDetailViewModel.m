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
@property (nonatomic, readonly) NSURL * _Nullable fileOnDisk;

@end

@implementation DropboxDetailViewModel
@synthesize fileOnDisk = _fileOnDisk;
@synthesize json = _json;

-(instancetype)initWithFile: (NSString *) fileName client: (DBUserClient *)client {
	self = [super init];
	if (self) {
		self.fileName = fileName;
		self.client = client;
	}
	return  self;
}

#pragma mark - Dropbox Download

- (void) downloadFile:(void (^) (void)) done {

	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSURL *outputDirectory = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    _fileOnDisk = [outputDirectory URLByAppendingPathComponent:self.fileName];
	
    Connectivity *connectivity = [[Connectivity alloc]init];
    if ([connectivity IsConnectionAvailable]) {
        // Internet connection available
        [self downloadFileFromService:done];
    }
    else {
        // Internet connection unavailable
        NSLog(@"No internet connection available");
        [self checkIfFileExists:fileManager done:done];
    }
}

/// Check if file exists at self.fileOnDisk
- (void) checkIfFileExists: (NSFileManager *) fileManager done:(void (^) (void)) done {
    if ([fileManager fileExistsAtPath:[_fileOnDisk path]]) {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:[_fileOnDisk path]];
        NSError *error;
        self.json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"Using file from disk %@", self.fileName);
        done();
    } else {
        NSLog(@"No file in disk at: %@", self.fileName);
    }
}

- (void) downloadFileFromService: (void (^) (void)) done {
    [[[self.client.filesRoutes downloadUrl:[self downloadURLString] overwrite:YES destination:self.fileOnDisk] setResponseBlock:^(DBFILESFileMetadata * _Nullable response, DBFILESDownloadError * _Nullable routeError, DBRequestError * _Nullable error, NSURL * _Nonnull destination) {
        if (response) {
            NSData *data = [[NSFileManager defaultManager] contentsAtPath:[destination path]];
            NSError *error;
            self.json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"File downloaded!");
            if (error != nil) {
                NSLog(@"%@", error);
            }
        // Error 409: File not found
        // Delete local file when file on server not found or changed
        } else if (error.statusCode.intValue == 409) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSError *error;
            [fileManager removeItemAtPath:self.fileOnDisk.path error:&error];
            _fileOnDisk = nil;
        } else {
            _fileOnDisk = nil;
            NSLog(@"%@\n%@\n", routeError, error);
        }
        done();
    }] setProgressBlock:^(int64_t bytesDownloaded, int64_t totalBytesDownloaded, int64_t totalBytesExpectedToDownload) {
        NSLog(@"%lld\n%lld\n%lld\n", bytesDownloaded, totalBytesDownloaded, totalBytesExpectedToDownload);
    }];
    
}

/// When internet connection is available try using pathLower if it exists.
/// Else use the local file name.
-(NSString *) downloadURLString {
    NSString *URLString = [NSString stringWithFormat:@"/%@", self.fileName];
    return URLString;
}

#pragma mark - Display Info

-(NSString *)capitalizedFileName {
    if ([self.fileName length] != 0) {
        return [NSString stringWithFormat:@"%@%@", [[self.fileName substringToIndex:1] uppercaseString], [self.fileName substringFromIndex:1]];
    } else {
        return @"";
    }
}

-(NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@%@", self, self.fileName];
}

@end
