//
//  UIColor+HexValue.m
//  Memories
//
//  Created by TakuNishimura on 2013/10/23.
//  Copyright (c) 2013年 Team Lab Inc. All rights reserved.
//

#import "UIColor+HexValue.h"

@implementation UIColor (HexValue)
+ (id)colorWithHexString:(NSString *)hexValue alpha:(CGFloat)a {
    NSScanner *colorScanner = [NSScanner scannerWithString:hexValue];
    unsigned int color;
    if (![colorScanner scanHexInt:&color]) return nil;
    CGFloat r = ((color & 0xFF0000) >> 16)/255.0f;
    CGFloat g = ((color & 0x00FF00) >> 8) /255.0f;
    CGFloat b =  (color & 0x0000FF) /255.0f;
    //NSLog(@"HEX to RGB >> r:%f g:%f b:%f a:%f\n",r,g,b,a);
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}
@end