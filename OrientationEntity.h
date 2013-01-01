//
//  OrientationEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class CommunityServiceEntity, OrientationHistoryEntity;

@interface OrientationEntity : NSManagedObject

@property (nonatomic, retain) NSString * orientation;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSSet *communityService;
@property (nonatomic, retain) NSSet *orientationHistories;
@end

@interface OrientationEntity (CoreDataGeneratedAccessors)

- (void)addCommunityServiceObject:(CommunityServiceEntity *)value;
- (void)removeCommunityServiceObject:(CommunityServiceEntity *)value;
- (void)addCommunityService:(NSSet *)values;
- (void)removeCommunityService:(NSSet *)values;

- (void)addOrientationHistoriesObject:(OrientationHistoryEntity *)value;
- (void)removeOrientationHistoriesObject:(OrientationHistoryEntity *)value;
- (void)addOrientationHistories:(NSSet *)values;
- (void)removeOrientationHistories:(NSSet *)values;

@end
