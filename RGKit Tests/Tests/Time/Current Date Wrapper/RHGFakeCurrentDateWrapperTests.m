//
//  RHGFakeCurrentDateWrapperTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <RHGFakeCurrentDateWrapper.h>

@interface RHGFakeCurrentDateWrapperTests : RHGAutoverifyingSenTestCase

@end



@implementation RHGFakeCurrentDateWrapperTests {
    RHGFakeCurrentDateWrapper *currentDateWrapper;
    
    NSDate *date;
}

- (void)setUp
{
    [super setUp];
    
    currentDateWrapper = [[RHGFakeCurrentDateWrapper alloc] init];
    date = [NSDate dateWithTimeInterval:1.0 sinceDate:[currentDateWrapper currentDate]];
}

- (void)testDefaultsTo1970
{
    currentDateWrapper = [[RHGFakeCurrentDateWrapper alloc] init];
    
    assertThat([currentDateWrapper frozenDate], equalTo([NSDate dateWithTimeIntervalSince1970:0]));
}

- (void)testSetsFrozenDate
{
    currentDateWrapper = [[RHGFakeCurrentDateWrapper alloc] initWithFrozenDate:[NSDate dateWithTimeIntervalSince1970:5.0]];
    
    assertThat([currentDateWrapper frozenDate], equalTo([NSDate dateWithTimeIntervalSince1970:5.0]));
}

- (void)testCanChangeFrozenDateLater
{
    currentDateWrapper.frozenDate = [NSDate dateWithTimeIntervalSince1970:5.0];
    
    assertThat([currentDateWrapper frozenDate], equalTo([NSDate dateWithTimeIntervalSince1970:5.0]));
}

- (void)testTimeUntilDate
{
    NSDate *targetDate = [NSDate dateWithTimeIntervalSince1970:5.0];
    NSTimeInterval timeUntil = [currentDateWrapper timeUntilDate:targetDate];
    
    assertThatDouble(timeUntil, equalToDouble(5.0));
}

- (void)testCallsDelegateWhenDateReached
{
    [self newDelegateExpectingCallback];
    
    [currentDateWrapper setFrozenDate:date];
}

- (id)newDelegateExpectingCallback
{
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGTimerWrapperDelegate)];
    [currentDateWrapper callback:delegate onDate:date];
    [[delegate expect] dateReached:date];
    
    return delegate;
}

- (void)testCallsDelegateWhenDatePassed
{
    [self newDelegateExpectingCallback];
    
    [currentDateWrapper setFrozenDate:[NSDate dateWithTimeInterval:60000.0 sinceDate:date]];
}

- (void)testCallsBackMultipleDelegates
{
    [self newDelegateExpectingCallback];
    [self newDelegateExpectingCallback];
    
    [currentDateWrapper setFrozenDate:date];
}

- (void)testDelegatesNotNotifiedTwice
{
    id d1 = [self newDelegateExpectingCallback];
    id d2 = [self newDelegateExpectingCallback];
    
    [currentDateWrapper setFrozenDate:date];
    
    [d1 verify];
    [d2 verify];
    
    [currentDateWrapper setFrozenDate:[NSDate dateWithTimeInterval:1.0 sinceDate:date]];
}


@end
