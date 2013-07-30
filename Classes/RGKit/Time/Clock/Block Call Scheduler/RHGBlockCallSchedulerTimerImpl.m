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



@implementation RHGBlockCallSchedulerTimerImpl {
    NSMutableDictionary *blocksForFireDate;
}

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
    blocksForFireDate = [[NSMutableDictionary alloc] init];
    
    return self;
}

- (void)dateReached:(NSDate *)theDate
{
    NSArray *blocks = [blocksForFireDate objectForKey:theDate];
    for (TimerWidgetVoidBlock aBlock in blocks) {
        aBlock();
    }
    [blocksForFireDate removeObjectForKey:theDate];
}

- (void)do:(TimerWidgetVoidBlock)theBlock onDate:(NSDate *)theDate
{
    [self addBlock:theBlock forFireDate:theDate];
    
    [[self currentDateWrapper] callback:self onDate:theDate];
}

- (void)addBlock:(TimerWidgetVoidBlock)theBlock forFireDate:(NSDate *)theDate;
{
    NSMutableArray *existingBlocks = [blocksForFireDate objectForKey:theDate];
    if (!existingBlocks) {
        existingBlocks = [[NSMutableArray alloc] init];
        [blocksForFireDate setObject:existingBlocks forKey:theDate];
    }
    
    [existingBlocks addObject:[theBlock copy]];
}

@end



NSString * RHGBlockCallSchedulerBlockNotSetException = @"RHGBlockCallSchedulerBlockNotSetException";
