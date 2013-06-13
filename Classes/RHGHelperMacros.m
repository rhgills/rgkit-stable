#import "RHGHelperMacros.h"

NSString * const RHGUnimplementedAbstractMethodException = @"RHGUnimplementedAbstractMethodException";

// Make RHGAssert failures show up in the "Application Specific Information"
// section of a crash log.
//
// see http://www.mikeash.com/pyblog/friday-qa-2013-05-03-proper-use-of-asserts.html
const char *__crashreporter_info__ = NULL;
asm(".desc _crashreporter_info, 0x10");