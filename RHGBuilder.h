//
//  RHGBuilder.h
//  silver
//
//  Created by Robert Gilliam on 4/1/13.
//  Copyright (c) 2013 Robert. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BUILDER_METHOD(NAME, TYPE) - (instancetype)with ## NAME:(TYPE)dependency; \
                                    @property (readonly) TYPE ## NAME
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

// use in build implementation.
#define CURRENT_VALUE(NAME) [self builtPropertyValueForKey:[NSString stringWithCString:#NAME encoding:NSUTF8StringEncoding]]

@interface RHGBuilder : NSObject

- (id)init;
- (id)build;

- (void)registerDefaultValues; // template method
- (void)declareProperties; // template method
- (id)buildObject; // template method

// methods used by macros
- (void)addBuiltPropertyNamed:(NSString *)propertyName;
- (void)setDefault:(id)theDefaultObject forBuiltPropertyNamed:(NSString *)thePropertyName;
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

- (id)initWithContext:(LRMockery *)context;
@property (readonly) LRMockery *context;

- (void)registerDefaultValues; // template method from superclass. you can use context here.

@end

