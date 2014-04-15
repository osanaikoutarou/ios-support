//
//  TLBKeyboardToolbarHelper.m
//  picmiina
//
//  Created by Tanaka Hiroki on 2014/04/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBKeyboardToolbarHelper.h"

#import "TLBKeyboardToolbarStandard.h"
#import "TLBKeyboardToolbarTextField.h"
#import "TLBKeyboardToolbarSegmentedControl.h"

@implementation TLBKeyboardToolbarHelper

+ (TLBKeyboardToolbarStandard *)instantiateSimpleWithRootView:(UIView *)rootView {
    NSArray *nibs = [[UINib nibWithNibName:@"TLBKeyboardToolbar" bundle:nil] instantiateWithOwner:nil options:nil];
    TLBKeyboardToolbarStandard *instanceObj = [nibs objectAtIndex:0];
    instanceObj.rootView = rootView;
    return instanceObj;
}

+ (TLBKeyboardToolbarStandard *)instantiateStandardWithRootView:(UIView *)rootView {
    NSArray *nibs = [[UINib nibWithNibName:@"TLBKeyboardToolbar" bundle:nil] instantiateWithOwner:nil options:nil];
    TLBKeyboardToolbarStandard *instanceObj = [nibs objectAtIndex:1];
    instanceObj.rootView = rootView;
    return instanceObj;
}

+ (TLBKeyboardToolbarTextField *)instantiateTextFieldWithRootView:(UIView *)rootView {
    NSArray *nibs = [[UINib nibWithNibName:@"TLBKeyboardToolbar" bundle:nil] instantiateWithOwner:nil options:nil];
    TLBKeyboardToolbarTextField *instanceObj = [nibs objectAtIndex:2];
    instanceObj.rootView = rootView;
    return instanceObj;
}

+ (TLBKeyboardToolbarSegmentedControl *)instantiateSegmentedControlWithRootView:(UIView *)rootView {
    NSArray *nibs = [[UINib nibWithNibName:@"TLBKeyboardToolbar" bundle:nil] instantiateWithOwner:nil options:nil];
    TLBKeyboardToolbarSegmentedControl *instanceObj = [nibs objectAtIndex:3];
    instanceObj.rootView = rootView;
    return instanceObj;
}

@end
