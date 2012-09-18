//
//  BatteryEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientPresentationEntity, InstrumentEntity;

@interface BatteryEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * numberReportsWritten;
@property (nonatomic, retain) NSNumber * numberAdminstered;
@property (nonatomic, retain) NSNumber * numberScored;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * ages;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * acronym;
@property (nonatomic, retain) NSString * batteryName;
@property (nonatomic, retain) NSNumber * sampleSize;
@property (nonatomic, retain) NSManagedObject *publisher;
@property (nonatomic, retain) NSSet *existingBatteries;
@property (nonatomic, retain) NSSet *instruments;
@property (nonatomic, retain) NSSet *clientPresentations;
@property (nonatomic, retain) NSSet *logs;
@end

@interface BatteryEntity (CoreDataGeneratedAccessors)

- (void)addExistingBatteriesObject:(NSManagedObject *)value;
- (void)removeExistingBatteriesObject:(NSManagedObject *)value;
- (void)addExistingBatteries:(NSSet *)values;
- (void)removeExistingBatteries:(NSSet *)values;

- (void)addInstrumentsObject:(InstrumentEntity *)value;
- (void)removeInstrumentsObject:(InstrumentEntity *)value;
- (void)addInstruments:(NSSet *)values;
- (void)removeInstruments:(NSSet *)values;

- (void)addClientPresentationsObject:(ClientPresentationEntity *)value;
- (void)removeClientPresentationsObject:(ClientPresentationEntity *)value;
- (void)addClientPresentations:(NSSet *)values;
- (void)removeClientPresentations:(NSSet *)values;

- (void)addLogsObject:(NSManagedObject *)value;
- (void)removeLogsObject:(NSManagedObject *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

@end
