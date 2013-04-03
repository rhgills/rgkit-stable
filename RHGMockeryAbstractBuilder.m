//
//  RHGMockeryAbstractBuilder.m
//  Phoenix
//
//  Created by Robert Gilliam on 4/3/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGMockeryAbstractBuilder.h"
#import "RHGAbstractBuilderSubclassesOnly.h"
#import "RHGHelperMacros.h"

@interface RHGMockeryObjectBuilder ()

- (id)initWithKeyedProperties:(NSMutableDictionary *)theKeyedProperties context:(LRMockery *)theContext;

@end





@implementation RHGMockeryObjectBuilder

@synthesize context = _context;

- (id)init
{
    [NSException raise:NSInternalInconsistencyException format:@"%@: use the designated init, not %@.", [self class], NSStringFromSelector(_cmd)];
    return nil;
}

- (id)initWithContext:(LRMockery *)context
{
    self = [super init];
    if (!self) return nil;
    
    NSParameterAssert(context);
    _context = context;
    
    return self;
}

- (id)initWithKeyedProperties:(NSMutableDictionary *)theKeyedProperties context:(LRMockery *)theContext
{
    self = [super initWithKeyedProperties:theKeyedProperties];
    if (!self) return nil;
    
    NSParameterAssert(theContext);
    _context = theContext;
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[[self class] alloc] initWithKeyedProperties:[self deepCopyProperties] context:self.context];
}

- (void)registerDefaultValues
{
    ABSTRACT_METHOD;
}

@end
