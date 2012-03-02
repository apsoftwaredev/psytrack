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

@synthesize combinedName;






-(NSString *)combinedName{


    
   combinedName=[NSString string];
    
    
    NSLog(@"name values in entity are %@, %@, %@, %@, %@, %@", prefix, firstName, middleName, lastName,suffix, credentialInitials );
    
    
    
    if (prefix.length) {
        combinedName=[prefix stringByAppendingString:@" "];
    } 
    
    if (firstName.length) {
        combinedName=[combinedName stringByAppendingString:firstName];
    }
    
    
    if (middleName.length ) 
    {
        NSString *middleInitial=[middleName substringToIndex:1];
        
        middleInitial=[middleInitial stringByAppendingString:@"."];
        
        
        
        combinedName=[combinedName stringByAppendingFormat:@" %@", middleInitial];
        
        
    }
    if (lastName.length  && combinedName.length ) 
    {
        
        
        combinedName=[combinedName stringByAppendingFormat:@" %@",lastName];
        
    }
    if (suffix.length  && combinedName.length) {
        
        combinedName=[combinedName stringByAppendingFormat:@" %@",suffix];
        
    }
    
    if (credentialInitials.length  && combinedName.length) {
        
        combinedName=[combinedName stringByAppendingFormat:@", %@", credentialInitials];
        
    }
    NSLog(@"combined name values at end in entity are  %@",combinedName  );
    
    
    
 
    
    

    return combinedName;

}
@end
