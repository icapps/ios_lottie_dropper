//
//  AppDelegate.m
//  LottyDropper
//
//  Created by Stijn Willems on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "AppDelegate.h"
@import ObjectiveDropboxOfficial;
#import "DropboxLoginable.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[DBClientsManager setupWithAppKey:@"eymfhqfru153aws"];
	return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
	DBOAuthResult *authResult = [DBClientsManager handleRedirectURL:url];
	if (authResult != nil) {
		if ([authResult isSuccess]) {

			if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
				UINavigationController * nav = (UINavigationController *) self.window.rootViewController;
				if ([[nav.topViewController class] conformsToProtocol:@protocol(DropboxLoginable)]) {
					[nav.topViewController performSelector:@selector(proceed)];
				}
			}
			NSLog(@"Success! User is logged into Dropbox.");
		} else if ([authResult isCancel]) {
			NSLog(@"Authorization flow was manually canceled by user!");
		} else if ([authResult isError]) {
			NSLog(@"Error: %@", authResult);
		}
	}
	return NO;
}

@end
