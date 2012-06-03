//
//  BreakTimeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 5/20/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TimeEntity;

@interface BreakTimeEntity : NSManagedObject

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * undefinedTime;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * breakNotes;
@property (nonatomic, retain) NSManagedObject *reason;
@property (nonatomic, retain) TimeEntity *time;

@end
