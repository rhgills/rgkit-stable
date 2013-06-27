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



@implementation RHGFakeFrozenClock

@synthesize block;

- (id)init
{
    [NSException raise:NSInternalInconsistencyException format:@"%@: use the designated init, not %@.", [self class], NSStringFromSelector(_cmd)];
    return nil;
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

- (void)scheduleOnDate:(NSDate *)theDate
{
    if ([[self currentDate] earlierDate:theDate] == [self currentDate]) {
        if ([self block]) {
            [self block]();
        }
    }else{
        // do nothing - time is frozen, so it will never fire
    }
}

- (void)callback:(id<RHGTimerWrapperDelegate>)delegate onDate:(NSDate *)theDate
{
    [[self currentDateWrapper] callback:delegate onDate:theDate];
}

@end
