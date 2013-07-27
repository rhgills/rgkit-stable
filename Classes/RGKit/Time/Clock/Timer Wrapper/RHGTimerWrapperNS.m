//
//  RHGTimerWrapper.m
//  
//
//  Created by Robert Gilliam on 6/27/13.
//
//

#import "RHGTimerWrapperNS.h"
#import "RHGCurrentDateWrapper.h"



@implementation RHGTimerWrapperNS



- (void)callback:(id <RHGTimerWrapperDelegate>)delegate onDate:(NSDate *)theDate;
{
    NSTimeInterval timeUntilDate = [self timeUntilDate:theDate];
    if (timeUntilDate <= 0) {
        [delegate dateReached:theDate];
        return;
    }
    
    [self scheduleCallbackFor:delegate onDate:theDate timeUntilDate:timeUntilDate];
}

- (NSTimeInterval)timeUntilDate:(NSDate *)theDate
{
    return [[self currentDateWrapper] timeUntilDate:theDate];
}

- (void)scheduleCallbackFor:(id)delegate onDate:(NSDate *)theDate timeUntilDate:(NSTimeInterval)timeUntil;
{
    NSInvocation *invocation = [self invocationToCallback:delegate onDate:theDate];
    [self scheduleCallbackWithInvocation:invocation timeUntilDate:timeUntil];
}

- (NSInvocation *)invocationToCallback:(id)delegate onDate:(NSDate *)theDate;
{
    NSMethodSignature *signature = [(id)delegate methodSignatureForSelector:@selector(dateReached:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:delegate];
    [invocation setSelector:@selector(dateReached:)];
    [invocation setArgument:&theDate atIndex:2];
    return invocation;
}

- (void)scheduleCallbackWithInvocation:(NSInvocation *)invocation timeUntilDate:(NSTimeInterval)timeUntil
{
    [NSTimer scheduledTimerWithTimeInterval:timeUntil invocation:invocation repeats:NO];
}

@end
