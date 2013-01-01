//
//  ExistingInterventionEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ExistingHoursEntity, InterventionTypeEntity, InterventionTypeSubtypeEntity;

@interface ExistingInterventionEntity : NSManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * hours;
@property (nonatomic, retain) InterventionTypeEntity *interventionType;
@property (nonatomic, retain) NSSet *models;
@property (nonatomic, retain) InterventionTypeSubtypeEntity *interventionSubType;
@property (nonatomic, retain) NSManagedObject *demographics;
@property (nonatomic, retain) ExistingHoursEntity *existingHours;
@end

@interface ExistingInterventionEntity (CoreDataGeneratedAccessors)

- (void)addModelsObject:(NSManagedObject *)value;
- (void)removeModelsObject:(NSManagedObject *)value;
- (void)addModels:(NSSet *)values;
- (void)removeModels:(NSSet *)values;

@end
