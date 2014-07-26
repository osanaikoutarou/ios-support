//
//  CALayer+BetterRect.m
//  CALayer+BetterRect
//
//  Created by TakuNishimura on 2014/04/21.
//  Copyright (c) 2014年 TakuNishimura. All rights reserved.
//

#import "CALayer+BetterRect.h"

@implementation CALayer (BetterRect)

- (CGPoint) topleft {
    return self.frame.origin;
}

- (void) setTopleft:(CGPoint)topleft {
    CGPoint origin = topleft;
    CGSize size = self.frame.size;
    self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
}

- (CGPoint) bottomright {
    return CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y + self.frame.size.height);
}

- (void) setBottomright:(CGPoint)bottomright {
    CGPoint origin = CGPointMake(bottomright.x - self.frame.size.width, bottomright.y - self.frame.size.height);
    CGSize size = self.frame.size;
    self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
}

- (CGFloat) left {
    return self.frame.origin.x;
}

- (void) setLeft:(CGFloat)left {
    CGPoint origin = self.frame.origin;
    CGSize size = self.frame.size;
    origin.x = left;
    self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
}

- (CGFloat) top {
    return self.frame.origin.y;
}

- (void) setTop:(CGFloat)top {
    CGPoint origin = self.frame.origin;
    CGSize size = self.frame.size;
    origin.y = top;
    self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
}

- (CGFloat) right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight:(CGFloat)right {
    CGPoint origin = self.frame.origin;
    CGSize size = self.frame.size;
    origin.x = right - size.width;
    self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
}

- (CGFloat) bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom:(CGFloat)bottom {
    CGPoint origin = self.frame.origin;
    CGSize size = self.frame.size;
    origin.y = bottom - size.height;
    self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
}


- (CGSize) size {
    return self.frame.size;
}

- (void) setSize:(CGSize)_size {
    CGPoint origin = self.frame.origin;
    CGSize size = _size;
    self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
}

- (CGFloat) width {
    return self.frame.size.width;
}

- (void) setWidth:(CGFloat)width {
    CGPoint origin = self.frame.origin;
    CGSize size = self.frame.size;
    size.width = width;
    self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
}

- (CGFloat) height {
    return self.frame.size.height;
}

- (void) setHeight:(CGFloat)height {
    CGPoint origin = self.frame.origin;
    CGSize size = self.frame.size;
    size.height = height;
    self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
}

@end
