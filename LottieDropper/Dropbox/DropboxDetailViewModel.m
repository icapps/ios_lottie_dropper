//
//  DropboxDetailViewModel.m
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "DropboxDetailViewModel.h"
@import ObjectiveDropboxOfficial;

@implementation DropboxDetailViewModel

-(instancetype)initWithFile: (DBFILESMetadata *) file {
	self = [super init];
	if (self) {
		self.file = file;
	}
	return  self;
}

#pragma mark:- Display Info

-(NSString *)fileName {
	return self.file.name;
}

@end
