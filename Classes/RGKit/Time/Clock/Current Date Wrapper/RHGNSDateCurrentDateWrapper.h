//
//  RHGNSDateCurrentDateWrapper.h
//  silver
//
//  Created by Robert Gilliam on 3/20/13.
//  Copyright (c) 2013 Robert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHGCurrentDateWrapper.h"

@class RHGTimerWrapperNS;

@interface RHGNSDateCurrentDateWrapper : NSObject <RHGCurrentDateWrapper>

+ (RHGNSDateCurrentDateWrapper *)sharedInstance;

- (id)init;
- (id)initWithTimerWrapper:(RHGTimerWrapperNS *)theTimerWrapper;

@end
