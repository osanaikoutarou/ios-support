//
//  TLBWebApiUtil.h
//  ios-support
//
//  Created by Tanaka Hiroki on 2014/05/19.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TLBBaseApiRequestProtocol;
@class TLBApiModel;

@interface TLBWebApiUtil : NSObject

+ (void)requestWithModel:(id<TLBBaseApiRequestProtocol>)model resultClass:(Class)classObj onComplete:(void(^)(NSError *error, id result))block;

@end
