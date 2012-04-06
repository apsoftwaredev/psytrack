//
//  TestingSessionDeliveredEntity.h
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/23/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity, TimeEntity;

@interface TestingSessionDeliveredEntity : NSManagedObject

@property (nonatomic, retain) NSString * eventIdentifier;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * dateOfService;
@property (nonatomic, retain) NSNumber * paperwork;
@property (nonatomic, retain) ClinicianEntity *supervisor;
@property (nonatomic, retain) NSManagedObject *trainingType;
@property (nonatomic, retain) NSManagedObject *administrationType;
@property (nonatomic, retain) TimeEntity *time;
@property (nonatomic, retain) NSSet *relatedSupportTime;
@property (nonatomic, retain) NSSet *licenseNumbersCredited;
@property (nonatomic, retain) NSSet *degreesCredited;
@property (nonatomic, retain) NSSet *clientPresentations;
@property (nonatomic, retain) NSManagedObject *treatmentSetting;
@property (nonatomic, retain) NSSet *testsAdministered;
@property (nonatomic, retain) NSManagedObject *site;
@property (nonatomic, retain) NSSet *certificationsCredited;
@end

@interface TestingSessionDeliveredEntity (CoreDataGeneratedAccessors)

- (void)addRelatedSupportTimeObject:(NSManagedObject *)value;
- (void)removeRelatedSupportTimeObject:(NSManagedObject *)value;
- (void)addRelatedSupportTime:(NSSet *)values;
- (void)removeRelatedSupportTime:(NSSet *)values;

- (void)addLicenseNumbersCreditedObject:(NSManagedObject *)value;
- (void)removeLicenseNumbersCreditedObject:(NSManagedObject *)value;
- (void)addLicenseNumbersCredited:(NSSet *)values;
- (void)removeLicenseNumbersCredited:(NSSet *)values;

- (void)addDegreesCreditedObject:(NSManagedObject *)value;
- (void)removeDegreesCreditedObject:(NSManagedObject *)value;
- (void)addDegreesCredited:(NSSet *)values;
- (void)removeDegreesCredited:(NSSet *)values;

- (void)addClientPresentationsObject:(NSManagedObject *)value;
- (void)removeClientPresentationsObject:(NSManagedObject *)value;
- (void)addClientPresentations:(NSSet *)values;
- (void)removeClientPresentations:(NSSet *)values;

- (void)addTestsAdministeredObject:(NSManagedObject *)value;
- (void)removeTestsAdministeredObject:(NSManagedObject *)value;
- (void)addTestsAdministered:(NSSet *)values;
- (void)removeTestsAdministered:(NSSet *)values;

- (void)addCertificationsCreditedObject:(NSManagedObject *)value;
- (void)removeCertificationsCreditedObject:(NSManagedObject *)value;
- (void)addCertificationsCredited:(NSSet *)values;
- (void)removeCertificationsCredited:(NSSet *)values;

@end
