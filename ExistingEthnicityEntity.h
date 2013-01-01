//
//  ExistingEthnicityEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class EthnicityEntity;

@interface ExistingEthnicityEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * numberOfIndividuals;
@property (nonatomic, retain) NSManagedObject *existingDemographics;
@property (nonatomic, retain) EthnicityEntity *ethnicity;

@end
