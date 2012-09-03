//
//  DiagnosisHistoryEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/3/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DiagnosisHistoryEntity.h"
#import "ClientEntity.h"
#import "ClinicianEntity.h"
#import "MedicationEntity.h"


@implementation DiagnosisHistoryEntity

@dynamic dateDiagnosed;
@dynamic dateEnded;
@dynamic onset;
@dynamic notes;
@dynamic order;
@dynamic axis;
@dynamic status;
@dynamic treatmentStarted;
@dynamic primary;
@dynamic diagnosedBy;
@dynamic clients;
@dynamic disorder;
@dynamic frequency;
@dynamic diagnosisLog;
@dynamic specifiers;
@dynamic medications;

@end
