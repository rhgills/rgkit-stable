//
//  NSRunLoop+RunUntilSignal.m
//  Phoenix Core Data Prototype
//
//  Created by Robert on 12/19/12.
//  Copyright (c) 2012 Robert Gilliam. All rights reserved.
//

#import "NSRunLoop+RunUntilSignal.h"

@implementation NSRunLoop (RunUntilSignal)

const CFAbsoluteTime kRunUntilSignalDefaultTimeout = 5.0;
NSString * const RunUntilSignalTimeoutException = @"RunUntilSignalTimeoutException";

- (void)runUntilSignal:(dispatch_semaphore_t)semaphore message:(NSString *)message
{
	[self runUntilSignal:semaphore message:message timeout:kRunUntilSignalDefaultTimeout];
}

- (void)runUntilSignal:(dispatch_semaphore_t)semaphore
{
	[self runUntilSignal:semaphore message:nil timeout:kRunUntilSignalDefaultTimeout];
}

- (void)runUntilSignal:(dispatch_semaphore_t)semaphore message:(NSString *)message timeout:(CFAbsoluteTime)timeout
{
	CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
	while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) {
		[self runMode:NSDefaultRunLoopMode
								 beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
		if( (CFAbsoluteTimeGetCurrent() - start) > timeout ) {
            [NSException raise:RunUntilSignalTimeoutException format:@"Timeout expired: %@", message];
            break;
        }
	}
}


@end
