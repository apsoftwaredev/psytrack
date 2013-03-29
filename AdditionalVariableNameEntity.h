//
//  AdditionalVariableNameEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class AdditionalVariableEntity, AdditionalVariableValueEntity;

@interface AdditionalVariableNameEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *variableName;
@property (nonatomic, retain) NSSet *aditionalVariables;
@property (nonatomic, retain) NSSet *variableValues;
@end

@interface AdditionalVariableNameEntity (CoreDataGeneratedAccessors)

- (void) addAditionalVariablesObject:(AdditionalVariableEntity *)value;
- (void) removeAditionalVariablesObject:(AdditionalVariableEntity *)value;
- (void) addAditionalVariables:(NSSet *)values;
- (void) removeAditionalVariables:(NSSet *)values;

- (void) addVariableValuesObject:(AdditionalVariableValueEntity *)value;
- (void) removeVariableValuesObject:(AdditionalVariableValueEntity *)value;
- (void) addVariableValues:(NSSet *)values;
- (void) removeVariableValues:(NSSet *)values;

@end
