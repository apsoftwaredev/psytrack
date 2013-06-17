//
//  MedicationReviewEntity.h
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

@class ClinicianEntity, FrequencyEntity, MedicationEntity, SideEffectEntity;

@interface MedicationReviewEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *doseChange;
@property (nonatomic, retain) NSString *adherence;
@property (nonatomic, retain) NSDate *nextReview;
@property (nonatomic, retain) NSString *keyString;
@property (nonatomic, retain) NSString *dosage;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *satisfaction;
@property (nonatomic, retain) NSDate *logDate;
@property (nonatomic, retain) NSNumber *sxChange;
@property (nonatomic, retain) NSDate *lastDose;
@property (nonatomic, retain) MedicationEntity *medication;
@property (nonatomic, retain) NSSet *sideEffects;
@property (nonatomic, retain) ClinicianEntity *prescriber;
@property (nonatomic, retain) FrequencyEntity *frequency;
@end

@interface MedicationReviewEntity (CoreDataGeneratedAccessors)

- (void) addSideEffectsObject:(SideEffectEntity *)value;
- (void) removeSideEffectsObject:(SideEffectEntity *)value;
- (void) addSideEffects:(NSSet *)values;
- (void) removeSideEffects:(NSSet *)values;

@end
