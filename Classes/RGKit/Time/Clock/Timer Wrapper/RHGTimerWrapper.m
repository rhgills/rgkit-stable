//
//  RHGTimerWrapper.m
//  
//
//  Created by Robert Gilliam on 6/27/13.
//
//

#import "RHGTimerWrapper.h"

@interface RHGTimerWrapper ()

@property (readonly) id <RHGCurrentDateWrapper> currentDateWrapper;

@end


@implementation RHGTimerWrapper

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

- (void)callback:(id <RHGCurrentDateWrapperDelegate>)delegate onDate:(NSDate *)theDate;
{
    NSTimeInterval timeUntilDate = [[self currentDateWrapper] timeUntilDate:theDate];
    if (timeUntilDate <= 0) {
        [delegate dateReached:theDate];
        return;
    }
    
    NSMethodSignature *signature = [(id)delegate methodSignatureForSelector:@selector(dateReached:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:delegate];
    [invocation setSelector:@selector(dateReached:)];
    [invocation setArgument:&theDate atIndex:2];
    [NSTimer scheduledTimerWithTimeInterval:timeUntilDate invocation:invocation repeats:NO];
}

@end
