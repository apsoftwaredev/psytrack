//
//  SupervisionTypeSubtypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SupervisionGivenEntity, SupervisionReceivedEntity, SupervisionTypeEntity;

@interface SupervisionTypeSubtypeEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * subType;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSSet *supervisionGiven;
@property (nonatomic, retain) NSSet *existingSupervision;
@property (nonatomic, retain) NSSet *supervisionReceived;
@property (nonatomic, retain) SupervisionTypeEntity *supervisionType;
@end

@interface SupervisionTypeSubtypeEntity (CoreDataGeneratedAccessors)

- (void)addSupervisionGivenObject:(SupervisionGivenEntity *)value;
- (void)removeSupervisionGivenObject:(SupervisionGivenEntity *)value;
- (void)addSupervisionGiven:(NSSet *)values;
- (void)removeSupervisionGiven:(NSSet *)values;

- (void)addExistingSupervisionObject:(NSManagedObject *)value;
- (void)removeExistingSupervisionObject:(NSManagedObject *)value;
- (void)addExistingSupervision:(NSSet *)values;
- (void)removeExistingSupervision:(NSSet *)values;

- (void)addSupervisionReceivedObject:(SupervisionReceivedEntity *)value;
- (void)removeSupervisionReceivedObject:(SupervisionReceivedEntity *)value;
- (void)addSupervisionReceived:(NSSet *)values;
- (void)removeSupervisionReceived:(NSSet *)values;

@end
