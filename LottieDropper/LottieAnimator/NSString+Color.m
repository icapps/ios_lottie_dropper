//
//  NSString+Color.m
//  LottieDropper
//
//  Created by Stefan Adams on 13/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "NSString+Color.h"

@implementation NSString (Color)

- (UIColor *)colorFromHex {
    NSString *colorString = [[self stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    
    NSLog(@"colorString :%@",colorString);
    CGFloat alpha, red, blue, green;
    
    // #RGB
    alpha = 1.0f;
    red   = [self colorComponentFrom: colorString start: 0 length: 2];
    green = [self colorComponentFrom: colorString start: 2 length: 2];
    blue  = [self colorComponentFrom: colorString start: 4 length: 2];
    
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

- (BOOL) verifyHex {
    NSString *hexRegex = @"^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$";
    NSPredicate *regexCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", hexRegex];
    
    if ([regexCheck evaluateWithObject: self]){
        return true;
    } else {
        return false;
    }
}

@end
