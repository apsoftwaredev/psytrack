//
//  SubstanceUseLogEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class SubstanceUseEntity;

@interface SubstanceUseLogEntity : NSManagedObject

@property (nonatomic, retain) NSString * typicalDose;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * logDate;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * timesUsedInLastThirtyDays;
@property (nonatomic, retain) SubstanceUseEntity *substanceUse;

@end
