//
//  ClinicianEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ClinicianEntity.h"
#import "AwardEntity.h"
#import "CertificationEntity.h"
#import "ClinicianGroupEntity.h"
#import "ClinicianTypeEntity.h"
#import "DegreeEntity.h"
#import "DemographicProfileEntity.h"
#import "DiagnosisHistoryEntity.h"
#import "EmploymentEntity.h"
#import "ExistingHoursEntity.h"
#import "ExistingSupervisionGivenEntity.h"
#import "GrantEntity.h"
#import "JobTitleEntity.h"
#import "LicenseEntity.h"
#import "LogEntity.h"
#import "MedicationReviewEntity.h"
#import "MembershipEntity.h"
#import "PublicationEntity.h"
#import "ReferralEntity.h"
#import "SiteEntity.h"
#import "SpecialtyEntity.h"
#import "SupervisionParentEntity.h"
#import "TeachingExperienceEntity.h"
#import "TimeTrackEntity.h"
#import "TrainingProgramEntity.h"

#import "PTTAppDelegate.h"

@implementation ClinicianEntity

@dynamic lastName;
@dynamic aBRecordIdentifier;
@dynamic practiceName;
@dynamic middleName;
@dynamic firstName;
@dynamic myPastSupervisor;
@dynamic website;
@dynamic suffix;
@dynamic myCurrentSupervisor;
@dynamic prefix;
@dynamic order;
@dynamic keyString;
@dynamic bio;
@dynamic myInformation;
@dynamic startedPracticing;
@dynamic notes;
@dynamic atMyCurrentSite;
@dynamic isPrescriber;
@dynamic logs;
@dynamic supervisedTime;
@dynamic awards;
@dynamic clinicianType;
@dynamic specialties;
@dynamic publications;
@dynamic groups;
@dynamic medicationPrescribed;
@dynamic supervisionSessionsPresent;
@dynamic licenses;
@dynamic existingSupervisionGiven;
@dynamic influences;
@dynamic diagnoser;
@dynamic site;
@dynamic grants;
@dynamic orientationHistory;
@dynamic degrees;
@dynamic demographicInfo;
@dynamic referrals;
@dynamic employments;
@dynamic certifications;
@dynamic advisingReceived;
@dynamic memberships;
@dynamic practicumCoursesInstructed;
@dynamic coursesInstructed;
@dynamic currentJobTitles;
@dynamic existingHours;
@dynamic teachingExperience;
@synthesize combinedName;

- (void) awakeFromInsert
{
    NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClinicianGroupEntity" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"addNewClinicians == %@", [NSNumber numberWithBool:YES]];
    [fetchRequest setPredicate:predicate];

    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects )
    {
        [self willAccessValueForKey:@"groups"];
        NSMutableSet *groupsMutableSet = (NSMutableSet *)[self mutableSetValueForKey:@"groups"];
        [self didAccessValueForKey:@"groups"];

        for (ClinicianGroupEntity *clinicianGroup in fetchedObjects)
        {
            [self willChangeValueForKey:@"groups"];
            [groupsMutableSet addObject:clinicianGroup];
            [self didChangeValueForKey:@"groups"];
        }
    }

    fetchRequest = nil;
}


- (NSString *) combinedName
{
    combinedName = [NSString string];

    [self willAccessValueForKey:@"prefix"];
    if (self.prefix.length)
    {
        combinedName = [self.prefix stringByAppendingString:@" "];
    }

    [self didAccessValueForKey:@"prefix"];

    [self willAccessValueForKey:@"firstName"];
    if (self.firstName.length)
    {
        combinedName = [combinedName stringByAppendingString:self.firstName];
    }

    [self didAccessValueForKey:@"firstName"];

    [self willAccessValueForKey:@"middleName"];
    if (self.middleName.length )
    {
        NSString *middleInitial = [self.middleName substringToIndex:1];

        middleInitial = [middleInitial stringByAppendingString:@"."];

        combinedName = [combinedName stringByAppendingFormat:@" %@", middleInitial];
    }

    [self didAccessValueForKey:@"middleName"];
    [self willAccessValueForKey:@"lastName"];

    if (self.lastName.length && combinedName.length )
    {
        combinedName = [combinedName stringByAppendingFormat:@" %@",self.lastName];
    }

    [self didAccessValueForKey:@"lastName"];
    [self willAccessValueForKey:@"suffix"];
    if (self.suffix.length && combinedName.length)
    {
        combinedName = [combinedName stringByAppendingFormat:@", %@",self.suffix];
    }

    [self didAccessValueForKey:@"suffix"];

    return combinedName;
}


@end
