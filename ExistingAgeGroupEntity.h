//
//  ExistingAgeGroupEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class AgeGroupEntity, ExistingDemographicsEntity;

@interface ExistingAgeGroupEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *numberOfIndividuals;
@property (nonatomic, retain) ExistingDemographicsEntity *existingDemographics;
@property (nonatomic, retain) AgeGroupEntity *ageGroup;

@end
