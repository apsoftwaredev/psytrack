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
#import "KeyEntity.h"

#import "ClientEntity.h"
#import "ExistingHoursEntity.h"
#import "ClinicianEntity.h"
#import "MedicationReviewEntity.h"
#import "MedicationEntity.h"
#import "ReferralEntity.h"
#import "InterpersonalEntity.h"
#import "MigrationHistoryEntity.h"
#import "DemographicProfileEntity.h"
#import "LogEntity.h"

@implementation LCYAppSettings

//@synthesize lockScreenChallengePhrase=lockScreenChallengePhrase_;
//@synthesize lockScreenChallengeResponse=lockScreenChallengeResponse_;



//-(void)rekeyEncryptedModelSubclasses{
//
//    BOOL rekey=YES;
//    if (rekey) {
//        NSArray *clientsArray=[self fetchEntity:@"ClientEntity"];
//        
//        for (ClientEntity *client in clientsArray) {
//            
//            [client rekeyEncryptedAttributes];
//        }
//    }
//   
//    if (rekey) {
//        NSArray *existingHoursArray=[self fetchEntity:@"ExistingHoursEntity"];
//        
//        for (ExistingHoursEntity *existingHours in existingHoursArray) {
//            
//            [existingHours rekeyEncryptedAttributes];
//        }
//    }
//    if (rekey) {
//        NSArray *clinicianArray=[self fetchEntity:@"ClinicianEntity"];
//        
//        for (ClinicianEntity *clinician in clinicianArray) {
//            
//            [clinician rekeyEncryptedAttributes];
//        }
//    }
//    if (rekey) {
//        NSArray *medicationReviewArray=[self fetchEntity:@"MedicationReviewEntity"];
//        
//        for (MedicationReviewEntity *medicationReview in medicationReviewArray) {
//            
//            [medicationReview rekeyEncryptedAttributes];
//        }
//    }
//    if (rekey) {
//        NSArray *medicationReviewArray=[self fetchEntity:@"MedicationReviewEntity"];
//        
//        for (MedicationReviewEntity *medicationReview in medicationReviewArray) {
//            
//            [medicationReview rekeyEncryptedAttributes];
//        }
//    }
//    if (rekey) {
//        NSArray *medicationEntityArray=[self fetchEntity:@"MedicationEntity"];
//        
//        for (MedicationEntity *medication in medicationEntityArray) {
//            
//            [medication rekeyEncryptedAttributes];
//        }
//    }
//    if (rekey) {
//        NSArray *referralEntityArray=[self fetchEntity:@"ReferralEntity"];
//        
//        for (ReferralEntity *referral in referralEntityArray) {
//            
//            [referral rekeyEncryptedAttributes];
//        }
//    }
//
//    if (rekey) {
//        NSArray *interpersonalEntityArray=[self fetchEntity:@"InterpersonalEntity"];
//        
//        for (InterpersonalEntity *interpersonal in interpersonalEntityArray) {
//            
//            [interpersonal rekeyEncryptedAttributes];
//        }
//    }
//    
//
//    if (rekey) {
//        NSArray *migrationHistoryEntityArray=[self fetchEntity:@"MigrationHistoryEntity"];
//        
//        for (MigrationHistoryEntity *migrationHistory in migrationHistoryEntityArray) {
//            
//            [migrationHistory rekeyEncryptedAttributes];
//        }
//    }
//    if (rekey) {
//        NSArray *demographicProfileEntityArray=[self fetchEntity:@"DemographicProfileEntity"];
//        
//        for (DemographicProfileEntity *demographicProfile in demographicProfileEntityArray) {
//            
//            [demographicProfile rekeyEncryptedAttributes];
//        }
//    }
//    
//    if (rekey) {
//        NSArray *logEntityArray=[self fetchEntity:@"LogEntity"];
//        
//        for (LogEntity *log in logEntityArray) {
//            
//            [log rekeyEncryptedAttributes];
//        }
//    }
//
//
//    
//
//}

-(NSArray *)fetchEntity:(NSString *)entityName{
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *managedObjectContext=appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
[fetchRequest setEntity:entity];

NSError *error = nil;
NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if (fetchedObjects) {
        return fetchedObjects;
    }
    
    else
        return [NSArray array];
    
//    fetchRequest=nil;
}


