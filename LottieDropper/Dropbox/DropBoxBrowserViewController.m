//
//  DropBoxBrowserViewController.m
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "DropBoxBrowserViewController.h"
#import "LottieDropper-Swift.h"
#import "DropboxBrowserViewModel.h"

@import ObjectiveDropboxOfficial;

@interface DropBoxBrowserViewController ()


@end

@implementation DropBoxBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.browserViewModel = [[DropboxBrowserViewModel alloc] init];
	[self.browserViewModel initializeDropboxClient:^{
		NSLog(@"Client has files %@", self.browserViewModel.fileNames);
	}];
}

@end
