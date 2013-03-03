//
//  IsFolder.m
//  Cocoaite
//
//  Created by Robert on 2/26/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "IsFolderOrFile.h"
#import <OCHamcrest/HCDescription.h>

@interface IsFolderOrFile ()

@property BOOL expectFolder;

@end

@implementation IsFolderOrFile

+ (id)isFolder
{
    return [[self alloc] initExpectingFolder:YES];
}

+ (id)isFile
{
    return [[self alloc] initExpectingFolder:NO];
}

- (id)initExpectingFolder:(BOOL)expectFolder
{
    self = [super init];
    if (!self) return nil;
    
    self.expectFolder = expectFolder;
    
    return self;
}

- (BOOL)matches:(id)item
{
    if (![item isKindOfClass:[NSString class]] && ![item isKindOfClass:[NSURL class]]) {
        return NO;
    }

    NSString *path = nil;
    if ([item isKindOfClass:[NSURL class]]) {
        NSURL *url = item;
        if (![url isFileURL]) {
            return NO;
        }
        path = [url path];
    }

    if ([item isKindOfClass:[NSString class]]) {
        path = item;
    }

    BOOL isDirectory;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (!exists) return NO;

    return (isDirectory == self.expectFolder);
}

- (void)describeTo:(id<HCDescription>)description
{
    [description appendText:@"a folder"];
}

- (void)describeMismatchOf:(id)item to:(id<HCDescription>)mismatchDescription
{
    if (![item isKindOfClass:[NSString class]] && ![item isKindOfClass:[NSURL class]]) {
        [[mismatchDescription appendText:@"not a path or URL, was "] appendDescriptionOf:item];
        return;
    }
    
    NSString *path;
    if ([item isKindOfClass:[NSURL class]]) {
        NSURL *url = item;
        if (![url isFileURL]) {
            [[mismatchDescription appendText:@"was not a file URL, was "] appendDescriptionOf:item];
            return;
        }
        path = [url path];
    }else{
        // NSString
        path = item;
    }
    
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil];
    if (!exists) {
        [[mismatchDescription appendText:@"no item at path "] appendDescriptionOf:path];
        return;
    }

    NSString *expected = self.expectFolder ? @"folder" : @"file";
    NSString *oppsite = self.expectFolder ? @"file" : @"folder";
    [[mismatchDescription appendText:[NSString stringWithFormat:@"was a %@, not a %@ at ", expected, oppsite]] appendDescriptionOf:item];
}

id <HCMatcher> isFolder()
{
    return [IsFolderOrFile isFolder];
}

id <HCMatcher> isFile()
{
    return [IsFolderOrFile isFile];
}

@end
