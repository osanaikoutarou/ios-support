//
//  TLBTestApiRequest.m
//  ios-support-demo
//
//  Created by Tanaka Hiroki on 2014/05/20.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBTestApiRequest.h"

@implementation TLBTestApiRequest

- (NSString *)apiPath {
    return @"http://date.jsontest.com//";
}

- (HttpRequestMethodType)requestMethod {
    return HttpRequestMethodTypeGET;
}

@end
