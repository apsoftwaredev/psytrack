//
//  AdditionalVariableValueEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AdditionalVariableEntity, AdditionalVariableNameEntity;

@interface AdditionalVariableValueEntity : NSManagedObject

@property (nonatomic, retain) NSString * variableValue;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSSet *additionalVariables;
@property (nonatomic, retain) AdditionalVariableNameEntity *variableName;
@end

@interface AdditionalVariableValueEntity (CoreDataGeneratedAccessors)

- (void)addAdditionalVariablesObject:(AdditionalVariableEntity *)value;
- (void)removeAdditionalVariablesObject:(AdditionalVariableEntity *)value;
- (void)addAdditionalVariables:(NSSet *)values;
- (void)removeAdditionalVariables:(NSSet *)values;

@end
