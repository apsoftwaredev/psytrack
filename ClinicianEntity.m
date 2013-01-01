//
//  ClinicianEntity.m
//  PsyTrack
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

@end
