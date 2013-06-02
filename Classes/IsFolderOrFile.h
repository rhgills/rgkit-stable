//
//  IsFolder.h
//  Cocoaite
//
//  Created by Robert on 2/26/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import <OCHamcrest/OCHamcrest.h>

@interface IsFolderOrFile : HCBaseMatcher

+ (id)isFolder;
+ (id)isFile;

@end

OBJC_EXPORT id <HCMatcher> isFolder();
OBJC_EXPORT id <HCMatcher> isFile();