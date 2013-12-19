//
//  NSArray+RHGEnumerationTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 12/18/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSArray+RHGEnumeration.h"

@interface NSArray_RHGEnumerationTests : SenTestCase

@end

@implementation NSArray_RHGEnumerationTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testEach
{
    NSArray *array = @[@"a", @"b"];
    NSMutableArray *calledWith = [NSMutableArray new];
    [array rhg_each:^(id obj) {
        [calledWith addObject:obj];
    }];
    
    assertThat(calledWith, equalTo(array));
}

@end
