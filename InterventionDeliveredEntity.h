//
//  InterventionDeliveredEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ServiceParentEntity.h"
#import "PTManagedObjectContext.h"

@class ClientPresentationEntity, InterventionModelEntity, InterventionTypeEntity, InterventionTypeSubtypeEntity, SupportActivityDeliveredEntity, TimeEntity;

@interface InterventionDeliveredEntity : ServiceParentEntity

@property (nonatomic, retain) NSSet *clientPresentations;
@property (nonatomic, retain) NSSet *relatedToIndirect;
@property (nonatomic, retain) InterventionTypeEntity *interventionType;
@property (nonatomic, retain) NSSet *modelsUsed;
@property (nonatomic, retain) InterventionTypeSubtypeEntity *subtype;
@property (nonatomic, retain) TimeEntity *time;
@end

@interface InterventionDeliveredEntity (CoreDataGeneratedAccessors)

- (void)addClientPresentationsObject:(ClientPresentationEntity *)value;
- (void)removeClientPresentationsObject:(ClientPresentationEntity *)value;
- (void)addClientPresentations:(NSSet *)values;
- (void)removeClientPresentations:(NSSet *)values;

- (void)addRelatedToIndirectObject:(SupportActivityDeliveredEntity *)value;
- (void)removeRelatedToIndirectObject:(SupportActivityDeliveredEntity *)value;
- (void)addRelatedToIndirect:(NSSet *)values;
- (void)removeRelatedToIndirect:(NSSet *)values;

- (void)addModelsUsedObject:(InterventionModelEntity *)value;
- (void)removeModelsUsedObject:(InterventionModelEntity *)value;
- (void)addModelsUsed:(NSSet *)values;
- (void)removeModelsUsed:(NSSet *)values;

@end
