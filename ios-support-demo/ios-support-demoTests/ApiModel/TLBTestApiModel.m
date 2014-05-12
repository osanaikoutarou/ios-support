//
//  TLBTestApiModel.m
//  ios-support-demo
//
//  Created by Tanaka Hiroki on 2014/05/12.
//  Copyright (c) 2014年 teamLab Inc. All rights reserved.
//

#import "TLBTestApiModel.h"
#import "TLBTestApiModelObject.h"

@implementation TLBTestApiModel

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

- (void)testModel
{
    TLBTestApiModelObject *model = [[TLBTestApiModelObject alloc] init];
    
    model.pString = @"item0";
    model.pNumber = @128;
    model.pArray = @[@"item1", @{@"item2": @"item3"}];
    model.pDictionary = @{@"item4": @"item5", @"item6": @[@"item7", @"item8", @"item9"]};
    model.p_int = 65536;
    model.p_bool = YES;
    model.pText = @"non-managed";
    
    NSString *contents = [[model contentsDictionary] description];
    
    XCTAssertTrue([self string:contents containsString:@"pString"]      , @"Not included the key of NSString.");
    XCTAssertTrue([self string:contents containsString:@"item0"]       , @"Not included the value of NSString.");
    XCTAssertTrue([self string:contents containsString:@"pNumber"]     , @"Not included the key of NSString.");
    XCTAssertTrue([self string:contents containsString:@"128"]         , @"Not included the value of NSNumber.");
    XCTAssertTrue([self string:contents containsString:@"pArray"]      , @"Not included the key of NSArray.");
    XCTAssertTrue([self string:contents containsString:@"item1"]       , @"Not included the value of NSArray.");
    XCTAssertTrue([self string:contents containsString:@"item2"]       , @"Not included the key of NSDictionary in NSArray.");
    XCTAssertTrue([self string:contents containsString:@"item3"]       , @"Not included the values NSDictionary in NSArray.");
    XCTAssertTrue([self string:contents containsString:@"pDictionary"] , @"Not included the key of NSArray.");
    XCTAssertTrue([self string:contents containsString:@"item4"]       , @"Not included the key of NSDictionary.");
    XCTAssertTrue([self string:contents containsString:@"item5"]       , @"Not included the value of NSDictionary.");
    XCTAssertTrue([self string:contents containsString:@"item6"]       , @"Not included the key of NSDictionary.");
    XCTAssertTrue([self string:contents containsString:@"item7"]       , @"Not included the values of NSArray in NSDictionary.");
    XCTAssertTrue([self string:contents containsString:@"item8"]       , @"Not included the values of NSArray in NSDictionary.");
    XCTAssertTrue([self string:contents containsString:@"item9"]       , @"Not included the values of NSArray in NSDictionary.");
    XCTAssertTrue([self string:contents containsString:@"p_int"]       , @"Not included the key of int.");
    XCTAssertTrue([self string:contents containsString:@"65536"]       , @"Not included the value of int.");
    XCTAssertTrue([self string:contents containsString:@"p_bool"]      , @"Not included the key of BOOL.");
    XCTAssertTrue([self string:contents containsString:@"true"]        , @"Not included the value of BOOL.");
    XCTAssertFalse([self string:contents containsString:@"pText"]      , @"Has included the key of non-managed property.");
    XCTAssertFalse([self string:contents containsString:@"non-managed"], @"Has included the value of non-managed property.");
    XCTAssertFalse([self string:contents containsString:@"pStringNil"] , @"Has included the key of nil NSString.");
    XCTAssertFalse([self string:contents containsString:@"pArrayNil"]  , @"Has included the key of nil NSArray.");
    XCTAssertFalse([self string:contents containsString:@"pDictNil"]   , @"Has included the key of nil NSDictionary.");
    
    TLBTestApiModelObject *model2 = [[TLBTestApiModelObject alloc] init];
    [model2 assignValuesByContentsDictionary:[model contentsDictionary]];
    
    XCTAssertTrue([[[model2 contentsDictionary] description] isEqualToString:[[model contentsDictionary] description]], @"Failed to assign a model from another model data.");
}

- (BOOL)string:(NSString *)string containsString:(NSString *)searchingString {
    NSRange rng = [string rangeOfString:searchingString options:NSCaseInsensitiveSearch];
    return rng.location != NSNotFound;
}


@end
