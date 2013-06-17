//
//  ServiceParentEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TimeTrackEntity.h"
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ServiceCodeEntity;

@interface ServiceParentEntity : TimeTrackEntity

@property (nonatomic, retain) NSNumber *paperwork;
@property (nonatomic, retain) NSNumber *batteryTask;
@property (nonatomic, retain) ServiceCodeEntity *serviceCode;

@end
