#if DEBUG
#define PROPERTY(propName)    NSStringFromSelector(@selector(propName))
#else
#define PROPERTY(propName)    @#propName
#endif

extern NSString * const RHGUnimplementedAbstractMethodException;
#define ABSTRACT_METHOD [NSException raise:RHGUnimplementedAbstractMethodException format:@"Abstract method %@ must be implemented in a concrete subclass. Don't call super.", NSStringFromSelector(_cmd)];

extern const char *__crashreporter_info__;
#define RHGAssert(expression, ...) \
    do { \
        if(!(expression)) { \
            NSString *__MAAssert_temp_string = [NSString stringWithFormat: @"Assertion failure: %s in %s on line %s:%d. %@", #expression, __func__, __FILE__, __LINE__, [NSString stringWithFormat: @"" __VA_ARGS__]]; \
            NSLog(@"%@", __MAAssert_temp_string); \
            __crashreporter_info__ = [__MAAssert_temp_string UTF8String]; \
            abort(); \
        } \
    } while(0)

// remove when iOS 7 is released
#ifndef NS_REQUIRES_SUPER
#if __has_attribute(objc_requires_super)
#define NS_REQUIRES_SUPER __attribute__((objc_requires_super))
#else
#define NS_REQUIRES_SUPER
#endif
#endif