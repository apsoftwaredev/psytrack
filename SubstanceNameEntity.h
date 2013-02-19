//
//  SubstanceNameEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class SubstanceClassEntity;

@interface SubstanceNameEntity : PTManagedObject

@property (nonatomic, retain) NSString * substanceName;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) SubstanceClassEntity *substanceClass;
@property (nonatomic, retain) NSSet *substanceUses;
@end

@interface SubstanceNameEntity (CoreDataGeneratedAccessors)

- (void)addSubstanceUsesObject:(NSManagedObject *)value;
- (void)removeSubstanceUsesObject:(NSManagedObject *)value;
- (void)addSubstanceUses:(NSSet *)values;
- (void)removeSubstanceUses:(NSSet *)values;

@end
