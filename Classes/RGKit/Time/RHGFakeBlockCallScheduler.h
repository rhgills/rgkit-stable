//
//  FakeBlockCallScheduler.h
//  Phoenix
//
//  Created by Robert Gilliam on 6/21/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RHGBlockCallScheduler.h"

@interface RHGFakeBlockCallScheduler : NSObject <RHGBlockCallScheduler>

// fake
@property (readonly) NSDate *scheduledDate;

@end

