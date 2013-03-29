//
//  MilitaryServiceEntity.h
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

@class DemographicProfileEntity, MilitaryServiceDatesEntity;

@interface MilitaryServiceEntity : PTManagedObject

@property (nonatomic, retain) NSString *awards;
@property (nonatomic, retain) NSNumber *serviceDisability;
@property (nonatomic, retain) NSNumber *tsClearance;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *exposureToCombat;
@property (nonatomic, retain) NSString *militarySpecialties;
@property (nonatomic, retain) NSString *highestRank;
@property (nonatomic, retain) DemographicProfileEntity *demographics;
@property (nonatomic, retain) NSSet *serviceHistory;
@end

@interface MilitaryServiceEntity (CoreDataGeneratedAccessors)

- (void) addServiceHistoryObject:(MilitaryServiceDatesEntity *)value;
- (void) removeServiceHistoryObject:(MilitaryServiceDatesEntity *)value;
- (void) addServiceHistory:(NSSet *)values;
- (void) removeServiceHistory:(NSSet *)values;

@end
