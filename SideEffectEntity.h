//
//  SideEffectEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class MedicationReviewEntity;

@interface SideEffectEntity : NSManagedObject

@property (nonatomic, retain) NSString * effect;
@property (nonatomic, retain) NSSet *medicationReview;
@end

@interface SideEffectEntity (CoreDataGeneratedAccessors)

- (void)addMedicationReviewObject:(MedicationReviewEntity *)value;
- (void)removeMedicationReviewObject:(MedicationReviewEntity *)value;
- (void)addMedicationReview:(NSSet *)values;
- (void)removeMedicationReview:(NSSet *)values;

@end
