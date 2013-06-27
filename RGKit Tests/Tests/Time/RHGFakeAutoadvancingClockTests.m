//
//  RHGFakeAutoadvancingClockTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGAutoverifyingSenTestCase.h"
#import <RHGFakeAutoadvancingClock.h>

@interface RHGFakeAutoadvancingClockTests : RHGAutoverifyingSenTestCase

@end


@implementation RHGFakeAutoadvancingClockTests {
    RHGFakeAutoadvancingClock *clock;
}

- (void)setUp
{
    [super setUp];
    
    clock = [[RHGFakeAutoadvancingClock alloc] initWithFrozenDate:[NSDate dateWithTimeIntervalSince1970:0]];
}

- (void)testBlockCalledIfTimeAlreadyPassed
{
    __block BOOL blockCalled = NO;
    clock.block = ^{
        blockCalled = YES;
    };
    
    [clock scheduleOnDate:[NSDate dateWithTimeIntervalSince1970:0]];
    
    STAssertTrue(blockCalled, nil);
}

- (void)testBlockCalledWhenScheduledDateArrives
{
    __block BOOL blockCalled = NO;
    clock.block = ^{
        blockCalled = YES;
    };
    
    [clock scheduleOnDate:[NSDate dateWithTimeIntervalSince1970:1.0]];
    STAssertFalse(blockCalled, nil);
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    STAssertTrue(blockCalled, nil);
}

@end
