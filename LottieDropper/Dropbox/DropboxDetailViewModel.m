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
	NSURL *outputUrl = [outputDirectory URLByAppendingPathComponent:@"test_file_output.txt"];

	[[[self.client.filesRoutes downloadUrl:self.file.pathLower overwrite:YES destination:outputUrl] setResponseBlock:^(DBFILESFileMetadata * _Nullable response, DBFILESDownloadError * _Nullable routeError, DBRequestError * _Nullable error, NSURL * _Nonnull destination) {
		if (response) {
			NSLog(@"%@\n", response);
			NSData *data = [[NSFileManager defaultManager] contentsAtPath:[destination path]];
			NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
			NSLog(@"%@\n", dataStr);
		} else {
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
