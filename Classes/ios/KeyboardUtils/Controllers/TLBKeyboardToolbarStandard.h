//
//  TLBKeyboardToolbarStandard.h
//  picmiina
//
//  Created by Tanaka Hiroki on 2014/04/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLBKeyboardToolbarStandard : UIToolbar

@property(nonatomic) UIView *rootView;

@property(nonatomic, copy) BOOL(^validationBlock)(void);
@property(nonatomic, copy) void(^doneBlock)(BOOL isCancelled);

@end
