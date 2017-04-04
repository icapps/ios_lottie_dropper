//
//  DropBoxBrowserViewController.m
//  LottieDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "DropBoxBrowserViewController.h"
#import "LottieDropper-Swift.h"
#import "DropboxBrowserViewModel.h"
#import "DropboxDetailViewModel.h"
#import "DropboxBrowserCollectionViewCell.h"
#import "LottieAnimatorViewController.h"

@import ObjectiveDropboxOfficial;

@interface DropBoxBrowserViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation DropBoxBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.browserViewModel = [[DropboxBrowserViewModel alloc] init];
	[self.browserViewModel initializeDropboxClient:^{
		NSLog(@"Client has files %@", self.browserViewModel.fileDetails);
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self.collectionView reloadData];
		}];
	}];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

	if ([segue.destinationViewController isKindOfClass:[LottieAnimatorViewController class]]) {
		LottieAnimatorViewController * animator = segue.destinationViewController;
		NSIndexPath * selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
		DropboxDetailViewModel *detail = [self.browserViewModel fileDetailAtIndexPath:selectedIndexPath];
		animator.dropboxDetail = detail;
	}

}

#pragma mark: Reload

-(IBAction)reloadFileList:(id)sender {
    
}

#pragma mark: - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.browserViewModel.fileDetails.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	DropboxBrowserCollectionViewCell * _Nonnull cell = (DropboxBrowserCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DropboxBrowserCollectionViewCell class]) forIndexPath:indexPath];
	DropboxDetailViewModel * detail = [self.browserViewModel fileDetailAtIndexPath:indexPath];
	[cell setup:detail.fileName];
	return  cell;
}

#pragma mark: - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake(collectionView.bounds.size.width - (_flowLayout.minimumInteritemSpacing * 2), _flowLayout.itemSize.height);
}

@end
