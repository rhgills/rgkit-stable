//
//  RHGCurrentDateWrapperFactory.m
//  Phoenix
//
//  Created by Robert Gilliam on 7/9/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGCurrentDateWrapperFactory.h"
#import <RHGNSDateCurrentDateWrapper.h>

@implementation RHGCurrentDateWrapperFactory

static id <RHGCurrentDateWrapper> sharedWrapper = nil;
+ (id <RHGCurrentDateWrapper>)sharedWrapper
{
    if (!sharedWrapper) {
        sharedWrapper = [self defaultWrapper];
    };
    return sharedWrapper;
}

+ (void)setSharedWrapper:(id<RHGCurrentDateWrapper>)theSharedWrapper
{
    sharedWrapper = theSharedWrapper;
}

+ (id <RHGCurrentDateWrapper>)defaultWrapper;
{
    return [[RHGNSDateCurrentDateWrapper alloc] init];
}

@end
