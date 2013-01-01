//
//  ExistingDisabilityEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DisabilityEntity, ExistingDemographicsEntity;

@interface ExistingDisabilityEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * numberOfIndividuals;
@property (nonatomic, retain) ExistingDemographicsEntity *existingDemographics;
@property (nonatomic, retain) DisabilityEntity *disability;

@end
