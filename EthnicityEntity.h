//
//  EthnicityEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DemographicProfileEntity;

@interface EthnicityEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * ethnicityName;
@property (nonatomic, retain) NSSet *demographics;
@property (nonatomic, retain) NSManagedObject *existingEthnicities;

@property (nonatomic, assign) int clientCount;

@end

@interface EthnicityEntity (CoreDataGeneratedAccessors)

- (void)addDemographicsObject:(DemographicProfileEntity *)value;
- (void)removeDemographicsObject:(DemographicProfileEntity *)value;
- (void)addDemographics:(NSSet *)values;
- (void)removeDemographics:(NSSet *)values;

@end
