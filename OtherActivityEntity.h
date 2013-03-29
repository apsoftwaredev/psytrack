//
//  OtherActivityEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class LogEntity;

@interface OtherActivityEntity : PTManagedObject

@property (nonatomic, retain) NSString *activity;
@property (nonatomic, retain) NSString *dates;
@property (nonatomic, retain) NSDate *hours;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSSet *logs;
@end

@interface OtherActivityEntity (CoreDataGeneratedAccessors)

- (void) addLogsObject:(LogEntity *)value;
- (void) removeLogsObject:(LogEntity *)value;
- (void) addLogs:(NSSet *)values;
- (void) removeLogs:(NSSet *)values;

@end
