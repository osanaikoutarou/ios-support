//
//  TLBTestApiModelObject.m
//  ios-support-demo
//
//  Created by Tanaka Hiroki on 2014/05/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBTestApiModelObject.h"

@implementation TLBTestApiModelObject

@synthesize pText = _pTextInternal;

- (NSArray *)allowsNilValues {
    return @[@"pStringForce", @"pArrayForce", @"pDictForce"];
}

@end
