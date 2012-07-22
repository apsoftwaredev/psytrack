//
//  ExistingHoursEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/22/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ExistingHoursEntity.h"
#import "ClinicianEntity.h"
#import "ExistingAssessmentEntity.h"
#import "ExistingInterventionEntity.h"
#import "ExistingSupervisionReceivedEntity.h"
#import "ExistingSupportActivityEntity.h"
#import "SiteEntity.h"
#import "TrainingProgramEntity.h"


@implementation ExistingHoursEntity

@dynamic endDate;
@dynamic startDate;
@dynamic notes;
@dynamic keyString;
@dynamic supportActivities;
@dynamic assessments;
@dynamic supervisor;
@dynamic directInterventions;
@dynamic supervisionReceived;
@dynamic supervisionGiven;
@dynamic programCourse;
@dynamic site;

@end
