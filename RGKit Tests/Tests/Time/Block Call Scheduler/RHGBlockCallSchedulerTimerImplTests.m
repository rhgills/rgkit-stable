//
//  RHGBlockCallSchedulerTimerImplTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 7/30/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGAutoverifyingSenTestCase.h"
#import "RHGBlockCallSchedulerTimerImpl.h"

@interface RHGBlockCallSchedulerTimerImplTests : RHGAutoverifyingSenTestCase

@end



@implementation RHGBlockCallSchedulerTimerImplTests {
    RHGBlockCallSchedulerTimerImpl *scheduler;
    
    id cdw;
    
    NSDate *scheduledDate;
    NSDate *otherScheduledDate;
}

- (void)setUp
{
    [super setUp];
    
    cdw = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapper)];
    scheduler = [[RHGBlockCallSchedulerTimerImpl alloc] initWithCurrentDateWrapper:cdw];
    
    scheduledDate = [NSDate dateWithTimeIntervalSince1970:1.0];
    otherScheduledDate = [NSDate dateWithTimeIntervalSince1970:2.0];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testRunsBlockWhenTimeReached;
{
    [[cdw expect] callback:scheduler onDate:scheduledDate];
    __block BOOL run = NO;
    [scheduler do:^{
        run = YES;
    } onDate:scheduledDate];

    assertThatBool(run, equalToBool(NO));
    [scheduler dateReached:scheduledDate];
    assertThatBool(run, equalToBool(YES));
}

- (void)testRunsMultipleBlocksWhenSameTimeReached;
{
    [[cdw expect] callback:scheduler onDate:scheduledDate];
    __block BOOL run1 = NO;
    [scheduler do:^{
        run1 = YES;
    } onDate:scheduledDate];
    
    [[cdw expect] callback:scheduler onDate:scheduledDate];
    __block BOOL run2 = NO;
    [scheduler do:^{
        run2 = YES;
    } onDate:scheduledDate];
    
    assertThatBool(run1, equalToBool(NO));
    assertThatBool(run2, equalToBool(NO));
    [scheduler dateReached:scheduledDate];
    
    assertThatBool(run1, equalToBool(YES));
    assertThatBool(run2, equalToBool(YES));
}

- (void)testRunsMultipleBlocksWhenDifferentTimesReached;
{
    [[cdw expect] callback:scheduler onDate:scheduledDate];
    __block BOOL run1 = NO;
    [scheduler do:^{
        run1 = YES;
    } onDate:scheduledDate];
    
    [[cdw expect] callback:scheduler onDate:otherScheduledDate];
    __block BOOL run2 = NO;
    [scheduler do:^{
        run2 = YES;
    } onDate:otherScheduledDate];
    
    assertThatBool(run1, equalToBool(NO));
    assertThatBool(run2, equalToBool(NO));
    
    [scheduler dateReached:scheduledDate];
    
    assertThatBool(run1, equalToBool(YES));
    assertThatBool(run2, equalToBool(NO));
    
    [scheduler dateReached:otherScheduledDate];
    
    assertThatBool(run2, equalToBool(YES));
}

@end
