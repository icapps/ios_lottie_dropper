//
//  DropBoxBrowserViewModelSpec.m
//  LottieDropper
//
//  Created by Stefan Adams on 29/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "DropboxBrowserViewModel.h"

@import XCTest;
@import OCMock;
@import Quick;
@import Nimble;

@interface DropBoxBrowserViewModelSpec : QuickSpec

@property (strong, nonatomic) DropboxBrowserViewModel* viewModel;

@end

@implementation DropBoxBrowserViewModelSpec

- (void)spec {
    describe(@"Client", ^{
        it(@"should return the correct client", ^{
            expect(self.viewModel.client).to(beNil());
        });
    });
}

@end

