//
//  TrainingProgramEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "TrainingProgramEntity.h"
#import "ClinicianEntity.h"
#import "ExistingHoursEntity.h"
#import "LogEntity.h"
#import "SchoolEntity.h"
#import "TimeTrackEntity.h"

@implementation TrainingProgramEntity

@dynamic doctorateLevel;
@dynamic trainingProgram;
@dynamic selectedByDefault;
@dynamic endDate;
@dynamic notes;
@dynamic order;
@dynamic course;
@dynamic startDate;
@dynamic seminarInstructor;
@dynamic school;
@dynamic timeTracks;
@dynamic logs;
@dynamic existingHours;


-(BOOL)associatedWithTimeRecords{
    
    
    
    BOOL associatedRecords=NO;
    
    [self willAccessValueForKey:@"timeTracks"];
    
    if (self.timeTracks.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"timeTracks"];
    
    
    [self willAccessValueForKey:@"existingHours"];
    
    if (self.existingHours.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"existingHours"];
    
    
    return associatedRecords;
    
    
    
}

@end
