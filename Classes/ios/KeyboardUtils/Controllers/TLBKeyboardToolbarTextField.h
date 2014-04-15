//
//  TLBKeyboardToolbarTextField.h
//  picmiina
//
//  Created by Tanaka Hiroki on 2014/04/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLBKeyboardToolbarTextField : UIToolbar

@property(nonatomic) UIView *rootView;

@property(nonatomic) NSString *defaultValue;
@property(nonatomic) NSString *placeholderValue;

@property(nonatomic, copy) BOOL(^validationBlock)(NSString *resultValue);
@property(nonatomic, copy) void(^doneBlock)(BOOL isCancelled, NSString *resultValue);

@end
