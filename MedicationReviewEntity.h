//
//  MedicationReviewEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 3/27/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity, MedicationEntity;

@interface MedicationReviewEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * doseChange;
@property (nonatomic, retain) NSDate * nextReview;
@property (nonatomic, retain) NSString * adherence;
@property (nonatomic, retain) NSString * dosage;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * satisfaction;
@property (nonatomic, retain) NSNumber * sxChange;
@property (nonatomic, retain) NSDate * logDate;
@property (nonatomic, retain) NSDate * lastDose;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) MedicationEntity *medication;
@property (nonatomic, retain) NSSet *sideEffects;
@property (nonatomic, retain) ClinicianEntity *prescriber;
@property (nonatomic, retain) NSManagedObject *frequency;

@property (nonatomic, weak) NSString *tempNotes;

//-(void)rekeyEncryptedAttributes;
@end



@interface MedicationReviewEntity (CoreDataGeneratedAccessors)

- (void)addSideEffectsObject:(NSManagedObject *)value;
- (void)removeSideEffectsObject:(NSManagedObject *)value;
- (void)addSideEffects:(NSSet *)values;
- (void)removeSideEffects:(NSSet *)values;

@end
