//
//  RHGNSTimerWidgetTests.m
//  Phoenix
//
//  Created by Robert Gilliam on 6/21/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGAutoverifyingSenTestCase.h"

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

//- (void)testBlockCalledIfTimeAlreadyPassed
//{
//    __block BOOL blockCalled = NO;
//    clock.block = ^{
//        blockCalled = YES;
//    };
//    
//    [clock scheduleOnDate:[NSDate dateWithTimeIntervalSince1970:0]];
//    
//    STAssertTrue(blockCalled, nil);
//}
//
//- (void)testBlockCalledWhenScheduledDateArrives
//{
//    __block BOOL blockCalled = NO;
//    clock.block = ^{
//        blockCalled = YES;
//    };
//    
//    [clock scheduleOnDate:[NSDate dateWithTimeIntervalSince1970:1.0]];
//    STAssertFalse(blockCalled, nil);
//    
//    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSince1970:1.1]];
//    STAssertTrue(blockCalled, nil);
//}

@end
