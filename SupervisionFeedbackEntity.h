//
//  SupervisionFeedbackEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientEntity, SupervisionParentEntity;

@interface SupervisionFeedbackEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *feedback;
@property (nonatomic, retain) NSManagedObject *topic;
@property (nonatomic, retain) SupervisionParentEntity *supervisionParent;
@property (nonatomic, retain) NSSet *clients;
@end

@interface SupervisionFeedbackEntity (CoreDataGeneratedAccessors)

- (void) addClientsObject:(ClientEntity *)value;
- (void) removeClientsObject:(ClientEntity *)value;
- (void) addClients:(NSSet *)values;
- (void) removeClients:(NSSet *)values;

@end
