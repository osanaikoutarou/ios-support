//
//  TLBTestApiResponse.h
//  ios-support-demo
//
//  Created by Tanaka Hiroki on 2014/05/20.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBBaseApiResponse.h"

@interface TLBTestApiResponse : TLBBaseApiResponse

@property(nonatomic) NSString *time;
@property(nonatomic) NSString *milliseconds_since_epoch;
@property(nonatomic) NSString *date;

@end
