#import "AppDelegate.h"
#import "DropboxLoginable.h"
#import "LottieDropper-Swift.h"

@import ObjectiveDropboxOfficial;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[DBClientsManager setupWithAppKey:@"eymfhqfru153aws"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES);
    // TODO: fix library to documents?
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSString *fileName =[NSString stringWithFormat:@"%@.log",@"LottieConsole"];
    NSString *logFilePath = [libraryDirectory stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    
    if ([fileManager fileExistsAtPath:logFilePath]) {
        NSError *error;
        [fileManager removeItemAtPath:logFilePath error:&error];
    }
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
    
	return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
	DBOAuthResult *authResult = [DBClientsManager handleRedirectURL:url];
	if (authResult != nil) {
		if ([authResult isSuccess]) {

			LottieDropperKeyChainBridge.shared.dropBoxAccessToken = authResult.accessToken;

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
