//
//  SupervisionTypeSubtypeEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class ExistingSupervisionEntity, SupervisionGivenEntity, SupervisionReceivedEntity, SupervisionTypeEntity;

@interface SupervisionTypeSubtypeEntity : PTManagedObject

@property (nonatomic, retain) NSString * subType;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSSet *existingSupervision;
@property (nonatomic, retain) SupervisionTypeEntity *supervisionType;
@property (nonatomic, retain) NSSet *supervisionReceived;
@property (nonatomic, retain) NSSet *supervisionGiven;
@end

@interface SupervisionTypeSubtypeEntity (CoreDataGeneratedAccessors)

- (void)addExistingSupervisionObject:(ExistingSupervisionEntity *)value;
- (void)removeExistingSupervisionObject:(ExistingSupervisionEntity *)value;
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
