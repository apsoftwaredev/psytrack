//
//  ExistingSexualOrientationEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ExistingDemographicsEntity;

@interface ExistingSexualOrientationEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *numberOfIndividuals;
@property (nonatomic, retain) NSString *sexualOrientation;
@property (nonatomic, retain) ExistingDemographicsEntity *existingDemographics;

@end
