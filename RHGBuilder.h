//
//  RHGBuilder.h
//  silver
//
//  Created by Robert Gilliam on 4/1/13.
//  Copyright (c) 2013 Robert. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BUILDER_METHOD(NAME, TYPE) - (instancetype)with ## NAME:(TYPE)dependency
//
// use in interface
// generates 'with' style builder methods.
//
// For example:
//
// BUILDER_METHOD(Application, NSApplication *);
//
// generates:
//
// - (instancetype)withApplication:(NSApplication *)obj;

// use in abstract method - (void)registerPropertiesAndDefaultValues
#define BUILD_PROPERTY(NAME) [self addBuiltPropertyNamed:[NSString stringWithCString:#NAME encoding:NSUTF8StringEncoding]]
#define DEFAULT(DEFAULT_OBJECT) [self setBuiltPropertyDefault:DEFAULT_OBJECT]

// use in build implementation.
#define CURRENT_VALUE(NAME) [self builtPropertyValueForKey:[NSString stringWithCString:#NAME encoding:NSUTF8StringEncoding]]

@interface RHGBuilder : NSObject

- (id)initWithMockery:(LRMockery *)context;
@property (readonly) LRMockery *context;

- (void)registerPropertiesAndDefaultValues; // template method
- (id)build; // template method

// methods used by macros
- (void)addBuiltPropertyNamed:(NSString *)propertyName;
- (void)setBuiltPropertyDefault:(id)defaultObject;
- (id)handleBuilderSelector:(SEL)sel withObject:(id)dependency;
- (id)builtPropertyValueForKey:(NSString *)key;

@end



@interface RHGBuilderProperty : NSObject

- (id)initWithName:(NSString *)theName;

@property (readonly) NSString *name;
@property id defaultValue;
@property id currentValue;

@end


@interface RHGMockeryObjectBuilder : RHGBuilder

- (id)initWithMockery:(LRMockery *)context;
@property (readonly) LRMockery *context;

@end