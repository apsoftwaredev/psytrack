//
//  DiagnosisHistoryEntity.h
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



@class ClientEntity, ClinicianEntity, DisorderEntity, DisorderSpecifierEntity, MedicationEntity;

@interface DiagnosisHistoryEntity : PTManagedObject

@property (nonatomic, retain) NSDate * treatmentStarted;
@property (nonatomic, retain) NSDate * dateDiagnosed;
@property (nonatomic, retain) NSDate * onset;
@property (nonatomic, retain) NSData * notes;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * axis;
@property (nonatomic, retain) NSNumber * primary;
@property (nonatomic, retain) NSDate * dateEnded;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSSet *medications;
@property (nonatomic, retain) NSSet *diagnosedBy;
@property (nonatomic, retain) NSSet *clients;
@property (nonatomic, retain) NSSet *specifiers;
@property (nonatomic, retain) DisorderEntity *disorder;
@property (nonatomic, retain) NSSet *diagnosisLog;
@property (nonatomic, retain) NSManagedObject *frequency;
@end

@interface DiagnosisHistoryEntity (CoreDataGeneratedAccessors)

- (void)addMedicationsObject:(MedicationEntity *)value;
- (void)removeMedicationsObject:(MedicationEntity *)value;
- (void)addMedications:(NSSet *)values;
- (void)removeMedications:(NSSet *)values;

- (void)addDiagnosedByObject:(ClinicianEntity *)value;
- (void)removeDiagnosedByObject:(ClinicianEntity *)value;
- (void)addDiagnosedBy:(NSSet *)values;
- (void)removeDiagnosedBy:(NSSet *)values;

- (void)addClientsObject:(ClientEntity *)value;
- (void)removeClientsObject:(ClientEntity *)value;
- (void)addClients:(NSSet *)values;
- (void)removeClients:(NSSet *)values;

- (void)addSpecifiersObject:(DisorderSpecifierEntity *)value;
- (void)removeSpecifiersObject:(DisorderSpecifierEntity *)value;
- (void)addSpecifiers:(NSSet *)values;
- (void)removeSpecifiers:(NSSet *)values;

- (void)addDiagnosisLogObject:(NSManagedObject *)value;
- (void)removeDiagnosisLogObject:(NSManagedObject *)value;
- (void)addDiagnosisLog:(NSSet *)values;
- (void)removeDiagnosisLog:(NSSet *)values;

@end
