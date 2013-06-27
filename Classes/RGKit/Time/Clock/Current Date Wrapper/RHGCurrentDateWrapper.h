//
//  CurrentDateWrapper.h
//  silver
//
//  Created by Robert Gilliam on 3/20/13.
//  Copyright (c) 2013 Robert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RHGTimerWrapper.h>

@protocol RHGCurrentDateWrapper <RHGTimerWrapper, NSObject>

- (NSDate *)currentDate;
- (NSDate *)dateForNextOccurenceOfHour:(NSInteger)hour;
- (NSTimeInterval)timeUntilDate:(NSDate *)date;

@end
