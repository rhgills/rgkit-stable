//
//  RHGMockeryAbstractBuilder.h
//  Phoenix
//
//  Created by Robert Gilliam on 4/3/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGBuilder.h"

@interface RHGMockeryObjectBuilder : RHGBuilder

- (id)initWithContext:(LRMockery *)context;
@property (readonly) LRMockery *context;

- (void)registerDefaultValues; // template method from superclass. you can use context here.

@end

