//
//  RHGNSTimerWidgetTests.m
//  Phoenix
//
//  Created by Robert Gilliam on 6/21/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//



@interface RHGBlockCallSchedulerTimerImplTests : RHGAutoverifyingSenTestCase

@end



#import "RHGBlockCallSchedulerTimerImpl.h"
#import <RHGNSDateCurrentDateWrapper.h>

@implementation RHGBlockCallSchedulerTimerImplTests {
    RHGBlockCallSchedulerTimerImpl *scheduler;
}

// integration w/ NSDateCurrentDateWrapper
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

- (void)testFiresMockBetterIsolatedDate
{
    __block BOOL fired = NO;
    
    id currentDateWrapper = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapper)];
    
    scheduler = [[RHGBlockCallSchedulerTimerImpl alloc] initWithCurrentDateWrapper:currentDateWrapper];
    [scheduler setBlock:^{
        fired = YES;
    }];
    
    NSDate *twoSecondsFromNow = [NSDate dateWithTimeIntervalSince1970:2.0];
    [[currentDateWrapper expect] callback:scheduler onDate:twoSecondsFromNow];
    [scheduler scheduleOnDate:twoSecondsFromNow];
    
    STAssertFalse(fired, nil);
    
    [scheduler dateReached:twoSecondsFromNow];
    
    STAssertTrue(fired, nil);
}

@end
