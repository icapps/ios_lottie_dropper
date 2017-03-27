//
//  DropboxBrowserCollectionViewCell.m
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "DropboxBrowserCollectionViewCell.h"

@interface DropboxBrowserCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation DropboxBrowserCollectionViewCell

- (void)setup: (NSString * _Nonnull) name {
	self.label.text = name;
}

@end
