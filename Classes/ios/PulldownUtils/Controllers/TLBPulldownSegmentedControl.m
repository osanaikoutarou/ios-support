//
//  TLBPulldownSegmentedControl.m
//  picmiina
//
//  Created by Tanaka Hiroki on 2014/04/14.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBPulldownSegmentedControl.h"

#import "TLBKeyboardToolbarHelper.h"
#import "TLBKeyboardToolbarSegmentedControl.h"

@implementation TLBPulldownSegmentedControl

- (void)setSegmentedControlDefaultIndex:(NSUInteger)segmentedControlDefaultIndex {
    _segmentedControlDefaultIndex = segmentedControlDefaultIndex;
    
    // viewにセット
    TLBKeyboardToolbarSegmentedControl *segmentedControlAccessoryView = (TLBKeyboardToolbarSegmentedControl *) self.customAccessoryView;
    if ([segmentedControlAccessoryView isKindOfClass:[TLBKeyboardToolbarSegmentedControl class]]) {
        segmentedControlAccessoryView.defaultIndex = segmentedControlDefaultIndex;
    }
}

#pragma mark internal

- (UIView *)customAccessoryView {
    TLBKeyboardToolbarSegmentedControl *accessoryView = [TLBKeyboardToolbarHelper instantiateSegmentedControlWithRootView:nil];
    
    accessoryView.titleValue = self.segmentedControlLabel;
    accessoryView.defaultIndex = self.segmentedControlDefaultIndex;
    accessoryView.segmentedControlLists = self.segmentedControlItems;
    
    accessoryView.doneBlock = ^(BOOL isCancelled, NSUInteger resultIndex, NSString *resultText) {
        if (!isCancelled) {
            self.segmentedControlDefaultIndex = resultIndex;
            
            if (self.segmentedControlChangedBlock) {
                self.segmentedControlChangedBlock(resultIndex);
            }
            
            [self doneForPickerView:[self selectedText]];
            [self doneForDatetimePickerView:[self selectedDate]];
        } else {
            [self closePickerView];
        }
    };
    
    return (UIView *) accessoryView;
}

@end
