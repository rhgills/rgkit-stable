//
//  RHGNSDateCurrentDateWrapper.m
//  silver
//
//  Created by Robert Gilliam on 3/20/13.
//  Copyright (c) 2013 Robert. All rights reserved.
//

#import "RHGNSDateCurrentDateWrapper.h"

@implementation RHGNSDateCurrentDateWrapper

+ (RHGNSDateCurrentDateWrapper *)sharedInstance {
    static RHGNSDateCurrentDateWrapper *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    
    return _sharedInstance;
}

- (NSDate *)currentDate
{
    return [NSDate date];
}

- (NSDate *)dateForNextOccurenceOfHour:(NSInteger)hour
{
    NSDate *currentDate = [self currentDate];
    NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit) fromDate:currentDate];
    NSDateComponents *dayToFireComponents = nil;
    
    if (currentDateComponents.hour > hour) {
        NSDateComponents *addingComponents = [[NSDateComponents alloc] init];
        addingComponents.day = 1;
        NSDate *dayToFire = [[NSCalendar currentCalendar] dateByAddingComponents:addingComponents toDate:currentDate options:0];
        dayToFireComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit) fromDate:dayToFire];
    }else{
        // will fire today
        dayToFireComponents = currentDateComponents;
    }
    
    dayToFireComponents.hour = hour;
    return [[NSCalendar currentCalendar] dateFromComponents:dayToFireComponents];
}

@end