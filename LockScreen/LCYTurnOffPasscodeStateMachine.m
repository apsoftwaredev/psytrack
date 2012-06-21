//
//  Created by Krishna Kotecha on 23/11/2010.
//  Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import "LCYTurnOffPasscodeStateMachine.h"
#import "PTTAppDelegate.h"
#import "LCYAppSettings.h"
#import "PTTEncryption.h"

NSString * NSStringFromLCYTurnOffPasscodeStates (LCYTurnOffPasscodeStates state)
{
	NSString *result = nil;
	switch (state) 
	{
		case LCYTurnOffPasscodeStatesConfirmExistingPassword:
			result = @"confirmExistingPassword";
			break;
		case LCYTurnOffPasscodeStatesDone:
			result = @"done";
			break;
		default:
			result = @"Unknown state";
			break;
	}
	return result;
}


@implementation LCYTurnOffPasscodeStateMachine

@synthesize existingPasscode = existingPasscode_;
@synthesize currentErrorText = currentErrorText_;

- (id) init;
{
	if ( (self = [super init]) )
	{
		state_ = LCYTurnOffPasscodeStatesConfirmExistingPassword;
	}
	return self;
}


- (NSString *) description;
{
	return [NSString stringWithFormat:@"state: %@ | existingPasscode: %@", 
			NSStringFromLCYTurnOffPasscodeStates(state_),
			self.existingPasscode
			];
}

- (void) successTransition;
{
	currentErrorText_ = nil;
	switch (state_) 
	{
		case LCYTurnOffPasscodeStatesConfirmExistingPassword:
			state_ = LCYTurnOffPasscodeStatesDone;
			break;
		case LCYTurnOffPasscodeStatesDone:
			break;
		default:
			NSAssert(NO, @"Unknown state");
			break;
	}	
}

- (void) failTransition;
{
	switch (state_) 
	{
		case LCYTurnOffPasscodeStatesConfirmExistingPassword:
			currentErrorText_ = @"Attempt to change passcode failed and the app was locked. Try again or cancel.";
			break;
		case LCYTurnOffPasscodeStatesDone:
			break;
		default:
			NSAssert(NO, @"Unknown state");
			break;
	}
}

- (void) transitionWithInput:(NSString *) input;
{
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    LCYAppSettings *appSettings=[[LCYAppSettings alloc]init];
    PTTEncryption *encryption=[[PTTEncryption alloc]init];
    NSString *passcodeToSave = (input) ? [NSString stringWithFormat:@"%@kdieJsi3ea18ki" ,input ] :@"o6fjZ4dhvKIUYVmaqnNJIPCBE2" ;
	switch (state_) 
	{
		case LCYTurnOffPasscodeStatesConfirmExistingPassword:
			if ([[appSettings passcodeData] isEqualToData:[encryption getHashBytes:[appDelegate convertStringToData: passcodeToSave]]])
			{
				[self successTransition];
			}
			else 
			{
                [appDelegate lockApplication];
                [appDelegate displayWrongPassword];
				[self failTransition];
                
			}
			break;
						
		case LCYTurnOffPasscodeStatesDone:
			break;
			
		default:
			NSAssert(NO, @"Unknown state");
			break;
	}	
}

- (NSString *) currentPromptText;
{
	NSString *result = nil;
	switch (state_) 
	{
		case LCYTurnOffPasscodeStatesConfirmExistingPassword:
			result = @"Enter existing passcode";
			break;
		default:
			result = @"Unknown state";
			break;
	}
	return result;
}

- (BOOL) gotCompletionState;
{
	return (state_ == LCYTurnOffPasscodeStatesDone);
}

- (NSData *) theNewPasscode;
{
	return nil;
}

- (void) setTheNewPasscode: (NSString *) nu;
{
}

- (void) reset;
{
	state_ = LCYTurnOffPasscodeStatesConfirmExistingPassword;
	self.theNewPasscode = nil;
	self.existingPasscode = nil;
	currentErrorText_ = nil;
}

@end
