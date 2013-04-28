//
//  RHGBuilder.h
//  silver
//
//  Created by Robert Gilliam on 4/1/13.
//  Copyright (c) 2013 Robert. All rights reserved.
//

#import <Foundation/Foundation.h>

// use in build implementation.
#define CURRENT_VALUE(NAME) [self builtPropertyValueForKey:[NSString stringWithCString:#NAME encoding:NSUTF8StringEncoding]]

@interface RHGAbstractBuilder : NSObject

- (id)init;
- (id)build;

- (void)registerDefaultValues; // template method
- (void)declareProperties; // template method
- (id)buildObject; // template method

- (void)addBuiltPropertyNamed:(NSString *)propertyName;
- (void)setDefault:(id)theDefaultObject forBuiltPropertyNamed:(NSString *)thePropertyName;

// methods used by macros
- (id)builtPropertyValueForKey:(NSString *)key;

// subclasses only
- (id)setBuiltProperty:(NSString *)aPropertyName to:(id)anObject;
@property (readonly) NSMutableDictionary *keyedProperties;

@end



@interface RHGBuilderProperty : NSObject

- (id)initWithName:(NSString *)theName;

@property (readonly) NSString *name;
@property id defaultValue;
@property id currentValue;

@end



