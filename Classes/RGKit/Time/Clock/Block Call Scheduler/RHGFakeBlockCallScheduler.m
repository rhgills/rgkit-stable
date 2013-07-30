//
//  FakeBlockCallScheduler.m
//  Phoenix
//
//  Created by Robert Gilliam on 6/21/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGFakeBlockCallScheduler.h"

@implementation RHGFakeBlockCallScheduler

@synthesize block = _block;
@synthesize scheduledDate = _scheduledDate;

- (void)do:(TimerWidgetVoidBlock)theBlock onDate:(NSDate *)theDate
{
    _block = theBlock;
    _scheduledDate = theDate;
}

@end
