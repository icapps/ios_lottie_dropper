//
//  SettingsViewModel.m
//  LottieDropper
//
//  Created by Stefan Adams on 11/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "SettingsViewModel.h"
#import "SettingsType.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@implementation SettingsViewModel

#pragma mark: SettingsTypes

- (SettingsType *) backgroundColor {
    return [[SettingsType alloc] initWithTitle:@"Background color" andSubtitle: self.hexColor];
}

- (NSArray<SettingsType *> *)settingsTypes {
    _settingsTypes = [[NSArray alloc] initWithObjects: [self backgroundColor], nil];
    return _settingsTypes;
}

#pragma mark: TableView

- (SettingsType * _Nullable) settingsTypeforIndexPath: (NSIndexPath*)indexPath {
    return self.settingsTypes[indexPath.row];
}

- (NSInteger) numberOfRows {
    return self.settingsTypes.count;
}

@end
