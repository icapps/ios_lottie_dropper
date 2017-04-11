//
//  SettingsViewModel.h
//  LottieDropper
//
//  Created by Stefan Adams on 11/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsType.h"

@interface SettingsViewModel : NSObject

@property (strong, nonatomic) NSString * _Nullable hexColor;
@property (strong, nonatomic) NSArray <SettingsType*> * _Nullable settingsTypes;

- (SettingsType * _Nullable) settingsTypeforIndexPath: (NSIndexPath*_Nonnull)indexPath;
- (NSInteger) numberOfRows;

@end
