//
//  LogEntity.h
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



@class ClientEntity, ClinicianEntity, ConferenceEntity, ConsultationEntity, TrainingProgramEntity;

@interface LogEntity : PTManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) NSDate * dateTime;
@property (nonatomic, retain) NSManagedObject *teachingExperience;
@property (nonatomic, retain) NSManagedObject *communityService;
@property (nonatomic, retain) TrainingProgramEntity *trainingProgram;
@property (nonatomic, retain) NSManagedObject *license;
@property (nonatomic, retain) NSManagedObject *advisingGiven;
@property (nonatomic, retain) ClinicianEntity *clinician;
@property (nonatomic, retain) NSManagedObject *expertTestemony;
@property (nonatomic, retain) ConsultationEntity *consultations;
@property (nonatomic, retain) NSManagedObject *presentation;
@property (nonatomic, retain) NSManagedObject *course;
@property (nonatomic, retain) ConferenceEntity *conference;
@property (nonatomic, retain) NSManagedObject *grant;
@property (nonatomic, retain) ClientEntity *client;
@property (nonatomic, retain) NSManagedObject *otherActivity;

@end
