//
//  NSURL+RHGXQueryComponents.m
//  Phoenix
//
//  Created by Robert Gilliam on 4/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

//
// From: http://stackoverflow.com/questions/3997976/parse-nsurl-query-property.
//

#import "NSURL+RHGXQueryComponents.h"
#import "NSString+RHGXQueryComponents.h"

@implementation NSURL (RHGXQueryComponents)
- (NSMutableDictionary *)queryComponents
{
    return [[self query] dictionaryFromQueryComponents];
}
@end
