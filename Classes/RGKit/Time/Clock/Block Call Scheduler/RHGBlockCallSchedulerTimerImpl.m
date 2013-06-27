//
//  RHGNSTimerWidget.m
//  Phoenix
//
//  Created by Robert Gilliam on 6/21/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGBlockCallSchedulerTimerImpl.h"
#import <DDLog.h>
#import <RHGHelperMacros.h>

static int ddLogLevel = LOG_LEVEL_WARN;



@interface RHGBlockCallSchedulerTimerImpl ()

@property (readonly) id <RHGCurrentDateWrapper> currentDateWrapper;

@end



@implementation RHGBlockCallSchedulerTimerImpl

@synthesize block = _block;

- (id)init
{
    [NSException raise:NSInternalInconsistencyException format:@"%@: use the designated init, not %@.", [self class], NSStringFromSelector(_cmd)];
    return nil;
}

- (id)initWithCurrentDateWrapper:(id<RHGCurrentDateWrapper>)theCurrentDateWrapper
{
    self = [super init];
    if (!self) return nil;
    
    _currentDateWrapper = theCurrentDateWrapper;
    
    return self;
}

- (void)scheduleOnDate:(NSDate *)theDate
{
    RHGAssert([self block], @"set the block before scheduling");
    
    [[self currentDateWrapper] callback:self onDate:theDate];
//    NSTimeInterval timeUntilDate = [[self currentDateWrapper] timeUntilDate:theDate];
//    if (timeUntilDate <= 0.0) {
//        [self callScheduledBlock];
//        return;
//    }
//    [[self currentDateWrapper] callback:self afterTimeInterval:timeUntilDate];
}

- (void)dateReached:(NSDate *)theDate
{
    [self callScheduledBlock];
}

- (void)timeIntervalDidElapse:(NSTimeInterval)theInterval
{
    [self callScheduledBlock];
}

- (void)callScheduledBlock
{
    if ([self block]) {
        [self block]();
    }else{
        DDLogWarn(@"nil block when %@ fired.", self);
    }
}


@end
