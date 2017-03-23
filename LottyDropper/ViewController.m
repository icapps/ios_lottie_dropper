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

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

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


@end
