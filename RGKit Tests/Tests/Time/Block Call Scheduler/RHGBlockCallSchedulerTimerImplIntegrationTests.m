//
//  RHGNSTimerWidgetTests.m
//  Phoenix
//
//  Created by Robert Gilliam on 6/21/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//



@interface RHGBlockCallSchedulerTimerImplIntegrationTests : RHGAutoverifyingSenTestCase

@end



#import "RHGBlockCallSchedulerTimerImpl.h"
#import <RHGNSDateCurrentDateWrapper.h>

@implementation RHGBlockCallSchedulerTimerImplIntegrationTests {
    RHGBlockCallSchedulerTimerImpl *scheduler;
    
    NSDate *scheduledDate;
}

- (void)setUp
{
    [super setUp];
    
    id <RHGCurrentDateWrapper> currentDateWrapper = [[RHGNSDateCurrentDateWrapper alloc] init];
    scheduler = [[RHGBlockCallSchedulerTimerImpl alloc] initWithCurrentDateWrapper:currentDateWrapper];
    
    scheduledDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
}

- (void)testFires
{
    __block BOOL fired = NO;
    [scheduler do:^{
        fired = YES;
    } onDate:scheduledDate];
    
    STAssertFalse(fired, nil);
    
    [self advanceTimeUntil:scheduledDate];
    
    STAssertTrue(fired, nil);
}

- (void)advanceTimeUntil:(NSDate *)date
{
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeInterval:0.1 sinceDate:date]];
}

@end
