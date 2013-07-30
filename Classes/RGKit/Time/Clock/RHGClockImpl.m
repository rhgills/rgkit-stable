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

- (void)do:(TimerWidgetVoidBlock)theBlock onDate:(NSDate *)theDate
{
    [_blockCallScheduler do:theBlock onDate:theDate];
}

- (NSTimeInterval)timeUntilDate:(NSDate *)date
{
    return [[self currentDateWrapper] timeUntilDate:date];
}

- (void)callback:(id<RHGTimerWrapperDelegate>)delegate onDate:(NSDate *)theDate
{
    [[self currentDateWrapper] callback:delegate onDate:theDate];
}

@end
