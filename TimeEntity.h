//
//  TimeEntity.h
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



@class AssessmentEntity, BreakTimeEntity, InterventionDeliveredEntity, SupervisionGivenEntity, SupervisionReceivedEntity, SupportActivityDeliveredEntity;

@interface TimeEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * stopwatchRunning;
@property (nonatomic, retain) NSNumber * stopwatchRestartAfterStop;
@property (nonatomic, retain) NSDate * addStopwatch;
@property (nonatomic, retain) NSDate * totalTime;
@property (nonatomic, retain) NSDate * timeToSubtract;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * pauseInterval;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSDate * pauseTime;
@property (nonatomic, retain) NSDate * stopwatchStartTime;
@property (nonatomic, retain) NSDate * additionalTime;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) SupportActivityDeliveredEntity *indirectSupportDelived;
@property (nonatomic, retain) InterventionDeliveredEntity *interventionDelivered;
@property (nonatomic, retain) AssessmentEntity *assessmentTime;
@property (nonatomic, retain) NSSet *breaks;
@property (nonatomic, retain) SupervisionReceivedEntity *supervisionReceived;
@property (nonatomic, retain) SupervisionGivenEntity *supervisionGiven;
@end

@interface TimeEntity (CoreDataGeneratedAccessors)

- (void)addBreaksObject:(BreakTimeEntity *)value;
- (void)removeBreaksObject:(BreakTimeEntity *)value;
- (void)addBreaks:(NSSet *)values;
- (void)removeBreaks:(NSSet *)values;

@end
