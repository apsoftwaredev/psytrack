//
//  ServiceEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 5/31/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity;

@interface ServiceEntity : NSManagedObject

@property (nonatomic, retain) NSDate * dateOfService;
@property (nonatomic, retain) NSString * eventIdentifier;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSNumber * paperwork;
@property (nonatomic, retain) NSManagedObject *serviceCode;
@property (nonatomic, retain) NSManagedObject *site;
@property (nonatomic, retain) ClinicianEntity *supervisor;
@property (nonatomic, retain) NSManagedObject *trainingType;

@end
