//
//  ExistingEthnicityEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EthnicityEntity;

@interface ExistingEthnicityEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *numberOfIndividuals;
@property (nonatomic, retain) NSManagedObject *existingDemographics;
@property (nonatomic, retain) EthnicityEntity *ethnicity;

@end
