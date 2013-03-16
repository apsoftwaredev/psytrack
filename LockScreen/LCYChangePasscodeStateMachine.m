//
//  StateMachine.m
//  StateMachine
//
//  Created by Krishna Kotecha on 23/11/2010.
//  Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import "LCYChangePasscodeStateMachine.h"
#import "PTTEncryption.h"
#import "PTTAppDelegate.h"
#import "LCYAppSettings.h"
NSString *NSStringFromLCYChangePasscodeStates(LCYChangePasscodeStates state)
{
    NSString *result = nil;
    switch (state)
    {
        case LCYChangePasscodeStatesConfirmExistingPassword:
            result = @"confirmExistingPassword";
            break;
        case LCYChangePasscodeStatesGetNewPassword:
            result = @"getNewPassword";
            break;
        case LCYChangePasscodeStatesConfirmNewPassword:
            result = @"confirmNewPassword";
            break;
        case LCYChangePasscodeStatesDone:
            result = @"done";
            break;
        default:
            result = @"Unknown state";
            break;
    } /* switch */

    return result;
}


@implementation LCYChangePasscodeStateMachine

@synthesize theNewPasscode = theNewPasscode_;
@synthesize existingPasscode = existingPasscode_;
@synthesize currentErrorText = currentErrorText_;

- (id) init;
{
    if ( (self = [super init]) )
    {
        state_ = LCYChangePasscodeStatesConfirmExistingPassword;
    }

    return self;
}

- (NSString *) description;
{
    return [NSString stringWithFormat:@"state: %@ | existingPasscode: %@ | new: %@",
            NSStringFromLCYChangePasscodeStates(state_),
            self.existingPasscode,
            self.theNewPasscode
    ];
}

- (void) successTransition;
{
    currentErrorText_ = nil;
    switch (state_)
    {
        case LCYChangePasscodeStatesConfirmExistingPassword:
            state_ = LCYChangePasscodeStatesGetNewPassword;
            break;
        case LCYChangePasscodeStatesGetNewPassword:
            state_ = LCYChangePasscodeStatesConfirmNewPassword;
            break;
        case LCYChangePasscodeStatesConfirmNewPassword:
            state_ = LCYChangePasscodeStatesDone;
            break;
        case LCYChangePasscodeStatesDone:
            break;
        default:
            NSAssert(NO, @"Unknown state");
            break;
    } /* switch */
}

- (void) failTransition;
{
    switch (state_)
    {
        case LCYChangePasscodeStatesConfirmExistingPassword:
            currentErrorText_ = @"Incorrect passcode. Try again.";
            break;
        case LCYChangePasscodeStatesGetNewPassword:
            break;
        case LCYChangePasscodeStatesConfirmNewPassword:
            self.theNewPasscode = nil;
            currentErrorText_ = @"Passcode did not match. Try again.";
            state_ = LCYChangePasscodeStatesGetNewPassword;
            break;
        case LCYChangePasscodeStatesDone:
            break;
        default:
            NSAssert(NO, @"Unknown state");
            break;
    } /* switch */
}

- (void) transitionWithInput:(NSString *)input;
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    LCYAppSettings *appSettings = [[LCYAppSettings alloc]init];
    PTTEncryption *encryption = [[PTTEncryption alloc]init];
    NSString *passcodeToSave = (input) ? [NSString stringWithFormat:@"%@kdieJsi3ea18ki",input ] : @"o6fjZ4dhvKIUYVmaqnNJIPCBE2";
    switch (state_)
    {
        case LCYChangePasscodeStatesConfirmExistingPassword:
        {
            if ([[appSettings passcodeData] isEqualToData:[encryption getHashBytes:[appDelegate convertStringToData:passcodeToSave]]])
            {
                [self successTransition];
            }
            else
            {
                [self failTransition];
            }
        }
        break;

        case LCYChangePasscodeStatesGetNewPassword:
            self.theNewPasscode = [encryption getHashBytes:[appDelegate convertStringToData:passcodeToSave]];
            [self successTransition];
            break;

        case LCYChangePasscodeStatesConfirmNewPassword:
            if ([self.theNewPasscode isEqualToData:[encryption getHashBytes:[appDelegate convertStringToData:passcodeToSave]]])
            {
                [self successTransition];
            }
            else
            {
                [self failTransition];
            }

            break;

        case LCYChangePasscodeStatesDone:
            break;

        default:
            NSAssert(NO, @"Unknown state");
            break;
    } /* switch */
}

- (NSString *) currentPromptText;
{
    NSString *result = nil;
    switch (state_)
    {
        case LCYChangePasscodeStatesConfirmExistingPassword:
            result = @"Enter existing passcode";
            break;
        case LCYChangePasscodeStatesGetNewPassword:
            result = @"Enter new passcode";
            break;
        case LCYChangePasscodeStatesConfirmNewPassword:
            result = @"Re-enter new passcode";
            break;
        case LCYChangePasscodeStatesDone:
            result = @"New passcode set";
            break;
        default:
            result = @"Unknown state";
            break;
    } /* switch */

    return result;
}

- (BOOL) gotCompletionState;
{
    return (state_ == LCYChangePasscodeStatesDone);
}

- (void) reset;
{
    state_ = LCYChangePasscodeStatesConfirmExistingPassword;
    currentErrorText_ = nil;
    self.theNewPasscode = nil;
    self.existingPasscode = nil;
}

@end
