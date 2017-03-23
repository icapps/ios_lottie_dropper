//
//  ViewController.m
//  LottyDropper
//
//  Created by Stijn Willems on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "ViewController.h"

@import ObjectiveDropboxOfficial;

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Dropbox actions

- (IBAction)grantDroboxAccess:(UIButton *)sender {
	[DBClientsManager authorizeFromController:[UIApplication sharedApplication]
								   controller:self
									  openURL:^(NSURL *url) {
										  [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
											  if (success) {

											  }
										  }];
									  }
								  browserAuth:YES];
}

#pragma mark - DropboxLoginable

- (void)proceed {
	[self performSegueWithIdentifier:@"dropbox success" sender:self];
}

- (void)failWithError:(NSError *)error {
	NSLog(@"%@", error);
}

@end
