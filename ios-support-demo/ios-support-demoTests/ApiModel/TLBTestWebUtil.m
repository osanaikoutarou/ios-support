//
//  TLBTestWebUtil.m
//  ios-support-demo
//
//  Created by Tanaka Hiroki on 2014/05/20.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBTestWebUtil.h"

#import "TLBWebApiUtil.h"
#import "TLBTestApiRequest.h"
#import "TLBTestApiResponse.h"

@implementation TLBTestWebUtil

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUtil
{
    // テスト実行完了フラグ
    __block BOOL isFinished = NO;
    
    TLBTestApiRequest *req = [[TLBTestApiRequest alloc] init];
    [TLBWebApiUtil requestWithModel:req resultClass:[TLBTestApiResponse class] onComplete:^(NSError *error, TLBTestApiResponse *result) {
        if (!error) {
            XCTAssertNotNil(result.time, @"The patameter 'time' not included.\n%@", [result contentsDictionary]);
            XCTAssertNotNil(result.milliseconds_since_epoch, @"The patameter 'time' not included.\n%@", [result contentsDictionary]);
            XCTAssertNotNil(result.date, @"The patameter 'time' not included.\n%@", [result contentsDictionary]);
            
            NSLog(@"Succeeded: %@", [result contentsDictionary]);
        } else {
            XCTFail(@"Network unavailable.");
        }
        
        isFinished = YES;
    }];
    while (!isFinished) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    XCTAssertTrue(isFinished, @"");
}

@end
