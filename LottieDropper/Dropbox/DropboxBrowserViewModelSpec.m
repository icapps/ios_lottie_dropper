//
//  DropboxBrowserViewModelSpec.m
//  LottieDropper
//
//  Created by Stefan Adams on 04/04/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DropboxBrowserViewModel.h"
#import "DropboxDetailViewModel.h"

@import ObjectiveDropboxOfficial;

#pragma mark: - Mocks

@interface MockDropboxBrowserViewModel : DropboxBrowserViewModel
@property (nonatomic, strong) NSArray <NSString*>* mockFileNamesInOutputDirectory;
@end

@implementation MockDropboxBrowserViewModel

-(NSArray<NSString *> *)fetchFilenamesFromOutputDirectory {
    return self.mockFileNamesInOutputDirectory;
}

@end


@interface DropboxBrowserViewModelSpec : XCTestCase
@property (nonatomic, strong) MockDropboxBrowserViewModel *viewModel;

@end

@implementation DropboxBrowserViewModelSpec

-(void)setUp {
    [super setUp];
    self.viewModel = [[MockDropboxBrowserViewModel alloc] init];
    self.viewModel.mockFileNamesInOutputDirectory = @[@"A",@"B", @"C"];
}

- (void)testBrowserFromLocalCache {
    
    [self.viewModel setupFileDetailsFromLocalFilenames];
    
    XCTAssertEqualObjects([[self.viewModel fileDetailAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]] fileName], @"A");
}

- (void)testBrowserFromLocalCacheWithoutHiddenFiles {
    
    self.viewModel.mockFileNamesInOutputDirectory = @[@".DS_Store", @"A",@"B", @"C"];
    
    [self.viewModel setupFileDetailsFromLocalFilenames];
    
    XCTAssertEqualObjects([[self.viewModel fileDetailAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]] fileName], @"A");
}


- (void)testMergeWithDropboxFileList {
    
    [self.viewModel setupFileDetailsFromLocalFilenames];
    
    DBFILESMetadata * dropboxfileA = [[DBFILESMetadata alloc] initWithName:@"A"];
    DBFILESMetadata * dropboxfileB = [[DBFILESMetadata alloc] initWithName:@"B"];
    DBFILESMetadata * dropboxfileC = [[DBFILESMetadata alloc] initWithName:@"C"];
    DBFILESMetadata * dropboxfileD = [[DBFILESMetadata alloc] initWithName:@"D"];

    self.viewModel.dropboxFileCache = [@[dropboxfileA, dropboxfileB, dropboxfileC, dropboxfileD] mutableCopy];
    
    [self.viewModel mergeDropboxFileListWithFileDetails];
    
    [self.viewModel sort];
    
    XCTAssertEqualObjects([[self.viewModel fileDetailAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]] fileName], @"D");
}

- (void)testMergeWithDropboxFileListWithLessFiles {
    
    [self.viewModel setupFileDetailsFromLocalFilenames];
    
    DBFILESMetadata * dropboxfileA = [[DBFILESMetadata alloc] initWithName:@"A"];
    DBFILESMetadata * dropboxfileC = [[DBFILESMetadata alloc] initWithName:@"C"];
    DBFILESMetadata * dropboxfileD = [[DBFILESMetadata alloc] initWithName:@"D"];
    
    // No B on dropbox
    self.viewModel.dropboxFileCache = [@[dropboxfileA, dropboxfileC, dropboxfileD] mutableCopy];
    
    [self.viewModel mergeDropboxFileListWithFileDetails];
    
    [self.viewModel sort];
    
    XCTAssertEqualObjects([[self.viewModel fileDetailAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]] fileName], @"C");

}

@end


