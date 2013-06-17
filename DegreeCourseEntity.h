//
//  DegreeCourseEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ClinicianEntity, DegreeEntity, LogEntity, SchoolEntity;

@interface DegreeCourseEntity : PTManagedObject

@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *grade;
@property (nonatomic, retain) NSNumber *credits;
@property (nonatomic, retain) NSString *courseName;
@property (nonatomic, retain) SchoolEntity *school;
@property (nonatomic, retain) DegreeEntity *degree;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *instructors;
@end

@interface DegreeCourseEntity (CoreDataGeneratedAccessors)

- (void) addLogsObject:(LogEntity *)value;
- (void) removeLogsObject:(LogEntity *)value;
- (void) addLogs:(NSSet *)values;
- (void) removeLogs:(NSSet *)values;

- (void) addInstructorsObject:(ClinicianEntity *)value;
- (void) removeInstructorsObject:(ClinicianEntity *)value;
- (void) addInstructors:(NSSet *)values;
- (void) removeInstructors:(NSSet *)values;

@end