-(BOOL)setPasscodeDataWithString:(NSString *)passcodeString{

    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
  	// as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
	NSString *passcodeToSave = (passcodeString) ? [NSString stringWithFormat:@"%@kdieJsi3ea18ki" ,passcodeString ] :@"o6fjZ4dhvKIUYVmaqnNJIPCBE2" ;

	
	
    
    
    BOOL success=NO;
    NSData *passcodeData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE];
    
    
    PTTEncryption *encryption=(PTTEncryption *)[appDelegate encryption];
    if (!encryption) {
        appDelegate.encryption=[[PTTEncryption alloc]init];
        encryption=appDelegate.encryption;
    }
    if (!passcodeData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_PASSCODE];
        success= [wrapper createKeychainValueWithData:[encryption getHashBytes:[appDelegate convertStringToData: passcodeToSave]] forIdentifier:K_LOCK_SCREEN_PASSCODE];
        //           passcodeData = [wrapper searchKeychainCopyMatching:@"Passcode"];
        
        
    }
    else {
        success= [wrapper updateKeychainValueWithData:[encryption getHashBytes:[appDelegate convertStringToData: passcodeToSave]] forIdentifier:K_LOCK_SCREEN_PASSCODE];
    }


//    passcodeString=nil;
//    passcodeData=nil;
//    passcodeToSave=nil;
//    wrapper=nil;
//    wrapper=nil;
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
    
    
//    passcodeData=nil;
//    passcodeDataToSave=nil;
//    wrapper=nil;
    
    return success;
    
    
}


-(BOOL)setTokenDataWithString:(NSString *)tokenString{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
  	// as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
	 
    BOOL success=NO;
    NSData *oldTokenData = [wrapper searchKeychainCopyMatching:K_OLD_SHARED_TOKEN];
    
    BOOL oldTokenKeychainItemExists=NO;
    BOOL tokenKeychainItemExists=NO;
    
    if (!oldTokenData) {
        
        [wrapper newSearchDictionary:K_OLD_SHARED_TOKEN];
        success= [wrapper createKeychainValueWithData:[appDelegate convertStringToData:tokenString] forIdentifier:K_OLD_SHARED_TOKEN];
        //           passcodeData = [wrapper searchKeychainCopyMatching:@"Passcode"];
        
        if (success) {
            oldTokenKeychainItemExists=YES;
        }
    }
    else {
        oldTokenKeychainItemExists=YES;
    }
    
    NSData *tokenData =[NSData dataWithData: [wrapper searchKeychainCopyMatching:K_CURRENT_SHARED_TOKEN]];
    
    if (!tokenData) {
        
        [wrapper newSearchDictionary:K_CURRENT_SHARED_TOKEN];
        success= [wrapper createKeychainValueWithData:[appDelegate convertStringToData:tokenString] forIdentifier:K_CURRENT_SHARED_TOKEN];
        
        tokenData = [NSData dataWithData:(NSData *)[wrapper searchKeychainCopyMatching:K_CURRENT_SHARED_TOKEN]];
        //           passcodeData = [wrapper searchKeychainCopyMatching:@"Passcode"];
        
        
        if (success) {
            tokenKeychainItemExists=YES;
        }
        
    }else {
        tokenKeychainItemExists=YES;
    }
    
    
    
    if (tokenKeychainItemExists && oldTokenKeychainItemExists && tokenData) {
      
        success= [wrapper updateKeychainValueWithData:tokenData forIdentifier:K_OLD_SHARED_TOKEN];
    }
    
    
    if (success && tokenKeychainItemExists) {
        
        success= [wrapper updateKeychainValueWithData:[appDelegate convertStringToData: tokenString] forIdentifier:K_CURRENT_SHARED_TOKEN];
    }
    
    
   oldTokenData =[wrapper searchKeychainCopyMatching:K_OLD_SHARED_TOKEN];
    

    
    
   
    
//    tokenData=nil;
//    
//    tokenString=nil;
//     wrapper=nil;
    
    return success;
    
    
}
-(BOOL)setPasswordCurrentDataWithString:(NSString *)passwordString{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
  	// as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
	NSString *passwordToSave = (passwordString) ? [NSString stringWithFormat:@"%@iJsi3" ,passwordString ] :@"o6fjZ4dhvKIUYVmaqnNJIPCBE2" ;
       
    
    BOOL success=NO;
    BOOL oldPasscodeKeychainItemExists=NO;
    BOOL passwordKeychainItemExists=NO;
    
    NSData *oldPasswordData =[wrapper searchKeychainCopyMatching:K_PASSWORD_OLD];
    
    
    PTTEncryption *encryption=(PTTEncryption *)[appDelegate encryption];
    if (!encryption) {
        appDelegate.encryption=[[PTTEncryption alloc]init];
        encryption=appDelegate.encryption;
    }
    
    if (!oldPasswordData) {
        
        [wrapper newSearchDictionary:K_PASSWORD_OLD];
        success= [wrapper createKeychainValueWithData:[encryption getHashBytes:[appDelegate convertStringToData: passwordToSave]] forIdentifier:K_PASSWORD_OLD];
        //           passcodeData = [wrapper searchKeychainCopyMatching:@"Passcode"];
        
        if (success) {
            oldPasscodeKeychainItemExists=YES;
        }
    }
    else {
        oldPasscodeKeychainItemExists=YES;
    }
    
    NSData *passwordData = [NSData dataWithData:[wrapper searchKeychainCopyMatching:K_PASSWORD_CURRENT]];
    
    
    
    if (!passwordData) {
       
        [wrapper newSearchDictionary:K_PASSWORD_CURRENT];
        success= [wrapper createKeychainValueWithData:[encryption getHashBytes:[appDelegate convertStringToData: passwordToSave]] forIdentifier:K_PASSWORD_CURRENT];
        
        passwordData =[NSData dataWithData: [wrapper searchKeychainCopyMatching:K_PASSWORD_CURRENT]];
        //           passcodeData = [wrapper searchKeychainCopyMatching:@"Passcode"];
        
        if (success) {
            passwordKeychainItemExists=YES;
        }
    }else {
        passwordKeychainItemExists=YES;
    }
    
    
    oldPasswordData =[wrapper searchKeychainCopyMatching:K_PASSWORD_OLD];

    if (oldPasswordData) {
   
        success= [wrapper updateKeychainValueWithData:passwordData forIdentifier:K_PASSWORD_OLD];
    }

    
    passwordData =[wrapper searchKeychainCopyMatching:K_PASSWORD_CURRENT];
    if (passwordKeychainItemExists&&oldPasscodeKeychainItemExists&& passwordData ) {
    
        success= [wrapper updateKeychainValueWithData:[encryption getHashBytes:[appDelegate convertStringToData: passwordToSave]] forIdentifier:K_PASSWORD_CURRENT];
    }
           
    return success;    
    
    
    
}



