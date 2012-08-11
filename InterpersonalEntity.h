//
//  InterpersonalEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 3/24/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DemographicProfileEntity;

@interface InterpersonalEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * contactFrequencyUnitLength;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * duration;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) NSString * contactFrequencyUnit;
@property (nonatomic, retain) NSNumber * contactFrequencyNumber;
@property (nonatomic, retain) DemographicProfileEntity *demographicProfile;
@property (nonatomic, retain) NSManagedObject *relationship;

@property (nonatomic, weak) NSString *tempNotes;

@end
