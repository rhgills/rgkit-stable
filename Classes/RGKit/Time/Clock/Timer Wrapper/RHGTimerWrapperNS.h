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

- (id)initWithCurrentDateWrapper:(id <RHGCurrentDateWrapper>)theCurrentDateWrapper;

@end
