//
//  RHGTimerWrapper.h
//  
//
//  Created by Robert Gilliam on 6/27/13.
//
//

#import <Foundation/Foundation.h>
#import <RHGCurrentDateWrapper.h>

@interface RHGTimerWrapper : NSObject

- (id)initWithCurrentDateWrapper:(id <RHGCurrentDateWrapper>)theCurrentDateWrapper;

- (void)callback:(id <RHGCurrentDateWrapperDelegate>)delegate onDate:(NSDate *)theDate;

@end
