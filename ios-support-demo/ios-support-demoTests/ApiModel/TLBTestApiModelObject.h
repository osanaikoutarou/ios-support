//
//  TLBTestApiModelObject.h
//  ios-support-demo
//
//  Created by Tanaka Hiroki on 2014/05/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLBApiModel.h"

@protocol TLBTestApiModelObject;

@interface TLBTestApiModelObject : TLBApiModel

// managed property
@property(nonatomic) NSString *pString;
@property(nonatomic) NSString *pStringNil;
@property(nonatomic) NSString *pStringForce;
@property(nonatomic) NSNumber *pNumber;
@property(nonatomic) NSArray *pArray;
@property(nonatomic) NSArray *pArrayNil;
@property(nonatomic) NSArray<TLBTestApiModelObject> *pArrayForce;
@property(nonatomic) NSDictionary *pDictionary;
@property(nonatomic) NSDictionary *pDictNil;
@property(nonatomic) NSDictionary *pDictForce;
@property(nonatomic) int p_int;
@property(nonatomic) BOOL p_bool;
@property(nonatomic) TLBTestApiModelObject *pChild;
@property(nonatomic) NSArray<TLBTestApiModelObject> *pChildArray;

// not-managed property
@property(nonatomic) NSString *pText;

@end
