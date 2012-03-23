/*
 *  ClinicianEntity.h
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
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MyInfoEntity, TestingSessionDeliveredEntity;

@interface ClinicianEntity : NSManagedObject {


 NSString * lastName;
 
  NSString * middleName;
     NSString * firstName;
   
   NSString * suffix;
   NSString * credentialInitials;
    NSString * prefix;




}

@property (nonatomic, strong) NSString * lastName;
@property (nonatomic, strong) NSString * clinicianType;
@property (nonatomic, strong) NSString * middleName;
@property (nonatomic, strong) NSString * firstName;
@property (nonatomic, strong) NSNumber * myPastSupervisor;
@property (nonatomic, strong) NSData * photo;
@property (nonatomic, strong) NSDate * updatedTimeStamp;
@property (nonatomic, strong) NSDate * keyDate;
@property (nonatomic, strong) NSNumber *aBRecordIdentifier;
@property (nonatomic, strong) NSString * suffix;
@property (nonatomic, strong) NSNumber * myCurrentSupervisor;
@property (nonatomic, strong) NSNumber * thisIsMyInfo;
@property (nonatomic, strong) NSNumber * order;
@property (nonatomic, strong) NSString * credentialInitials;
@property (nonatomic, strong) NSDate * startedPracticing;
@property (nonatomic, strong) NSString * prefix;
@property (nonatomic, strong) NSNumber * atMyCurrentSite;
@property (nonatomic, strong) NSString * notes;
@property (nonatomic, strong) NSNumber * myInformation;

@property (nonatomic, strong) NSSet *logs;
@property (nonatomic, strong) NSSet *awards;
@property (nonatomic, strong) NSSet *supportDeliverySupervised;
@property (nonatomic, strong) NSSet *specialties;
@property (nonatomic, strong) NSSet *publications;
@property (nonatomic, strong) MyInfoEntity *myInfo;
@property (nonatomic, strong) NSSet *psyTestingSessionsSupervised;
@property (nonatomic, strong) NSManagedObject *medicationPrescribed;
@property (nonatomic, strong) NSSet *influences;
@property (nonatomic, strong) NSSet *supervisionGiven;
@property (nonatomic, strong) NSManagedObject *myAdvisor;
@property (nonatomic, strong) NSSet *interventionsSupervised;
@property (nonatomic, strong) NSSet *orientationHistory;
@property (nonatomic, strong) NSSet *degrees;
@property (nonatomic, strong) NSManagedObject *advisingGiven;
@property (nonatomic, strong) NSManagedObject *demographicInfo;
@property (nonatomic, strong) NSManagedObject *contactInformation;
@property (nonatomic, strong) NSSet *employments;
@property (nonatomic, strong) NSSet *certifications;
@property (nonatomic, strong) NSSet *licenseNumbers;
@property (nonatomic, strong) NSSet *memberships;
@property (nonatomic, strong) NSSet *referrals;
@property (nonatomic, strong) NSSet *currentJobTitles;
@property (nonatomic, strong) NSManagedObject *teachingExperience;

@property (nonatomic, strong) NSString *tempNotes;


@property (nonatomic, strong)  NSString *combinedName;
@end

@interface ClinicianEntity (CoreDataGeneratedAccessors)

- (void)addLogsObject:(NSManagedObject *)value;
- (void)removeLogsObject:(NSManagedObject *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

- (void)addAwardsObject:(NSManagedObject *)value;
- (void)removeAwardsObject:(NSManagedObject *)value;
- (void)addAwards:(NSSet *)values;
- (void)removeAwards:(NSSet *)values;

- (void)addSupportDeliverySupervisedObject:(NSManagedObject *)value;
- (void)removeSupportDeliverySupervisedObject:(NSManagedObject *)value;
- (void)addSupportDeliverySupervised:(NSSet *)values;
- (void)removeSupportDeliverySupervised:(NSSet *)values;

- (void)addSpecialtiesObject:(NSManagedObject *)value;
- (void)removeSpecialtiesObject:(NSManagedObject *)value;
- (void)addSpecialties:(NSSet *)values;
- (void)removeSpecialties:(NSSet *)values;

- (void)addPublicationsObject:(NSManagedObject *)value;
- (void)removePublicationsObject:(NSManagedObject *)value;
- (void)addPublications:(NSSet *)values;
- (void)removePublications:(NSSet *)values;

- (void)addPsyTestingSessionsSupervisedObject:(TestingSessionDeliveredEntity *)value;
- (void)removePsyTestingSessionsSupervisedObject:(TestingSessionDeliveredEntity *)value;
- (void)addPsyTestingSessionsSupervised:(NSSet *)values;
- (void)removePsyTestingSessionsSupervised:(NSSet *)values;

- (void)addInfluencesObject:(NSManagedObject *)value;
- (void)removeInfluencesObject:(NSManagedObject *)value;
- (void)addInfluences:(NSSet *)values;
- (void)removeInfluences:(NSSet *)values;

- (void)addSupervisionGivenObject:(NSManagedObject *)value;
- (void)removeSupervisionGivenObject:(NSManagedObject *)value;
- (void)addSupervisionGiven:(NSSet *)values;
- (void)removeSupervisionGiven:(NSSet *)values;

- (void)addInterventionsSupervisedObject:(NSManagedObject *)value;
- (void)removeInterventionsSupervisedObject:(NSManagedObject *)value;
- (void)addInterventionsSupervised:(NSSet *)values;
- (void)removeInterventionsSupervised:(NSSet *)values;

- (void)addOrientationHistoryObject:(NSManagedObject *)value;
- (void)removeOrientationHistoryObject:(NSManagedObject *)value;
- (void)addOrientationHistory:(NSSet *)values;
- (void)removeOrientationHistory:(NSSet *)values;

- (void)addDegreesObject:(NSManagedObject *)value;
- (void)removeDegreesObject:(NSManagedObject *)value;
- (void)addDegrees:(NSSet *)values;
- (void)removeDegrees:(NSSet *)values;

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

- (void)addReferralsObject:(NSManagedObject *)value;
- (void)removeReferralsObject:(NSManagedObject *)value;
- (void)addReferrals:(NSSet *)values;
- (void)removeReferrals:(NSSet *)values;

- (void)addCurrentJobTitlesObject:(NSManagedObject *)value;
- (void)removeCurrentJobTitlesObject:(NSManagedObject *)value;
- (void)addCurrentJobTitles:(NSSet *)values;
- (void)removeCurrentJobTitles:(NSSet *)values;

@end
