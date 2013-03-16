//
//  LCYInputDrivenStateMachine.m
//  LockScreen
//
//  Created by Krishna Kotecha on 25/11/2010.
//  Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import "LCYPasscodeUIStateMachine.h"

@implementation LCYPasscodeUIStateMachine

@dynamic theNewPasscode;
@dynamic existingPasscode;
@dynamic currentErrorText;

- (NSString *) currentPromptText;
{
    return nil;
}

- (void) transitionWithInput:(NSString *)input;
{
}

- (BOOL) gotCompletionState;
{
    return NO;
}

- (void) reset;
{
}

@end
