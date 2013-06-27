//
//  RHGClockImpl.m
//  
//
//  Created by Robert Gilliam on 6/26/13.
//
//

#import "RHGClockImpl.h"

#import "RHGBlockCallSchedulerTimerImpl.h"
#import "RHGNSDateCurrentDateWrapper.h"


@interface RHGClockImpl ()

@property (readonly) RHGBlockCallSchedulerTimerImpl *blockCallScheduler;


@end

@implementation RHGClockImpl

@dynamic block;

- (id)init;
{
    self = [super init];
    if (!self) return nil;
    
    _currentDateWrapper = [[RHGNSDateCurrentDateWrapper alloc] init];
    _blockCallScheduler = [[RHGBlockCallSchedulerTimerImpl alloc] initWithCurrentDateWrapper:_currentDateWrapper];
    
    return self;
}

- (NSDate *)currentDate
{
    return [[self currentDateWrapper] currentDate];
}

- (NSDate *)dateForNextOccurenceOfHour:(NSInteger)hour
{
    return [[self currentDateWrapper] dateForNextOccurenceOfHour:hour];
}

- (void)scheduleOnDate:(NSDate *)theDate
{
    [[self blockCallScheduler] scheduleOnDate:theDate];
}

- (void)setBlock:(TimerWidgetVoidBlock)block
{
    [[self blockCallScheduler] setBlock:block];
}

- (TimerWidgetVoidBlock)block
{
    return [[self blockCallScheduler] block];
}

- (NSTimeInterval)timeUntilDate:(NSDate *)date
{
    return [[self currentDateWrapper] timeUntilDate:date];
}

@end
