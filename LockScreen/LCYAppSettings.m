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
#import "PTTEncryption.h"

@implementation LCYAppSettings

//@synthesize lockScreenChallengePhrase=lockScreenChallengePhrase_;
//@synthesize lockScreenChallengeResponse=lockScreenChallengeResponse_;





-(BOOL)setPasscodeDataWithString:(NSString *)passcodeString{

    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
  	// as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
	NSString *passcodeToSave = (passcodeString) ? [NSString stringWithFormat:@"%@kdieJsi3ea18ki" ,passcodeString ] :@"o6fjZ4dhvKIUYVmaqnNJIPCBE2" ;
    NSLog(@"passcodeToSave: %@", passcodeToSave);
	
	
    
    
    BOOL success=NO;
    NSData *passcodeData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE];
    
    
    PTTEncryption *encryption=(PTTEncryption *)[appDelegate encryption];
    if (!passcodeData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_PASSCODE];
        success= [wrapper createKeychainValueWithData:[encryption getHashBytes:[appDelegate convertStringToData: passcodeToSave]] forIdentifier:K_LOCK_SCREEN_PASSCODE];
        //           passcodeData = [wrapper searchKeychainCopyMatching:@"Passcode"];
        
        
    }
    else {
        success= [wrapper updateKeychainValueWithData:[encryption getHashBytes:[appDelegate convertStringToData: passcodeToSave]] forIdentifier:K_LOCK_SCREEN_PASSCODE];
    }


    passcodeString=nil;
    passcodeData=nil;
    passcodeToSave=nil;
    wrapper=nil;
    
    return success;


}


-(BOOL)setLockScreenLocked:(BOOL)lockScreenLocked{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
  
    BOOL success=NO;
    
   
    NSData *lockScreenLockedData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCKED];
    
    if (!lockScreenLockedData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_LOCKED];
        success= [wrapper createKeychainValue:[NSString stringWithFormat:@"%i", lockScreenLocked] forIdentifier:K_LOCK_SCREEN_LOCKED];
    }else  {
        success= [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",lockScreenLocked] forIdentifier:K_LOCK_SCREEN_LOCKED];
        
    } 

    wrapper=nil;
    lockScreenLockedData=nil;
    
    return success;
    
    
}

-(BOOL)setLockScreenIsOn:(BOOL)lockScreenIsOn{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
   
    
    BOOL success=NO;
    
    
    NSData *pascodeOnData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE_IS_ON];
    if (!pascodeOnData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_PASSCODE_IS_ON];
        success=  [wrapper createKeychainValue:[NSString stringWithFormat:@"%i", lockScreenIsOn] forIdentifier:K_LOCK_SCREEN_PASSCODE_IS_ON];
        
        
    }else  {
        success=  [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",lockScreenIsOn] forIdentifier:K_LOCK_SCREEN_PASSCODE_IS_ON];
        
    }
    
    pascodeOnData=nil;
    wrapper=nil;
    
    
    return success;
    
    
}

-(BOOL)setLockScreenAttempt:(int)attempt{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
    // as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
	
    BOOL success=NO;
    
    
    NSData *lockScreenAttemptData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_ATTEMPT];
    if (!lockScreenAttemptData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_ATTEMPT];
        success= [wrapper createKeychainValue:[NSString stringWithFormat:@"%i",attempt] forIdentifier:K_LOCK_SCREEN_ATTEMPT];
        
        
    }else  {
        success=  [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",attempt] forIdentifier:K_LOCK_SCREEN_ATTEMPT];
    }
    
    
    lockScreenAttemptData=nil;
    wrapper=nil;
    
    return success;
    
    
}


-(BOOL)setLockScreenStartup:(BOOL)lockOnStartup{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
    // as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
	
    BOOL success=NO;
    
    
    
    
    NSData *lockScreenStartupData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCK_AT_STARTUP];
    if (!lockScreenStartupData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_LOCK_AT_STARTUP];
        success= [wrapper createKeychainValue:[NSString stringWithFormat:@"%i", lockOnStartup] forIdentifier:K_LOCK_SCREEN_LOCK_AT_STARTUP];
        
    }else  {
        success= [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",lockOnStartup] forIdentifier:K_LOCK_SCREEN_LOCK_AT_STARTUP];
    }
    
    
    lockScreenStartupData=nil;
    wrapper=nil;
    
    return success;
    
    
}

-(BOOL)setLockScreenTimerOn:(BOOL)timerOn{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
    // as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
	
    BOOL success=NO;
    
    
    
    
    
    NSData *lockScreenTimerOnData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_TIMER_ON];
    if (!lockScreenTimerOnData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_TIMER_ON];
        success= [wrapper createKeychainValue:[NSString stringWithFormat:@"%i", timerOn] forIdentifier:K_LOCK_SCREEN_TIMER_ON];
        
    }else  {
        success=  [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",timerOn] forIdentifier:K_LOCK_SCREEN_TIMER_ON];
    }
    
    lockScreenTimerOnData=nil;
    wrapper=nil;
    
    return success;
    
    
}

-(NSData *)passcodeData{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
   
    return [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE];
    
    
}


- (BOOL) isPasscodeOn
{	
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE_IS_ON];
    
    return (BOOL)[(NSString * )[appDelegate convertDataToString:lockedData]boolValue];
    
}
- (BOOL) isLockedAtStartup
{	
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCK_AT_STARTUP];
    
    return (BOOL)[(NSString * )[appDelegate convertDataToString:lockedData]boolValue];
}



-(BOOL)isAppLocked{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCKED];
    
    return (BOOL)[(NSString * )[appDelegate convertDataToString:lockedData]boolValue];	
    
}
-(BOOL)isLockedTimerOn{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_TIMER_ON];
    
    return (BOOL)[(NSString * )[appDelegate convertDataToString:lockedData]boolValue];	
    
}




@end
