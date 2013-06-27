//
//  RHGTimerWrapperTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGAutoverifyingSenTestCase.h"
#import <RHGTimerWrapper.h>
#import <RHGCurrentDateWrapper.h> // temp
#import <RHGNSDateCurrentDateWrapper.h>

@interface RHGTimerWrapperTests : RHGAutoverifyingSenTestCase

@end


@implementation RHGTimerWrapperTests {
    RHGTimerWrapper *timerWrapper;
    
    id currentDateWrapper;
}

- (void)setUp
{
    [super setUp];
    
    currentDateWrapper = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapper)];
    timerWrapper = [[RHGTimerWrapper alloc] initWithCurrentDateWrapper:currentDateWrapper];
}

//- (void)testCallsBackWhenTimerFires
//{
//    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapperDelegate)];
//    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.1];
//    [timerWrapper callback:delegate onDate:date];
//    
//    [[delegate expect] dateReached:date];
//    
//    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
//}
//
//- (void)testSchedulesATimerToCallBack
//{
//    NSTimer *timer = [fakeRunLoop scheduledTimer];
//    assertThat(timer, notNilValue());
//    assertThat([timer fireDate], scheduledDate);
//}

- (void)testCallsBackImmediatelyIfDateElapsed
{
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapperDelegate)];
    NSDate *date = [NSDate date];
    [[[currentDateWrapper stub] andReturnValue:OCMOCK_VALUE((NSTimeInterval){-0.1})] timeUntilDate:date];
    
    [[delegate expect] dateReached:date];
    [timerWrapper callback:delegate onDate:date];
}

@end
