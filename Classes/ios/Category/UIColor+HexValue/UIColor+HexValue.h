//
//  UIColor+HexValue.h
//  Memories
//
//  Created by TakuNishimura on 2013/10/23.
//  Copyright (c) 2013年 Team Lab Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexValue)

+ (id)colorWithHexString:(NSString *)hexValue alpha:(CGFloat)a;

@end
