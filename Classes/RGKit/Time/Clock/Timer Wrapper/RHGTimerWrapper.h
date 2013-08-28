//
//  RHGTimerWrapper.h
//  
//
//  Created by Robert Gilliam on 6/27/13.
//
//

#import <Foundation/Foundation.h>
#import "RHGTimerWrapperDelegate.h"

@protocol RHGTimerWrapper <NSObject>

- (void)callback:(id <RHGTimerWrapperDelegate>)delegate onDate:(NSDate *)theDate;

@end
