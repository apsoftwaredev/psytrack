//
//  MyInfoEntity.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SupervisorEntity;

@interface MyInfoEntity : NSManagedObject

@property (nonatomic, strong) NSNumber * savePassword;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSSet *memberships;
@property (nonatomic, strong) NSSet *orientationHistory;
@property (nonatomic, strong) NSSet *employments;
@property (nonatomic, strong) NSSet *specialties;
@property (nonatomic, strong) NSSet *degrees;
@property (nonatomic, strong) NSManagedObject *teachingExperience;
@property (nonatomic, strong) NSSet *advisors;
@property (nonatomic, strong) NSSet *indirectSupportActivity;
@property (nonatomic, strong) NSSet *awards;
@property (nonatomic, strong) NSSet *advisingGiven;
@property (nonatomic, strong) NSManagedObject *demographicInfo;
@property (nonatomic, strong) NSSet *continuingEducation;
@property (nonatomic, strong) NSManagedObject *contactInformation;
@property (nonatomic, strong) NSSet *licenseNumbers;
@property (nonatomic, strong) NSSet *certifications;
@property (nonatomic, strong) NSSet *publications;
@property (nonatomic, strong) SupervisorEntity *myClinicianData;
@property (nonatomic, strong) NSSet *influences;
@end

@interface MyInfoEntity (CoreDataGeneratedAccessors)

- (void)addMembershipsObject:(NSManagedObject *)value;
- (void)removeMembershipsObject:(NSManagedObject *)value;
- (void)addMemberships:(NSSet *)values;
- (void)removeMemberships:(NSSet *)values;

- (void)addOrientationHistoryObject:(NSManagedObject *)value;
- (void)removeOrientationHistoryObject:(NSManagedObject *)value;
- (void)addOrientationHistory:(NSSet *)values;
- (void)removeOrientationHistory:(NSSet *)values;

- (void)addEmploymentsObject:(NSManagedObject *)value;
- (void)removeEmploymentsObject:(NSManagedObject *)value;
- (void)addEmployments:(NSSet *)values;
- (void)removeEmployments:(NSSet *)values;

- (void)addSpecialtiesObject:(NSManagedObject *)value;
- (void)removeSpecialtiesObject:(NSManagedObject *)value;
- (void)addSpecialties:(NSSet *)values;
- (void)removeSpecialties:(NSSet *)values;

- (void)addDegreesObject:(NSManagedObject *)value;
- (void)removeDegreesObject:(NSManagedObject *)value;
- (void)addDegrees:(NSSet *)values;
- (void)removeDegrees:(NSSet *)values;

- (void)addAdvisorsObject:(NSManagedObject *)value;
- (void)removeAdvisorsObject:(NSManagedObject *)value;
- (void)addAdvisors:(NSSet *)values;
- (void)removeAdvisors:(NSSet *)values;

- (void)addIndirectSupportActivityObject:(NSManagedObject *)value;
- (void)removeIndirectSupportActivityObject:(NSManagedObject *)value;
- (void)addIndirectSupportActivity:(NSSet *)values;
- (void)removeIndirectSupportActivity:(NSSet *)values;

- (void)addAwardsObject:(NSManagedObject *)value;
- (void)removeAwardsObject:(NSManagedObject *)value;
- (void)addAwards:(NSSet *)values;
- (void)removeAwards:(NSSet *)values;

- (void)addAdvisingGivenObject:(NSManagedObject *)value;
- (void)removeAdvisingGivenObject:(NSManagedObject *)value;
- (void)addAdvisingGiven:(NSSet *)values;
- (void)removeAdvisingGiven:(NSSet *)values;

- (void)addContinuingEducationObject:(NSManagedObject *)value;
- (void)removeContinuingEducationObject:(NSManagedObject *)value;
- (void)addContinuingEducation:(NSSet *)values;
- (void)removeContinuingEducation:(NSSet *)values;

- (void)addLicenseNumbersObject:(NSManagedObject *)value;
- (void)removeLicenseNumbersObject:(NSManagedObject *)value;
- (void)addLicenseNumbers:(NSSet *)values;
- (void)removeLicenseNumbers:(NSSet *)values;

- (void)addCertificationsObject:(NSManagedObject *)value;
- (void)removeCertificationsObject:(NSManagedObject *)value;
- (void)addCertifications:(NSSet *)values;
- (void)removeCertifications:(NSSet *)values;

- (void)addPublicationsObject:(NSManagedObject *)value;
- (void)removePublicationsObject:(NSManagedObject *)value;
- (void)addPublications:(NSSet *)values;
- (void)removePublications:(NSSet *)values;

- (void)addInfluencesObject:(NSManagedObject *)value;
- (void)removeInfluencesObject:(NSManagedObject *)value;
- (void)addInfluences:(NSSet *)values;
- (void)removeInfluences:(NSSet *)values;

@end
