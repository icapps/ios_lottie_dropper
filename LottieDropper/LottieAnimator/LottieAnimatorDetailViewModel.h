//
//  LottieAnimatorDetailViewModel.h
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LottieAnimatorDetailViewModel : NSObject

- (void)updateBackgroundColorForFile:(NSString*)fileName withHex:(NSString*)hex;
- (NSString *)getBackgroundColorHexFromFile: (NSString*)fileName;

@end
