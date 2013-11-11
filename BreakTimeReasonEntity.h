//
//  BreakTimeReasonEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BreakTimeEntity;

@interface BreakTimeReasonEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *breakName;
@property (nonatomic, retain) NSSet *breakTimes;
@end

@interface BreakTimeReasonEntity (CoreDataGeneratedAccessors)

- (void) addBreakTimesObject:(BreakTimeEntity *)value;
- (void) removeBreakTimesObject:(BreakTimeEntity *)value;
- (void) addBreakTimes:(NSSet *)values;
- (void) removeBreakTimes:(NSSet *)values;

@end
