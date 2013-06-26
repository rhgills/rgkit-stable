//
//  RHGFakeCurrentDateWrapper.h
//  Phoenix
//
//  Created by Robert Gilliam on 4/12/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RHGCurrentDateWrapper.h"

@interface RHGFakeCurrentDateWrapper : NSObject <RHGCurrentDateWrapper>

 - (id)initWithFrozenDate:(NSDate *)currentDate;

@property (nonatomic) NSDate *frozenDate;

@end
