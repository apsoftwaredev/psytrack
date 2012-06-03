//
//  ClientInstrumentScoresEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 5/30/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InstrumentEntity, InstrumentScoreEntity;

@interface ClientInstrumentScoresEntity : NSManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSManagedObject *clientPresentation;
@property (nonatomic, retain) InstrumentEntity *instrument;
@property (nonatomic, retain) NSSet *scores;
@end

@interface ClientInstrumentScoresEntity (CoreDataGeneratedAccessors)

- (void)addScoresObject:(InstrumentScoreEntity *)value;
- (void)removeScoresObject:(InstrumentScoreEntity *)value;
- (void)addScores:(NSSet *)values;
- (void)removeScores:(NSSet *)values;

@end
