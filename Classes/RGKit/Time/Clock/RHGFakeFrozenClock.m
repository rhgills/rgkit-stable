//
//  RHGFakeFrozenClock.m
//  
//
//  Created by Robert Gilliam on 6/26/13.
//
//

#import "RHGFakeFrozenClock.h"
#import "RHGFakeCurrentDateWrapper.h"

@interface RHGFakeFrozenClock ()

@property (readonly) RHGFakeCurrentDateWrapper *currentDateWrapper;

@end



@implementation RHGFakeFrozenClock {
    TimerWidgetVoidBlock block;
    NSDate *scheduledDate;
}

@dynamic frozenDate;

- (id)init
{
    return [self initWithFrozenDate:[NSDate dateWithTimeIntervalSince1970:0.0]];
}

- (id)initWithFrozenDate:(NSDate *)theDate;
{
    self = [super init];
    if (!self) return nil;
    
    _currentDateWrapper = [[RHGFakeCurrentDateWrapper alloc] initWithFrozenDate:theDate];
    
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
    scheduledDate = theDate;
    block = theBlock;

    [self callBlockIfScheduledDatePassed];
}

- (void)callBlockIfScheduledDatePassed;
{
    NSDate *now = [self currentDate];
    if (block && [now laterDate:scheduledDate] == now) {
        block();
    }
}

- (void)callback:(id<RHGTimerWrapperDelegate>)delegate onDate:(NSDate *)theDate
{
    [[self currentDateWrapper] callback:delegate onDate:theDate];
}

- (void)setFrozenDate:(NSDate *)frozenDate;
{
    [[self currentDateWrapper] setFrozenDate:frozenDate];

    [self callBlockIfScheduledDatePassed];
}

- (NSDate *)frozenDate;
{
    return [[self currentDateWrapper] frozenDate];
}

@end
