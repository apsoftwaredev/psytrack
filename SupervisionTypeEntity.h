//
//  SupervisionTypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SupervisionGivenEntity, SupervisionReceivedEntity;

@interface SupervisionTypeEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * supervisionType;
@property (nonatomic, retain) NSSet *supervisionRecieved;
@property (nonatomic, retain) NSSet *supervisionGiven;
@property (nonatomic, retain) NSSet *existingSupervision;
@end

@interface SupervisionTypeEntity (CoreDataGeneratedAccessors)

- (void)addSupervisionRecievedObject:(SupervisionReceivedEntity *)value;
- (void)removeSupervisionRecievedObject:(SupervisionReceivedEntity *)value;
- (void)addSupervisionRecieved:(NSSet *)values;
- (void)removeSupervisionRecieved:(NSSet *)values;

- (void)addSupervisionGivenObject:(SupervisionGivenEntity *)value;
- (void)removeSupervisionGivenObject:(SupervisionGivenEntity *)value;
- (void)addSupervisionGiven:(NSSet *)values;
- (void)removeSupervisionGiven:(NSSet *)values;

- (void)addExistingSupervisionObject:(NSManagedObject *)value;
- (void)removeExistingSupervisionObject:(NSManagedObject *)value;
- (void)addExistingSupervision:(NSSet *)values;
- (void)removeExistingSupervision:(NSSet *)values;

@end
