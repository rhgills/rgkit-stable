//
//  RHGBuilder.m
//  silver
//
//  Created by Robert Gilliam on 4/1/13.
//  Copyright (c) 2013 Robert. All rights reserved.
//

#import "RHGAbstractBuilder.h"
#import "RHGAbstractBuilderSubclassesOnly.h"
#import "RHGHelperMacros.h"

#import <LRMocky.h>

@implementation NSString (BuilderAdditions)

- (NSString *)rhg_stringByRemovingPrefix:(NSString *)prefix
{
    if (![self rhg_beginsWith:prefix]) {
        return self;
    }
    
    return [self stringByReplacingCharactersInRange:NSMakeRange(0, [prefix length]) withString:@""];
}

- (BOOL)rhg_beginsWith:(NSString *)prefix
{
    NSRange rangeOfPrefix = [self rangeOfString:prefix];
    return rangeOfPrefix.location == 0;
}

- (NSString *)rhg_stringByDowncasingFirstCharacter
{
    NSRange firstCharacterRange = NSMakeRange(0, 1);
    NSString *firstCharacter = [self substringWithRange:firstCharacterRange];
    firstCharacter = [firstCharacter lowercaseString];
    return [self stringByReplacingCharactersInRange:firstCharacterRange withString:firstCharacter];
}

@end








@interface RHGAbstractBuilder ()

@property (readonly) NSMutableDictionary *keyedProperties;
@property RHGBuilderProperty *currentProperty;

@end


@implementation RHGAbstractBuilder

@synthesize keyedProperties = _keyedProperties;

- (id)init
{
    self = [super init];
    if (!self) return nil;
    
    return [self initWithKeyedProperties:[NSMutableDictionary dictionary]];
    
    return self;
}

- (id)initWithKeyedProperties:(NSMutableDictionary *)theKeyedProperties
{
    self = [super init];
    if (!self) return nil;
    
    NSParameterAssert(theKeyedProperties);
    _keyedProperties = theKeyedProperties;
    [self declareProperties];
    
    return self;
}

- (void)declareProperties
{
    ABSTRACT_METHOD
}

- (void)registerDefaultValues
{
    ABSTRACT_METHOD
}

- (void)addBuiltPropertyNamed:(NSString *)propertyName
{
    RHGBuilderProperty *property = [self.keyedProperties objectForKey:propertyName];
    
    if (!property) {
        property = [[RHGBuilderProperty alloc] initWithName:propertyName];
        [self.keyedProperties setObject:property forKey:propertyName];
    }
    
    self.currentProperty = property;
}

- (void)setDefault:(id)theDefaultObject forBuiltProperty:(RHGBuilderProperty *)theProperty
{
    [theProperty setDefaultValue:theDefaultObject];
}

- (void)setDefault:(id)theDefaultObject forBuiltPropertyNamed:(NSString *)thePropertyName
{
    [self setDefault:theDefaultObject forBuiltProperty:[self builtPropertyNamed:thePropertyName]];
}

- (NSMutableDictionary *)deepCopyProperties
{
    NSMutableDictionary *copiedProperties = [NSMutableDictionary dictionaryWithCapacity:self.keyedProperties.count];
    for (RHGBuilderProperty *aProperty in self.keyedProperties.allValues) {
        [copiedProperties setValue:[aProperty copy] forKey:aProperty.name];
    }
    return copiedProperties;
}

- (id)copyWithZone:(NSZone *)zone
{
    RHGAbstractBuilder *copy = [[[self class] alloc] initWithKeyedProperties:[self deepCopyProperties]];
    return copy;
}

- (RHGBuilderProperty *)builtPropertyNamed:(NSString *)aKey
{
    return [self.keyedProperties objectForKey:aKey];
}

- (id)setBuiltProperty:(NSString *)aPropertyName to:(id)anObject
{
    RHGAbstractBuilder *builder = [self copy];
    RHGBuilderProperty *theProperty = [builder builtPropertyNamed:aPropertyName];
    NSParameterAssert(theProperty);
    
    [theProperty setCurrentValue:anObject];
    return builder;
}

- (NSString *)propertyNameFromBuilderMethodName:(NSString *)methodName
{
    NSString *propertyPart = [methodName rhg_stringByRemovingPrefix:@"with"];
    propertyPart = [propertyPart rhg_stringByDowncasingFirstCharacter];
    propertyPart = [propertyPart stringByReplacingOccurrencesOfString:@":" withString:@""];
    return propertyPart;
}

- (id)handleBuilderSelector:(SEL)sel withObject:(id)dependency
{
    NSString *methodName = NSStringFromSelector(sel);
    if ([methodName rhg_beginsWith:@"with"]) {
        NSString *propertyName = [self propertyNameFromBuilderMethodName:methodName];
        return [self setBuiltProperty:propertyName to:dependency];
    }
    
    [NSException raise:NSInternalInconsistencyException format:@"Unrecognized builder selector %@. Doesn't start with 'with'.", methodName];
    return nil;
}

- (id)builtPropertyValueForKey:(NSString *)key
{
    RHGBuilderProperty *property = [self.keyedProperties valueForKey:key];
    id setValue = property.currentValue;
    if (!setValue) {
        id defaultValue = property.defaultValue;
        NSAssert(defaultValue, @"property %@ must have a default value.", key);
        return defaultValue;
    }
    
    return setValue;
}

- (id)build
{
    [self registerDefaultValues];
    return [self buildObject];
}

- (id)buildObject
{
    ABSTRACT_METHOD;
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([methodName rhg_beginsWith:@"with"]) {
        NSString *propertyName = [self propertyNameFromBuilderMethodName:methodName];
        if ([self.keyedProperties.allKeys containsObject:propertyName]) {
            NSString *objcTypes = [NSString stringWithFormat:@"%s%s%s%s", @encode(id), @encode(id), @encode(SEL), @encode(id)];
            return [NSMethodSignature signatureWithObjCTypes:[objcTypes cStringUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL theSelector = anInvocation.selector;

    NSString *methodName = NSStringFromSelector(theSelector);
    if ([methodName rhg_beginsWith:@"with"]) {
        NSString *propertyName = [self propertyNameFromBuilderMethodName:methodName];
        if ([self.keyedProperties.allKeys containsObject:propertyName]) {            
            
            id theObject;
            [anInvocation getArgument:&theObject atIndex:2];

            id trampolinedBuilder = [self handleBuilderSelector:theSelector withObject:theObject];
            NSParameterAssert(trampolinedBuilder);
            CFRetain((__bridge CFTypeRef)trampolinedBuilder); // this might leak. I don't know what goes on in setReturnValue, but it crashes when the autorelease pool is popped otherwise.
            [anInvocation setReturnValue:&trampolinedBuilder];
            return;
        }
    }
    
    [super forwardInvocation:anInvocation];
}

@end





@implementation RHGBuilderProperty

- (id)init
{
    [NSException raise:NSInternalInconsistencyException format:@"%@: use the designated init.", [self class]];
    return nil;
}

- (id)initWithName:(NSString *)theName
{
    self = [super init];
    if (!self) return nil;
    
    _name = theName;
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    RHGBuilderProperty *copy = [[RHGBuilderProperty alloc] initWithName:self.name];
    copy.defaultValue = self.defaultValue;
    copy.currentValue = self.currentValue;
    
    return copy;
}

@end
