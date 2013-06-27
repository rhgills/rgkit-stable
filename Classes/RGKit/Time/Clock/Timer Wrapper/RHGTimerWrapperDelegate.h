//
//  RHGTimerWrapperDelegate.h
//  
//
//  Created by Robert Gilliam on 6/27/13.
//
//

#import <Foundation/Foundation.h>

@protocol RHGTimerWrapperDelegate <NSObject>

@optional
- (void)dateReached:(NSDate *)theDate;

@end