-(BOOL)updateOldPasswordWithCurrentPassword{

    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
   
  	// as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
	

    NSData *oldPasswordData =[wrapper searchKeychainCopyMatching:K_PASSWORD_OLD];
    
    
   
    BOOL oldPasscodeKeychainItemExists=NO;
    BOOL passwordKeychainItemExists=NO;
    BOOL success=NO;
    
    if (!oldPasswordData) {
        
        return NO;
    
    }
    else {
        oldPasscodeKeychainItemExists=YES;
    }
    
    NSData *passwordData = [NSData dataWithData:(NSData *)[wrapper searchKeychainCopyMatching:K_PASSWORD_CURRENT]];
    
    
    
    if (!passwordData) {
        return NO;        
        
    }else {
        passwordKeychainItemExists=YES;
    }
    
    PTTEncryption *encryption=[[PTTEncryption alloc]init];
        if (passwordKeychainItemExists &&oldPasscodeKeychainItemExists) {
   
        oldPasswordData =[wrapper searchKeychainCopyMatching:K_PASSWORD_OLD];
        
        if (oldPasswordData) {
            
            success= [wrapper updateKeychainValueWithData:passwordData forIdentifier:K_PASSWORD_OLD];
        }
        else
        {
           
            success= [wrapper createKeychainValueWithData:[encryption getHashBytes:passwordData] forIdentifier:K_PASSWORD_OLD];
            
           
        
        }

    }
    encryption=nil;
    wrapper=nil;
    return success;

}


