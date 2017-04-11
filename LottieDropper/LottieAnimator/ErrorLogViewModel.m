//
//  ErrorLogViewModel.m
//  LottieDropper
//
//  Created by Ben Algoet on 11/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "ErrorLogViewModel.h"

@implementation ErrorLogViewModel

-(NSString *)fileContents {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSString *fileName =[NSString stringWithFormat:@"%@.log",@"LottieConsole"];
    NSString *logFilePath = [libraryDirectory stringByAppendingPathComponent:fileName];
    
    NSError* error;
    NSString *fileContents = [NSString stringWithContentsOfFile:logFilePath encoding:NSUTF8StringEncoding error:&error];

    return [self filterLogfrom:fileContents];
}

- (NSString *) filterLogfrom: (NSString *) fileContents {
    NSArray <NSString *> * newLineFileContents = [fileContents componentsSeparatedByString:@"\n"];
    NSMutableArray <NSString *> * allWarningFileContents = [[NSMutableArray alloc] init]; 
    
    NSString * stringToCompare = @"LOT";
    NSArray * filteredFileContents = [newLineFileContents filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSString *object, NSDictionary<NSString *,id> *bindings) {
        return [object containsString:stringToCompare];
    }]];
    
    for (NSString *filteredFileContent in filteredFileContents) {
        NSString *warningLog = [[filteredFileContent componentsSeparatedByString:@"Warning:"] objectAtIndex:1];
        
        if (warningLog != nil) {
            [allWarningFileContents addObject:warningLog];
        }
    }
    
    NSLog(@"%@", filteredFileContents);
    
    return [allWarningFileContents componentsJoinedByString:@"\n"];
}

@end
