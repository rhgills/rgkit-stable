//
//  RHGFakeCurrentDateWrapper.m
//  Phoenix
//
//  Created by Robert Gilliam on 4/12/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGFakeCurrentDateWrapper.h"

@interface RHGFakeCurrentDateWrapper ()

@property id <RHGTimerWrapperDelegate> waitingDelegate;
@property NSDate *waitingDate;

@end



@implementation RHGFakeCurrentDateWrapper

@synthesize frozenDate = _frozenDate;

- (id)init
{
    return [self initWithFrozenDate:[NSDate dateWithTimeIntervalSince1970:0]];
}

- (id)initWithFrozenDate:(NSDate *)theFrozenDate
{
    self = [super init];
    if (!self) return nil;
    
    _frozenDate = theFrozenDate;
    
    return self;
}

- (void)setFrozenDate:(NSDate *)frozenDate
{
    _frozenDate = frozenDate;
    
    [self notifyWaitingDelegateIfTargetDateReached];
}

- (NSDate *)currentDate
{
    return self.frozenDate;
}

- (NSDate *)dateForNextOccurenceOfHour:(NSInteger)hour
{
[NSException raise:NSInternalInconsistencyException format:@"%@: %@ is not yet implemented.", [self class], NSStringFromSelector(_cmd)];
}

- (NSTimeInterval)timeUntilDate:(NSDate *)date
{
    return [date timeIntervalSinceDate:[self currentDate]];
}

- (void)callback:(id<RHGTimerWrapperDelegate>)delegate onDate:(NSDate *)theDate
{
    self.waitingDelegate = delegate;
    self.waitingDate = theDate;

    [self notifyWaitingDelegateIfTargetDateReached];
}

- (void)notifyWaitingDelegateIfTargetDateReached
{
    if (self.waitingDelegate) {
        NSTimeInterval timeUntilDate = [self timeUntilDate:self.waitingDate];
        if (timeUntilDate <= 0) {
            [self.waitingDelegate dateReached:self.waitingDate];
            self.waitingDelegate = nil;
            self.waitingDate = nil;
        }
    }
}

@end
