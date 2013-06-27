//
//  RHGNSTimerWidgetTests.m
//  Phoenix
//
//  Created by Robert Gilliam on 6/21/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGAutoverifyingSenTestCase.h"
#import <OCMock.h>

@interface RHGBlockCallSchedulerTimerImplTests : RHGAutoverifyingSenTestCase

@end



#import "RHGBlockCallSchedulerTimerImpl.h"
#import <RHGNSDateCurrentDateWrapper.h>

@implementation RHGBlockCallSchedulerTimerImplTests {
    RHGBlockCallSchedulerTimerImpl *scheduler;
}

- (void)testFires
{
    __block BOOL fired = NO;
    
    id <RHGCurrentDateWrapper> currentDateWrapper = [[RHGNSDateCurrentDateWrapper alloc] init];
    scheduler = [[RHGBlockCallSchedulerTimerImpl alloc] initWithCurrentDateWrapper:currentDateWrapper];
    [scheduler setBlock:^{
        fired = YES;
    }];
    
    NSDate *oneHundredMillisecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:0.1];
    [scheduler scheduleOnDate:oneHundredMillisecondsFromNow];
    
    STAssertFalse(fired, nil);
    
    NSDate *twoHundredMillisecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:0.2];
    [[NSRunLoop currentRunLoop] runUntilDate:twoHundredMillisecondsFromNow];
    
    STAssertTrue(fired, nil);
}

- (void)testFiresMockBetterIsolated
{
    __block BOOL fired = NO;
    
    id currentDateWrapper = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapper)];
    
    scheduler = [[RHGBlockCallSchedulerTimerImpl alloc] initWithCurrentDateWrapper:currentDateWrapper];
    [scheduler setBlock:^{
        fired = YES;
    }];
    
    NSDate *twoSecondsFromNow = [NSDate dateWithTimeIntervalSince1970:2.0];
    [[[currentDateWrapper stub] andReturnValue:OCMOCK_VALUE((NSTimeInterval){2.0})] timeUntilDate:twoSecondsFromNow];
    [[currentDateWrapper expect] callback:scheduler afterTimeInterval:2.0];
    [scheduler scheduleOnDate:twoSecondsFromNow];
    
    STAssertFalse(fired, nil);
    
    [scheduler timeIntervalDidElapse:2.0];
    
    STAssertTrue(fired, nil);
}

- (void)testFiresIfDateAlreadyElapsed
{
    __block BOOL fired = NO;
    
    id currentDateWrapper = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapper)];
    
    scheduler = [[RHGBlockCallSchedulerTimerImpl alloc] initWithCurrentDateWrapper:currentDateWrapper];
    [scheduler setBlock:^{
        fired = YES;
    }];
    
    NSDate *twoSecondsBeforeNow = [NSDate dateWithTimeIntervalSince1970:0.0];
    [[[currentDateWrapper stub] andReturnValue:OCMOCK_VALUE((NSTimeInterval){-2.0})] timeUntilDate:twoSecondsBeforeNow];
    [scheduler scheduleOnDate:twoSecondsBeforeNow];
    
    STAssertTrue(fired, nil);
}

@end
