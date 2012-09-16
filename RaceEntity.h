//
//  RaceEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DemographicProfileEntity;

@interface RaceEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * raceName;
@property (nonatomic, retain) DemographicProfileEntity *demographics;
@property (nonatomic, retain) NSSet *existingRaces;
@end

@interface RaceEntity (CoreDataGeneratedAccessors)

- (void)addExistingRacesObject:(NSManagedObject *)value;
- (void)removeExistingRacesObject:(NSManagedObject *)value;
- (void)addExistingRaces:(NSSet *)values;
- (void)removeExistingRaces:(NSSet *)values;

@end
