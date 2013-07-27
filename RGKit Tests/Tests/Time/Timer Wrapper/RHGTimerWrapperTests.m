//
//  RHGTimerWrapperTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGAutoverifyingSenTestCase.h"
#import <RHGTimerWrapperNS.h>
#import <RHGCurrentDateWrapper.h> // temp
#import <RHGNSDateCurrentDateWrapper.h>

@interface RHGTimerWrapperTests : RHGAutoverifyingSenTestCase

@end


@implementation RHGTimerWrapperTests {
    RHGTimerWrapperNS *timerWrapper;
    
    id currentDateWrapper;
    id partial;
    id delegate;
    
    NSDate *date;
}

- (void)setUp
{
    [super setUp];
    
    currentDateWrapper = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapper)];
    timerWrapper = [[RHGTimerWrapperNS alloc] init];
    timerWrapper.currentDateWrapper = currentDateWrapper;
    
    partial = [self autoVerifiedPartialMockForObject:timerWrapper];
    delegate = [self autoVerifiedMockForProtocol:@protocol(RHGTimerWrapperDelegate)];
    
    date = [NSDate dateWithTimeIntervalSince1970:0.0];
}

- (void)testCallsBackImmediatelyIfDateElapsed
{
    NSDate *pastDate = [NSDate dateWithTimeIntervalSince1970:0.0];
    [[[currentDateWrapper stub] andReturnValue:OCMOCK_VALUE((NSTimeInterval){-0.1})] timeUntilDate:pastDate];
    
    [[delegate expect] dateReached:pastDate];
    [timerWrapper callback:delegate onDate:pastDate];
}

- (void)testSchedulesACallbackIfDateInFuture
{
    NSDate *futureDate = [NSDate dateWithTimeIntervalSince1970:0.0];
    [[[currentDateWrapper stub] andReturnValue:OCMOCK_VALUE((NSTimeInterval){0.1})] timeUntilDate:futureDate];
    
    [[partial expect] scheduleCallbackFor:delegate onDate:futureDate timeUntilDate:0.1];
    
    [timerWrapper callback:delegate onDate:futureDate];
}

- (void)testScheduledCallbackSchedulesUsingInvocation
{
    id invocation = @"";
    NSTimeInterval timeUntil = 1.0;
    
    [[[partial expect] andReturn:invocation] invocationToCallback:delegate onDate:date];
    [[partial expect] scheduleCallbackWithInvocation:invocation timeUntilDate:timeUntil];
    
    [timerWrapper scheduleCallbackFor:delegate onDate:date timeUntilDate:timeUntil];
}

- (void)testInvocationWillCallBackDelegateWhenFired
{
    NSInvocation *invocation = [timerWrapper invocationToCallback:delegate onDate:date];
    
    assertThat(invocation.target, sameInstance(delegate));
    STAssertEquals(invocation.selector, @selector(dateReached:), nil);
    
    id dateArg;
    [invocation getArgument:&dateArg atIndex:2];
    assertThat(dateArg, equalTo(date));
}

@end
