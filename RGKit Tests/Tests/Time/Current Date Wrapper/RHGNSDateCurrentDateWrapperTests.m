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
}

- (void)setUp
{
    [super setUp];
    
    currentDateWrapper = [[RHGNSDateCurrentDateWrapper alloc] init];
}

- (void)testCallsBackOnDate
{
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapperDelegate)];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.1];
    [currentDateWrapper callback:delegate onDate:date];
    
    [[delegate expect] dateReached:date];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
}

- (void)testCallsBackImmediatelyIfDateElapsed
{
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapperDelegate)];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-0.1];
    
    [[delegate expect] dateReached:date];
    [currentDateWrapper callback:delegate onDate:date];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
}

@end
