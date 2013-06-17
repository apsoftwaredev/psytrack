//
//  DisorderSubCategoryEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class DisorderEntity;

@interface DisorderSubCategoryEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *subCategory;
@property (nonatomic, retain) NSSet *disorders;
@end

@interface DisorderSubCategoryEntity (CoreDataGeneratedAccessors)

- (void) addDisordersObject:(DisorderEntity *)value;
- (void) removeDisordersObject:(DisorderEntity *)value;
- (void) addDisorders:(NSSet *)values;
- (void) removeDisorders:(NSSet *)values;

@end
