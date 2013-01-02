//
//  TimeEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "TimeEntity.h"
#import "AssessmentEntity.h"
#import "BreakTimeEntity.h"
#import "InterventionDeliveredEntity.h"
#import "SupervisionGivenEntity.h"
#import "SupervisionReceivedEntity.h"
#import "SupportActivityDeliveredEntity.h"


@implementation TimeEntity

@dynamic stopwatchRunning;
@dynamic stopwatchRestartAfterStop;
@dynamic addStopwatch;
@dynamic totalTime;
@dynamic timeToSubtract;
@dynamic notes;
@dynamic pauseInterval;
@dynamic endTime;
@dynamic pauseTime;
@dynamic stopwatchStartTime;
@dynamic additionalTime;
@dynamic startTime;
@dynamic indirectSupportDelived;
@dynamic interventionDelivered;
@dynamic assessmentTime;
@dynamic breaks;
@dynamic supervisionReceived;
@dynamic supervisionGiven;


-(BOOL)validateValue:(__autoreleasing id *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error
{
    if ( ![self.managedObjectContext isKindOfClass:[PTManagedObjectContext class]] ) {
        return YES;
    }
    else {
        return [super validateValue:value forKey:key error:error];
    }
}

+(BOOL)deletesInvalidObjectsAfterFailedSave
{
    return NO;
}

-(void)repairForError:(NSError *)error
{
    if ( [self.class deletesInvalidObjectsAfterFailedSave] ) {
        [self.managedObjectContext deleteObject:self];
    }
}


@end
