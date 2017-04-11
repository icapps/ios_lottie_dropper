//
//  SettingsTableViewCell.h
//  LottieDropper
//
//  Created by Stefan Adams on 11/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsType.h"

@interface SettingsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

- (void)configureCellFor:(SettingsType*)settingsType;

@end
