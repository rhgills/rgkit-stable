//
//  NSString+RHGPrefixAdditions.m
//  Phoenix
//
//  Created by Robert Gilliam on 4/26/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "NSString+RHGPrefixAdditions.h"

@implementation NSString (RHGPrefixAdditions)

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
