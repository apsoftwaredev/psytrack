//
//  FrequencyEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class AdditionalSymptomEntity, DiagnosisHistoryEntity, MedicationReviewEntity;

@interface FrequencyEntity : PTManagedObject

@property (nonatomic, retain) NSString *frequencyUnit;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSNumber *frequencyUnitLength;
@property (nonatomic, retain) NSNumber *frequencyNumber;
@property (nonatomic, retain) NSNumber *numberOfTimes;
@property (nonatomic, retain) NSNumber *timeOfDay;
@property (nonatomic, retain) NSDate *duration;
@property (nonatomic, retain) AdditionalSymptomEntity *symptoms;
@property (nonatomic, retain) MedicationReviewEntity *medicationUse;
@property (nonatomic, retain) NSManagedObject *substanceUse;
@property (nonatomic, retain) NSSet *diagnosis;
@end

@interface FrequencyEntity (CoreDataGeneratedAccessors)

- (void) addDiagnosisObject:(DiagnosisHistoryEntity *)value;
- (void) removeDiagnosisObject:(DiagnosisHistoryEntity *)value;
- (void) addDiagnosis:(NSSet *)values;
- (void) removeDiagnosis:(NSSet *)values;

@end
