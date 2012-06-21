//
//  InterventionTypeSubtypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/21/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InterventionDeliveredEntity;

@interface InterventionTypeSubtypeEntity : NSManagedObject

@property (nonatomic, retain) NSString * interventionSubtype;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSManagedObject *interventionType;
@property (nonatomic, retain) NSSet *interventionDelivered;
@end

@interface InterventionTypeSubtypeEntity (CoreDataGeneratedAccessors)

- (void)addInterventionDeliveredObject:(InterventionDeliveredEntity *)value;
- (void)removeInterventionDeliveredObject:(InterventionDeliveredEntity *)value;
- (void)addInterventionDelivered:(NSSet *)values;
- (void)removeInterventionDelivered:(NSSet *)values;

@end
