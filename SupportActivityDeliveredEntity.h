//
//  SupportActivityDeliveredEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ServiceParentEntity.h"
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class InterventionDeliveredEntity, SupportActivityClientEntity, SupportActivityTypeEntity, TimeEntity;

@interface SupportActivityDeliveredEntity : ServiceParentEntity

@property (nonatomic, retain) NSSet *relatedToIntervention;
@property (nonatomic, retain) NSSet *supportActivityClients;
@property (nonatomic, retain) TimeEntity *time;
@property (nonatomic, retain) SupportActivityTypeEntity *supportActivityType;
@end

@interface SupportActivityDeliveredEntity (CoreDataGeneratedAccessors)

- (void) addRelatedToInterventionObject:(InterventionDeliveredEntity *)value;
- (void) removeRelatedToInterventionObject:(InterventionDeliveredEntity *)value;
- (void) addRelatedToIntervention:(NSSet *)values;
- (void) removeRelatedToIntervention:(NSSet *)values;

- (void) addSupportActivityClientsObject:(SupportActivityClientEntity *)value;
- (void) removeSupportActivityClientsObject:(SupportActivityClientEntity *)value;
- (void) addSupportActivityClients:(NSSet *)values;
- (void) removeSupportActivityClients:(NSSet *)values;

@end
