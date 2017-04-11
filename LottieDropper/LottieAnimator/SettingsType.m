//
//  SettingsType.m
//  LottieDropper
//
//  Created by Stefan Adams on 11/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "SettingsType.h"

@implementation SettingsType

- (instancetype) initWithTitle: (NSString*)title andSubtitle: (NSString*)subtitle {
    self = super.init;
    
    if (self) {
        self.title = title;
        self.subtitle = subtitle;
    }
    
    return self;
}

@end
