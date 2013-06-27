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

@dynamic block;

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

- (void)scheduleOnDate:(NSDate *)theDate
{
    [[self blockCallScheduler] scheduleOnDate:theDate];
}

- (void)setBlock:(TimerWidgetVoidBlock)theBlock
{
    [[self blockCallScheduler] setBlock:theBlock];
}

- (TimerWidgetVoidBlock)block
{
    return [[self blockCallScheduler] block];
}

- (void)callback:(id<RHGCurrentDateWrapperDelegate>)delegate afterTimeInterval:(NSTimeInterval)theInterval
{
    [[self currentDateWrapper] callback:delegate afterTimeInterval:theInterval];
}

@end
