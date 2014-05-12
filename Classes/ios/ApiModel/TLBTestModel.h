//
//  TLBTestModel.h
//  test-refr
//
//  Created by Tanaka Hiroki on 2014/05/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBReflectionCompatibleModel.h"

@interface TLBTestModel : TLBReflectionCompatibleModel

@property(nonatomic) NSString *path;

@property(nonatomic) NSString *pString;
@property(nonatomic) NSNumber *pNumber;
@property(nonatomic) NSArray *p_array;
@property(nonatomic) NSDictionary *pDictionary;
@property(nonatomic) int pInt;
@property(nonatomic) BOOL pBool;


@end
