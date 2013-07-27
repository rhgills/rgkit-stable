//
//  RHGClockImplTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/26/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//


#import "RHGClockImpl.h"

@interface RHGClockImplIntegrationTests : RHGAutoverifyingSenTestCase

@end



@implementation RHGClockImplIntegrationTests {
    RHGClockImpl *clock;
}

- (void)setUp
{
    [super setUp];
    
    clock = [[RHGClockImpl alloc] init];
}

- (void)testFires
{
    __block BOOL fired = NO;
    
    [clock setBlock:^{
        fired = YES;
    }];
    
    NSDate *oneHundredMillisecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:0.1];
    [clock scheduleOnDate:oneHundredMillisecondsFromNow];
    
    STAssertFalse(fired, nil);
    
    NSDate *twoHundredMillisecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:0.2];
    [[NSRunLoop currentRunLoop] runUntilDate:twoHundredMillisecondsFromNow];
    
    STAssertTrue(fired, nil);
}

- (void)testReturnsCurrentDate
{
    NSTimeInterval delta = [[clock currentDate] timeIntervalSinceDate:[NSDate date]];
    STAssertEqualsWithAccuracy(delta, 0.0, .05, nil);
}

- (void)testNextOccurenceOfHourOccursToday
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    components.hour = 4;
    
    NSDate *fourAm = [[NSCalendar currentCalendar] dateFromComponents:components];
    [self setCurrentDateTo:fourAm];
    
    NSDate *fiveAm = [clock dateForNextOccurenceOfHour:5];
    NSDateComponents *fiveAmComponents = [[NSCalendar currentCalendar] components:(NSDayCalendarUnit) fromDate:fiveAm];
    
    STAssertEquals(fiveAmComponents.day, components.day, nil);
}

- (void)testNextOccurenceOfHourOccursTomorrow
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    components.hour = 6;
    
    NSDate *sixAm = [[NSCalendar currentCalendar] dateFromComponents:components];
    [self setCurrentDateTo:sixAm];
    
    NSDate *fiveAm = [clock dateForNextOccurenceOfHour:5];
    NSDateComponents *fiveAmComponents = [[NSCalendar currentCalendar] components:(NSDayCalendarUnit) fromDate:fiveAm];
    
    STAssertEquals(fiveAmComponents.day, components.day + 1, nil);
}

- (void)testNextOccurenceOfHourIsCurrentHour
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    components.hour = 5;
    
    NSDate *fiveAm = [[NSCalendar currentCalendar] dateFromComponents:components];
    [self setCurrentDateTo:fiveAm];
    
    NSDate *dateForNextOccurance = [clock dateForNextOccurenceOfHour:5];
    NSDateComponents *dateForNextOccuranceComponents = [[NSCalendar currentCalendar] components:(NSDayCalendarUnit) fromDate:dateForNextOccurance];
    
    STAssertEquals(components.day, dateForNextOccuranceComponents.day, nil);
}

- (void)setCurrentDateTo:(NSDate *)currentDate
{
    id fakeCurrentDateWrapper = [OCMockObject partialMockForObject:[clock currentDateWrapper]];
    [[[fakeCurrentDateWrapper stub] andReturn:currentDate] currentDate];
}

- (NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (void)testTimeUntilDate
{
    NSDate *fiveAm = [self dateWithHour:5 minute:0 second:0];
    [self setCurrentDateTo:fiveAm];

    NSDate *fiveTen = [self dateWithHour:5 minute:10 second:0];
    NSTimeInterval timeUntilFiveTen = [clock timeUntilDate:fiveTen];
    
    STAssertEquals(timeUntilFiveTen, 10.0 * 60.0, nil);
}

@end
