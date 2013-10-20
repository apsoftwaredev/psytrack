//
//  InstrumentScoreNameEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class InstrumentEntity, InstrumentScoreEntity;

@interface InstrumentScoreNameEntity : PTManagedObject

@property (nonatomic, retain) NSString *abbreviatedName;
@property (nonatomic, retain) NSString *scoreName;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) InstrumentEntity *instrument;
@property (nonatomic, retain) NSSet *scores;
@end

@interface InstrumentScoreNameEntity (CoreDataGeneratedAccessors)

- (void) addScoresObject:(InstrumentScoreEntity *)value;
- (void) removeScoresObject:(InstrumentScoreEntity *)value;
- (void) addScores:(NSSet *)values;
- (void) removeScores:(NSSet *)values;

@end
