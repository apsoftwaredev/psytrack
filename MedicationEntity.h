//
//  MedicationEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class AdditionalSymptomEntity, ClientEntity, DiagnosisHistoryEntity, MedicationReviewEntity;

@interface MedicationEntity : PTManagedObject

@property (nonatomic, retain) NSDate *discontinued;
@property (nonatomic, retain) NSString *keyString;
@property (nonatomic, retain) NSString *productNo;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *drugName;
@property (nonatomic, retain) NSString *applNo;
@property (nonatomic, retain) NSDate *dateStarted;
@property (nonatomic, retain) NSSet *medLogs;
@property (nonatomic, retain) NSSet *symptomsTargeted;
@property (nonatomic, retain) NSSet *diagnoses;
@property (nonatomic, retain) ClientEntity *client;
@end

@interface MedicationEntity (CoreDataGeneratedAccessors)

- (void) addMedLogsObject:(MedicationReviewEntity *)value;
- (void) removeMedLogsObject:(MedicationReviewEntity *)value;
- (void) addMedLogs:(NSSet *)values;
- (void) removeMedLogs:(NSSet *)values;

- (void) addSymptomsTargetedObject:(AdditionalSymptomEntity *)value;
- (void) removeSymptomsTargetedObject:(AdditionalSymptomEntity *)value;
- (void) addSymptomsTargeted:(NSSet *)values;
- (void) removeSymptomsTargeted:(NSSet *)values;

- (void) addDiagnosesObject:(DiagnosisHistoryEntity *)value;
- (void) removeDiagnosesObject:(DiagnosisHistoryEntity *)value;
- (void) addDiagnoses:(NSSet *)values;
- (void) removeDiagnoses:(NSSet *)values;

@end
