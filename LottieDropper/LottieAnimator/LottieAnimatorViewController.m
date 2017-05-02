//
//  LottieAnimatorViewController.m
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "LottieAnimatorViewController.h"
#import "DropboxDetailViewModel.h"

@import Lottie;

@interface LottieAnimatorViewController ()

@end

@implementation LottieAnimatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	NSLog(@"Animating file %@", self.dropboxDetail.fileName );

	[self.dropboxDetail downloadFile:^{
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self loadAnimation];
		}];
	}];

}

- (void) loadAnimation {

	if (self.dropboxDetail.json != nil) {
		LOTAnimationView *animation = [LOTAnimationView animationFromJSON:self.dropboxDetail.json];
		animation.translatesAutoresizingMaskIntoConstraints = NO;

		[self.view addSubview:animation];

		[[[animation centerXAnchor] constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
		[[[animation centerYAnchor] constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];


		[animation playWithCompletion:^(BOOL animationFinished) {
				// Do Something
		}];

	} else {
		NSLog(@"LottieAnimatorViewController needs a file before animating");
	}


}

@end
