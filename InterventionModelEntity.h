//
//  InterventionModelEntity.h
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



@class ExistingInterventionEntity, InterventionDeliveredEntity;

@interface InterventionModelEntity : PTManagedObject

@property (nonatomic, retain) NSString * modelName;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * acronym;
@property (nonatomic, retain) NSNumber * evidenceBased;
@property (nonatomic, retain) InterventionDeliveredEntity *interventionDelivered;
@property (nonatomic, retain) NSSet *existingInterventions;
@end

@interface InterventionModelEntity (CoreDataGeneratedAccessors)

- (void)addExistingInterventionsObject:(ExistingInterventionEntity *)value;
- (void)removeExistingInterventionsObject:(ExistingInterventionEntity *)value;
- (void)addExistingInterventions:(NSSet *)values;
- (void)removeExistingInterventions:(NSSet *)values;

@end
