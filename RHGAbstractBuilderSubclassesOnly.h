@interface RHGAbstractBuilder (SubclassesOnly)

- (id)initWithKeyedProperties:(NSMutableDictionary *)theKeyedProperties;
- (NSMutableDictionary *)deepCopyProperties;

@end
