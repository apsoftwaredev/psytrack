//
//  InstrumentLogEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BatteryEntity, InstrumentEntity;

@interface InstrumentLogEntity : NSManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * logDate;
@property (nonatomic, retain) NSNumber * task;
@property (nonatomic, retain) InstrumentEntity *instrument;
@property (nonatomic, retain) BatteryEntity *battery;

@end
