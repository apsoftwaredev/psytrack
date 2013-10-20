//
//  DiagnosisHistoryEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "DiagnosisHistoryEntity.h"
#import "ClientEntity.h"
#import "ClinicianEntity.h"
#import "DisorderEntity.h"
#import "DisorderSpecifierEntity.h"
#import "MedicationEntity.h"

@implementation DiagnosisHistoryEntity

@dynamic treatmentStarted;
@dynamic dateDiagnosed;
@dynamic onset;
@dynamic notes;
@dynamic order;
@dynamic axis;
@dynamic primary;
@dynamic dateEnded;
@dynamic status;
@dynamic medications;
@dynamic diagnosedBy;
@dynamic clients;
@dynamic specifiers;
@dynamic disorder;
@dynamic diagnosisLog;
@dynamic frequency;

@end
