//
//  RHGNSDateCurrentDateWrapperTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//


#import <RHGNSDateCurrentDateWrapper.h>

@interface RHGNSDateCurrentDateWrapperTests : RHGAutoverifyingSenTestCase

@end


@implementation RHGNSDateCurrentDateWrapperTests {
    RHGNSDateCurrentDateWrapper *currentDateWrapper;
    id timerWrapper;
    
    NSDate *pastDate;
    NSDate *futureDate;
}

- (void)setUp
{
    [super setUp];
    
    timerWrapper = [self autoVerifiedMockForProtocol:@protocol(RHGTimerWrapper)];
    currentDateWrapper = [[RHGNSDateCurrentDateWrapper alloc] initWithTimerWrapper:timerWrapper];
    
    futureDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
    pastDate = [NSDate dateWithTimeIntervalSinceNow:-0.1];
}

- (void)testPassesCallbackRequestsDownToTimerWrapper
{
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGTimerWrapperDelegate)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:1.0];
    
    [[timerWrapper expect] callback:delegate onDate:date];
    
    [currentDateWrapper callback:delegate onDate:date];
}

@end
