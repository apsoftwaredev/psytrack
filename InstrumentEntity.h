//
//  InstrumentEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 5/29/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface InstrumentEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * acronym;
@property (nonatomic, retain) NSString * publisher;
@property (nonatomic, retain) NSString * instrumentName;
@property (nonatomic, retain) NSString * ages;
@property (nonatomic, retain) NSNumber * sampleSize;
@property (nonatomic, retain) NSSet *scores;
@property (nonatomic, retain) NSManagedObject *instrumentType;
@property (nonatomic, retain) NSSet *scoreNames;
@property (nonatomic, retain) NSSet *existingInstruments;
@property (nonatomic, retain) NSSet *batteries;
@end

@interface InstrumentEntity (CoreDataGeneratedAccessors)

- (void)addScoresObject:(NSManagedObject *)value;
- (void)removeScoresObject:(NSManagedObject *)value;
- (void)addScores:(NSSet *)values;
- (void)removeScores:(NSSet *)values;

- (void)addScoreNamesObject:(NSManagedObject *)value;
- (void)removeScoreNamesObject:(NSManagedObject *)value;
- (void)addScoreNames:(NSSet *)values;
- (void)removeScoreNames:(NSSet *)values;

- (void)addExistingInstrumentsObject:(NSManagedObject *)value;
- (void)removeExistingInstrumentsObject:(NSManagedObject *)value;
- (void)addExistingInstruments:(NSSet *)values;
- (void)removeExistingInstruments:(NSSet *)values;

- (void)addBatteriesObject:(NSManagedObject *)value;
- (void)removeBatteriesObject:(NSManagedObject *)value;
- (void)addBatteries:(NSSet *)values;
- (void)removeBatteries:(NSSet *)values;

@end
