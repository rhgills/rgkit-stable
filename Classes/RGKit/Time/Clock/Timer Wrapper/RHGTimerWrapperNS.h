//
//  RHGTimerWrapper.h
//  
//
//  Created by Robert Gilliam on 6/27/13.
//
//

#import <Foundation/Foundation.h>
#import <RHGTimerWrapper.h>

@protocol RHGCurrentDateWrapper;

@interface RHGTimerWrapperNS : NSObject <RHGTimerWrapper>

// dependencies
@property () id <RHGCurrentDateWrapper> currentDateWrapper;

// for tests
- (void)scheduleCallbackFor:(id)delegate onDate:(NSDate *)theDate timeUntilDate:(NSTimeInterval)timeUntil;
- (NSInvocation *)invocationToCallback:(id)delegate onDate:(NSDate *)theDate;
- (void)scheduleCallbackWithInvocation:(NSInvocation *)invocation timeUntilDate:(NSTimeInterval)timeUntil;

@end
