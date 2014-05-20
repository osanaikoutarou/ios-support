//
//  TLBBaseApiRequest.h
//  ios-support
//
//  Created by Tanaka Hiroki on 2014/05/20.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBApiModel.h"

typedef NS_ENUM(NSUInteger, HttpRequestMethodType) {
    HttpRequestMethodTypeGET,
    HttpRequestMethodTypePOST,
    HttpRequestMethodTypePUT,
    HttpRequestMethodTypeDELETE,
};

#define HTTP_REQUEST_METHOD_TYPE_STRING @[@"GET", @"POST", @"PUT", @"DELETE"]

@protocol TLBBaseApiRequestProtocol <NSObject>

@required

- (NSString *)apiPath;
- (HttpRequestMethodType)requestMethod;
- (NSDictionary *)contentsDictionary;

@end

@interface TLBBaseApiRequest : TLBApiModel

@end
