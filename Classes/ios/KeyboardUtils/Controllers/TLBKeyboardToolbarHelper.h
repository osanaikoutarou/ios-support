//
//  TLBKeyboardToolbarHelper.h
//  picmiina
//
//  Created by Tanaka Hiroki on 2014/04/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLBKeyboardToolbarStandard;
@class TLBKeyboardToolbarTextField;
@class TLBKeyboardToolbarSegmentedControl;

@interface TLBKeyboardToolbarHelper : NSObject

+ (TLBKeyboardToolbarStandard *)instantiateSimpleWithRootView:(UIView *)rootView;
+ (TLBKeyboardToolbarStandard *)instantiateStandardWithRootView:(UIView *)rootView;
+ (TLBKeyboardToolbarTextField *)instantiateTextFieldWithRootView:(UIView *)rootView;
+ (TLBKeyboardToolbarSegmentedControl *)instantiateSegmentedControlWithRootView:(UIView *)rootView;
   
@end
