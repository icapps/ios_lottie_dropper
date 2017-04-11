//
//  SettingsType.h
//  LottieDropper
//
//  Created by Stefan Adams on 11/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsType : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;

- (instancetype) initWithTitle: (NSString*)title andSubtitle: (NSString*)subtitle;

@end
