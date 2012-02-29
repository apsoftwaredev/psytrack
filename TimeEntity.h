//
//  TimeEntity.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/29/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TestingSessionDeliveredEntity;

@interface TimeEntity : NSManagedObject

@property (nonatomic, strong) NSDate * addStopwatch;
@property (nonatomic, strong) NSDate * totalTime;
@property (nonatomic, strong) NSDate * timeToSubtract;
@property (nonatomic, strong) NSString * notes;
@property (nonatomic, strong) NSNumber * pauseInterval;
@property (nonatomic, strong) NSDate * endTime;
@property (nonatomic, strong) NSDate * pauseTime;
@property (nonatomic, strong) NSDate * stopwatchStartTime;
@property (nonatomic, strong) NSDate * additionalTime;
@property (nonatomic, strong) NSDate * startTime;
@property (nonatomic, strong) NSNumber * stopwatchRunning;
@property (nonatomic, strong) NSNumber * stopwatchRestartAfterStop;
@property (nonatomic, strong) NSManagedObject *indirectSupportDelived;
@property (nonatomic, strong) NSManagedObject *interventionDelivered;
@property (nonatomic, strong) TestingSessionDeliveredEntity *testingSessionDelivered;
@property (nonatomic, strong) NSSet *breaks;
@end

@interface TimeEntity (CoreDataGeneratedAccessors)

- (void)addBreaksObject:(NSManagedObject *)value;
- (void)removeBreaksObject:(NSManagedObject *)value;
- (void)addBreaks:(NSSet *)values;
- (void)removeBreaks:(NSSet *)values;

@end
