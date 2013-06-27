//
//  RHGFakeAutoadvancingCurrentDateWrapperTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGAutoverifyingSenTestCase.h"
#import <RHGFakeAutoadvancingCurrentDateWrapper.h>

@interface RHGFakeAutoadvancingCurrentDateWrapperTests : RHGAutoverifyingSenTestCase

@end


@implementation RHGFakeAutoadvancingCurrentDateWrapperTests {
    RHGFakeAutoadvancingCurrentDateWrapper *currentDateWrapper;
}

- (void)setUp
{
    [super setUp];
    
    currentDateWrapper = [[RHGFakeAutoadvancingCurrentDateWrapper alloc] initWithStartDate:[NSDate dateWithTimeIntervalSince1970:0]];
}

- (void)testReturnsStartDate
{
    STAssertEqualsWithAccuracy([[currentDateWrapper currentDate] timeIntervalSince1970], 0.0, .05, nil);
}

- (void)testStartDateAdvances
{
    sleep(1);
    
    STAssertEqualsWithAccuracy([[currentDateWrapper currentDate] timeIntervalSince1970], 1.0, .05, nil);
}

- (void)testDateForNextOccurenceNotYetImplemented
{
    STAssertThrows([currentDateWrapper dateForNextOccurenceOfHour:0], nil);
}

- (void)testTimeUntilDate
{
    NSDate *sixSecondsLater = [NSDate dateWithTimeIntervalSince1970:6.0];
    
    STAssertEqualsWithAccuracy([currentDateWrapper timeUntilDate:sixSecondsLater], 6.0, .05, nil);
}

@end
