//
//  DropboxDetailViewModel.h
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Connectivity.h"

NS_ASSUME_NONNULL_BEGIN

@class DBFILESMetadata;
@class DBUserClient;

@interface DropboxDetailViewModel : NSObject

-(instancetype)initWithFile: (NSString *) fileName client: (DBUserClient *)client;

#pragma mark: - Display info

@property (nonatomic, strong) NSString *fileName;

#pragma mark: - Dropbox file info

@property (nonatomic, strong, nullable) NSDictionary * json;

- (void) downloadFile:(void (^) (void)) done;

@end

NS_ASSUME_NONNULL_END
