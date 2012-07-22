//
//  TrainingProgramEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/22/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity, ExistingHoursEntity, LogEntity, TimeTrackEntity;

@interface TrainingProgramEntity : NSManagedObject

@property (nonatomic, retain) NSString * trainingProgram;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * selectedByDefault;
@property (nonatomic, retain) NSString * course;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSSet *timeTracks;
@property (nonatomic, retain) ClinicianEntity *seminarInstructor;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *existingHours;
@property (nonatomic, retain) NSManagedObject *school;
@end

@interface TrainingProgramEntity (CoreDataGeneratedAccessors)

- (void)addTimeTracksObject:(TimeTrackEntity *)value;
- (void)removeTimeTracksObject:(TimeTrackEntity *)value;
- (void)addTimeTracks:(NSSet *)values;
- (void)removeTimeTracks:(NSSet *)values;

- (void)addLogsObject:(LogEntity *)value;
- (void)removeLogsObject:(LogEntity *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

- (void)addExistingHoursObject:(ExistingHoursEntity *)value;
- (void)removeExistingHoursObject:(ExistingHoursEntity *)value;
- (void)addExistingHours:(NSSet *)values;
- (void)removeExistingHours:(NSSet *)values;

@end
