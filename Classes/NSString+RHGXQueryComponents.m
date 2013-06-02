//
//  NSString+RHGXQueryComponents.m
//  Phoenix
//
//  Created by Robert Gilliam on 4/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

//
// From: http://stackoverflow.com/questions/3997976/parse-nsurl-query-property.
//

#import "NSString+RHGXQueryComponents.h"

@implementation NSString (RHGXQueryComponents)
- (NSString *)stringByDecodingURLFormat
{
    NSString *result = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (NSString *)stringByEncodingURLFormat
{
    NSString *result = [self stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    result = [result stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (NSMutableDictionary *)dictionaryFromQueryComponents
{
    NSMutableDictionary *queryComponents = [NSMutableDictionary dictionary];
    for(NSString *keyValuePairString in [self componentsSeparatedByString:@"&"])
    {
        NSArray *keyValuePairArray = [keyValuePairString componentsSeparatedByString:@"="];
        if ([keyValuePairArray count] < 2) continue; // Verify that there is at least one key, and at least one value.  Ignore extra = signs
        NSString *key = [[keyValuePairArray objectAtIndex:0] stringByDecodingURLFormat];
        NSString *value = [[keyValuePairArray objectAtIndex:1] stringByDecodingURLFormat];
                
        id resultOrArrayOfResults = [queryComponents objectForKey:key]; // URL spec says that multiple values are allowed per key
        if (!resultOrArrayOfResults) {
            [queryComponents setObject:value forKey:key];
        }else{
            if ([resultOrArrayOfResults isKindOfClass:[NSString class]]) {
                NSMutableArray *results = [NSMutableArray arrayWithCapacity:2];
                [results addObject:resultOrArrayOfResults];
                [results addObject:value];
                [queryComponents setObject:results forKey:key];
            }else{
                // is already an array
                NSMutableArray *results = (NSMutableArray *)resultOrArrayOfResults;
                [results addObject:value];
            }
        }
    }
    return queryComponents;
}
@end
