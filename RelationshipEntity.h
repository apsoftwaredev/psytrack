//
//  RelationshipEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InterpersonalEntity;

@interface RelationshipEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * relationship;
@property (nonatomic, retain) NSSet *clientRelationship;
@end

@interface RelationshipEntity (CoreDataGeneratedAccessors)

- (void)addClientRelationshipObject:(InterpersonalEntity *)value;
- (void)removeClientRelationshipObject:(InterpersonalEntity *)value;
- (void)addClientRelationship:(NSSet *)values;
- (void)removeClientRelationship:(NSSet *)values;

@end
