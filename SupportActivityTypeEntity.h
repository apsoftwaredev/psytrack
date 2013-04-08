//
//  SupportActivityTypeEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.1
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ExistingSupportActivityEntity, SupportActivityDeliveredEntity;

@interface SupportActivityTypeEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *supportActivityType;
@property (nonatomic, retain) NSSet *supportActivitiesDelivered;
@property (nonatomic, retain) NSSet *existingSupportActivities;
@end

@interface SupportActivityTypeEntity (CoreDataGeneratedAccessors)

- (void) addSupportActivitiesDeliveredObject:(SupportActivityDeliveredEntity *)value;
- (void) removeSupportActivitiesDeliveredObject:(SupportActivityDeliveredEntity *)value;
- (void) addSupportActivitiesDelivered:(NSSet *)values;
- (void) removeSupportActivitiesDelivered:(NSSet *)values;

- (void) addExistingSupportActivitiesObject:(ExistingSupportActivityEntity *)value;
- (void) removeExistingSupportActivitiesObject:(ExistingSupportActivityEntity *)value;
- (void) addExistingSupportActivities:(NSSet *)values;
- (void) removeExistingSupportActivities:(NSSet *)values;

@end
