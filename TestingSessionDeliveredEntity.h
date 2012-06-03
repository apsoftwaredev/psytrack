//
//  TestingSessionDeliveredEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 5/31/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ServiceEntity.h"

@class TimeEntity;

@interface TestingSessionDeliveredEntity : ServiceEntity

@property (nonatomic, retain) NSManagedObject *assessmentType;
@property (nonatomic, retain) NSSet *clientPresentations;
@property (nonatomic, retain) TimeEntity *time;
@end

@interface TestingSessionDeliveredEntity (CoreDataGeneratedAccessors)

- (void)addClientPresentationsObject:(NSManagedObject *)value;
- (void)removeClientPresentationsObject:(NSManagedObject *)value;
- (void)addClientPresentations:(NSSet *)values;
- (void)removeClientPresentations:(NSSet *)values;

@end
