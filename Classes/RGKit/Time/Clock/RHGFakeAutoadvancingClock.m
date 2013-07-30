//
//  RHGFakeAutoadvancingClock.m
//  
//
//  Created by Robert Gilliam on 6/26/13.
//
//

#import "RHGFakeAutoadvancingClock.h"
#import "RHGFakeAutoadvancingCurrentDateWrapper.h"
#import "RHGBlockCallSchedulerTimerImpl.h"



@interface RHGFakeAutoadvancingClock ()

@property (readonly) RHGFakeAutoadvancingCurrentDateWrapper *currentDateWrapper;
@property (readonly) RHGBlockCallSchedulerTimerImpl *blockCallScheduler;

@end

@implementation RHGFakeAutoadvancingClock

- (id)init
{
    [NSException raise:NSInternalInconsistencyException format:@"%@: use the designated init, not %@.", [self class], NSStringFromSelector(_cmd)];
    return nil;
}

- (id)initWithFrozenDate:(NSDate *)theDate;
{
    self = [super init];
    if (!self) return nil;
    
    _currentDateWrapper = [[RHGFakeAutoadvancingCurrentDateWrapper alloc] initWithStartDate:theDate];
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

- (NSTimeInterval)timeUntilDate:(NSDate *)date
{
    return [[self currentDateWrapper] timeUntilDate:date];
}

- (void)do:(TimerWidgetVoidBlock)theBlock onDate:(NSDate *)theDate;
{
    [_blockCallScheduler do:theBlock onDate:theDate];
}

- (void)callback:(id<RHGTimerWrapperDelegate>)delegate onDate:(NSDate *)theDate
{
    [[self currentDateWrapper] callback:delegate onDate:theDate];
}

@end
