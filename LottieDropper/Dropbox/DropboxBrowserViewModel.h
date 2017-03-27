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

	/// If a client has been
@interface DropboxBrowserViewModel : NSObject

@property (nonatomic, strong) DBUserClient * client;

- (void)initializeDropboxClient: (void (^)(void)) done;

- (NSArray <NSString*> *) fileNames;

@end

NS_ASSUME_NONNULL_END
