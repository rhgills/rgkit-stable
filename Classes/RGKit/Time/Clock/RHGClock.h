//
//  RHGClock.h
//  
//
//  Created by Robert Gilliam on 6/26/13.
//
//

#import <Foundation/Foundation.h>

#import "RHGCurrentDateWrapper.h"
#import "RHGBlockCallScheduler.h"

@protocol RHGClock <RHGCurrentDateWrapper, RHGBlockCallScheduler, NSObject>

@end
