//
//  RHGTimerWrapperIntegrationTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGAutoverifyingSenTestCase.h"
#import <RHGTimerWrapper.h>
#import <RHGCurrentDateWrapper.h> // temp
#import <RHGNSDateCurrentDateWrapper.h>


@interface RHGTimerWrapperIntegrationTests : RHGAutoverifyingSenTestCase

@end



@implementation RHGTimerWrapperIntegrationTests {
    RHGTimerWrapper *timerWrapper;
}

- (void)setUp
{
    [super setUp];
    
    id currentDateWrapper = [[RHGNSDateCurrentDateWrapper alloc] init];
    timerWrapper = [[RHGTimerWrapper alloc] initWithCurrentDateWrapper:currentDateWrapper];
}

- (void)testCallsBackOnDate
{
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapperDelegate)];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.1];
    [timerWrapper callback:delegate onDate:date];
    
    [[delegate expect] dateReached:date];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
}

- (void)testCallsBackImmediatelyIfDateElapsed
{
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapperDelegate)];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-0.1];
    
    [[delegate expect] dateReached:date];
    [timerWrapper callback:delegate onDate:date];
}

@end
