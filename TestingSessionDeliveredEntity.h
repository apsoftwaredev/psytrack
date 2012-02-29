//
//  TestingSessionDeliveredEntity.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 11/22/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SupervisorEntity, TimeEntity;

@interface TestingSessionDeliveredEntity : NSManagedObject

@property (nonatomic, strong) NSDate * dateOfTesting;
@property (nonatomic, strong) NSString * notes;
@property (nonatomic, strong) NSNumber * order;
@property (nonatomic, strong) SupervisorEntity *supervisor;
@property (nonatomic, strong) NSManagedObject *trainingType;
@property (nonatomic, strong) NSManagedObject *administrationType;
@property (nonatomic, strong) TimeEntity *time;
@property (nonatomic, strong) NSSet *relatedSupportTime;
@property (nonatomic, strong) NSSet *licenseNumbersCredited;
@property (nonatomic, strong) NSSet *degreesCredited;
@property (nonatomic, strong) NSSet *clientPresentations;
@property (nonatomic, strong) NSManagedObject *treatmentSetting;
@property (nonatomic, strong) NSSet *testsAdministered;
@property (nonatomic, strong) NSSet *certificationsCredited;
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
