//
//  InstrumentScoreNameEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 5/30/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InstrumentEntity;

@interface InstrumentScoreNameEntity : NSManagedObject

@property (nonatomic, retain) NSString * scoreName;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * abbreviatedName;
@property (nonatomic, retain) InstrumentEntity *instrument;
@property (nonatomic, retain) NSSet *scores;
@end

@interface InstrumentScoreNameEntity (CoreDataGeneratedAccessors)

- (void)addScoresObject:(NSManagedObject *)value;
- (void)removeScoresObject:(NSManagedObject *)value;
- (void)addScores:(NSSet *)values;
- (void)removeScores:(NSSet *)values;

@end
