//
//  TimeTrackEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/6/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity;

@interface TimeTrackEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * eventIdentifier;
@property (nonatomic, retain) NSDate * dateOfService;
@property (nonatomic, retain) NSManagedObject *site;
@property (nonatomic, retain) ClinicianEntity *supervisor;
@property (nonatomic, retain) NSManagedObject *trainingType;

@end
