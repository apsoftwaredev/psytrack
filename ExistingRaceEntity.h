//
//  ExistingRaceEntity.h
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



@class ExistingDemographicsEntity, RaceEntity;

@interface ExistingRaceEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * numberOfIndividuals;
@property (nonatomic, retain) ExistingDemographicsEntity *existingDemographics;
@property (nonatomic, retain) RaceEntity *race;

@end
