//
//  InstrumentLogEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BatteryEntity, InstrumentEntity;

@interface InstrumentLogEntity : NSManagedObject

@property (nonatomic, retain) NSDate *logDate;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *task;
@property (nonatomic, retain) InstrumentEntity *instrument;
@property (nonatomic, retain) BatteryEntity *battery;

@end
