//
//  DisabilityEntity.h
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

@class DemographicProfileEntity;

@interface DisabilityEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *disabilityName;
@property (nonatomic, retain) NSSet *demographics;
@property (nonatomic, retain) NSSet *existingDisabilities;
@property (nonatomic, assign) int clientCount;

@end

@interface DisabilityEntity (CoreDataGeneratedAccessors)

- (void) addDemographicsObject:(DemographicProfileEntity *)value;
- (void) removeDemographicsObject:(DemographicProfileEntity *)value;
- (void) addDemographics:(NSSet *)values;
- (void) removeDemographics:(NSSet *)values;

- (void) addExistingDisabilitiesObject:(NSManagedObject *)value;
- (void) removeExistingDisabilitiesObject:(NSManagedObject *)value;
- (void) addExistingDisabilities:(NSSet *)values;
- (void) removeExistingDisabilities:(NSSet *)values;

@end
