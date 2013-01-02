//
//  SupervisionModelEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class SupervisionParentEntity;

@interface SupervisionModelEntity : PTManagedObject

@property (nonatomic, retain) NSString * modelName;
@property (nonatomic, retain) NSNumber * evidenceBased;
@property (nonatomic, retain) NSString * acronym;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSSet *supervisionParents;
@end

@interface SupervisionModelEntity (CoreDataGeneratedAccessors)

- (void)addSupervisionParentsObject:(SupervisionParentEntity *)value;
- (void)removeSupervisionParentsObject:(SupervisionParentEntity *)value;
- (void)addSupervisionParents:(NSSet *)values;
- (void)removeSupervisionParents:(NSSet *)values;

@end
