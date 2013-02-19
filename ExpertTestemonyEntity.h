//
//  ExpertTestemonyEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class ClientEntity, LogEntity, PublicationEntity;

@interface ExpertTestemonyEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * plantifDefendant;
@property (nonatomic, retain) NSString * caseName;
@property (nonatomic, retain) NSDate * hours;
@property (nonatomic, retain) NSString * attorneys;
@property (nonatomic, retain) NSString * judge;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *courtAppearances;
@property (nonatomic, retain) NSSet *publications;
@property (nonatomic, retain) ClientEntity *client;
@property (nonatomic, retain) NSManagedObject *organization;
@end

@interface ExpertTestemonyEntity (CoreDataGeneratedAccessors)

- (void)addLogsObject:(LogEntity *)value;
- (void)removeLogsObject:(LogEntity *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

- (void)addCourtAppearancesObject:(NSManagedObject *)value;
- (void)removeCourtAppearancesObject:(NSManagedObject *)value;
- (void)addCourtAppearances:(NSSet *)values;
- (void)removeCourtAppearances:(NSSet *)values;

- (void)addPublicationsObject:(PublicationEntity *)value;
- (void)removePublicationsObject:(PublicationEntity *)value;
- (void)addPublications:(NSSet *)values;
- (void)removePublications:(NSSet *)values;

@end
