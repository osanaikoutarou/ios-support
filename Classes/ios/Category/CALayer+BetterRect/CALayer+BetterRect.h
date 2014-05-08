//
//  CALayer+BetterRect.h
//  CALayer+BetterRect
//
//  Created by TakuNishimura on 2014/04/21.
//  Copyright (c) 2014年 TakuNishimura. All rights reserved.
//

@interface CALayer (BetterRect)

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
