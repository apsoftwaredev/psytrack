//
//  ClinicianEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"




@class AwardEntity, CertificationEntity, ClinicianGroupEntity, ClinicianTypeEntity, DegreeEntity, DemographicProfileEntity, DiagnosisHistoryEntity, EmploymentEntity, ExistingHoursEntity, ExistingSupervisionGivenEntity, GrantEntity, JobTitleEntity, LicenseEntity, LogEntity, MedicationReviewEntity, MembershipEntity, PublicationEntity, ReferralEntity, SiteEntity, SpecialtyEntity, SupervisionParentEntity, TeachingExperienceEntity, TimeTrackEntity, TrainingProgramEntity;

@interface ClinicianEntity : PTManagedObject

@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * aBRecordIdentifier;
@property (nonatomic, retain) NSString * practiceName;
@property (nonatomic, retain) NSString * middleName;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * myPastSupervisor;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * suffix;
@property (nonatomic, retain) NSNumber * myCurrentSupervisor;
@property (nonatomic, retain) NSString * prefix;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSNumber * myInformation;
@property (nonatomic, retain) NSDate * startedPracticing;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * atMyCurrentSite;
@property (nonatomic, retain) NSNumber * isPrescriber;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *supervisedTime;
@property (nonatomic, retain) NSSet *awards;
@property (nonatomic, retain) NSSet *clinicianType;
@property (nonatomic, retain) NSSet *specialties;
@property (nonatomic, retain) NSSet *publications;
@property (nonatomic, retain) NSSet *groups;
@property (nonatomic, retain) MedicationReviewEntity *medicationPrescribed;
@property (nonatomic, retain) NSSet *supervisionSessionsPresent;
@property (nonatomic, retain) NSSet *licenses;
@property (nonatomic, retain) NSSet *existingSupervisionGiven;
@property (nonatomic, retain) NSSet *influences;
@property (nonatomic, retain) DiagnosisHistoryEntity *diagnoser;
@property (nonatomic, retain) NSSet *site;
@property (nonatomic, retain) NSSet *grants;
@property (nonatomic, retain) NSSet *orientationHistory;
@property (nonatomic, retain) NSSet *degrees;
@property (nonatomic, retain) DemographicProfileEntity *demographicInfo;
@property (nonatomic, retain) NSSet *referrals;
@property (nonatomic, retain) NSSet *employments;
@property (nonatomic, retain) NSSet *certifications;
@property (nonatomic, retain) NSManagedObject *advisingReceived;
@property (nonatomic, retain) NSSet *memberships;
@property (nonatomic, retain) NSSet *practicumCoursesInstructed;
@property (nonatomic, retain) NSManagedObject *coursesInstructed;
@property (nonatomic, retain) NSSet *currentJobTitles;
@property (nonatomic, retain) NSSet *existingHours;
@property (nonatomic, retain) TeachingExperienceEntity *teachingExperience;



@property (nonatomic, strong)  NSString *combinedName;


@end

@interface ClinicianEntity (CoreDataGeneratedAccessors)

