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
    TLBTestApiModelObject *modelChild = [[TLBTestApiModelObject alloc] init];
    modelChild.pString = @"itemChild0";
    modelChild.pArray = @[@"itemChild1", @{@"itemChild2": @"itemChild3"}];
    
    TLBTestApiModelObject *modelChildA1 = [[TLBTestApiModelObject alloc] init];
    modelChildA1.pString = @"itemChildA10";
    modelChildA1.pArray = @[@"itemChildA11", @{@"itemChildA12": @"itemChildA13"}];
    
    TLBTestApiModelObject *modelChildA2 = [[TLBTestApiModelObject alloc] init];
    modelChildA2.pString = @"itemChildA20";
    modelChildA2.pArray = @[@"itemChildA21", @{@"itemChildA22": @"itemChildA23"}];
    
    TLBTestApiModelObject *model = [[TLBTestApiModelObject alloc] init];
    model.pString = @"item0";
    model.pNumber = @128;
    model.pArray = @[@"item1", @{@"item2": @"item3"}];
    model.pDictionary = @{@"item4": @"item5", @"item6": @[@"item7", @"item8", @"item9"]};
    model.p_int = 65536;
    model.p_bool = YES;
    model.pText = @"non-managed";
    model.pChild = modelChild;
    model.pChildArray = (NSArray<TLBTestApiModelObject> *) @[modelChildA1, modelChildA2];
    
    NSString *contents = [[model contentsDictionary] description];
    
    XCTAssertTrue([self string:contents containsString:@"pString"]     , @"Not included the key of NSString.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"item0"]       , @"Not included the value of NSString.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"pNumber"]     , @"Not included the key of NSString.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"128"]         , @"Not included the value of NSNumber.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"pArray"]      , @"Not included the key of NSArray.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"item1"]       , @"Not included the value of NSArray.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"item2"]       , @"Not included the key of NSDictionary in NSArray.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"item3"]       , @"Not included the values NSDictionary in NSArray.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"pDictionary"] , @"Not included the key of NSArray.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"item4"]       , @"Not included the key of NSDictionary.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"item5"]       , @"Not included the value of NSDictionary.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"item6"]       , @"Not included the key of NSDictionary.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"item7"]       , @"Not included the values of NSArray in NSDictionary.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"item8"]       , @"Not included the values of NSArray in NSDictionary.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"item9"]       , @"Not included the values of NSArray in NSDictionary.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"p_int"]       , @"Not included the key of int.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"65536"]       , @"Not included the value of int.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"p_bool"]      , @"Not included the key of BOOL.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"true"]        , @"Not included the value of BOOL.\n%@", contents);
    
    XCTAssertTrue([self string:contents containsString:@"pChild"]      , @"Not included the key of Child Object.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"itemChild0"]  , @"Not included the value of Child Object.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"itemChild1"]  , @"Not included the value of Child Object.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"itemChild2"]  , @"Not included the value of Child Object.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"itemChild3"]  , @"Not included the value of Child Object.\n%@", contents);
    
    XCTAssertTrue([self string:contents containsString:@"pChildArray"]   , @"Not included the key of Child Array Object.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"itemChildA10"]  , @"Not included the value of Child Array Object.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"itemChildA11"]  , @"Not included the value of Child Array Object.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"itemChildA12"]  , @"Not included the value of Child Array Object.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"itemChildA13"]  , @"Not included the value of Child Array Object.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"itemChildA20"]  , @"Not included the value of Child Array Object.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"itemChildA21"]  , @"Not included the value of Child Array Object.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"itemChildA22"]  , @"Not included the value of Child Array Object.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"itemChildA23"]  , @"Not included the value of Child Array Object.\n%@", contents);
    
    XCTAssertFalse([self string:contents containsString:@"pText"]      , @"Has included the key of non-managed property.\n%@", contents);
    XCTAssertFalse([self string:contents containsString:@"non-managed"], @"Has included the value of non-managed property.\n%@", contents);
    XCTAssertFalse([self string:contents containsString:@"pStringNil"] , @"Has included the key of nil NSString.\n%@", contents);
    XCTAssertFalse([self string:contents containsString:@"pArrayNil"]  , @"Has included the key of nil NSArray.\n%@", contents);
    XCTAssertFalse([self string:contents containsString:@"pDictNil"]   , @"Has included the key of nil NSDictionary.\n%@", contents);
    
    XCTAssertTrue([self string:contents containsString:@"pStringForce"] , @"Not included the key of nil NSString.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"pArrayForce"]  , @"Not included the key of nil NSArray.\n%@", contents);
    XCTAssertTrue([self string:contents containsString:@"pDictForce"]   , @"Not included the key of nil NSDictionary.\n%@", contents);
    
    TLBTestApiModelObject *model2 = [[TLBTestApiModelObject alloc] initWithContentsDictionary:[model contentsDictionary]];
    
    XCTAssertTrue([[[model2 contentsDictionary] description] isEqualToString:[[model contentsDictionary] description]],
                  @"Failed to assign a model from another model data.\n%@ vs %@",
                  [[model contentsDictionary] description],
                  [[model2 contentsDictionary] description]);
    
    for (int i=0, n=model.pChildArray.count; i<n; ++i) {
        TLBTestApiModelObject *objA = model.pChildArray[i];
        TLBTestApiModelObject *objB = model2.pChildArray[i];
        
        XCTAssertTrue([[[objB contentsDictionary] description] isEqualToString:[[objA contentsDictionary] description]],
                      @"Failed to assign a model from another model data.\n%@ vs %@",
                      [[objA contentsDictionary] description],
                      [[objB contentsDictionary] description]);
    }
    
    NSLog(@"Succeeded: %@", contents);
}

- (BOOL)string:(NSString *)string containsString:(NSString *)searchingString {
    NSRange rng = [string rangeOfString:searchingString options:NSCaseInsensitiveSearch];
    return rng.location != NSNotFound;
}


@end
