//
//  SettingsViewController.m
//  LottieDropper
//
//  Created by Stefan Adams on 11/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsTableViewCell.h"
#import "SettingsViewModel.h"

@interface SettingsViewController ()

@property (strong, nonatomic) SettingsViewModel * viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewModel = [[SettingsViewModel alloc] init];
    self.viewModel.hexColor = @"#12345";
}

#pragma mark: TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell configureCellFor:[self.viewModel settingsTypeforIndexPath:indexPath]];
    
    return cell;
}

@end
