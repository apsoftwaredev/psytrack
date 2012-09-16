//
//  DisabilityEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DemographicProfileEntity;

@interface DisabilityEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * disabilityName;
@property (nonatomic, retain) NSSet *demographics;
@property (nonatomic, retain) NSSet *existingDisabilities;
@end

@interface DisabilityEntity (CoreDataGeneratedAccessors)

- (void)addDemographicsObject:(DemographicProfileEntity *)value;
- (void)removeDemographicsObject:(DemographicProfileEntity *)value;
- (void)addDemographics:(NSSet *)values;
- (void)removeDemographics:(NSSet *)values;

- (void)addExistingDisabilitiesObject:(NSManagedObject *)value;
- (void)removeExistingDisabilitiesObject:(NSManagedObject *)value;
- (void)addExistingDisabilities:(NSSet *)values;
- (void)removeExistingDisabilities:(NSSet *)values;

@end
