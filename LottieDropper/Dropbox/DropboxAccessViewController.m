#import "DropboxAccessViewController.h"
#import "LottieDropper-Swift.h"

@import ObjectiveDropboxOfficial;

@interface DropboxAccessViewController ()

@end

@implementation DropboxAccessViewController

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

#pragma mark - Exit application to allow acces again

- (IBAction)exitToDropboxAccesWithLogout:(UIStoryboardSegue *)segue {
	LottieDropperKeyChainBridge.shared.dropBoxAccessToken = nil;
}

@end
