//
//  RHGNSDateCurrentDateWrapperTests.m
//  RGKit Tests
//
//  Created by Robert Gilliam on 6/27/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//


#import <RHGNSDateCurrentDateWrapper.h>

@interface RHGNSDateCurrentDateWrapperTests : RHGAutoverifyingSenTestCase

@end


@implementation RHGNSDateCurrentDateWrapperTests {
    RHGNSDateCurrentDateWrapper *currentDateWrapper;
}

- (void)setUp
{
    [super setUp];
    
    currentDateWrapper = [[RHGNSDateCurrentDateWrapper alloc] init];
}

- (void)testCallsBackAfterInterval
{
    id delegate = [self autoVerifiedMockForProtocol:@protocol(RHGCurrentDateWrapperDelegate)];
    [currentDateWrapper callback:delegate afterTimeInterval:0.1];
    
    [[delegate expect]  timeIntervalDidElapse:0.1];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
}

@end
