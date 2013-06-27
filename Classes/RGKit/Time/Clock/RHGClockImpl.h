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

@property (readonly) RHGNSDateCurrentDateWrapper *currentDateWrapper;

@end
