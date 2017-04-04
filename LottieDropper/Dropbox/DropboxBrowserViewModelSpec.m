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

@end

@implementation DropboxBrowserViewModelSpec


- (void)testBrowserWithoutLocalCache {
    MockDropboxBrowserViewModel * viewModel = [[MockDropboxBrowserViewModel alloc] init];
    
    viewModel.mockFileNamesInOutputDirectory = @[@"A",@"B", @"C"];
    
    XCTAssertEqual(viewModel.fileDetails.count, 0);
    
    [viewModel setupFileDetailsFromLocalFilenames];
    
    XCTAssertEqualObjects([[viewModel fileDetailAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]] fileName], @"A");
}


- (void)testMergeWithDropboxFileList {
    MockDropboxBrowserViewModel * viewModel = [[MockDropboxBrowserViewModel alloc] init];
    
    viewModel.mockFileNamesInOutputDirectory = @[@"A",@"B", @"C"];
    
    XCTAssertEqual(viewModel.fileDetails.count, 0);
    
    [viewModel setupFileDetailsFromLocalFilenames];
    
    DBFILESMetadata * dropboxfileA = [[DBFILESMetadata alloc] initWithName:@"A"];
    DBFILESMetadata * dropboxfileB = [[DBFILESMetadata alloc] initWithName:@"B"];
    DBFILESMetadata * dropboxfileC = [[DBFILESMetadata alloc] initWithName:@"C"];
    DBFILESMetadata * dropboxfileD = [[DBFILESMetadata alloc] initWithName:@"D"];

    viewModel.dropboxFileCache = [@[dropboxfileA, dropboxfileB, dropboxfileC, dropboxfileD] mutableCopy];
    
    [viewModel mergeDropboxFileListWithFileDetails];
    
    [viewModel sort];
    
    // should have added D
    XCTAssertEqualObjects([[viewModel fileDetailAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]] fileName], @"D");
}

- (void)testMergeWithDropboxFileListWitLessFiles {
    MockDropboxBrowserViewModel * viewModel = [[MockDropboxBrowserViewModel alloc] init];
    
    viewModel.mockFileNamesInOutputDirectory = @[@"A",@"B", @"C"];
    
    XCTAssertEqual(viewModel.fileDetails.count, 0);
    
    [viewModel setupFileDetailsFromLocalFilenames];
    
    DBFILESMetadata * dropboxfileA = [[DBFILESMetadata alloc] initWithName:@"A"];
    DBFILESMetadata * dropboxfileC = [[DBFILESMetadata alloc] initWithName:@"C"];
    DBFILESMetadata * dropboxfileD = [[DBFILESMetadata alloc] initWithName:@"D"];
    
    // No B on dropbox
    viewModel.dropboxFileCache = [@[dropboxfileA, dropboxfileC, dropboxfileD] mutableCopy];
    
    [viewModel mergeDropboxFileListWithFileDetails];
    
    [viewModel sort];
    
    // should have added D
    XCTAssertEqualObjects([[viewModel fileDetailAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]] fileName], @"D");

}

@end


