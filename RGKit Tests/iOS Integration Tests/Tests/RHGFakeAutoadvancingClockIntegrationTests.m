//
//  RHGFakeAutoadvancingClockTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//


#import <RHGFakeAutoadvancingClock.h>

@interface RHGFakeAutoadvancingClockIntegrationTests : RHGAutoverifyingSenTestCase

@end


@implementation RHGFakeAutoadvancingClockIntegrationTests {
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
    [clock do:^{
        blockCalled = YES;
    } onDate:[NSDate dateWithTimeIntervalSince1970:0]];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    STAssertTrue(blockCalled, nil);
}

- (void)testBlockCalledWhenScheduledDateArrives
{
    __block BOOL blockCalled = NO;
    [clock do:^{
        blockCalled = YES;
    } onDate:[NSDate dateWithTimeIntervalSince1970:1.0]];
    
    STAssertFalse(blockCalled, nil);
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.1]];
    
    STAssertTrue(blockCalled, nil);
}

@end
