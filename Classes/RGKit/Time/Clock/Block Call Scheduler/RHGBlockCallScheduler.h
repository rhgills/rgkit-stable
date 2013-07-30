//
//  RHGBlockCallScheduler.h
//  Phoenix
//
//  Created by Robert Gilliam on 6/21/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^TimerWidgetVoidBlock)();



@protocol RHGBlockCallScheduler <NSObject>

- (void)do:(TimerWidgetVoidBlock)theBlock onDate:(NSDate *)theDate;

@end