-(BOOL)updateOldTokenWithCurrentToken{
    
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
  	// as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
	
    
    NSData *oldTokenData =[wrapper searchKeychainCopyMatching:K_OLD_SHARED_TOKEN];
    
    
    
    BOOL oldTokenKeychainItemExists=NO;
    BOOL tokenKeychainItemExists=NO;
    BOOL success=NO;
    
    if (!oldTokenData) {
        
        return NO;
        
    }
    else {
        oldTokenKeychainItemExists=YES;
    }
    
    NSData *tokenData = [NSData dataWithData:(NSData *)[wrapper searchKeychainCopyMatching:K_CURRENT_SHARED_TOKEN]];
    
    
    
    if (!tokenData) {
        return NO;        
        
    }else {
        tokenKeychainItemExists=YES;
    }
    
    if (tokenKeychainItemExists && oldTokenKeychainItemExists) {
    
        oldTokenData =[wrapper searchKeychainCopyMatching:K_OLD_SHARED_TOKEN];
        
        if (oldTokenData) {
            
            success= [wrapper updateKeychainValueWithData:tokenData forIdentifier:K_OLD_SHARED_TOKEN];
        }
    
    }
//    wrapper=nil;
    
    return success;
    
}


-(BOOL)setPasscodeHintWithString:(NSString *)hintString{

    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
  	// as we cant store a nil value in the dictionary, we store an empty string to represent no passcode.
   
	
	
    
    if (!hintString.length) {
        hintString=@"VoidDoNotUseThisString876";
    }
    BOOL success=NO;
    NSData *hintData = [wrapper searchKeychainCopyMatching:K_PASSOWRD_HINT];
    
    
    
    if (!hintData) {
        
        [wrapper newSearchDictionary:K_PASSOWRD_HINT];
        success= [wrapper createKeychainValueWithData:[appDelegate convertStringToData: hintString] forIdentifier:K_PASSOWRD_HINT];
        //           passcodeData = [wrapper searchKeychainCopyMatching:@"Passcode"];
        
        
    }
    else {
        success= [wrapper updateKeychainValueWithData:[appDelegate convertStringToData: hintString] forIdentifier:K_PASSOWRD_HINT];
    }
    
//    wrapper=nil;
    
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

//    wrapper=nil;
//    lockScreenLockedData=nil;
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
   
   
//    wrapper=nil;
    
    return success;
    
    
}

-(BOOL)setLockScreenAttempt:(NSInteger)attempt{
    
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
    
    
//    lockScreenAttemptData=nil;
//    wrapper=nil;
    
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
        success= [wrapper updateKeychainValue: [NSString stringWithFormat:@"%i",lockOnStartup] forIdentifier:K_LOCK_SCREEN_LOCK_AT_STARTUP];
    }
    
    
//    lockScreenStartupData=nil;
//    wrapper=nil;
    
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
    
//    lockScreenTimerOnData=nil;
//    wrapper=nil;
    
    return success;
    
    
}

-(NSData *)passcodeData{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
   
    NSData *currentPasscodeData=[wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE];
    
   
    if (!currentPasscodeData) {
        return [NSData data];
    }
    else {
        return currentPasscodeData;
    }
    
    
    
}


-(NSData *)defaultPasscodeData{
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    PTTEncryption *encryption=(PTTEncryption *)appDelegate.encryption;
    if (!encryption) {
        appDelegate.encryption=[[PTTEncryption alloc]init];
        encryption=appDelegate.encryption;
    }
    NSString *defaultPasscode=@"o6fjZ4dhvKIUYVmaqnNJIPCBE2";
    NSData *defaultPasscodeData=[encryption getHashBytes:[appDelegate convertStringToData:defaultPasscode]];
    
    if(!defaultPasscodeData)
        return [NSData data];
    else {
        return defaultPasscodeData;
    }
}
-(BOOL)passCodeDataIsEqualToDefaultPasscodeData{
    
    if ([[self passcodeData] isEqualToData:[self defaultPasscodeData]]) {
        return  YES;
    }
    else {
        return NO;
    }
    
    
    
}


-(NSData *)passwordData{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
    NSData *currentPasswordData=[wrapper searchKeychainCopyMatching:K_PASSWORD_CURRENT];
    if (!currentPasswordData) {
        return [NSData data];
    }
    else {
        return currentPasswordData;
    }
    
    
}

