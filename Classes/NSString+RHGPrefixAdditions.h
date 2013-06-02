//
//  NSString+RHGPrefixAdditions.h
//  Phoenix
//
//  Created by Robert Gilliam on 4/26/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RHGPrefixAdditions)

- (NSString *)rhg_stringByRemovingPrefix:(NSString *)prefix;

- (BOOL)rhg_beginsWith:(NSString *)prefix;

- (NSString *)rhg_stringByDowncasingFirstCharacter;

@end
