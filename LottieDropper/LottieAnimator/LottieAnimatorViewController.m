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
#import "UIColor+Hex.h"
#import "NSString+Color.h"
#import "LottieAnimatorDetailViewModel.h"
#import "DropboxDetailViewModel.h"

@import Lottie;

@interface LottieAnimatorViewController ()
@property (strong, nonatomic) LOTAnimationView *animation;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) LottieAnimatorDetailViewModel * viewModel;
@property (strong, nonatomic) DropboxDetailViewModel * dropboxViewModel;

// Color picker
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorViewTopConstraint;
@property (weak, nonatomic) IBOutlet NKOColorPickerView *colorPickerView;
@property (weak, nonatomic) IBOutlet UIView *colorPickerBackgroundView;
@property (weak, nonatomic) IBOutlet UITextField *hexTextfield;
@property (assign) BOOL isColorPickerOpen;

#pragma mark: Toolbar buttons
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *playButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loopButton;

@end

@implementation LottieAnimatorViewController

#pragma mark: viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[LottieAnimatorDetailViewModel alloc] init];
    self.dropboxViewModel = [[DropboxDetailViewModel alloc] init];
    
	NSLog(@"Animating file %@", self.dropboxDetail.fileName );
	[self.dropboxDetail downloadFile:^{
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self loadAnimation];
		}];
	}];
    
    self.colorPickerView.didChangeColorBlock = ^(UIColor *color){
        self.hexTextfield.text = [color hex];
        self.view.backgroundColor = color;
        [self.viewModel updateBackgroundColorForFile:self.dropboxDetail.fileName withHex:[color hex]];
    };
    
    [self setupUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.dropboxViewModel uploadDropBoxFileWithFileName:self.dropboxDetail.fileName];
}

#pragma mark: Setup UI

- (void) setupUI {
    self.hexTextfield.delegate = self;
    self.colorPickerBackgroundView.layer.cornerRadius = 10;
    [self setColorFromHexText:[self.viewModel getBackgroundColorHexFromFile:self.dropboxDetail.fileName]];
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

- (void)setColorFromHexText:(NSString*)hexText {
    if ([hexText verifyHex]) {
        UIColor *hexColor = [hexText colorFromHex];
        [self.colorPickerView setColor:hexColor];
    } else {
        NSLog(@"This isn't a valid hex string.");
    }
}

#pragma mark: Textfield delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self setColorFromHexText:self.hexTextfield.text];
    [self.hexTextfield resignFirstResponder];
    return true;
}

@end
