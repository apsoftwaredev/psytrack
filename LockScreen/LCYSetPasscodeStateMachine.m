//
//  Created by Krishna Kotecha on 23/11/2010.
//  Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import "LCYSetPasscodeStateMachine.h"
#import "PTTAppDelegate.h"
#import "LCYAppSettings.h"
#import "PTTEncryption.h"
NSString* NSStringFromLCYSetPasscodeStates (LCYSetPasscodeStates state)
{
	NSString *result = nil;
	switch (state) 
	{
		case LCYSetPasscodeStatesGetNewPassword:
			result = @"getNewPassword";
			break;
		case LCYSetPasscodeStatesConfirmNewPassword:
			result = @"confirmNewPassword";
			break;
		case LCYSetPasscodeStatesDone:
			result = @"done";
			break;
		default:
			result = @"Unknown state";
			break;
	}
	return result;
}

@implementation LCYSetPasscodeStateMachine

@synthesize theNewPasscode = theNewPasscode_;
@synthesize currentErrorText = currentErrorText_;


- (id) init;
{
	if ( (self = [super init]) )
	{
		state_ = LCYSetPasscodeStatesGetNewPassword;
	}
	return self;
}


- (NSString *) description;
{
	return [NSString stringWithFormat:@"state: %@ | new: %@", 
			NSStringFromLCYSetPasscodeStates(state_),
			self.theNewPasscode
			];
}

- (void) successTransition;
{
	currentErrorText_ = nil;
	switch (state_) 
	{
		case LCYSetPasscodeStatesGetNewPassword:
			state_ = LCYSetPasscodeStatesConfirmNewPassword;
			break;
		case LCYSetPasscodeStatesConfirmNewPassword:
			state_ = LCYSetPasscodeStatesDone;
			break;
		case LCYSetPasscodeStatesDone:
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
		case LCYSetPasscodeStatesGetNewPassword:
			break;
		case LCYSetPasscodeStatesConfirmNewPassword:
			self.theNewPasscode = nil;
			currentErrorText_ = @"Passcode did not match. Try again.";
			state_ = LCYSetPasscodeStatesGetNewPassword;
			break;
		case LCYSetPasscodeStatesDone:
			break;
		default:
			NSAssert(NO, @"Unknown state");
			break;
	}
}

- (void) transitionWithInput:(NSString *) input;
{
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
 
    PTTEncryption *encryption=[[PTTEncryption alloc]init];
    NSString *passcodeToSave = (input) ? [NSString stringWithFormat:@"%@kdieJsi3ea18ki" ,input ] :@"o6fjZ4dhvKIUYVmaqnNJIPCBE2" ;
	switch (state_) 
	{			
		case LCYSetPasscodeStatesGetNewPassword:
			self.theNewPasscode = [encryption getHashBytes:[appDelegate convertStringToData: passcodeToSave]];
			[self successTransition];
			break;
			
		case LCYSetPasscodeStatesConfirmNewPassword:
			if ([self.theNewPasscode isEqualToData:[encryption getHashBytes:[appDelegate convertStringToData: passcodeToSave]]])
			{
				[self successTransition];
			}
			else 
			{
				[self failTransition];
			}

			break;
			
		case LCYSetPasscodeStatesDone:
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
		case LCYSetPasscodeStatesGetNewPassword:
			result = @"Enter new passcode";
			break;
		case LCYSetPasscodeStatesConfirmNewPassword:
			result = @"Re-enter new passcode";
			break;
		case LCYSetPasscodeStatesDone:
			result = @"New passcode set";
			break;
		default:
			result = @"Unknown state";
			break;
	}
	return result;
}

- (BOOL) gotCompletionState;
{
	return (state_ == LCYSetPasscodeStatesDone);
}

- (void) reset;
{
	state_ = LCYSetPasscodeStatesGetNewPassword;
	currentErrorText_ = nil;
	self.theNewPasscode = nil;
}

@end
