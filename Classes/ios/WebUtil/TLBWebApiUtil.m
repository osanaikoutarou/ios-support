//
//  TLBWebApiUtil.m
//  ios-support
//
//  Created by Tanaka Hiroki on 2014/05/19.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBWebApiUtil.h"

#import "TLBBaseApiRequest.h"
#import <AFNetworking/AFNetworking.h>

@implementation TLBWebApiUtil

+ (void)requestWithModel:(id<TLBBaseApiRequestProtocol>)modelObj resultClass:(Class)classObj onComplete:(void(^)(NSError *error, id result))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"[Api Request]\n"
           "  Path: %@\n"
           "  Method: %@\n"
           "  Body: %@",
          [modelObj apiPath], HTTP_REQUEST_METHOD_TYPE_STRING[(NSUInteger)[modelObj requestMethod]], [modelObj contentsDictionary]);
    
    void (^successBlock)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *opr, id result){
        NSLog(@"[Api Response] Succeeded\n"
              "  Status: %u\n"
              "  Body: %@\n",
              opr.response.statusCode, [result description]);
        
        if (block) {
            id resultObj = [[classObj alloc] initWithContentsDictionary:result];
            NSLog(@"%@", [resultObj contentsDictionary]);
            block(nil, resultObj);
        }
    };
    void (^errorBlock)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *opr, NSError *error){
        NSLog(@"[Api Response] ERROR!!\n"
              "  Status: %u\n"
              "  Error Description: %@\n",
              opr.response.statusCode, [error localizedDescription]);
        
        if (block) {
            block(error, nil);
        }
    };
    
    switch ([modelObj requestMethod]) {
        case HttpRequestMethodTypeGET:
            [manager GET:[modelObj apiPath]
              parameters:[modelObj contentsDictionary]
                 success:successBlock
                 failure:errorBlock];
            break;
        case HttpRequestMethodTypePOST:
            [manager POST:[modelObj apiPath]
              parameters:[modelObj contentsDictionary]
                 success:successBlock
                 failure:errorBlock];
            break;
        case HttpRequestMethodTypePUT:
            [manager PUT:[modelObj apiPath]
              parameters:[modelObj contentsDictionary]
                 success:successBlock
                 failure:errorBlock];
            break;
        case HttpRequestMethodTypeDELETE:
            [manager DELETE:[modelObj apiPath]
              parameters:[modelObj contentsDictionary]
                 success:successBlock
                 failure:errorBlock];
            break;
        default:
            break;
    }
}

@end
