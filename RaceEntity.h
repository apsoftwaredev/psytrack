//
//  RaceEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DemographicProfileEntity, ExistingRaceEntity;

@interface RaceEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *raceName;
@property (nonatomic, retain) NSSet *demographics;
@property (nonatomic, retain) NSSet *existingRaces;

@property (nonatomic, assign) int clientCount;
@end

@interface RaceEntity (CoreDataGeneratedAccessors)

- (void) addDemographicsObject:(DemographicProfileEntity *)value;
- (void) removeDemographicsObject:(DemographicProfileEntity *)value;
- (void) addDemographics:(NSSet *)values;
- (void) removeDemographics:(NSSet *)values;

- (void) addExistingRacesObject:(ExistingRaceEntity *)value;
- (void) removeExistingRacesObject:(ExistingRaceEntity *)value;
- (void) addExistingRaces:(NSSet *)values;
- (void) removeExistingRaces:(NSSet *)values;

@end
