//
//  SupervisionTypeSubtypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SupervisionGivenEntity, SupervisionReceivedEntity;

@interface SupervisionTypeSubtypeEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * subType;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSSet *existingSupervision;
@property (nonatomic, retain) NSSet *supervisionReceived;
@property (nonatomic, retain) NSSet *supervisionGiven;
@end

@interface SupervisionTypeSubtypeEntity (CoreDataGeneratedAccessors)

- (void)addExistingSupervisionObject:(NSManagedObject *)value;
- (void)removeExistingSupervisionObject:(NSManagedObject *)value;
- (void)addExistingSupervision:(NSSet *)values;
- (void)removeExistingSupervision:(NSSet *)values;

- (void)addSupervisionReceivedObject:(SupervisionReceivedEntity *)value;
- (void)removeSupervisionReceivedObject:(SupervisionReceivedEntity *)value;
- (void)addSupervisionReceived:(NSSet *)values;
- (void)removeSupervisionReceived:(NSSet *)values;

- (void)addSupervisionGivenObject:(SupervisionGivenEntity *)value;
- (void)removeSupervisionGivenObject:(SupervisionGivenEntity *)value;
- (void)addSupervisionGiven:(NSSet *)values;
- (void)removeSupervisionGiven:(NSSet *)values;

@end
