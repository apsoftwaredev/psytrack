//
//  LCYAppSettings.m
//  LockScreen
//
//  Created by Krishna Kotecha on 27/11/2010.
//   Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import "LCYAppSettings.h"
#import "PTTAppDelegate.h"
#import "KeychainItemWrapper.h"
@interface LCYAppSettings()
- (void) updateProperties;
@end

@implementation LCYAppSettings

@synthesize lockScreenPasscodeIsOn = lockScreenPasscodeIsOn_;
@synthesize lockScreenPasscode = lockScreenPasscode_;
@synthesize lockScreenLocked=lockScreenLocked_;
@synthesize lockScreenPasscodeAttempt=lockScreenPasscodeAttempt_;
@synthesize lockScreenTimerOn=lockScreenTimerOn_;
@synthesize lockScreenLockAtStartup=lockScreenLockAtStartup_;
//@synthesize lockScreenChallengePhrase=lockScreenChallengePhrase_;
//@synthesize lockScreenChallengeResponse=lockScreenChallengeResponse_;



- (id) init;
{
	if ( (self = [super init]) )
	{
		[self updateProperties];
	}
	return self;
}

- (BOOL) saveSettings
{
        BOOL result=FALSE;
        [self updateProperties];
        result=[self synchronize];
        return result;

}
- (BOOL) synchronize
{
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
   NSMutableDictionary* lockDictionary=(NSMutableDictionary *)[appDelegate lockValuesDictionary];
    
    [lockDictionary setValue:[NSNumber numberWithBool:self.lockScreenPasscodeIsOn] forKey:K_LOCK_SCREEN_PASSCODE_IS_ON];

	// as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
	NSString *passcodeToSave = (self.lockScreenPasscodeIsOn) ? self.lockScreenPasscode : @"" ;
NSLog(@"passcodeToSave: %@", passcodeToSave);
	
	[lockDictionary setObject:passcodeToSave forKey:K_LOCK_SCREEN_PASSCODE];
	KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Passcode" accessGroup:nil];
	
    NSString *password=[wrapper objectForKey:(__bridge_transfer id)kSecValueData];
    //    BOOL falseData=YES;
    if ( wrapper && (!password ||!password.length)) {
        
        [wrapper setObject:passcodeToSave forKey:(__bridge id) kSecValueData];
    }

    [lockDictionary setValue:[NSNumber numberWithBool:self.lockScreenLocked] forKey:K_LOCK_SCREEN_LOCKED];
    [lockDictionary setValue:[NSNumber numberWithInteger:self.lockScreenPasscodeAttempt] forKey:K_LOCK_SCREEN_ATTEMPT];
    [lockDictionary setValue:[NSNumber numberWithBool:self.lockScreenTimerOn] forKey:K_LOCK_SCREEN_TIMER_ON];
    [lockDictionary setValue:[NSNumber numberWithBool:self.lockScreenLockAtStartup] forKey:K_LOCK_SCREEN_LOCK_AT_STARTUP];
//    [userDefaults setValue:self.lockScreenChallengePhrase forKey:K_LOCK_SCREEN_CHALLENGE_PHRASE];
//    [userDefaults setValue:self.lockScreenChallengeResponse forKey:K_LOCK_SCREEN_LOCK_CHALLENGE_RESPONSE];
    
    //NSLog(@"lock screen pass code is on is%i",self.lockScreenPasscodeIsOn);
    //NSLog(@"lock screen screen locked is on is%i",self.lockScreenLocked);
     //NSLog(@"lock screen passcode to save is on is%@",self.lockScreenPasscode);
    //NSLog(@"lock screen lock screen attempt is on is%i",self.lockScreenPasscodeAttempt);
     //NSLog(@"lock screen lock screen attempt is on is%i",self.lockScreenLockAtStartup);
    
	BOOL result = [appDelegate saveLockDictionarySettings];
	if (result)
	{
		[self updateProperties];
	}
	return result;
}



- (void) updateProperties;
{
	NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];	
	self.lockScreenPasscodeIsOn = [userDefaults boolForKey:K_LOCK_SCREEN_PASSCODE_IS_ON];
	lockScreenPasscode_ = [userDefaults stringForKey:K_LOCK_SCREEN_PASSCODE];	
    self.lockScreenLocked= [userDefaults boolForKey:K_LOCK_SCREEN_LOCKED];
    self.lockScreenPasscodeAttempt=[userDefaults integerForKey:K_LOCK_SCREEN_ATTEMPT];
    self.lockScreenTimerOn=[userDefaults boolForKey:K_LOCK_SCREEN_TIMER_ON];
    self.lockScreenLockAtStartup=[userDefaults boolForKey:K_LOCK_SCREEN_LOCK_AT_STARTUP];
//    self.lockScreenChallengePhrase=[userDefaults stringForKey:K_LOCK_SCREEN_CHALLENGE_PHRASE];
//    self.lockScreenChallengeResponse=[userDefaults stringForKey:K_LOCK_SCREEN_LOCK_CHALLENGE_RESPONSE];
    
    
}


@end
