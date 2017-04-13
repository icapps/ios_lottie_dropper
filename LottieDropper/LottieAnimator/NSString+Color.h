//
//  NSString+Color.h
//  LottieDropper
//
//  Created by Stefan Adams on 13/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Color)

- (UIColor *)colorFromHex;
- (BOOL) verifyHex;

@end
