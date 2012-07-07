//
//  TestingSessionDeliveredEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/6/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ServiceParentEntity.h"

@class TimeEntity;

@interface TestingSessionDeliveredEntity : ServiceParentEntity

@property (nonatomic, retain) NSSet *clientPresentations;
@property (nonatomic, retain) NSManagedObject *assessmentType;
@property (nonatomic, retain) TimeEntity *time;
@end

@interface TestingSessionDeliveredEntity (CoreDataGeneratedAccessors)

- (void)addClientPresentationsObject:(NSManagedObject *)value;
- (void)removeClientPresentationsObject:(NSManagedObject *)value;
- (void)addClientPresentations:(NSSet *)values;
- (void)removeClientPresentations:(NSSet *)values;

@end
