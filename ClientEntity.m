//
//  ClientEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ClientEntity.h"
#import "AccomodationEntity.h"
#import "ClientGroupEntity.h"
#import "ClientPresentationEntity.h"
#import "DemographicProfileEntity.h"
#import "DiagnosisHistoryEntity.h"
#import "ExpertTestemonyEntity.h"
#import "FeeEntity.h"
#import "HospitalizationEntity.h"
#import "LogEntity.h"
#import "MedicationEntity.h"
#import "OtherReferralSourceEntity.h"
#import "PaymentEntity.h"
#import "PhoneEntity.h"
#import "ReferralEntity.h"
#import "SubstanceUseEntity.h"
#import "SupervisionFeedbackEntity.h"
#import "SupportActivityClientEntity.h"
#import "VitalsEntity.h"

#import "PTTAppDelegate.h"

@implementation ClientEntity

@dynamic dateOfBirth;
@dynamic lastName;
@dynamic middleName;
@dynamic firstName;
@dynamic address;
@dynamic initials;
@dynamic clientIDCode;
@dynamic suffix;
@dynamic currentClient;
@dynamic prefix;
@dynamic order;
@dynamic keyString;
@dynamic dateAdded;
@dynamic familyHistory;
@dynamic notes;
@dynamic historical;
@dynamic fData;
@dynamic logs;
@dynamic substanceUse;
@dynamic groups;
@dynamic supportActivityClients;
@dynamic accomodations;
@dynamic fees;
@dynamic phoneNumbers;
@dynamic hospitalizations;
@dynamic clientPresentations;
@dynamic supervisonFeedback;
@dynamic expertTestemony;
@dynamic diagnoses;
@dynamic demographicInfo;
@dynamic referrals;
@dynamic payments;
@dynamic medicationHistory;
@dynamic vitals;
@dynamic otherReferralSource;



- (void) awakeFromInsert
{
    [super awakeFromInsert];
    
    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];
    
    [self willAccessValueForKey:@"dateAdded"];
    if ([(NSDate *)self.dateAdded isEqualToDate:referenceDate]) {
        [self didAccessValueForKey:@"dateAdded"];
        [self willChangeValueForKey:(NSString *)@"dateAdded"];
        self.dateAdded = [NSDate date];
        [self didChangeValueForKey:(NSString *)@"dateAdded"];
    }
    
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClientGroupEntity" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"addNewClients == %@", [NSNumber numberWithBool:YES]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects) {
        [self willAccessValueForKey:@"groups"];
        NSMutableSet *groupsMutableSet=(NSMutableSet *)[self mutableSetValueForKey:@"groups"];
        [self didAccessValueForKey:@"groups"];
        
        for (ClientGroupEntity *clientGroup in fetchedObjects) {
            [self willChangeValueForKey:@"groups"];
            [groupsMutableSet addObject:clientGroup];
            [self didChangeValueForKey:@"groups"];
            
            
        }
        fetchRequest=nil;
    }
    
}
@end
