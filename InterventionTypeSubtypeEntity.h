//
//  InterventionTypeSubtypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class ExistingInterventionEntity, InterventionDeliveredEntity, InterventionTypeEntity;

@interface InterventionTypeSubtypeEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * interventionSubType;
@property (nonatomic, retain) InterventionTypeEntity *interventionType;
@property (nonatomic, retain) NSSet *interventionsDelivered;
@property (nonatomic, retain) NSSet *existingInterventions;
@end

@interface InterventionTypeSubtypeEntity (CoreDataGeneratedAccessors)

- (void)addInterventionsDeliveredObject:(InterventionDeliveredEntity *)value;
- (void)removeInterventionsDeliveredObject:(InterventionDeliveredEntity *)value;
- (void)addInterventionsDelivered:(NSSet *)values;
- (void)removeInterventionsDelivered:(NSSet *)values;

- (void)addExistingInterventionsObject:(ExistingInterventionEntity *)value;
- (void)removeExistingInterventionsObject:(ExistingInterventionEntity *)value;
- (void)addExistingInterventions:(NSSet *)values;
- (void)removeExistingInterventions:(NSSet *)values;

@end
