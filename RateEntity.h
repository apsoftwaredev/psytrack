//
//  RateEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class ClientPresentationEntity, SupportActivityClientEntity;

@interface RateEntity : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * hourlyRate;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * dateStarted;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * dateEnded;
@property (nonatomic, retain) NSString * rateName;
@property (nonatomic, retain) NSSet *rateCharges;
@property (nonatomic, retain) NSSet *supportActivityClient;
@property (nonatomic, retain) NSSet *clientPresentations;
@end

@interface RateEntity (CoreDataGeneratedAccessors)

- (void)addRateChargesObject:(NSManagedObject *)value;
- (void)removeRateChargesObject:(NSManagedObject *)value;
- (void)addRateCharges:(NSSet *)values;
- (void)removeRateCharges:(NSSet *)values;

- (void)addSupportActivityClientObject:(SupportActivityClientEntity *)value;
- (void)removeSupportActivityClientObject:(SupportActivityClientEntity *)value;
- (void)addSupportActivityClient:(NSSet *)values;
- (void)removeSupportActivityClient:(NSSet *)values;

- (void)addClientPresentationsObject:(ClientPresentationEntity *)value;
- (void)removeClientPresentationsObject:(ClientPresentationEntity *)value;
- (void)addClientPresentations:(NSSet *)values;
- (void)removeClientPresentations:(NSSet *)values;

@end
