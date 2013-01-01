//
//  InstrumentEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BatteryEntity, ClientInstrumentScoresEntity, ExistingInstrumentEntity, InstrumentLogEntity, InstrumentPublisherEntity, InstrumentScoreNameEntity, InstrumentTypeEntity;

@interface InstrumentEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * numberReportsWritten;
@property (nonatomic, retain) NSNumber * numberScored;
@property (nonatomic, retain) NSString * instrumentName;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * ages;
@property (nonatomic, retain) NSString * acronym;
@property (nonatomic, retain) NSNumber * numberAdmistered;
@property (nonatomic, retain) NSNumber * sampleSize;
@property (nonatomic, retain) NSSet *scoreNames;
@property (nonatomic, retain) NSSet *existingInstruments;
@property (nonatomic, retain) NSSet *batteries;
@property (nonatomic, retain) NSSet *scores;
@property (nonatomic, retain) InstrumentTypeEntity *instrumentType;
@property (nonatomic, retain) InstrumentPublisherEntity *publisher;
@property (nonatomic, retain) NSSet *logs;
@end

@interface InstrumentEntity (CoreDataGeneratedAccessors)

- (void)addScoreNamesObject:(InstrumentScoreNameEntity *)value;
- (void)removeScoreNamesObject:(InstrumentScoreNameEntity *)value;
- (void)addScoreNames:(NSSet *)values;
- (void)removeScoreNames:(NSSet *)values;

- (void)addExistingInstrumentsObject:(ExistingInstrumentEntity *)value;
- (void)removeExistingInstrumentsObject:(ExistingInstrumentEntity *)value;
- (void)addExistingInstruments:(NSSet *)values;
- (void)removeExistingInstruments:(NSSet *)values;

- (void)addBatteriesObject:(BatteryEntity *)value;
- (void)removeBatteriesObject:(BatteryEntity *)value;
- (void)addBatteries:(NSSet *)values;
- (void)removeBatteries:(NSSet *)values;

- (void)addScoresObject:(ClientInstrumentScoresEntity *)value;
- (void)removeScoresObject:(ClientInstrumentScoresEntity *)value;
- (void)addScores:(NSSet *)values;
- (void)removeScores:(NSSet *)values;

- (void)addLogsObject:(InstrumentLogEntity *)value;
- (void)removeLogsObject:(InstrumentLogEntity *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

@end
