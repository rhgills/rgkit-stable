@interface RHGBuilder (SubclassesOnly)

- (id)initWithKeyedProperties:(NSMutableDictionary *)theKeyedProperties;
- (NSMutableDictionary *)deepCopyProperties;

@end