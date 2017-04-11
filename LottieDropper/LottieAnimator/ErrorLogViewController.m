//
//  ErrorLogViewController.m
//  LottieDropper
//
//  Created by Ben Algoet on 11/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "ErrorLogViewController.h"
#import "ErrorLogViewModel.h"

@interface ErrorLogViewController ()
@property (weak, nonatomic) IBOutlet UITextView *errorLogTextView;
@property (nonatomic, strong) ErrorLogViewModel * errorLogViewModel;
@end

@implementation ErrorLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.errorLogViewModel = [[ErrorLogViewModel alloc] init];
    _errorLogTextView.text = self.errorLogViewModel.fileContents;
}

- (void) filteredFileContents {
//    NSArray <NSString *> * strings = [fileContents componentsSeparatedByString:@"\n"];
}

@end
