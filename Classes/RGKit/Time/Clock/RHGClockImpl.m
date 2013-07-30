//
//  RHGClockImpl.m
//  
//
//  Created by Robert Gilliam on 6/26/13.
//
//

#import "RHGClockImpl.h"

#import "RHGBlockCallSchedulerTimerImpl.h"
#import "RHGNSDateCurrentDateWrapper.h"



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"
@implementation RHGClockImpl {
    id <RHGBlockCallScheduler> blockCallScheduler;
}
#pragma clang diagnostic pop

- (id)init;
{
    return [self initWithCurrentDateWrapper:[[RHGNSDateCurrentDateWrapper alloc] init] scheduler:[[RHGBlockCallSchedulerTimerImpl alloc] initWithCurrentDateWrapper:_currentDateWrapper]];
}

- (id)initWithCurrentDateWrapper:(id <RHGCurrentDateWrapper>)theWrapper scheduler:(id <RHGBlockCallScheduler>)theScheduler;
{
    self = [super init];
    if (!self) return nil;
    
    _currentDateWrapper = theWrapper;
    blockCallScheduler = theScheduler;
    
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([_currentDateWrapper respondsToSelector:aSelector])
        return _currentDateWrapper;
    else if ([blockCallScheduler respondsToSelector:aSelector])
        return blockCallScheduler;
    
    return nil;
}

@end