-(NSData *)oldPasswordData{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
    NSData *oldPasswordData=[wrapper searchKeychainCopyMatching:K_PASSWORD_OLD];
    if (!oldPasswordData) {
        return [NSData data];
    }
    else {
        return oldPasswordData;
    }
    
    
}
-(NSString *)hintString{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    NSData *currentHintData=[wrapper searchKeychainCopyMatching:K_PASSOWRD_HINT];
    if (!currentHintData) {
        return [NSString string];
    }
    else {
        NSString *returnString=[appDelegate convertDataToString: currentHintData];
        if ([returnString isEqualToString:@"VoidDoNotUseThisString876"]) 
        {
            returnString=[NSString string];
        } 
        return returnString;
    }

    
}



-(NSData *)defaultPasswordData{
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    PTTEncryption *encryption=(PTTEncryption *)appDelegate.encryption;
    if (!encryption) {
        appDelegate.encryption=[[PTTEncryption alloc]init];
        encryption=appDelegate.encryption;
    }
NSString *defaultPassword=@"o6fjZ4dhvKIUYVmaqnNJIPCBE2";
    NSData *defaultPasswordData=[encryption getHashBytes:[appDelegate convertStringToData:defaultPassword]];
    if(!defaultPasswordData)
        return [NSData data];
    else {
        return defaultPasswordData;
    }
}


-(BOOL)passwordDataIsEqualToDefaultPasswordData{

    if ([[self passwordData] isEqualToData:[self defaultPasswordData]]) {
        return  YES;
    }
    else {
        return NO;
    }



}
-(NSString *)currentSharedTokenString{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    return [appDelegate convertDataToString:(NSData *) [wrapper searchKeychainCopyMatching:K_CURRENT_SHARED_TOKEN]];
    
    
}
-(NSString *)oldSharedTokenString{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    return [appDelegate convertDataToString:(NSData *) [wrapper searchKeychainCopyMatching:K_OLD_SHARED_TOKEN]];
    
    
}

-(NSData *)defaultSharedTokenData{
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    NSString *defaultSharedTokenStr=@"wMbq-zvD2-6p";
    NSData *defaultSharedTokenData=[appDelegate convertStringToData:defaultSharedTokenStr];
    if(!defaultSharedTokenData)
        return [NSData data];
    else {
        return defaultSharedTokenData;
    }
}


-(BOOL)currentSharedTokenDataIsEqualToDefaultSharedTokenData{
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    if ([[appDelegate convertStringToData:[self currentSharedTokenString]] isEqualToData:[self defaultSharedTokenData]]) {
        return  YES;
    }
    else {
        return NO;
    }
    
    
    
}

- (BOOL) isPasscodeOn
{	
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE_IS_ON];
    BOOL passcodeOn=(BOOL)[(NSString * )[appDelegate convertDataToString:lockedData]boolValue];
    
//    wrapper=nil;
//    lockedData=nil;
    return passcodeOn;
    
}
- (BOOL) isLockedAtStartup
{	
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCK_AT_STARTUP];
    BOOL lockedOn=(BOOL)[(NSString * )[appDelegate convertDataToString:lockedData]boolValue];
//    lockedData=nil;
//    wrapper=nil;
    
    return lockedOn;
}



-(BOOL)isAppLocked{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCKED];
    BOOL appLocked=(BOOL)[(NSString * )[appDelegate convertDataToString:lockedData]boolValue];
//    wrapper=nil;
//    lockedData=nil;
    return appLocked;
    
}
-(BOOL)isLockedTimerOn{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_TIMER_ON];
    BOOL timerOn=(BOOL)[(NSString * )[appDelegate convertDataToString:lockedData]boolValue];
    
//    wrapper=nil;
//    lockedData=nil;
    return timerOn;
    
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
//    wrapper=nil;
//    lockedData=nil;
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
    numberFormatter=nil;
    return valid;
    
}
-(NSString *)generateToken{

    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *tokenString=[appDelegate generateRandomStringOfLength:4];
    tokenString=[tokenString stringByAppendingFormat:@"-%@",[appDelegate generateRandomStringOfLength:4]];
    tokenString=[tokenString stringByAppendingFormat:@"-%@",[appDelegate generateRandomStringOfLength:4]];


    return tokenString;


}

