//
//  LCYAppSettings.h
//  LockScreen
//
//  Created by Krishna Kotecha on 27/11/2010.
//   Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import <Foundation/Foundation.h>

static NSString * const K_LOCK_SCREEN_PASSCODE_IS_ON = @"lock_screen_passcode_is_on";
static NSString * const K_LOCK_SCREEN_PASSCODE = @"lock_screen_passcode";
static NSString * const K_LOCK_SCREEN_LOCKED=@"lock_screen_locked";
static NSString * const K_LOCK_SCREEN_ATTEMPT= @"lock_screen_passcode_attempt";
static NSString * const K_LOCK_SCREEN_TIMER_ON= @"lock_screen_timer_on";
static NSString * const K_LOCK_SCREEN_LOCK_AT_STARTUP= @"lock_screen_lock_at_startup";
static NSString * const K_LOCK_SCREEN_P_HSH= @"pw_hash";
static NSString * const K_LOCK_SCREEN_DF_HASH= @"df_hash";
static NSString * const K_LOCK_SCREEN_RAN= @"ran_st";
static NSString * const K_LOCK_SCREEN_CURRENT_KEYSTRING= @"current_keyString";
@interface LCYAppSettings : NSObject 
{
	BOOL lockScreenPasscodeIsOn_;
	NSString *lockScreenPasscode_;
//    NSString *lockScreenChallengePhrase_;
//    NSString *lockScreenChallengeResponse_;
	NSInteger lockScreenUserPasscodeAttempt_;
    BOOL lockScreenLocked_;
    BOOL lockScreenTimerOn_;
   BOOL lockScreenLockAtStartup_;
}

@property (nonatomic, assign) BOOL lockScreenPasscodeIsOn;
@property (nonatomic, assign) BOOL lockScreenLocked;
@property (nonatomic, assign) NSInteger lockScreenPasscodeAttempt;
@property (nonatomic, strong) NSString *lockScreenPasscode;
//@property (nonatomic, retain) NSString *lockScreenChallengePhrase;
//@property (nonatomic, retain) NSString *lockScreenChallengeResponse;

@property (nonatomic, assign) BOOL lockScreenTimerOn;
@property (nonatomic, assign) BOOL lockScreenLockAtStartup;

- (void) updateProperties;
- (BOOL) synchronize;
-(BOOL)saveSettings;

@end
