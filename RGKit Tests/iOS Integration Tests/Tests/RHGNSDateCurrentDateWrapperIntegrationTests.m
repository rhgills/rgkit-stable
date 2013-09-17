//
//  RHGTimerWrapperIntegrationTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGAutoverifyingSenTestCase.h"
#import <RHGTimerWrapperNS.h>
#import <RHGCurrentDateWrapper.h> // temp
#import <RHGNSDateCurrentDateWrapper.h>


@interface RHGNSDateCurrentDateWrapperIntegrationTests : RHGAutoverifyingSenTestCase

@end


@implementation RHGNSDateCurrentDateWrapperIntegrationTests {
    RHGNSDateCurrentDateWrapper *currentDateWrapper;
    RHGTimerWrapperNS *timerWrapper;
    
    NSDate *pastDate;
    NSDate *futureDate;
}

- (void)setUp
{
    [super setUp];
    
    timerWrapper = [[RHGTimerWrapperNS alloc] init];
    currentDateWrapper = [[RHGNSDateCurrentDateWrapper alloc] initWithTimerWrapper:timerWrapper];
    timerWrapper.currentDateWrapper = currentDateWrapper;
    
    futureDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
    pastDate = [NSDate dateWithTimeIntervalSinceNow:-0.1];
}

- (void)testCallsBackOnDate
{
    [self newDelegateExpectingCallbackOnFutureDate];
    
    [self advanceTimeUntil:futureDate];
}

- (id)newDelegateExpectingCallbackOnFutureDate;
{
    return [self newDelegateExpectingCallbackOnDate:futureDate];
}

- (id)newDelegateExpectingCallbackOnDate:(NSDate *)date
{
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGTimerWrapperDelegate)];
    [currentDateWrapper callback:delegate onDate:date];
    [[delegate expect] dateReached:date];
    
    return delegate;
}

- (id)newDelegateExpectingImmediateCallbackForPreviousDate
{
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGTimerWrapperDelegate)];
    [[delegate expect] dateReached:pastDate];
    [currentDateWrapper callback:delegate onDate:pastDate];
    return delegate;
}

- (void)advanceTimeUntil:(NSDate *)date
{
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeInterval:0.1 sinceDate:date]];
}

- (void)spinTheRunloop
{
    [self advanceTimeUntil:[NSDate date]];
}

- (void)testCallsBackImmediatelyIfDateElapsed
{
    [self newDelegateExpectingImmediateCallbackForPreviousDate];
}

- (void)testCallsbackMultipleDelegates
{
    [self newDelegateExpectingCallbackOnFutureDate];
    [self newDelegateExpectingCallbackOnFutureDate];
    
    [self advanceTimeUntil:futureDate];
}

// this flickers
- (void)testDelegatesNotNotifiedTwice
{
    id d1 = [self newDelegateExpectingCallbackOnFutureDate];
    id d2 = [self newDelegateExpectingCallbackOnFutureDate];
    
    [self advanceTimeUntil:futureDate];
    
    [d1 verify];
    [d2 verify];
    
    [self advanceTimeUntil:[NSDate dateWithTimeInterval:1.0 sinceDate:futureDate]];
}

@end