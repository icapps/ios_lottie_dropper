//
//  SettingsTableViewCell.m
//  LottieDropper
//
//  Created by Stefan Adams on 11/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "SettingsTableViewCell.h"


@implementation SettingsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellFor:(SettingsType*)settingsType {
    self.titleLabel.text = settingsType.title;
    self.subtitleLabel.text = settingsType.subtitle;
}

@end
