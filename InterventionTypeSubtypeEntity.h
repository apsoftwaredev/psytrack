//
//  InterventionTypeSubtypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InterventionDeliveredEntity, InterventionTypeEntity;

@interface InterventionTypeSubtypeEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * interventionSubType;
@property (nonatomic, retain) NSSet *interventionDelivered;
@property (nonatomic, retain) InterventionTypeEntity *interventionType;
@property (nonatomic, retain) NSSet *existingInterventions;
@end

@interface InterventionTypeSubtypeEntity (CoreDataGeneratedAccessors)

- (void)addInterventionDeliveredObject:(InterventionDeliveredEntity *)value;
- (void)removeInterventionDeliveredObject:(InterventionDeliveredEntity *)value;
- (void)addInterventionDelivered:(NSSet *)values;
- (void)removeInterventionDelivered:(NSSet *)values;

- (void)addExistingInterventionsObject:(NSManagedObject *)value;
- (void)removeExistingInterventionsObject:(NSManagedObject *)value;
- (void)addExistingInterventions:(NSSet *)values;
- (void)removeExistingInterventions:(NSSet *)values;

@end
