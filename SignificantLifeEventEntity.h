//
//  SignificantLifeEventEntity.h
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

@class DemographicProfileEntity;

@interface SignificantLifeEventEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *eventType;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSSet *demographics;
@end

@interface SignificantLifeEventEntity (CoreDataGeneratedAccessors)

- (void) addDemographicsObject:(DemographicProfileEntity *)value;
- (void) removeDemographicsObject:(DemographicProfileEntity *)value;
- (void) addDemographics:(NSSet *)values;
- (void) removeDemographics:(NSSet *)values;

@end
