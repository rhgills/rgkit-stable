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
    @throw @"Not yet implemented.";
}

- (void)callback:(id<RHGCurrentDateWrapperDelegate>)delegate afterTimeInterval:(NSTimeInterval)theInterval
{
    @throw @"NYI";
}

- (NSTimeInterval)timeUntilDate:(NSDate *)date
{
    @throw @"NYI";
}

@end
