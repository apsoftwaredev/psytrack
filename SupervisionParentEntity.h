//
//  SupervisionParentEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TimeTrackEntity.h"

@class ClinicianEntity;

@interface SupervisionParentEntity : TimeTrackEntity

@property (nonatomic, retain) NSSet *studentsPresent;
@property (nonatomic, retain) NSSet *supervisionFeedback;
@property (nonatomic, retain) NSManagedObject *supervisionType;
@property (nonatomic, retain) NSSet *modelsUsed;
@end

@interface SupervisionParentEntity (CoreDataGeneratedAccessors)

- (void)addStudentsPresentObject:(ClinicianEntity *)value;
- (void)removeStudentsPresentObject:(ClinicianEntity *)value;
- (void)addStudentsPresent:(NSSet *)values;
- (void)removeStudentsPresent:(NSSet *)values;

- (void)addSupervisionFeedbackObject:(NSManagedObject *)value;
- (void)removeSupervisionFeedbackObject:(NSManagedObject *)value;
- (void)addSupervisionFeedback:(NSSet *)values;
- (void)removeSupervisionFeedback:(NSSet *)values;

- (void)addModelsUsedObject:(NSManagedObject *)value;
- (void)removeModelsUsedObject:(NSManagedObject *)value;
- (void)addModelsUsed:(NSSet *)values;
- (void)removeModelsUsed:(NSSet *)values;

@end
