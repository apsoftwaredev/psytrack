//
//  DegreeEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ClinicianEntity, DegreeNameEntity, SchoolEntity;

@interface DegreeEntity : PTManagedObject

@property (nonatomic, retain) NSDate *dateAwarded;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *updatedTimeStamp;
@property (nonatomic, retain) SchoolEntity *school;
@property (nonatomic, retain) DegreeNameEntity *degree;
@property (nonatomic, retain) NSSet *majors;
@property (nonatomic, retain) NSSet *minors;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) ClinicianEntity *clinician;
@end

@interface DegreeEntity (CoreDataGeneratedAccessors)

- (void) addMajorsObject:(NSManagedObject *)value;
- (void) removeMajorsObject:(NSManagedObject *)value;
- (void) addMajors:(NSSet *)values;
- (void) removeMajors:(NSSet *)values;

- (void) addMinorsObject:(NSManagedObject *)value;
- (void) removeMinorsObject:(NSManagedObject *)value;
- (void) addMinors:(NSSet *)values;
- (void) removeMinors:(NSSet *)values;

- (void) addCoursesObject:(NSManagedObject *)value;
- (void) removeCoursesObject:(NSManagedObject *)value;
- (void) addCourses:(NSSet *)values;
- (void) removeCourses:(NSSet *)values;

@end
