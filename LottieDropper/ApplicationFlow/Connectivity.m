//
//  Connectivity.m
//  LottieDropper
//
//  Created by Ben Algoet on 30/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "Connectivity.h"

@implementation Connectivity

- (BOOL) IsConnectionAvailable {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    return !(networkStatus == NotReachable);
}

@end
