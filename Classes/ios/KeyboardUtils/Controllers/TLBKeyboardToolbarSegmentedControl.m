//
//  TLBKeyboardToolboxSegmentedControl.m
//  picmiina
//
//  Created by Tanaka Hiroki on 2014/04/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBKeyboardToolbarSegmentedControl.h"

@interface TLBKeyboardToolbarSegmentedControl ()

@property(nonatomic, weak) IBOutlet UIBarButtonItem *titleLabel;
@property(nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation TLBKeyboardToolbarSegmentedControl

#pragma mark setter/getter

- (void)setTitleValue:(NSString *)titleValue {
    _titleValue = titleValue;
    
    self.titleLabel.title = titleValue;
}

- (NSUInteger)defaultIndex {
    return self.segmentedControl.selectedSegmentIndex;
}

- (void)setDefaultIndex:(NSUInteger)defaultIndex {
    self.segmentedControl.selectedSegmentIndex = defaultIndex;
}

- (void)setSegmentedControlLists:(NSArray *)segmentedControlLists {
    _segmentedControlLists = segmentedControlLists;
    
    NSUInteger idx = 0;
    
    // 今あるデータを全て削除する
    while (self.segmentedControl.numberOfSegments > 0) {
        [self.segmentedControl removeSegmentAtIndex:0 animated:NO];
    }
    
    // 新たに差し込む
    for (NSString *value in segmentedControlLists) {
        [self.segmentedControl insertSegmentWithTitle:value atIndex:idx++ animated:NO];
    }
}

#pragma mark button action

- (IBAction)cancelAction:(id)sender {
    // テキストはデフォルトに戻しておく
    self.segmentedControl.selectedSegmentIndex = self.defaultIndex;
    
    [self completionWithResult:YES];
}

- (IBAction)doneAction:(id)sender {
    // バリデーション
    if (self.validationBlock) {
        if (!self.validationBlock()) {
            return;
        }
    }
    
    // デフォルトを更新する
    self.defaultIndex = self.segmentedControl.selectedSegmentIndex;
    
    [self completionWithResult:NO];
}

- (void)completionWithResult:(BOOL)isCancelled {
    [self.rootView endEditing:YES];
    
    // リストがセットされていなければ例外を発生させる
    if (self.segmentedControlLists.count == 0) {
        [NSException raise:@"EmptyDataSetFound" format:@"Required data set."];
        return;
    }
    
    // ユーザ定義処理
    if (self.doneBlock) {
        self.doneBlock(isCancelled, self.segmentedControl.selectedSegmentIndex, self.segmentedControlLists[self.segmentedControl.selectedSegmentIndex]);
    }
}

@end
