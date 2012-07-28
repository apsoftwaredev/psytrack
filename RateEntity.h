//
//  RateEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/28/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RateChargeEntity, ServiceParentEntity;

@interface RateEntity : NSManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDecimalNumber * hourlyRate;
@property (nonatomic, retain) NSString * rateName;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * dateStarted;
@property (nonatomic, retain) NSDate * dateEnded;
@property (nonatomic, retain) NSSet *services;
@property (nonatomic, retain) NSSet *rateCharges;
@end

@interface RateEntity (CoreDataGeneratedAccessors)

- (void)addServicesObject:(ServiceParentEntity *)value;
- (void)removeServicesObject:(ServiceParentEntity *)value;
- (void)addServices:(NSSet *)values;
- (void)removeServices:(NSSet *)values;

- (void)addRateChargesObject:(RateChargeEntity *)value;
- (void)removeRateChargesObject:(RateChargeEntity *)value;
- (void)addRateCharges:(NSSet *)values;
- (void)removeRateCharges:(NSSet *)values;

@end
