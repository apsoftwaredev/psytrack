//
//  ConferenceEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class LogEntity, OrganizationEntity, PresentationEntity;

@interface ConferenceEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *attendenceSize;
@property (nonatomic, retain) NSDate *hours;
@property (nonatomic, retain) NSString *notableTopics;
@property (nonatomic, retain) NSString *notableSpeakers;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSSet *myPresentations;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *hostingOrganizations;
@end

@interface ConferenceEntity (CoreDataGeneratedAccessors)

- (void) addMyPresentationsObject:(PresentationEntity *)value;
- (void) removeMyPresentationsObject:(PresentationEntity *)value;
- (void) addMyPresentations:(NSSet *)values;
- (void) removeMyPresentations:(NSSet *)values;

- (void) addLogsObject:(LogEntity *)value;
- (void) removeLogsObject:(LogEntity *)value;
- (void) addLogs:(NSSet *)values;
- (void) removeLogs:(NSSet *)values;

- (void) addHostingOrganizationsObject:(OrganizationEntity *)value;
- (void) removeHostingOrganizationsObject:(OrganizationEntity *)value;
- (void) addHostingOrganizations:(NSSet *)values;
- (void) removeHostingOrganizations:(NSSet *)values;

@end
