//
//  RHGNSDateCurrentDateWrapper.h
//  silver
//
//  Created by Robert Gilliam on 3/20/13.
//  Copyright (c) 2013 Robert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentDateWrapper.h"

@interface RHGNSDateCurrentDateWrapper : NSObject <CurrentDateWrapper>

+ (RHGNSDateCurrentDateWrapper *)sharedInstance;

@end
