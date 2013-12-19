//
//  NSArray+RHGEnumeration.m
//  
//
//  Created by Robert Gilliam on 12/18/13.
//
//

#import "NSArray+RHGEnumeration.h"

@implementation NSArray (RHGEnumeration)

- (void)each:(RHGEachBlock)block;
{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

@end
