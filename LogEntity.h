//
//  LogEntity.h
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/23/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientEntity, ClinicianEntity;

@interface LogEntity : NSManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * dateTime;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) ClientEntity *client;
@property (nonatomic, retain) NSManagedObject *advisingGiven;
@property (nonatomic, retain) NSManagedObject *advisor;
@property (nonatomic, retain) NSManagedObject *licenseNumber;
@property (nonatomic, retain) ClinicianEntity *clinician;

@property (nonatomic, weak) NSString *tempNotes;

@end
