//
//  LRInvocationComparitor.m
//  Mocky
//
//  Created by Luke Redpath on 27/07/2010.
//  Copyright (c) 2010 LJR Software Limited. All rights reserved.
//

#import "LRInvocationComparitor.h"
#import "NSInvocation+OCMAdditions.h"
#import "LRHamcrestSupport.h"


@implementation LRInvocationComparitor

+ (id)comparitorForInvocation:(NSInvocation *)invocation;
{
  return [[[self alloc] initWithInvocation:invocation] autorelease];
}

- (id)initWithInvocation:(NSInvocation *)anInvocation;
{
  if (self = [super init]) {
    expectedInvocation = [anInvocation retain];
    [expectedInvocation retainArguments];
  }
  return self;
}

- (void)dealloc 
{
  [expectedInvocation release];
  [super dealloc];
}

- (BOOL)matchesParameters:(NSInvocation *)invocation;
{
    NSMethodSignature *methodSignature = [expectedInvocation methodSignature];
    
    for (int i = 2; i < [methodSignature numberOfArguments]; i++) {
        id expected = [expectedInvocation getArgumentAtIndexAsObject:i];
        id received = [invocation getArgumentAtIndexAsObject:i];
        
        BOOL expectedMatchesReceived = NO;
        if ([expected conformsToProtocol:NSProtocolFromString(@"HCMatcher")]) {
            expectedMatchesReceived = [expected matches:received];
        }
        else if (expected != nil) {
            expectedMatchesReceived = [expected isEqual:received];
        }else{ // expected == nil
            expectedMatchesReceived = (received == nil);
        }
        
        if (!expectedMatchesReceived) {
            return NO;
        }
    }
    
    return YES;
}

@end
