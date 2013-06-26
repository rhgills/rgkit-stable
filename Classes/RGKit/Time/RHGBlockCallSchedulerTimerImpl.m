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
    self = [super init];
    if (!self) return nil;
    
    
    
    return self;
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
    
//    NSTimeInterval timeUntilDate = [[self currentDateWrapper] timeUntilDate:theDate];
//    NSTimer *timer = [NSTimer timerWithTimeInterval:timeUntilDate target:self selector:@selector(timerFired:) userInfo:nil repeats:NO];
    
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:theDate
                                              interval:0
                                                target:self
                                              selector:@selector(timerFired:)
                                              userInfo:nil
                                               repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    NSLog(@"%@ scheduled to fire on date: %@", self, theDate);
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

@end
