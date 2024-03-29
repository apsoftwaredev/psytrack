//
//  ClientInstrumentScoresEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientPresentationEntity, InstrumentEntity, InstrumentScoreEntity;

@interface ClientInstrumentScoresEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) InstrumentEntity *instrument;
@property (nonatomic, retain) NSSet *scores;
@property (nonatomic, retain) ClientPresentationEntity *clientPresentation;
@end

@interface ClientInstrumentScoresEntity (CoreDataGeneratedAccessors)

- (void) addScoresObject:(InstrumentScoreEntity *)value;
- (void) removeScoresObject:(InstrumentScoreEntity *)value;
- (void) addScores:(NSSet *)values;
- (void) removeScores:(NSSet *)values;

@end
