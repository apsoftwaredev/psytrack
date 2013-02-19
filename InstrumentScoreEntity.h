//
//  InstrumentScoreEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class ClientInstrumentScoresEntity, InstrumentScoreNameEntity;

@interface InstrumentScoreEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * confidence;
@property (nonatomic, retain) NSNumber * tScore;
@property (nonatomic, retain) NSNumber * cIFloor;
@property (nonatomic, retain) NSNumber * cICeiling;
@property (nonatomic, retain) NSNumber * scaledScore;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSNumber * zScore;
@property (nonatomic, retain) NSNumber * baseRate;
@property (nonatomic, retain) NSNumber * standardScore;
@property (nonatomic, retain) NSNumber * rawScore;
@property (nonatomic, retain) NSNumber * percentile;
@property (nonatomic, retain) ClientInstrumentScoresEntity *clientInstrumentScore;
@property (nonatomic, retain) InstrumentScoreNameEntity *scoreName;

@end
