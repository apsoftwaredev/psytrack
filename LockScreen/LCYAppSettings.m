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
-(BOOL)setPasscodeDataWithData:(NSData *)passcodeDataToSave{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
       
    
    BOOL success=NO;
    NSData *passcodeData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE];
    
    
   
    if (!passcodeData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_PASSCODE];
        success= [wrapper createKeychainValueWithData: passcodeDataToSave forIdentifier:K_LOCK_SCREEN_PASSCODE];
        //           passcodeData = [wrapper searchKeychainCopyMatching:@"Passcode"];
        
        
    }
    else {
        success= [wrapper updateKeychainValueWithData:passcodeDataToSave forIdentifier:K_LOCK_SCREEN_PASSCODE];
    }
    
    
    passcodeData=nil;
    passcodeDataToSave=nil;
    wrapper=nil;
    
    return success;
    
    
}


-(BOOL)setLockScreenLocked:(BOOL)lockScreenLocked{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

  
    BOOL success=NO;
    
   
    NSData *lockScreenLockedData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCKED];
    
    if (!lockScreenLockedData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_LOCKED];
        success= [wrapper createKeychainValueWithData:[appDelegate convertStringToData:(NSString *)[NSString stringWithFormat:@"%i", lockScreenLocked]] forIdentifier:K_LOCK_SCREEN_LOCKED];
    }else  {
        success= [wrapper updateKeychainValueWithData:(NSData *)[appDelegate convertStringToData:(NSString *)[NSString stringWithFormat:@"%i",lockScreenLocked]] forIdentifier:K_LOCK_SCREEN_LOCKED];
        
    } 

    wrapper=nil;
    lockScreenLockedData=nil;
    
    return success;
    
    
}

-(BOOL)setLockScreenPasscodeIsOn:(BOOL)lockScreenIsOn{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    
    BOOL success=NO;
   
    
    NSData *pascodeOnData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE_IS_ON];
    NSData *dataToGoIn=[appDelegate convertStringToData:(NSString *)[NSString stringWithFormat:@"%i",lockScreenIsOn]];
    
       
    if (!pascodeOnData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_PASSCODE_IS_ON];
        success=  [wrapper createKeychainValue: [NSString stringWithFormat:@"%i", 1] forIdentifier:K_LOCK_SCREEN_PASSCODE_IS_ON];
        
        
    }else  {
               
        success=  [wrapper updateKeychainValueWithData:dataToGoIn forIdentifier:K_LOCK_SCREEN_PASSCODE_IS_ON];
        
    }
   
   
                       
    
    return success;
    
    
}

-(BOOL)setLockScreenAttempt:(NSInteger)attempt{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
    // as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
	PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    BOOL success=NO;
    
    
    NSData *lockScreenAttemptData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_ATTEMPT];
    if (!lockScreenAttemptData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_ATTEMPT];
        success= [wrapper createKeychainValueWithData:[appDelegate convertStringToData:[NSString stringWithFormat:@"%i",attempt]] forIdentifier:K_LOCK_SCREEN_ATTEMPT];
        
        
    }else  {
        success=  [wrapper updateKeychainValueWithData:[appDelegate convertStringToData:(NSString *)[NSString stringWithFormat:@"%i",attempt]] forIdentifier:K_LOCK_SCREEN_ATTEMPT];
    }
    
    
    lockScreenAttemptData=nil;
    wrapper=nil;
    
    return success;
    
    
}


-(BOOL)setLockScreenStartup:(BOOL)lockOnStartup{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    // as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
	
    BOOL success=NO;
    
    
    
    
    NSData *lockScreenStartupData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCK_AT_STARTUP];
    if (!lockScreenStartupData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_LOCK_AT_STARTUP];
        success= [wrapper createKeychainValueWithData:[appDelegate convertStringToData:[NSString stringWithFormat:@"%i", lockOnStartup]] forIdentifier:K_LOCK_SCREEN_LOCK_AT_STARTUP];
        
    }else  {
        success= [wrapper updateKeychainValueWithData: [appDelegate convertStringToData:(NSString *)[NSString stringWithFormat:@"%i",lockOnStartup]] forIdentifier:K_LOCK_SCREEN_LOCK_AT_STARTUP];
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

- (NSInteger) numberOfUnlockAttempts
{	
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_ATTEMPT];
    NSInteger numberOfAttempts=0;
    if (lockedData) {
        NSString *numberStr=(NSString * )[appDelegate convertDataToString:lockedData];
        
        if ([self checkStringIsNumber:numberStr]) {
            numberOfAttempts=[numberStr integerValue];
        }
        else {
            numberOfAttempts=20;
        }
    }
    else {
        numberOfAttempts=20;
    }
    return numberOfAttempts;
    
}
-(BOOL)checkStringIsNumber:(NSString *)str{
    BOOL valid=YES;
    NSNumberFormatter *numberFormatter =[[NSNumberFormatter alloc] init];
    NSString *numberStr=[str stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSNumber *number=[numberFormatter numberFromString:numberStr];
    if (numberStr.length && [numberStr floatValue]<1000000 &&number) {
        valid=YES;
        
        if ([str rangeOfString:@"Number"].location != NSNotFound) {
            NSScanner* scan = [NSScanner scannerWithString:numberStr]; 
            int val;         
            
            valid=[scan scanInt:&val] && [scan isAtEnd];
            
            
        }
        
        
    } 
    
    return valid;
    
}

@end
