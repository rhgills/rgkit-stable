//
//  CurrentDateWrapper.h
//  silver
//
//  Created by Robert Gilliam on 3/20/13.
//  Copyright (c) 2013 Robert. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol RHGCurrentDateWrapperDelegate <NSObject>

- (void)timeIntervalDidElapse:(NSTimeInterval)theInterval;

@end




@protocol RHGCurrentDateWrapper <NSObject>

- (NSDate *)currentDate;
- (NSDate *)dateForNextOccurenceOfHour:(NSInteger)hour;

- (NSTimeInterval)timeUntilDate:(NSDate *)date;

@optional
- (void)callback:(id <RHGCurrentDateWrapperDelegate>)delegate afterTimeInterval:(NSTimeInterval)theInterval;

@end
