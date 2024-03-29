//
//  BreakTimeEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BreakTimeReasonEntity, TimeEntity;

@interface BreakTimeEntity : NSManagedObject

@property (nonatomic, retain) NSDate *endTime;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSDate *undefinedTime;
@property (nonatomic, retain) NSDate *startTime;
@property (nonatomic, retain) NSString *breakNotes;
@property (nonatomic, retain) BreakTimeReasonEntity *reason;
@property (nonatomic, retain) TimeEntity *time;

@end
