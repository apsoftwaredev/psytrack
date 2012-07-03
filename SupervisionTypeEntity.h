//
//  SupervisionTypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/28/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SupervisionParentEntity;

@interface SupervisionTypeEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * supervisionType;
@property (nonatomic, retain) NSSet *supervisionParent;
@property (nonatomic, retain) NSSet *existingSupervision;
@end

@interface SupervisionTypeEntity (CoreDataGeneratedAccessors)

- (void)addSupervisionParentObject:(SupervisionParentEntity *)value;
- (void)removeSupervisionParentObject:(SupervisionParentEntity *)value;
- (void)addSupervisionParent:(NSSet *)values;
- (void)removeSupervisionParent:(NSSet *)values;

- (void)addExistingSupervisionObject:(NSManagedObject *)value;
- (void)removeExistingSupervisionObject:(NSManagedObject *)value;
- (void)addExistingSupervision:(NSSet *)values;
- (void)removeExistingSupervision:(NSSet *)values;

@end
