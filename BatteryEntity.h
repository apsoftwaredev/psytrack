//
//  BatteryEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ExistingBatteryEntity, InstrumentEntity, InstrumentLogEntity, InstrumentPublisherEntity;

@interface BatteryEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *numberReportsWritten;
@property (nonatomic, retain) NSNumber *numberAdminstered;
@property (nonatomic, retain) NSNumber *numberScored;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *ages;
@property (nonatomic, retain) NSString *acronym;
@property (nonatomic, retain) NSString *batteryName;
@property (nonatomic, retain) NSNumber *sampleSize;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) InstrumentPublisherEntity *publisher;
@property (nonatomic, retain) NSSet *instruments;
@property (nonatomic, retain) NSSet *existingBatteries;
@property (nonatomic, retain) NSSet *clientBatteryNotes;
@end

@interface BatteryEntity (CoreDataGeneratedAccessors)

- (void) addLogsObject:(InstrumentLogEntity *)value;
- (void) removeLogsObject:(InstrumentLogEntity *)value;
- (void) addLogs:(NSSet *)values;
- (void) removeLogs:(NSSet *)values;

- (void) addInstrumentsObject:(InstrumentEntity *)value;
- (void) removeInstrumentsObject:(InstrumentEntity *)value;
- (void) addInstruments:(NSSet *)values;
- (void) removeInstruments:(NSSet *)values;

- (void) addExistingBatteriesObject:(ExistingBatteryEntity *)value;
- (void) removeExistingBatteriesObject:(ExistingBatteryEntity *)value;
- (void) addExistingBatteries:(NSSet *)values;
- (void) removeExistingBatteries:(NSSet *)values;

- (void) addClientBatteryNotesObject:(NSManagedObject *)value;
- (void) removeClientBatteryNotesObject:(NSManagedObject *)value;
- (void) addClientBatteryNotes:(NSSet *)values;
- (void) removeClientBatteryNotes:(NSSet *)values;

@end
