//
//  ClinicianEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/22/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianGroupEntity, DemographicProfileEntity, ExistingHoursEntity, LogEntity, MedicationReviewEntity, ReferralEntity, SiteEntity, SupervisionParentEntity, TimeTrackEntity, TrainingProgramEntity;

@interface ClinicianEntity : NSManagedObject

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
@property (nonatomic, retain) NSData * notes;
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
@property (nonatomic, retain) NSSet *influences;
@property (nonatomic, retain) NSSet *existingSupervisionGiven;
@property (nonatomic, retain) NSManagedObject *diagnoser;
@property (nonatomic, retain) NSSet *site;
@property (nonatomic, retain) NSSet *consultationReferral;
@property (nonatomic, retain) NSSet *grants;
@property (nonatomic, retain) NSSet *orientationHistory;
@property (nonatomic, retain) NSSet *degrees;
@property (nonatomic, retain) DemographicProfileEntity *demographicInfo;
@property (nonatomic, retain) NSSet *referrals;
@property (nonatomic, retain) NSSet *employments;
@property (nonatomic, retain) NSSet *certifications;
@property (nonatomic, retain) NSSet *licenseNumbers;
@property (nonatomic, retain) NSSet *memberships;
@property (nonatomic, retain) NSManagedObject *advisingReceived;
@property (nonatomic, retain) NSSet *currentJobTitles;
@property (nonatomic, retain) NSSet *existingHours;
@property (nonatomic, retain) NSManagedObject *teachingExperience;
@property (nonatomic, retain) NSSet *practicumCoursesInstructed;


@property (nonatomic, weak) NSString *tempNotes;
@property (nonatomic, strong)  NSString *combinedName;

-(void)rekeyEncryptedAttributes;

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

- (void)addAwardsObject:(NSManagedObject *)value;
- (void)removeAwardsObject:(NSManagedObject *)value;
- (void)addAwards:(NSSet *)values;
- (void)removeAwards:(NSSet *)values;

- (void)addClinicianTypeObject:(NSManagedObject *)value;
- (void)removeClinicianTypeObject:(NSManagedObject *)value;
- (void)addClinicianType:(NSSet *)values;
- (void)removeClinicianType:(NSSet *)values;

- (void)addSpecialtiesObject:(NSManagedObject *)value;
- (void)removeSpecialtiesObject:(NSManagedObject *)value;
- (void)addSpecialties:(NSSet *)values;
- (void)removeSpecialties:(NSSet *)values;

- (void)addPublicationsObject:(NSManagedObject *)value;
- (void)removePublicationsObject:(NSManagedObject *)value;
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

- (void)addInfluencesObject:(NSManagedObject *)value;
- (void)removeInfluencesObject:(NSManagedObject *)value;
- (void)addInfluences:(NSSet *)values;
- (void)removeInfluences:(NSSet *)values;

- (void)addExistingSupervisionGivenObject:(NSManagedObject *)value;
- (void)removeExistingSupervisionGivenObject:(NSManagedObject *)value;
- (void)addExistingSupervisionGiven:(NSSet *)values;
- (void)removeExistingSupervisionGiven:(NSSet *)values;

- (void)addSiteObject:(SiteEntity *)value;
- (void)removeSiteObject:(SiteEntity *)value;
- (void)addSite:(NSSet *)values;
- (void)removeSite:(NSSet *)values;

- (void)addConsultationReferralObject:(NSManagedObject *)value;
- (void)removeConsultationReferralObject:(NSManagedObject *)value;
- (void)addConsultationReferral:(NSSet *)values;
- (void)removeConsultationReferral:(NSSet *)values;

- (void)addGrantsObject:(NSManagedObject *)value;
- (void)removeGrantsObject:(NSManagedObject *)value;
- (void)addGrants:(NSSet *)values;
- (void)removeGrants:(NSSet *)values;

- (void)addOrientationHistoryObject:(NSManagedObject *)value;
- (void)removeOrientationHistoryObject:(NSManagedObject *)value;
- (void)addOrientationHistory:(NSSet *)values;
- (void)removeOrientationHistory:(NSSet *)values;

- (void)addDegreesObject:(NSManagedObject *)value;
- (void)removeDegreesObject:(NSManagedObject *)value;
- (void)addDegrees:(NSSet *)values;
- (void)removeDegrees:(NSSet *)values;

- (void)addReferralsObject:(ReferralEntity *)value;
- (void)removeReferralsObject:(ReferralEntity *)value;
- (void)addReferrals:(NSSet *)values;
- (void)removeReferrals:(NSSet *)values;

- (void)addEmploymentsObject:(NSManagedObject *)value;
- (void)removeEmploymentsObject:(NSManagedObject *)value;
- (void)addEmployments:(NSSet *)values;
- (void)removeEmployments:(NSSet *)values;

- (void)addCertificationsObject:(NSManagedObject *)value;
- (void)removeCertificationsObject:(NSManagedObject *)value;
- (void)addCertifications:(NSSet *)values;
- (void)removeCertifications:(NSSet *)values;

- (void)addLicenseNumbersObject:(NSManagedObject *)value;
- (void)removeLicenseNumbersObject:(NSManagedObject *)value;
- (void)addLicenseNumbers:(NSSet *)values;
- (void)removeLicenseNumbers:(NSSet *)values;

- (void)addMembershipsObject:(NSManagedObject *)value;
- (void)removeMembershipsObject:(NSManagedObject *)value;
- (void)addMemberships:(NSSet *)values;
- (void)removeMemberships:(NSSet *)values;

- (void)addCurrentJobTitlesObject:(NSManagedObject *)value;
- (void)removeCurrentJobTitlesObject:(NSManagedObject *)value;
- (void)addCurrentJobTitles:(NSSet *)values;
- (void)removeCurrentJobTitles:(NSSet *)values;

- (void)addExistingHoursObject:(ExistingHoursEntity *)value;
- (void)removeExistingHoursObject:(ExistingHoursEntity *)value;
- (void)addExistingHours:(NSSet *)values;
- (void)removeExistingHours:(NSSet *)values;

- (void)addPracticumCoursesInstructedObject:(TrainingProgramEntity *)value;
- (void)removePracticumCoursesInstructedObject:(TrainingProgramEntity *)value;
- (void)addPracticumCoursesInstructed:(NSSet *)values;
- (void)removePracticumCoursesInstructed:(NSSet *)values;

@end
