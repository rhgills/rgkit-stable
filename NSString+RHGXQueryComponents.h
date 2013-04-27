//
//  NSString+RHGXQueryComponents.h
//  Phoenix
//
//  Created by Robert Gilliam on 4/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RHGXQueryComponents)
- (NSString *)stringByDecodingURLFormat;
- (NSString *)stringByEncodingURLFormat;
- (NSMutableDictionary *)dictionaryFromQueryComponents;
@end
