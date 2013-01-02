//
//  SupervisionParentEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TimeTrackEntity.h"
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class ClinicianEntity, SupervisionFeedbackEntity;

@interface SupervisionParentEntity : TimeTrackEntity

@property (nonatomic, retain) NSSet *studentsPresent;
@property (nonatomic, retain) NSSet *modelsUsed;
@property (nonatomic, retain) NSSet *supervisionFeedback;
@end

@interface SupervisionParentEntity (CoreDataGeneratedAccessors)

- (void)addStudentsPresentObject:(ClinicianEntity *)value;
- (void)removeStudentsPresentObject:(ClinicianEntity *)value;
- (void)addStudentsPresent:(NSSet *)values;
- (void)removeStudentsPresent:(NSSet *)values;

- (void)addModelsUsedObject:(NSManagedObject *)value;
- (void)removeModelsUsedObject:(NSManagedObject *)value;
- (void)addModelsUsed:(NSSet *)values;
- (void)removeModelsUsed:(NSSet *)values;

- (void)addSupervisionFeedbackObject:(SupervisionFeedbackEntity *)value;
- (void)removeSupervisionFeedbackObject:(SupervisionFeedbackEntity *)value;
- (void)addSupervisionFeedback:(NSSet *)values;
- (void)removeSupervisionFeedback:(NSSet *)values;

@end
