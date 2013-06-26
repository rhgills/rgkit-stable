//
//  RHGFakeAutoadvancingCurrentDateWrapper.h
//  Phoenix
//
//  Created by Robert Gilliam on 4/16/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHGCurrentDateWrapper.h"

@interface RHGFakeAutoadvancingCurrentDateWrapper : NSObject <RHGCurrentDateWrapper>

- (id)initWithStartDate:(NSDate *)date;

@end
