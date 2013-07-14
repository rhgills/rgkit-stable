//
//  RHGCurrentDateWrapperFactory.h
//  Phoenix
//
//  Created by Robert Gilliam on 7/9/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RHGCurrentDateWrapper.h>

@interface RHGCurrentDateWrapperFactory : NSObject

+ (id <RHGCurrentDateWrapper>)sharedWrapper;

+ (id <RHGCurrentDateWrapper>)defaultWrapper;
+ (void)setSharedWrapper:(id <RHGCurrentDateWrapper>)theSharedWrapper;

@end
