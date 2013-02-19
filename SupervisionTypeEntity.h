//
//  SupervisionTypeEntity.h
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



@class ExistingSupervisionEntity, SupervisionGivenEntity, SupervisionReceivedEntity, SupervisionTypeSubtypeEntity;

@interface SupervisionTypeEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * supervisionType;
@property (nonatomic, retain) NSSet *existingSupervision;
@property (nonatomic, retain) NSSet *supervisionRecieved;
@property (nonatomic, retain) NSSet *supervisionGiven;
@property (nonatomic, retain) NSSet *subTypes;
@end

@interface SupervisionTypeEntity (CoreDataGeneratedAccessors)

- (void)addExistingSupervisionObject:(ExistingSupervisionEntity *)value;
- (void)removeExistingSupervisionObject:(ExistingSupervisionEntity *)value;
- (void)addExistingSupervision:(NSSet *)values;
- (void)removeExistingSupervision:(NSSet *)values;

- (void)addSupervisionRecievedObject:(SupervisionReceivedEntity *)value;
- (void)removeSupervisionRecievedObject:(SupervisionReceivedEntity *)value;
- (void)addSupervisionRecieved:(NSSet *)values;
- (void)removeSupervisionRecieved:(NSSet *)values;

- (void)addSupervisionGivenObject:(SupervisionGivenEntity *)value;
- (void)removeSupervisionGivenObject:(SupervisionGivenEntity *)value;
- (void)addSupervisionGiven:(NSSet *)values;
- (void)removeSupervisionGiven:(NSSet *)values;

- (void)addSubTypesObject:(SupervisionTypeSubtypeEntity *)value;
- (void)removeSubTypesObject:(SupervisionTypeSubtypeEntity *)value;
- (void)addSubTypes:(NSSet *)values;
- (void)removeSubTypes:(NSSet *)values;

@end
