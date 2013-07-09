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

+ (id <RHGCurrentDateWrapper>)sharedWrapper
{
    static id <RHGCurrentDateWrapper> sharedWrapper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWrapper = [[RHGNSDateCurrentDateWrapper alloc] init];
    });
    return sharedWrapper;
}

@end
