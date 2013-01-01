//
//  ConferenceEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 8/12/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LogEntity;

@interface ConferenceEntity : NSManagedObject

@property (nonatomic, retain) NSString * notableSpeakers;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * hours;
@property (nonatomic, retain) NSNumber * attendenceSize;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * notableTopics;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *myPresentations;
@property (nonatomic, retain) NSSet *hostingOrganizations;
@end

@interface ConferenceEntity (CoreDataGeneratedAccessors)

- (void)addLogsObject:(LogEntity *)value;
- (void)removeLogsObject:(LogEntity *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

- (void)addMyPresentationsObject:(NSManagedObject *)value;
- (void)removeMyPresentationsObject:(NSManagedObject *)value;
- (void)addMyPresentations:(NSSet *)values;
- (void)removeMyPresentations:(NSSet *)values;

- (void)addHostingOrganizationsObject:(NSManagedObject *)value;
- (void)removeHostingOrganizationsObject:(NSManagedObject *)value;
- (void)addHostingOrganizations:(NSSet *)values;
- (void)removeHostingOrganizations:(NSSet *)values;

@end
