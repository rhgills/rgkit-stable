//
//  RHGFakeCurrentDateWrapperTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <RHGFakeCurrentDateWrapper.h>

@interface RHGFakeCurrentDateWrapperTests : RHGAutoverifyingSenTestCase

@end



@implementation RHGFakeCurrentDateWrapperTests {
    RHGFakeCurrentDateWrapper *currentDateWrapper;
}

- (void)setUp
{
    [super setUp];
}

- (void)givenInit
{
    currentDateWrapper = [[RHGFakeCurrentDateWrapper alloc] init];
}

- (void)testDefaultsTo1970
{
    currentDateWrapper = [[RHGFakeCurrentDateWrapper alloc] init];
    
    assertThat([currentDateWrapper frozenDate], equalTo([NSDate dateWithTimeIntervalSince1970:0]));
}

- (void)testSetsFrozenDate
{
    currentDateWrapper = [[RHGFakeCurrentDateWrapper alloc] initWithFrozenDate:[NSDate dateWithTimeIntervalSince1970:5.0]];
    
    assertThat([currentDateWrapper frozenDate], equalTo([NSDate dateWithTimeIntervalSince1970:5.0]));
}

- (void)testCanChangeFrozenDateLater
{
    [self givenInit];
    
    currentDateWrapper.frozenDate = [NSDate dateWithTimeIntervalSince1970:5.0];
    
    assertThat([currentDateWrapper frozenDate], equalTo([NSDate dateWithTimeIntervalSince1970:5.0]));
}

- (void)testTimeUntilDate
{
    [self givenInit];
    
    NSDate *targetDate = [NSDate dateWithTimeIntervalSince1970:5.0];
    NSTimeInterval timeUntil = [currentDateWrapper timeUntilDate:targetDate];
    
    assertThatDouble(timeUntil, equalToDouble(5.0));
}

- (void)testCallsDelegateWhenDateReached
{
    [self givenInit];
    
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGTimerWrapperDelegate)];
    NSDate *targetDate = [NSDate dateWithTimeIntervalSince1970:5.0];
    [currentDateWrapper callback:delegate onDate:targetDate];
    
    [[delegate expect] dateReached:targetDate];
    
    [currentDateWrapper setFrozenDate:targetDate];
}

- (void)testCallsDelegateWhenDatePassed
{
    [self givenInit];
    
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGTimerWrapperDelegate)];
    NSDate *targetDate = [NSDate dateWithTimeIntervalSince1970:5.0];
    [currentDateWrapper callback:delegate onDate:targetDate];
    
    [[delegate expect] dateReached:targetDate];
    
    [currentDateWrapper setFrozenDate:[NSDate dateWithTimeInterval:60000.0 sinceDate:targetDate]];
}

@end
