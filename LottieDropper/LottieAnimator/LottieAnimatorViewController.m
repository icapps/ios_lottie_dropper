//
//  LottieAnimatorViewController.m
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "LottieAnimatorViewController.h"
#import "DropboxDetailViewModel.h"
#import "UIColor+LottieColors.h"
#import "NKOColorPickerView.h"

@import Lottie;

@interface LottieAnimatorViewController ()
@property (strong, nonatomic) LOTAnimationView *animation;
@property (weak, nonatomic) IBOutlet UISlider *slider;

// Color picker
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorViewTopConstraint;
@property (weak, nonatomic) IBOutlet NKOColorPickerView *colorPickerView;
@property (weak, nonatomic) IBOutlet UIView *colorPickerBackgroundView;
@property (weak, nonatomic) IBOutlet UITextField *hexTextfield;
@property (assign) BOOL isColorPickerOpen;
@property (strong, nonatomic) UIColor *savedColor;

#pragma mark: Toolbar buttons
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *playButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loopButton;

@end

@implementation LottieAnimatorViewController

#pragma mark: viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
   
	NSLog(@"Animating file %@", self.dropboxDetail.fileName );
	[self.dropboxDetail downloadFile:^{
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self loadAnimation];
		}];
	}];
    
    self.colorPickerView.didChangeColorBlock = ^(UIColor *color){
        self.hexTextfield.text = [self hexStringFromColor:color];
        self.view.backgroundColor = color;
    };
    
    [self setupUI];
}

#pragma mark: Setup UI

- (void) setupUI {
    self.colorPickerBackgroundView.layer.cornerRadius = 10;
    [self.colorPickerView setColor:UIColor.whiteColor];
}

#pragma mark: Toolbar actions

- (IBAction)playOrPauseAnimation:(id)sender {
    if ([self.animation isAnimationPlaying]) {
        [self.animation pause];
    } else {
        [self startAnimation];
    }
    [self changePlayButtonForState: [self.animation isAnimationPlaying]];
}

- (IBAction)loop:(id)sender {
    self.animation.loopAnimation = !self.animation.loopAnimation;
    if (self.animation.loopAnimation) {
        self.loopButton.tintColor = [UIColor sapGreenColor];
    } else {
        self.loopButton.tintColor = [UIColor deepSkyBlueColor];
    }
}

- (IBAction)progressValueChanged:(UISlider *)sender {
    self.animation.animationProgress = sender.value;
    [self changePlayButtonForState: [self.animation isAnimationPlaying]];
}

- (IBAction)openOrCloseColorPicker:(id)sender {
    if (self.isColorPickerOpen) {
        [self shouldOpenColorPicker:false];
    } else {
        [self shouldOpenColorPicker:true];
    }
}

#pragma mark: Load & start animation

- (void) loadAnimation {

	if (self.dropboxDetail.json != nil) {
		_animation = [LOTAnimationView animationFromJSON:self.dropboxDetail.json];
		_animation.translatesAutoresizingMaskIntoConstraints = NO;

        [self.view insertSubview:self.animation belowSubview:self.colorPickerBackgroundView];

		[[[self.animation centerXAnchor] constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
		[[[self.animation centerYAnchor] constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];

        [self startAnimation];
	} else {
		NSLog(@"LottieAnimatorViewController needs a file before animating");
	}

}

- (void) startAnimation {
    [self resetSliderIfNeeded];
    [self.animation playWithCompletion:^(BOOL animationFinished) {
        self.slider.value = self.animation.animationProgress;
        [self changePlayButtonForState:!animationFinished];
    }];
    [self changePlayButtonForState: [self.animation isAnimationPlaying]];
}

- (void) resetSliderIfNeeded {
    if (self.slider.value == self.slider.maximumValue) {
        self.slider.value = 0;
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

#pragma mark: Color Picker.

- (void)shouldOpenColorPicker: (BOOL)shouldOpen {
    if (shouldOpen) {
        self.isColorPickerOpen = true;
        self.colorViewTopConstraint.constant = -302;
        
        [UIView animateWithDuration:0.35 animations:^{
            [self.view layoutIfNeeded];
        }];
    } else {
        self.isColorPickerOpen = false;
        self.colorViewTopConstraint.constant = 0;
        
        [UIView animateWithDuration:0.35 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
}

@end
