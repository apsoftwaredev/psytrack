//
//  ClientInstrumentScoresEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class ClientPresentationEntity, InstrumentEntity, InstrumentScoreEntity;

@interface ClientInstrumentScoresEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) InstrumentEntity *instrument;
@property (nonatomic, retain) NSSet *scores;
@property (nonatomic, retain) ClientPresentationEntity *clientPresentation;
@end

@interface ClientInstrumentScoresEntity (CoreDataGeneratedAccessors)

- (void)addScoresObject:(InstrumentScoreEntity *)value;
- (void)removeScoresObject:(InstrumentScoreEntity *)value;
- (void)addScores:(NSSet *)values;
- (void)removeScores:(NSSet *)values;

@end
