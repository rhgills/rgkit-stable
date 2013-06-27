//
//  RHGFakeAutoadvancingCurrentDateWrapperTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//


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
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    
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

- (void)testCallsBackOnDate
{
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapperDelegate)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0.1];
    [currentDateWrapper callback:delegate onDate:date];
    
    [[delegate expect] dateReached:date];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
}

- (void)testCallsBackImmediatelyIfDateElapsed
{
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapperDelegate)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:-5.0];
    
    [[delegate expect] dateReached:date];
    
    [currentDateWrapper callback:delegate onDate:date];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
}

@end
