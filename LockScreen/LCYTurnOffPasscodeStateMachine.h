//
//  Created by Krishna Kotecha on 23/11/2010.
//  Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import <Foundation/Foundation.h>
#import "LCYPasscodeUIStateMachine.h"

typedef enum 
{ 
	LCYTurnOffPasscodeStatesConfirmExistingPassword,
	LCYTurnOffPasscodeStatesDone,
} LCYTurnOffPasscodeStates;

@interface LCYTurnOffPasscodeStateMachine : LCYPasscodeUIStateMachine 
{
	LCYTurnOffPasscodeStates state_;

	NSData *existingPasscode_;	
	NSString *currentErrorText_;
}

@property (nonatomic, copy) NSData* theNewPasscode;
@property (nonatomic, copy) NSData* existingPasscode;
@property (nonatomic, readonly) NSString *currentErrorText;

NSString * NSStringFromLCYTurnOffPasscodeStates (LCYTurnOffPasscodeStates state);
- (void) transitionWithInput:(NSString *) input;

- (void) successTransition;
- (void) failTransition;

- (NSString *) currentPromptText;

- (BOOL) gotCompletionState;
- (void) reset;

@end
