//
//  ExistingInterventionEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ExistingDemographicsEntity, ExistingHoursEntity, InterventionModelEntity, InterventionTypeEntity, InterventionTypeSubtypeEntity;

@interface ExistingInterventionEntity : NSManagedObject

@property (nonatomic, retain) NSString *monthlyLogNotes;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *hours;
@property (nonatomic, retain) InterventionTypeEntity *interventionType;
@property (nonatomic, retain) NSSet *models;
@property (nonatomic, retain) InterventionTypeSubtypeEntity *interventionSubType;
@property (nonatomic, retain) ExistingDemographicsEntity *demographics;
@property (nonatomic, retain) ExistingHoursEntity *existingHours;
@end

@interface ExistingInterventionEntity (CoreDataGeneratedAccessors)

- (void) addModelsObject:(InterventionModelEntity *)value;
- (void) removeModelsObject:(InterventionModelEntity *)value;
- (void) addModels:(NSSet *)values;
- (void) removeModels:(NSSet *)values;

@end
