//
//  RHGFakeCurrentDateWrapper.m
//  Phoenix
//
//  Created by Robert Gilliam on 4/12/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGFakeCurrentDateWrapper.h"
#import "DDLog.h"



static int ddLogLevel = LOG_LEVEL_WARN;



@implementation RHGFakeCurrentDateWrapper {
    NSMutableArray *waitingDelegates;
    NSMutableArray *waitingDates;
}

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
    
    waitingDelegates = [NSMutableArray array];
    waitingDates = [NSMutableArray array];
    
    return self;
}

- (void)setFrozenDate:(NSDate *)frozenDate
{
    _frozenDate = frozenDate;
    
    [self notifyWaitingDelegatesIfTargetDateReached];
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
    [waitingDelegates addObject:delegate];
    [waitingDates addObject:theDate];
    
    [self notifyWaitingDelegatesIfTargetDateReached];
}

- (void)notifyWaitingDelegatesIfTargetDateReached
{
    NSMutableIndexSet *finishedIndices = [self finishedIndicesByRunningDelegatesPastTargetDate];
    [self markDelegatesNoLongerWaiting:finishedIndices];
}

- (NSMutableIndexSet *)finishedIndicesByRunningDelegatesPastTargetDate
{
    NSMutableIndexSet *finishedIndices = [[NSMutableIndexSet alloc] init];
    [waitingDelegates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id <RHGTimerWrapperDelegate> aWaitingDelegate = waitingDelegates[idx];
        NSDate *aWaitingDate = waitingDates[idx];
        
        if ([self notifyWaitingDelegate:aWaitingDelegate ifDateReached:aWaitingDate])
            [finishedIndices addIndex:idx];
    }];
    
    return finishedIndices;
}

- (BOOL)notifyWaitingDelegate:(id)aWaitingDelegate ifDateReached:(NSDate *)aWaitingDate
{
    NSTimeInterval timeUntilDate = [self timeUntilDate:aWaitingDate];
    if (timeUntilDate <= 0) {
        [aWaitingDelegate dateReached:aWaitingDate];
        return YES;
    }
    
    return NO;
}

- (void)markDelegatesNoLongerWaiting:(NSMutableIndexSet *)finishedIndices
{
    [waitingDelegates removeObjectsAtIndexes:finishedIndices];
    [waitingDates removeObjectsAtIndexes:finishedIndices];
}

@end