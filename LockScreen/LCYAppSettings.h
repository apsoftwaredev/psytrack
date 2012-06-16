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



-(BOOL)setPasscodeDataWithString:(NSString *)passcodeString;


-(BOOL)setLockScreenLocked:(BOOL)lockScreenLocked;

-(BOOL)setLockScreenPasscodeIsOn:(BOOL)lockScreenIsOn;
-(BOOL)setPasscodeDataWithData:(NSData *)passcodeDataToSave;
-(BOOL)setLockScreenAttempt:(int)attempt;


-(BOOL)setLockScreenStartup:(BOOL)lockOnStartup;

-(BOOL)setLockScreenTimerOn:(BOOL)timerOn;

-(NSData *)passcodeData;

- (BOOL) isPasscodeOn;
- (BOOL) isLockedAtStartup;

- (NSInteger) numberOfUnlockAttempts;

-(BOOL)isAppLocked;
-(BOOL)isLockedTimerOn;

@end
