//
//  EthnicityEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class DemographicProfileEntity, ExistingEthnicityEntity;

@interface EthnicityEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *ethnicityName;
@property (nonatomic, retain) NSSet *demographics;
@property (nonatomic, retain) ExistingEthnicityEntity *existingEthnicities;

@property (nonatomic, assign) int clientCount;
@end

@interface EthnicityEntity (CoreDataGeneratedAccessors)

- (void) addDemographicsObject:(DemographicProfileEntity *)value;
- (void) removeDemographicsObject:(DemographicProfileEntity *)value;
- (void) addDemographics:(NSSet *)values;
- (void) removeDemographics:(NSSet *)values;

@end
