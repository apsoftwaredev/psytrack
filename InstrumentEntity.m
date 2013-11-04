//
//  InstrumentEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "InstrumentEntity.h"
#import "BatteryEntity.h"
#import "ClientInstrumentScoresEntity.h"
#import "ExistingInstrumentEntity.h"
#import "InstrumentLogEntity.h"
#import "InstrumentPublisherEntity.h"
#import "InstrumentScoreNameEntity.h"
#import "InstrumentTypeEntity.h"

@implementation InstrumentEntity

@dynamic numberReportsWritten;
@dynamic numberScored;
@dynamic instrumentName;
@dynamic notes;
@dynamic order;
@dynamic ages;
@dynamic acronym;
@dynamic numberAdmistered;
@dynamic sampleSize;
@dynamic scoreNames;
@dynamic existingInstruments;
@dynamic batteries;
@dynamic scores;
@dynamic instrumentType;
@dynamic publisher;
@dynamic logs;

@end
