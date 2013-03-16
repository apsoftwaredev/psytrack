//
//  TimeTrackEntity.h
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

@class ClinicianEntity, SiteEntity, TrainingProgramEntity;

@interface TimeTrackEntity : PTManagedObject

@property (nonatomic, retain) NSString *monthlyLogNotes;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *eventIdentifier;
@property (nonatomic, retain) NSDate *dateOfService;
@property (nonatomic, retain) SiteEntity *site;
@property (nonatomic, retain) ClinicianEntity *supervisor;
@property (nonatomic, retain) TrainingProgramEntity *trainingProgram;

@end
