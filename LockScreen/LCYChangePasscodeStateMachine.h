//
//  StateMachine.h
//  StateMachine
//
//  Created by Krishna Kotecha on 23/11/2010.
//  Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012

#import <Foundation/Foundation.h>
#import "LCYPasscodeUIStateMachine.h"

typedef enum 
{ 
	LCYChangePasscodeStatesConfirmExistingPassword,
	LCYChangePasscodeStatesGetNewPassword,
	LCYChangePasscodeStatesConfirmNewPassword,
	LCYChangePasscodeStatesDone,
} LCYChangePasscodeStates;

@interface LCYChangePasscodeStateMachine : LCYPasscodeUIStateMachine 
{
	LCYChangePasscodeStates state_;

	NSString *existingPasscode_;
	NSString *theNewPasscode_;
	
	NSString *currentErrorText_;
}


@property (nonatomic, copy) NSString* existingPasscode;
@property (nonatomic, copy) NSString* theNewPasscode;

@property (nonatomic, readonly) NSString *currentErrorText;

NSString* NSStringFromLCYChangePasscodeStates (LCYChangePasscodeStates state);
- (void) transitionWithInput:(NSString *) input;

- (void) successTransition;
- (void) failTransition;

- (NSString *) currentPromptText;

- (BOOL) gotCompletionState;
- (void) reset;

@end
