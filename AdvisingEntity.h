//
//  AdvisingEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity, LogEntity;

@interface AdvisingEntity : NSManagedObject

@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *current;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) ClinicianEntity *advisee;
@end

@interface AdvisingEntity (CoreDataGeneratedAccessors)

- (void) addLogsObject:(LogEntity *)value;
- (void) removeLogsObject:(LogEntity *)value;
- (void) addLogs:(NSSet *)values;
- (void) removeLogs:(NSSet *)values;

@end