-(BOOL)rekeyKeyEntityKeys{
    
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
//    PTTEncryption *encryption=(PTTEncryption *)appDelegate.encryption;
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
    [appDelegate saveContext];
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
 
    BOOL changedPassword=appDelegate.changedPassword;
    BOOL changedToken=appDelegate.changedToken;
    
    
    if (changedToken&&!changedPassword) {
        [self updateOldPasswordWithCurrentPassword];
    }
    if (changedPassword &&!changedToken) {
        [self updateOldTokenWithCurrentToken];
    }
    if (changedPassword&&changedToken) {
         [self updateOldPasswordWithCurrentPassword];
        [self updateOldTokenWithCurrentToken];
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *keyEntity = [NSEntityDescription entityForName:@"KeyEntity" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:keyEntity];
    
     
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    //4
   
    if (error) {
        return NO;
    }
    
         
   
    if (fetchedObjects.count) 
    {
        
        
      

        
   
        NSData *oldSharedSymetricData=[appDelegate getOldSharedSymetricData];
     
        for (KeyEntity *keyObjectInArray in fetchedObjects) {
           
            
            
                      
                       
            [keyObjectInArray willAccessValueForKey:@"dataF"];
            NSData *dataF=[NSData dataWithData:keyObjectInArray.dataF];
            [keyObjectInArray didAccessValueForKey:@"dataF"];
            
            NSData *symetricDataEncryptedWithOld=[appDelegate decryptDataToPlainData:dataF usingSymetricKey:oldSharedSymetricData];
           
            [keyObjectInArray didAccessValueForKey:@"dataF"];
            NSData *symetricData=nil;
            
            if (symetricDataEncryptedWithOld&&symetricDataEncryptedWithOld.length) {
                 symetricData=[appDelegate encryptDataToEncryptedData:symetricDataEncryptedWithOld];
            }
            
                       
            
                                                  
            
            
            if (symetricData) {
                [keyObjectInArray willChangeValueForKey:@"dataF"];
                keyObjectInArray.dataF =[NSData dataWithData: symetricData];
                [keyObjectInArray didChangeValueForKey:@"dataF"];
                
            }
           
           
        }
        
        
                   

    }
    
   
    
    
    NSData *  currentKeyStringData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_CURRENT_KEYSTRING];
    
    
    BOOL success=NO;
    NSData *sharedSymetricData=nil;
    NSString *newKeyString=[NSString string];
    NSMutableArray * fetchedObjectsKeyStrings=[fetchedObjects mutableArrayValueForKey:@"keyString"];
  
    if (!newKeyString.length) {
      
        do {
            newKeyString =[appDelegate generateExposedKey];
        } while ([fetchedObjectsKeyStrings containsObject:newKeyString]);
        
    }
    if (!currentKeyStringData) {
       
        success= [wrapper createKeychainValue:newKeyString forIdentifier:K_LOCK_SCREEN_CURRENT_KEYSTRING];
        currentKeyStringData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_CURRENT_KEYSTRING];
        
    }else  
    {
       
        success=  [wrapper updateKeychainValue:newKeyString forIdentifier:K_LOCK_SCREEN_CURRENT_KEYSTRING];
    }
        
    if (success) {
   
        KeyEntity *newKeyObject=[[KeyEntity alloc] initWithEntity:keyEntity insertIntoManagedObjectContext:managedObjectContext];
        [newKeyObject willChangeValueForKey:@"keyString"];
        
        newKeyObject.keyString=[NSString stringWithString:newKeyString] ;
        [newKeyObject didChangeValueForKey:@"keyString"];
       
//        symetricData=[encryption wrapSymmetricKey:symetricData keyRef:nil useDefaultPublicKey:YES];
        sharedSymetricData=[NSData  dataWithData:(NSData *)[appDelegate getSharedSymetricData]];
       NSData * newSymetricData=[appDelegate encryptDataToEncryptedData:sharedSymetricData];
       
        [newKeyObject willChangeValueForKey:@"dataF"];
        newKeyObject.dataF=[NSData dataWithData:(NSData *) newSymetricData];
        [newKeyObject didChangeValueForKey:@"dataF"];
        
            
    }
    [appDelegate saveContext];
//    [managedObjectContext processPendingChanges];
  
   
    [appDelegate saveContext];
//    wrapper=nil;
//    fetchRequest=nil;
    return YES;



}


@end
