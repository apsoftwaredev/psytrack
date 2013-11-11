//
//  TeachingExperienceEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity, LogEntity, PublicationEntity, SchoolEntity, TopicEntity;

@interface TeachingExperienceEntity : NSManagedObject

@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSNumber *credits;
@property (nonatomic, retain) NSString *classTitle;
@property (nonatomic, retain) NSNumber *numberOfStudents;
@property (nonatomic, retain) NSDate *hours;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *teachingRole;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) SchoolEntity *school;
@property (nonatomic, retain) ClinicianEntity *clinician;
@property (nonatomic, retain) NSSet *publications;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *topics;
@end

@interface TeachingExperienceEntity (CoreDataGeneratedAccessors)

- (void) addPublicationsObject:(PublicationEntity *)value;
- (void) removePublicationsObject:(PublicationEntity *)value;
- (void) addPublications:(NSSet *)values;
- (void) removePublications:(NSSet *)values;

- (void) addLogsObject:(LogEntity *)value;
- (void) removeLogsObject:(LogEntity *)value;
- (void) addLogs:(NSSet *)values;
- (void) removeLogs:(NSSet *)values;

- (void) addTopicsObject:(TopicEntity *)value;
- (void) removeTopicsObject:(TopicEntity *)value;
- (void) addTopics:(NSSet *)values;
- (void) removeTopics:(NSSet *)values;

@end
