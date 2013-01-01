//
//  TrainingProgramEntity.m
//  PsyTrack
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


-(BOOL)validateValue:(__autoreleasing id *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error
{
    if ( ![self.managedObjectContext isKindOfClass:[PTManagedObjectContext class]] ) {
        return YES;
    }
    else {
        return [super validateValue:value forKey:key error:error];
    }
}

@end
