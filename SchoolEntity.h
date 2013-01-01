//
//  SchoolEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class DegreeCourseEntity, DegreeEntity, TeachingExperienceEntity, TrainingProgramEntity;

@interface SchoolEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSSet *degrees;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) NSSet *trainingProgram;
@property (nonatomic, retain) NSSet *teachingExperience;
@end

@interface SchoolEntity (CoreDataGeneratedAccessors)

- (void)addDegreesObject:(DegreeEntity *)value;
- (void)removeDegreesObject:(DegreeEntity *)value;
- (void)addDegrees:(NSSet *)values;
- (void)removeDegrees:(NSSet *)values;

- (void)addCoursesObject:(DegreeCourseEntity *)value;
- (void)removeCoursesObject:(DegreeCourseEntity *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

- (void)addTrainingProgramObject:(TrainingProgramEntity *)value;
- (void)removeTrainingProgramObject:(TrainingProgramEntity *)value;
- (void)addTrainingProgram:(NSSet *)values;
- (void)removeTrainingProgram:(NSSet *)values;

- (void)addTeachingExperienceObject:(TeachingExperienceEntity *)value;
- (void)removeTeachingExperienceObject:(TeachingExperienceEntity *)value;
- (void)addTeachingExperience:(NSSet *)values;
- (void)removeTeachingExperience:(NSSet *)values;

@end
