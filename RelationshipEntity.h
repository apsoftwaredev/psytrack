//
//  RelationshipEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class InterpersonalEntity;

@interface RelationshipEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *relationship;
@property (nonatomic, retain) NSSet *clientRelationship;
@end

@interface RelationshipEntity (CoreDataGeneratedAccessors)

- (void) addClientRelationshipObject:(InterpersonalEntity *)value;
- (void) removeClientRelationshipObject:(InterpersonalEntity *)value;
- (void) addClientRelationship:(NSSet *)values;
- (void) removeClientRelationship:(NSSet *)values;

@end
