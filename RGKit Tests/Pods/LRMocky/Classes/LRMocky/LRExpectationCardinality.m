//
//  LRExpectationCardinality.m
//  Mocky
//
//  Created by Luke Redpath on 27/07/2010.
//  Copyright (c) 2010 LJR Software Limited. All rights reserved.
//

#import "LRExpectationCardinality.h"
#import "LRExpectationMessage.h"

@implementation LREqualToCardinality

@synthesize permissivity = _permissivity;

- (id)initWithInt:(int)anInt;
{
  if (self = [super init]) {
    equalToInt = anInt;
      _permissivity = 1;
  }
  return self;
}

- (BOOL)satisfiedBy:(int)numberOfInvocations
{
  return numberOfInvocations == equalToInt;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"exactly(%d)", equalToInt];
}

- (void)describeTo:(LRExpectationMessage *)message
{
  [message append:[NSString stringWithFormat:@"%@ times", [self description]]];
}

@end

id<LRExpectationCardinality> LRM_exactly(int anInt)
{
  return [[[LREqualToCardinality alloc] initWithInt:anInt] autorelease];
}

@implementation LRAtLeastCardinality

@synthesize permissivity = _permissivity;


- (id)initWithMinimum:(int)theMinimum;
{
  if (self = [super init]) {
    minimum = theMinimum;
      _permissivity = (NSIntegerMax - minimum);
  }
  return self;
}

- (BOOL)satisfiedBy:(int)numberOfInvocations
{
  return numberOfInvocations >= minimum;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"atLeast(%d)", minimum];
}

- (void)describeTo:(LRExpectationMessage *)message
{
  [message append:[NSString stringWithFormat:@"%@ times", [self description]]];
}

@end

id<LRExpectationCardinality> LRM_atLeast(int anInt)
{
  return [[[LRAtLeastCardinality alloc] initWithMinimum:anInt] autorelease];
}

@implementation LRAtMostCardinality

@synthesize permissivity = _permissivity;


- (id)initWithMaximum:(int)theMaximum;
{
  if (self = [super init]) {
    maximum = theMaximum;
      _permissivity = (maximum - 0) + 1;
  }
  return self;
}

- (BOOL)satisfiedBy:(int)numberOfInvocations
{
  return numberOfInvocations <= maximum;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"atMost(%d)", maximum];
}

- (void)describeTo:(LRExpectationMessage *)message
{
  [message append:[NSString stringWithFormat:@"%@ times", [self description]]];
}

@end

id<LRExpectationCardinality> LRM_atMost(int anInt)
{
  return [[[LRAtMostCardinality alloc] initWithMaximum:anInt] autorelease];
}

@implementation LRBetweenCardinality

@synthesize permissivity = _permissivity;


- (id)initWithMinimum:(int)theMinimum andMaximum:(int)theMaximum;
{
  if (self = [super init]) {
    minimum = theMinimum;
    maximum = theMaximum;
      _permissivity = (maximum - minimum) + 1;
  }
  return self;
}

- (BOOL)satisfiedBy:(int)numberOfInvocations
{
  return (numberOfInvocations >= minimum && numberOfInvocations <= maximum);
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"between(%d and %d)", minimum, maximum];
}

- (void)describeTo:(LRExpectationMessage *)message
{
  [message append:[NSString stringWithFormat:@"%@ times", [self description]]];
}

@end

id<LRExpectationCardinality> LRM_between(int min, int max)
{
  return [[[LRBetweenCardinality alloc] initWithMinimum:min andMaximum:max] autorelease];
}
