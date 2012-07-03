//
//  SupportActivityTypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/28/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SupportActivityDeliveredEntity;

@interface SupportActivityTypeEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * supportActivityType;
@property (nonatomic, retain) NSSet *supportActivitiesDelivered;
@property (nonatomic, retain) NSSet *existingSupportActivities;
@end

@interface SupportActivityTypeEntity (CoreDataGeneratedAccessors)

- (void)addSupportActivitiesDeliveredObject:(SupportActivityDeliveredEntity *)value;
- (void)removeSupportActivitiesDeliveredObject:(SupportActivityDeliveredEntity *)value;
- (void)addSupportActivitiesDelivered:(NSSet *)values;
- (void)removeSupportActivitiesDelivered:(NSSet *)values;

- (void)addExistingSupportActivitiesObject:(NSManagedObject *)value;
- (void)removeExistingSupportActivitiesObject:(NSManagedObject *)value;
- (void)addExistingSupportActivities:(NSSet *)values;
- (void)removeExistingSupportActivities:(NSSet *)values;

@end
