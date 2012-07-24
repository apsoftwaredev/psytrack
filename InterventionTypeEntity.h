//
//  InterventionTypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/21/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ClinicianEntity.h"
@class InterventionDeliveredEntity, InterventionTypeSubtypeEntity;

@interface InterventionTypeEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * interventionType;
@property (nonatomic, retain) NSSet *interventionsDelivered;
@property (nonatomic, retain) NSSet *subTypes;
@property (nonatomic, retain) NSSet *existingInterventions;



@end

@interface InterventionTypeEntity (CoreDataGeneratedAccessors)

- (void)addInterventionDeliveredObject:(InterventionDeliveredEntity *)value;
- (void)removeInterventionDeliveredObject:(InterventionDeliveredEntity *)value;
- (void)addInterventionDelivered:(NSSet *)values;
- (void)removeInterventionDelivered:(NSSet *)values;

- (void)addSubTypesObject:(InterventionTypeSubtypeEntity *)value;
- (void)removeSubtypesObject:(InterventionTypeSubtypeEntity *)value;
- (void)addSubTypes:(NSSet *)values;
- (void)removeSubTypes:(NSSet *)values;

- (void)addExistingInterventionsObject:(NSManagedObject *)value;
- (void)removeExistingInterventionsObject:(NSManagedObject *)value;
- (void)addExistingInterventions:(NSSet *)values;
- (void)removeExistingInterventions:(NSSet *)values;


-(NSString *)totalHoursForMonth:(NSDate *)dateInMonth;
-(NSTimeInterval )totalHoursForMonthTI:(NSDate *)dateInMonth;


@end
