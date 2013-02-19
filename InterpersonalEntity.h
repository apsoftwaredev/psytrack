//
//  InterpersonalEntity.h
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



@class DemographicProfileEntity, RelationshipEntity;

@interface InterpersonalEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * contactFrequencyUnitLength;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * duration;
@property (nonatomic, retain) NSString * contactFrequencyUnit;
@property (nonatomic, retain) NSNumber * contactFrequencyNumber;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) DemographicProfileEntity *demographicProfile;
@property (nonatomic, retain) RelationshipEntity *relationship;

@end
