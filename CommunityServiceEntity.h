//
//  CommunityServiceEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class LogEntity;

@interface CommunityServiceEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * dateStarted;
@property (nonatomic, retain) NSDate * dateEnded;
@property (nonatomic, retain) NSDate * hours;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * projectName;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSManagedObject *organization;
@end

@interface CommunityServiceEntity (CoreDataGeneratedAccessors)

- (void)addLogsObject:(LogEntity *)value;
- (void)removeLogsObject:(LogEntity *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

@end
