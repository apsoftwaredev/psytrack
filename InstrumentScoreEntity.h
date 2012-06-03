//
//  InstrumentScoreEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 5/30/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InstrumentScoreNameEntity;

@interface InstrumentScoreEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * rawScore;
@property (nonatomic, retain) NSNumber * cIFloor;
@property (nonatomic, retain) NSNumber * cICeiling;
@property (nonatomic, retain) NSNumber * confidence;
@property (nonatomic, retain) NSNumber * scaledScore;
@property (nonatomic, retain) NSNumber * percentile;
@property (nonatomic, retain) NSNumber * zScore;
@property (nonatomic, retain) NSNumber * tScore;
@property (nonatomic, retain) NSNumber * standardScore;
@property (nonatomic, retain) NSNumber * baseRate;
@property (nonatomic, retain) NSManagedObject *clientInstrumentScore;
@property (nonatomic, retain) InstrumentScoreNameEntity *scoreName;

@end
