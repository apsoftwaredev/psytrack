//
//  InterventionTypeEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ExistingInterventionEntity, InterventionDeliveredEntity, InterventionTypeSubtypeEntity;

@interface InterventionTypeEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *interventionType;
@property (nonatomic, retain) NSSet *subTypes;
@property (nonatomic, retain) NSSet *interventionsDelivered;
@property (nonatomic, retain) NSSet *existingInterventions;
@end

@interface InterventionTypeEntity (CoreDataGeneratedAccessors)

- (void) addSubTypesObject:(InterventionTypeSubtypeEntity *)value;
- (void) removeSubTypesObject:(InterventionTypeSubtypeEntity *)value;
- (void) addSubTypes:(NSSet *)values;
- (void) removeSubTypes:(NSSet *)values;

- (void) addInterventionsDeliveredObject:(InterventionDeliveredEntity *)value;
- (void) removeInterventionsDeliveredObject:(InterventionDeliveredEntity *)value;
- (void) addInterventionsDelivered:(NSSet *)values;
- (void) removeInterventionsDelivered:(NSSet *)values;

- (void) addExistingInterventionsObject:(ExistingInterventionEntity *)value;
- (void) removeExistingInterventionsObject:(ExistingInterventionEntity *)value;
- (void) addExistingInterventions:(NSSet *)values;
- (void) removeExistingInterventions:(NSSet *)values;


-(BOOL)associatedWithTimeRecords;
@end
