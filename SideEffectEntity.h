//
//  SideEffectEntity.h
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

@class MedicationReviewEntity;

@interface SideEffectEntity : PTManagedObject

@property (nonatomic, retain) NSString *effect;
@property (nonatomic, retain) NSSet *medicationReview;
@end

@interface SideEffectEntity (CoreDataGeneratedAccessors)

- (void) addMedicationReviewObject:(MedicationReviewEntity *)value;
- (void) removeMedicationReviewObject:(MedicationReviewEntity *)value;
- (void) addMedicationReview:(NSSet *)values;
- (void) removeMedicationReview:(NSSet *)values;

@end
