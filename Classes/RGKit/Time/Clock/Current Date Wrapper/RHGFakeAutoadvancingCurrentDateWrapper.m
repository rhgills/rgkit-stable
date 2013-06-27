//
//  RHGFakeAutoadvancingCurrentDateWrapper.m
//  Phoenix
//
//  Created by Robert Gilliam on 4/16/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGFakeAutoadvancingCurrentDateWrapper.h"


@interface RHGFakeAutoadvancingCurrentDateWrapper ()

@property (readonly) NSDate *fakeStartDate;
@property (readonly) NSTimeInterval systemStartTimeInterval;

@end


@implementation RHGFakeAutoadvancingCurrentDateWrapper

- (id)initWithStartDate:(NSDate *)date
{
    self = [super init];
    if (!self) return nil;
    
    _fakeStartDate = date;
    _systemStartTimeInterval = [NSDate timeIntervalSinceReferenceDate];
    
    return self;
}

- (id)init
{
    [NSException raise:NSInternalInconsistencyException format:@"%@: use the designated init, not %@.", [self class], NSStringFromSelector(_cmd)];
    return nil;
}

- (NSDate *)currentDate
{
    NSTimeInterval systemCurrentTimeInterval = [NSDate timeIntervalSinceReferenceDate];
    return [NSDate dateWithTimeInterval:systemCurrentTimeInterval - self.systemStartTimeInterval sinceDate:self.fakeStartDate];
}
- (NSDate *)dateForNextOccurenceOfHour:(NSInteger)hour
{
    @throw @"Not yet implemented.";
}

- (NSTimeInterval)timeUntilDate:(NSDate *)date
{
    return [date timeIntervalSinceDate:[self currentDate]];
}

- (void)callback:(id<RHGCurrentDateWrapperDelegate>)delegate afterTimeInterval:(NSTimeInterval)theInterval
{
    NSMethodSignature *signature = [(id)delegate methodSignatureForSelector:@selector(timeIntervalDidElapse:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:delegate];
    [invocation setSelector:@selector(timeIntervalDidElapse:)];
    [invocation setArgument:&theInterval atIndex:2];
    
    [NSTimer scheduledTimerWithTimeInterval:theInterval invocation:invocation repeats:NO];
}

@end