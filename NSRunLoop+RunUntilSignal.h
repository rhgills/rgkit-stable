//
//  NSRunLoop+RunUntilSignal.h
//  Phoenix Core Data Prototype
//
//  Created by Robert on 12/19/12.
//  Copyright (c) 2012 Robert Gilliam. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const CFAbsoluteTime kRunUntilSignalDefaultTimeout;
extern NSString * const RunUntilSignalTimeoutException;

@interface NSRunLoop (RunUntilSignal)

- (void)runUntilSignal:(dispatch_semaphore_t)semaphore;
- (void)runUntilSignal:(dispatch_semaphore_t)semaphore message:(NSString *)message;
- (void)runUntilSignal:(dispatch_semaphore_t)semaphore message:(NSString *)message timeout:(CFAbsoluteTime)timeout;

@end
