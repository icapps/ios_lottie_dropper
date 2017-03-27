//
//  LottieFlowControllerViewController.m
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "LottieFlowControllerViewController.h"
#import "LottieDropper-Swift.h"
#import "DropboxAccessViewController.h"
#import "DropBoxBrowserViewController.h"

@interface LottieFlowControllerViewController ()

@end

@implementation LottieFlowControllerViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setupFlow];
	}

	return  self;
}

- (void)awakeFromNib {
	[super awakeFromNib];

	[self setupFlow];
}

- (void) setupFlow {
	UIStoryboard * dropboxStoryboard = [UIStoryboard storyboardWithName:@"Dropbox" bundle:[NSBundle mainBundle]];
	DropboxAccessViewController * accessViewController = [dropboxStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([DropboxAccessViewController class])];

	DBAccessToken * token = LottieDropperKeyChainBridge.shared.dropBoxAccessToken;
	if (token == nil) {
		self.viewControllers = @[accessViewController];
	} else {
		DropBoxBrowserViewController * dropboxBrowserViewController = [dropboxStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([DropBoxBrowserViewController class])];
		self.viewControllers = @[accessViewController, dropboxBrowserViewController];
	}

}

@end
