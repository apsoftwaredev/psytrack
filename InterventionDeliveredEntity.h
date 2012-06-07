//
//  InterventionDeliveredEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/6/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ServiceParentEntity.h"

@class TimeEntity;

@interface InterventionDeliveredEntity : ServiceParentEntity

@property (nonatomic, retain) NSSet *clientPresentations;
@property (nonatomic, retain) NSManagedObject *interventionType;
@property (nonatomic, retain) TimeEntity *time;
@property (nonatomic, retain) NSSet *modelsUsed;
@end

@interface InterventionDeliveredEntity (CoreDataGeneratedAccessors)

- (void)addClientPresentationsObject:(NSManagedObject *)value;
- (void)removeClientPresentationsObject:(NSManagedObject *)value;
- (void)addClientPresentations:(NSSet *)values;
- (void)removeClientPresentations:(NSSet *)values;

- (void)addModelsUsedObject:(NSManagedObject *)value;
- (void)removeModelsUsedObject:(NSManagedObject *)value;
- (void)addModelsUsed:(NSSet *)values;
- (void)removeModelsUsed:(NSSet *)values;

@end
