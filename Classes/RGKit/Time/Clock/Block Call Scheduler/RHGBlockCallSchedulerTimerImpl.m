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

- (void)timerFired:(NSTimer *)theTimer;

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
    
    NSTimeInterval timeUntilDate = [[self currentDateWrapper] timeUntilDate:theDate];
    if (timeUntilDate <= 0.0) {
        [self callScheduledBlock];
        return;
    }
    [[self currentDateWrapper] callback:self afterTimeInterval:timeUntilDate];
    
//    NSTimeInterval timeUntilDate = [[self currentDateWrapper] timeUntilDate:theDate];
//    if (timeUntilDate <= 0.0) {
//        [self callScheduledBlock];
//        return;
//    }
//
//    NSTimer *timer = [NSTimer timerWithTimeInterval:timeUntilDate target:self selector:@selector(timerFired:) userInfo:nil repeats:NO];
//        
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    NSLog(@"%@ scheduled to fire on date: %@", self, theDate);
}

- (void)timeIntervalDidElapse:(NSTimeInterval)theInterval
{
    [self callScheduledBlock];
}

- (void)timerFired:(NSTimer *)theTimer
{
    NSLog(@"%@ fired!", self);
    
    if ([self block]) {
        [self block]();
    }else{
        DDLogWarn(@"nil block when %@ fired.", self);
    }
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
