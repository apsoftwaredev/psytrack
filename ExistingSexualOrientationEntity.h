//
//  ExistingSexualOrientationEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class ExistingDemographicsEntity;

@interface ExistingSexualOrientationEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * numberOfIndividuals;
@property (nonatomic, retain) NSString * sexualOrientation;
@property (nonatomic, retain) ExistingDemographicsEntity *existingDemographics;

@end
