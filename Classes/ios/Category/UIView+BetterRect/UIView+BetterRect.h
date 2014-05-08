//
//  UIView+BetterRect.h
//  leopalace21
//
//  Created by Dai Hamada on 6/4/13.
//  Copyright (c) 2013 teamLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BetterRect)

@property (nonatomic, assign) CGPoint topleft;
@property (nonatomic, assign) CGPoint bottomright;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end
