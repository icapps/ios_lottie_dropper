//
//  UIColor+Hex.m
//  LottieDropper
//
//  Created by Stefan Adams on 13/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

- (NSString *)hex {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
}

@end
