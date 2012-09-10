//
//  AdditionalVariableEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AdditionalVariableNameEntity, AdditionalVariableValueEntity, DemographicProfileEntity;

@interface AdditionalVariableEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * scale;
@property (nonatomic, retain) NSNumber * sliderOne;
@property (nonatomic, retain) NSDate * timeValueTwo;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * timeValue;
@property (nonatomic, retain) NSString * stringValue;
@property (nonatomic, retain) NSNumber * sliderTwo;
@property (nonatomic, retain) NSDate * dateValue;
@property (nonatomic, retain) NSSet *selectedValue;
@property (nonatomic, retain) NSSet *demographics;
@property (nonatomic, retain) NSSet *clientPresentation;
@property (nonatomic, retain) AdditionalVariableNameEntity *variableName;
@end

@interface AdditionalVariableEntity (CoreDataGeneratedAccessors)

- (void)addSelectedValueObject:(AdditionalVariableValueEntity *)value;
- (void)removeSelectedValueObject:(AdditionalVariableValueEntity *)value;
- (void)addSelectedValue:(NSSet *)values;
- (void)removeSelectedValue:(NSSet *)values;

- (void)addDemographicsObject:(DemographicProfileEntity *)value;
- (void)removeDemographicsObject:(DemographicProfileEntity *)value;
- (void)addDemographics:(NSSet *)values;
- (void)removeDemographics:(NSSet *)values;

- (void)addClientPresentationObject:(NSManagedObject *)value;
- (void)removeClientPresentationObject:(NSManagedObject *)value;
- (void)addClientPresentation:(NSSet *)values;
- (void)removeClientPresentation:(NSSet *)values;

@end
