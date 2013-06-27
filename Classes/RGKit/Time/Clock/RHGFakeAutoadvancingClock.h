//
//  RHGFakeAutoadvancingClock.h
//  
//
//  Created by Robert Gilliam on 6/26/13.
//
//

#import <Foundation/Foundation.h>
#import "RHGClock.h"

@interface RHGFakeAutoadvancingClock : NSObject <RHGClock>

- (id)initWithFrozenDate:(NSDate *)theDate;

@end
