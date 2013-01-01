//
//  PresentationEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ConferenceEntity, LogEntity, PresentationDeliveredEntity, PublicationEntity;

@interface PresentationEntity : NSManagedObject

@property (nonatomic, retain) NSDate * length;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *topics;
@property (nonatomic, retain) NSSet *publications;
@property (nonatomic, retain) NSSet *conferences;
@property (nonatomic, retain) NSSet *deliveries;
@end

@interface PresentationEntity (CoreDataGeneratedAccessors)

- (void)addLogsObject:(LogEntity *)value;
- (void)removeLogsObject:(LogEntity *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

- (void)addTopicsObject:(NSManagedObject *)value;
- (void)removeTopicsObject:(NSManagedObject *)value;
- (void)addTopics:(NSSet *)values;
- (void)removeTopics:(NSSet *)values;

- (void)addPublicationsObject:(PublicationEntity *)value;
- (void)removePublicationsObject:(PublicationEntity *)value;
- (void)addPublications:(NSSet *)values;
- (void)removePublications:(NSSet *)values;

- (void)addConferencesObject:(ConferenceEntity *)value;
- (void)removeConferencesObject:(ConferenceEntity *)value;
- (void)addConferences:(NSSet *)values;
- (void)removeConferences:(NSSet *)values;

- (void)addDeliveriesObject:(PresentationDeliveredEntity *)value;
- (void)removeDeliveriesObject:(PresentationDeliveredEntity *)value;
- (void)addDeliveries:(NSSet *)values;
- (void)removeDeliveries:(NSSet *)values;

@end
