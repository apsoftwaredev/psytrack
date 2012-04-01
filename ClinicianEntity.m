/*
 *  ClinicianEntity.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 1/16/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ClinicianEntity.h"
#import "PTTAppDelegate.h"
//#import "MyInfoEntity.h"
//#import "TestingSessionDeliveredEntity.h"


@implementation ClinicianEntity

@dynamic lastName;
@dynamic clinicianType;
@dynamic middleName;
@dynamic firstName;
@dynamic myPastSupervisor;
@dynamic photo;
@dynamic updatedTimeStamp;
@dynamic aBRecordIdentifier;
@dynamic suffix;
@dynamic myCurrentSupervisor;
@dynamic thisIsMyInfo;
@dynamic order;
@dynamic credentialInitials;
@dynamic startedPracticing;
@dynamic prefix;
@dynamic atMyCurrentSite;
@dynamic notes;
@dynamic myInformation;
@dynamic logs;
@dynamic awards;
@dynamic supportDeliverySupervised;
@dynamic specialties;
@dynamic publications;
@dynamic myInfo;
@dynamic psyTestingSessionsSupervised;
@dynamic medicationPrescribed;
@dynamic influences;
@dynamic supervisionGiven;
@dynamic myAdvisor;
@dynamic interventionsSupervised;
@dynamic orientationHistory;
@dynamic degrees;
@dynamic advisingGiven;
@dynamic demographicInfo;
@dynamic contactInformation;
@dynamic employments;
@dynamic certifications;
@dynamic licenseNumbers;
@dynamic memberships;
@dynamic referrals;
@dynamic currentJobTitles;
@dynamic teachingExperience;
@dynamic keyDate;
@synthesize combinedName;

@synthesize tempNotes;




-(NSString *)combinedName{


    
   combinedName=[NSString string];
    
    
    NSLog(@"name values in entity are %@, %@, %@, %@, %@, %@", prefix, firstName, middleName, lastName,suffix, credentialInitials );
    
    
    [self willAccessValueForKey:@"prefix"];
    if (prefix.length) {
        combinedName=[prefix stringByAppendingString:@" "];
    } 
    [self didAccessValueForKey:@"prefix"];
    
     [self willAccessValueForKey:@"firstName"];
    if (firstName.length) {
        combinedName=[combinedName stringByAppendingString:firstName];
    }
     [self didAccessValueForKey:@"firstName"];
    
     [self willAccessValueForKey:@"middleName"];
    if (middleName.length ) 
    {
        
        NSString *middleInitial=[middleName substringToIndex:1];
        
        middleInitial=[middleInitial stringByAppendingString:@"."];
        
        
        
        combinedName=[combinedName stringByAppendingFormat:@" %@", middleInitial];
        
        
    }
     [self didAccessValueForKey:@"middleName"];
    [self willAccessValueForKey:@"lastName"];

    if (lastName.length  && combinedName.length ) 
    {
        
        
        combinedName=[combinedName stringByAppendingFormat:@" %@",lastName];
        
    }
     [self didAccessValueForKey:@"lastName"];
    [self willAccessValueForKey:@"suffix"];
    if (suffix.length  && combinedName.length) {
        
        combinedName=[combinedName stringByAppendingFormat:@" %@",suffix];
        
    }
     [self didAccessValueForKey:@"suffix"];
    [self willAccessValueForKey:@"credentialInitials"];
    if (credentialInitials.length  && combinedName.length) {
        
        combinedName=[combinedName stringByAppendingFormat:@", %@", credentialInitials];
        
    }
     [self didAccessValueForKey:@"credentialInitials"];
    NSLog(@"combined name values at end in entity are  %@",combinedName  );
    
    
    
 
    
    

    return combinedName;

}


-(void)setNotes:(NSString *)notes{
    
    [self setStringToPrimitiveData:(NSString *)notes forKey:@"notes"];
    
    self.tempNotes=notes;
}
- (void)setStringToPrimitiveData:(NSString *)strValue forKey:(NSString *)key 
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (appDelegate.okayToDecryptBool) {
        
        
        
        
        
        NSDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)strValue withKeyDate:self.keyDate];
        NSLog(@"encrypted dictionary right after set %@",encryptedDataDictionary);
        NSData *encryptedData;
        NSDate *encryptedKeyDate;
        if ([encryptedDataDictionary.allKeys containsObject:@"encryptedData"]) {
            encryptedData=[encryptedDataDictionary valueForKey:@"encryptedData"];
            
            
            if ([encryptedDataDictionary.allKeys containsObject:@"keyDate"]) {
                NSLog(@"all keys are %@",[encryptedDataDictionary allKeys]);
                
                encryptedKeyDate=[encryptedDataDictionary valueForKey:@"keyDate"];
                NSLog(@"key date is client entity %@",encryptedKeyDate);
            }
        }
        
        
        if (encryptedData.length) {
            [self willChangeValueForKey:key];
            [self setPrimitiveValue:encryptedData forKey:key];
            [self didChangeValueForKey:key];
        }
        
        
        
        if (![encryptedKeyDate isEqualToDate:self.keyDate]) {
            [self willChangeValueForKey:@"keyDate"];
            [self setPrimitiveValue:encryptedKeyDate forKey:@"keyDate"];
            [self didChangeValueForKey:@"keyDate"];
            
        }
        
        
        
        
        
        
    }
}
-(NSString *)notes{
    //
    NSString *tempStr;
    [self willAccessValueForKey:@"tempNotes"];
    
    
    if (!self.tempNotes ||!self.tempNotes.length) {
        
        [self didAccessValueForKey:@"tempNotes"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"notes"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"notes"];
        
        [self didAccessValueForKey:@"notes"];
        
        [self willAccessValueForKey:@"keyDate"];
        NSDate *tmpKeyDate=self.keyDate;
        [self didAccessValueForKey:@"keyDate"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:tmpKeyDate encryptedData:primitiveData];
        
        tempStr=[appDelegate convertDataToString:strData];
        
        [self willChangeValueForKey:@"tempNotes"];
        
        self.tempNotes=tempStr;
        [self didChangeValueForKey:@"tempNotes"];
        
        
    }
    else 
    {
        tempStr=self.tempNotes;
        [self didAccessValueForKey:@"tempNotes"];
    }
    
    
    
    
    return tempStr;
    
}

@end
