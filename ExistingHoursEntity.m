//
//  ExistingHoursEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ExistingHoursEntity.h"
#import "ClinicianEntity.h"
#import "ExistingAssessmentEntity.h"
#import "ExistingInterventionEntity.h"
#import "ExistingSupervisionGivenEntity.h"
#import "ExistingSupervisionReceivedEntity.h"
#import "ExistingSupportActivityEntity.h"
#import "SiteEntity.h"
#import "TrainingProgramEntity.h"


@implementation ExistingHoursEntity

@dynamic keyString;
@dynamic endDate;
@dynamic notes;
@dynamic startDate;
@dynamic supportActivities;
@dynamic directInterventions;
@dynamic supervisor;
@dynamic assessments;
@dynamic programCourse;
@dynamic site;
@dynamic supervisionReceived;
@dynamic supervisionGiven;

@end
