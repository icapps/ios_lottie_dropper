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
@property (strong, nonatomic) LOTAnimationView *animation;

#pragma mark: Toolbar buttons
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *playButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loopButton;

@end

@implementation LottieAnimatorViewController

- (IBAction)playOrPauseAnimation:(id)sender {
    if ([self.animation isAnimationPlaying]) {
        [self.animation pause];
    } else {
        [self.animation playWithCompletion:^(BOOL animationFinished) {
            [self changePlayButtonForState:!animationFinished];
        }];
    }
    
    [self changePlayButtonForState: [self.animation isAnimationPlaying]];
}

- (IBAction)loop:(id)sender {
    self.animation.loopAnimation = !self.animation.loopAnimation;
    if (self.animation.loopAnimation) {
        self.loopButton.tintColor = [UIColor colorWithRed:50.f/255.f
                                                    green:207.f/255.f
                                                     blue:193.f/255.f
                                                    alpha:1.f];

    } else {
        self.loopButton.tintColor = [UIColor colorWithRed:0.f/255.f
                                                    green:122.f/255.f
                                                     blue:255.f/255.f
                                                    alpha:1.f];

    }
}

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
		_animation = [LOTAnimationView animationFromJSON:self.dropboxDetail.json];
		_animation.translatesAutoresizingMaskIntoConstraints = NO;

		[self.view addSubview:self.animation];

		[[[self.animation centerXAnchor] constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
		[[[self.animation centerYAnchor] constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
        
        [self.animation playWithCompletion:^(BOOL animationFinished) {
            [self changePlayButtonForState:!animationFinished];
        }];
	} else {
		NSLog(@"LottieAnimatorViewController needs a file before animating");
	}


}

/// Changes the default playButton between pause and play item based on isPlaying.
- (void) changePlayButtonForState: (BOOL) isPlaying {
     NSMutableArray *toolbarButtons = [[self.toolbar items] mutableCopy];
    
    if (isPlaying) {
        _playButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(playOrPauseAnimation:)];
    } else {
        _playButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(playOrPauseAnimation:)];
    }
    
    [toolbarButtons removeObjectAtIndex:4];
    [toolbarButtons insertObject:self.playButton atIndex:4];
    [self.toolbar setItems:toolbarButtons];
}

@end
