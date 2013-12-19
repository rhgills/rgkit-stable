//
//  NSArray+RHGEnumeration.h
//  
//
//  Created by Robert Gilliam on 12/18/13.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (RHGEnumeration)

typedef void(^RHGEachBlock)(id obj);
- (void)rhg_each:(RHGEachBlock)block;

@end
