//
//  RHGFakeCurrentDateWrapper.m
//  Phoenix
//
//  Created by Robert Gilliam on 4/12/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGFakeCurrentDateWrapper.h"

@implementation RHGFakeCurrentDateWrapper

- (id)initWithFrozenDate:(NSDate *)theFrozenDate
{
    self = [super init];
    if (!self) return nil;
    
    _frozenDate = theFrozenDate;
    
    return self;
}

- (NSDate *)currentDate
{
    return self.frozenDate;
}

- (NSDate *)dateForNextOccurenceOfHour:(NSInteger)hour
{
[NSException raise:NSInternalInconsistencyException format:@"%@: %@ is not yet implemented.", [self class], NSStringFromSelector(_cmd)];
}

- (void)callback:(id<RHGTimerWrapperDelegate>)delegate afterTimeInterval:(NSTimeInterval)theInterval
{
[NSException raise:NSInternalInconsistencyException format:@"%@: %@ is not yet implemented.", [self class], NSStringFromSelector(_cmd)];
}

- (NSTimeInterval)timeUntilDate:(NSDate *)date
{
    [NSException raise:NSInternalInconsistencyException format:@"%@: %@ is not yet implemented.", [self class], NSStringFromSelector(_cmd)];
}

- (void)callback:(id<RHGTimerWrapperDelegate>)delegate onDate:(NSDate *)theDate
{
    [NSException raise:NSInternalInconsistencyException format:@"%@: %@ is not yet implemented.", [self class], NSStringFromSelector(_cmd)];
}

@end