- (void)addLogsObject:(LogEntity *)value;
- (void)removeLogsObject:(LogEntity *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

- (void)addSupervisedTimeObject:(TimeTrackEntity *)value;
- (void)removeSupervisedTimeObject:(TimeTrackEntity *)value;
- (void)addSupervisedTime:(NSSet *)values;
- (void)removeSupervisedTime:(NSSet *)values;

- (void)addAwardsObject:(AwardEntity *)value;
- (void)removeAwardsObject:(AwardEntity *)value;
- (void)addAwards:(NSSet *)values;
- (void)removeAwards:(NSSet *)values;

- (void)addClinicianTypeObject:(ClinicianTypeEntity *)value;
- (void)removeClinicianTypeObject:(ClinicianTypeEntity *)value;
- (void)addClinicianType:(NSSet *)values;
- (void)removeClinicianType:(NSSet *)values;

- (void)addSpecialtiesObject:(SpecialtyEntity *)value;
- (void)removeSpecialtiesObject:(SpecialtyEntity *)value;
- (void)addSpecialties:(NSSet *)values;
- (void)removeSpecialties:(NSSet *)values;

- (void)addPublicationsObject:(PublicationEntity *)value;
- (void)removePublicationsObject:(PublicationEntity *)value;
- (void)addPublications:(NSSet *)values;
- (void)removePublications:(NSSet *)values;

- (void)addGroupsObject:(ClinicianGroupEntity *)value;
- (void)removeGroupsObject:(ClinicianGroupEntity *)value;
- (void)addGroups:(NSSet *)values;
- (void)removeGroups:(NSSet *)values;

- (void)addSupervisionSessionsPresentObject:(SupervisionParentEntity *)value;
- (void)removeSupervisionSessionsPresentObject:(SupervisionParentEntity *)value;
- (void)addSupervisionSessionsPresent:(NSSet *)values;
- (void)removeSupervisionSessionsPresent:(NSSet *)values;

- (void)addLicensesObject:(LicenseEntity *)value;
- (void)removeLicensesObject:(LicenseEntity *)value;
- (void)addLicenses:(NSSet *)values;
- (void)removeLicenses:(NSSet *)values;

- (void)addExistingSupervisionGivenObject:(ExistingSupervisionGivenEntity *)value;
- (void)removeExistingSupervisionGivenObject:(ExistingSupervisionGivenEntity *)value;
- (void)addExistingSupervisionGiven:(NSSet *)values;
- (void)removeExistingSupervisionGiven:(NSSet *)values;

- (void)addInfluencesObject:(NSManagedObject *)value;
- (void)removeInfluencesObject:(NSManagedObject *)value;
- (void)addInfluences:(NSSet *)values;
- (void)removeInfluences:(NSSet *)values;

- (void)addSiteObject:(SiteEntity *)value;
- (void)removeSiteObject:(SiteEntity *)value;
- (void)addSite:(NSSet *)values;
- (void)removeSite:(NSSet *)values;

- (void)addGrantsObject:(GrantEntity *)value;
- (void)removeGrantsObject:(GrantEntity *)value;
- (void)addGrants:(NSSet *)values;
- (void)removeGrants:(NSSet *)values;

- (void)addOrientationHistoryObject:(NSManagedObject *)value;
- (void)removeOrientationHistoryObject:(NSManagedObject *)value;
- (void)addOrientationHistory:(NSSet *)values;
- (void)removeOrientationHistory:(NSSet *)values;

- (void)addDegreesObject:(DegreeEntity *)value;
- (void)removeDegreesObject:(DegreeEntity *)value;
- (void)addDegrees:(NSSet *)values;
- (void)removeDegrees:(NSSet *)values;

- (void)addReferralsObject:(ReferralEntity *)value;
- (void)removeReferralsObject:(ReferralEntity *)value;
- (void)addReferrals:(NSSet *)values;
- (void)removeReferrals:(NSSet *)values;

- (void)addEmploymentsObject:(EmploymentEntity *)value;
- (void)removeEmploymentsObject:(EmploymentEntity *)value;
- (void)addEmployments:(NSSet *)values;
- (void)removeEmployments:(NSSet *)values;

- (void)addCertificationsObject:(CertificationEntity *)value;
- (void)removeCertificationsObject:(CertificationEntity *)value;
- (void)addCertifications:(NSSet *)values;
- (void)removeCertifications:(NSSet *)values;

- (void)addMembershipsObject:(MembershipEntity *)value;
- (void)removeMembershipsObject:(MembershipEntity *)value;
- (void)addMemberships:(NSSet *)values;
- (void)removeMemberships:(NSSet *)values;

- (void)addPracticumCoursesInstructedObject:(TrainingProgramEntity *)value;
- (void)removePracticumCoursesInstructedObject:(TrainingProgramEntity *)value;
- (void)addPracticumCoursesInstructed:(NSSet *)values;
- (void)removePracticumCoursesInstructed:(NSSet *)values;

- (void)addCurrentJobTitlesObject:(JobTitleEntity *)value;
- (void)removeCurrentJobTitlesObject:(JobTitleEntity *)value;
- (void)addCurrentJobTitles:(NSSet *)values;
- (void)removeCurrentJobTitles:(NSSet *)values;

- (void)addExistingHoursObject:(ExistingHoursEntity *)value;
- (void)removeExistingHoursObject:(ExistingHoursEntity *)value;
- (void)addExistingHours:(NSSet *)values;
- (void)removeExistingHours:(NSSet *)values;

@end
