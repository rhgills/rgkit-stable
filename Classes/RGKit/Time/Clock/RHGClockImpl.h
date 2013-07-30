//
//  RHGClockImpl.h
//  
//
//  Created by Robert Gilliam on 6/26/13.
//
//

#import <Foundation/Foundation.h>
#import "RHGClock.h"

@class RHGNSDateCurrentDateWrapper;

@interface RHGClockImpl : NSObject <RHGClock>

- (id)init;
- (id)initWithCurrentDateWrapper:(id <RHGCurrentDateWrapper>)theWrapper scheduler:(id <RHGBlockCallScheduler>)theScheduler;

@property (readonly) id <RHGCurrentDateWrapper> currentDateWrapper;

@end
