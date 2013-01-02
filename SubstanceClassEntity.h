//
//  SubstanceClassEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"




@interface SubstanceClassEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * substanceClassName;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSSet *substanceNames;
@end

@interface SubstanceClassEntity (CoreDataGeneratedAccessors)

- (void)addSubstanceNamesObject:(NSManagedObject *)value;
- (void)removeSubstanceNamesObject:(NSManagedObject *)value;
- (void)addSubstanceNames:(NSSet *)values;
- (void)removeSubstanceNames:(NSSet *)values;

@end
