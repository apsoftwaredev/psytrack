//
//  CultureGroupEntity.h
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

@interface CultureGroupEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * cultureName;
@property (nonatomic, retain) NSSet *demographics;
@end

@interface CultureGroupEntity (CoreDataGeneratedAccessors)

- (void)addDemographicsObject:(DemographicProfileEntity *)value;
- (void)removeDemographicsObject:(DemographicProfileEntity *)value;
- (void)addDemographics:(NSSet *)values;
- (void)removeDemographics:(NSSet *)values;

@end
