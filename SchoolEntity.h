//
//  SchoolEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/22/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TrainingProgramEntity;

@interface SchoolEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSSet *degrees;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) NSSet *trainingProgram;
@end

@interface SchoolEntity (CoreDataGeneratedAccessors)

- (void)addDegreesObject:(NSManagedObject *)value;
- (void)removeDegreesObject:(NSManagedObject *)value;
- (void)addDegrees:(NSSet *)values;
- (void)removeDegrees:(NSSet *)values;

- (void)addCoursesObject:(NSManagedObject *)value;
- (void)removeCoursesObject:(NSManagedObject *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

- (void)addTrainingProgramObject:(TrainingProgramEntity *)value;
- (void)removeTrainingProgramObject:(TrainingProgramEntity *)value;
- (void)addTrainingProgram:(NSSet *)values;
- (void)removeTrainingProgram:(NSSet *)values;

@end
