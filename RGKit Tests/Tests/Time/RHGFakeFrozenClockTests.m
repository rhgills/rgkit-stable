//
// Created by Robert Gilliam on 9/17/13.
// Copyright (c) 2013 Robert Gilliam. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RHGFakeFrozenClockTests.h"


@implementation RHGFakeFrozenClockTests {
    __block BOOL blockCalled;

    RHGFakeFrozenClock *clock;
}

- (RHGFakeFrozenClock *)clockScheduledToCallBlockAtTime:(NSTimeInterval)scheduledTimeSince1970;
{
    return [self clockStartingAt:0.0 scheduledToCallBlockAtTime:scheduledTimeSince1970];
}

- (RHGFakeFrozenClock *)clockStartingAt:(NSTimeInterval)startSince1970 scheduledToCallBlockAtTime:(NSTimeInterval)scheduledTimeSince1970;
{
    RHGFakeFrozenClock *c = [[RHGFakeFrozenClock alloc] initWithFrozenDate:[NSDate dateWithTimeIntervalSince1970:startSince1970]];

    [c do:^{
        blockCalled = YES;
    }  onDate:[NSDate dateWithTimeIntervalSince1970:scheduledTimeSince1970]];

    return c;
}

- (void)testDoesNotCallBlockWhenScheduledLater
{
    clock = [self clockScheduledToCallBlockAtTime:1.0];

    STAssertFalse(blockCalled, nil);
}

- (void)testCallsBlockWhenTimeAdvancesToScheduledDate
{
    clock = [self clockScheduledToCallBlockAtTime:5.0];
    [clock setFrozenDate:[NSDate dateWithTimeIntervalSince1970:5.0]];

    STAssertTrue(blockCalled, nil);
}

- (void)testDoesNotCallBlockWhenTimeAdvancesBeforeScheduledDate
{
    clock = [self clockScheduledToCallBlockAtTime:5.0];
    [clock setFrozenDate:[NSDate dateWithTimeIntervalSince1970:4.0]];

    STAssertFalse(blockCalled, nil);
}

- (void)testCallsBlockImmediatelyIfScheduledEarlierThanCurrentDate
{
    clock = [self clockStartingAt:2.0 scheduledToCallBlockAtTime:1.0];

    STAssertTrue(blockCalled, nil);
}

@end