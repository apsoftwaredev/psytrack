//
//  DiagnosisHistoryEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/3/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientEntity, ClinicianEntity, MedicationEntity;

@interface DiagnosisHistoryEntity : NSManagedObject

@property (nonatomic, retain) NSDate * dateDiagnosed;
@property (nonatomic, retain) NSDate * dateEnded;
@property (nonatomic, retain) NSDate * onset;
@property (nonatomic, retain) NSData * notes;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * axis;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSDate * treatmentStarted;
@property (nonatomic, retain) NSNumber * primary;
@property (nonatomic, retain) NSSet *diagnosedBy;
@property (nonatomic, retain) NSSet *clients;
@property (nonatomic, retain) NSManagedObject *disorder;
@property (nonatomic, retain) NSManagedObject *frequency;
@property (nonatomic, retain) NSSet *diagnosisLog;
@property (nonatomic, retain) NSSet *specifiers;
@property (nonatomic, retain) NSSet *medications;
@end

@interface DiagnosisHistoryEntity (CoreDataGeneratedAccessors)

- (void)addDiagnosedByObject:(ClinicianEntity *)value;
- (void)removeDiagnosedByObject:(ClinicianEntity *)value;
- (void)addDiagnosedBy:(NSSet *)values;
- (void)removeDiagnosedBy:(NSSet *)values;

- (void)addClientsObject:(ClientEntity *)value;
- (void)removeClientsObject:(ClientEntity *)value;
- (void)addClients:(NSSet *)values;
- (void)removeClients:(NSSet *)values;

- (void)addDiagnosisLogObject:(NSManagedObject *)value;
- (void)removeDiagnosisLogObject:(NSManagedObject *)value;
- (void)addDiagnosisLog:(NSSet *)values;
- (void)removeDiagnosisLog:(NSSet *)values;

- (void)addSpecifiersObject:(NSManagedObject *)value;
- (void)removeSpecifiersObject:(NSManagedObject *)value;
- (void)addSpecifiers:(NSSet *)values;
- (void)removeSpecifiers:(NSSet *)values;

- (void)addMedicationsObject:(MedicationEntity *)value;
- (void)removeMedicationsObject:(MedicationEntity *)value;
- (void)addMedications:(NSSet *)values;
- (void)removeMedications:(NSSet *)values;

@end
