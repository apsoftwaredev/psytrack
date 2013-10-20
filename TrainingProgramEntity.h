//
//  TrainingProgramEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ClinicianEntity, ExistingHoursEntity, LogEntity, SchoolEntity, TimeTrackEntity;

@interface TrainingProgramEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *doctorateLevel;
@property (nonatomic, retain) NSString *trainingProgram;
@property (nonatomic, retain) NSNumber *selectedByDefault;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *course;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) ClinicianEntity *seminarInstructor;
@property (nonatomic, retain) SchoolEntity *school;
@property (nonatomic, retain) NSSet *timeTracks;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *existingHours;
@end

@interface TrainingProgramEntity (CoreDataGeneratedAccessors)

- (void) addTimeTracksObject:(TimeTrackEntity *)value;
- (void) removeTimeTracksObject:(TimeTrackEntity *)value;
- (void) addTimeTracks:(NSSet *)values;
- (void) removeTimeTracks:(NSSet *)values;

- (void) addLogsObject:(LogEntity *)value;
- (void) removeLogsObject:(LogEntity *)value;
- (void) addLogs:(NSSet *)values;
- (void) removeLogs:(NSSet *)values;

- (void) addExistingHoursObject:(ExistingHoursEntity *)value;
- (void) removeExistingHoursObject:(ExistingHoursEntity *)value;
- (void) addExistingHours:(NSSet *)values;
- (void) removeExistingHours:(NSSet *)values;

-(BOOL)associatedWithTimeRecords;
@end
