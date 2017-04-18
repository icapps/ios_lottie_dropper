//
//  LottieAnimatorDetailViewModel.m
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "LottieAnimatorDetailViewModel.h"

@implementation LottieAnimatorDetailViewModel

#pragma mark: Update background color in json.

/// Will set a new json file and write it to the correct file in the documents directory.
- (void)updateBackgroundColorForFile:(NSString*)fileName withHex:(NSString*)hex {
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    NSError *error;
    NSString* jsonFileContents = [[NSString alloc] initWithContentsOfFile:fileAtPath encoding:NSUTF8StringEncoding error:&error];
    
    NSString * backgroundColorJSON = [[NSString alloc] initWithFormat:@"{\"backgroundColor\":\"%@\",", hex];
    NSString * newFile = [self replaceOldJson:jsonFileContents withNewJson:backgroundColorJSON];
    
    [[newFile dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
}

/// Replaced the old json file with the new json file.
- (NSString *)replaceOldJson:(NSString*)oldJson withNewJson: (NSString*)newJson {
    NSString * newFile;
    
    if ([oldJson containsString:@"backgroundColor"]) {
        // Overwrite it by selecting the hex range and change it to the new hex
        NSRange range = [newJson rangeOfString:newJson];
        newFile = [oldJson stringByReplacingCharactersInRange: range withString:newJson];
    } else {
        // Write new json data { backgroundColor : #FFFFFF } to the jsonFile.
        if ([oldJson length] != 0) {
            newFile = [oldJson stringByReplacingCharactersInRange: NSMakeRange(0, 1) withString:newJson];
        }
    }
    
    return newFile;
}

- (NSString *)getBackgroundColorHexFromFile: (NSString*)fileName {
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    NSError *error;
    NSString* jsonFileContents = [[NSString alloc] initWithContentsOfFile:fileAtPath encoding:NSUTF8StringEncoding error:&error];
    
    NSString *hex;
    if ([jsonFileContents containsString: @"backgroundColor"]) {
        hex = [jsonFileContents substringWithRange:NSMakeRange(20, 7)];
    } else {
        hex = @"#FFFFFF"; // White color hex
    }

    return hex;
}

@end
