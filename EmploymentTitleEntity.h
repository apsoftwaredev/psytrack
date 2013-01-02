//
//  EmploymentTitleEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class EmploymentPositionEntity;

@interface EmploymentTitleEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * jobTitle;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSSet *employmentPositions;
@end

@interface EmploymentTitleEntity (CoreDataGeneratedAccessors)

- (void)addEmploymentPositionsObject:(EmploymentPositionEntity *)value;
- (void)removeEmploymentPositionsObject:(EmploymentPositionEntity *)value;
- (void)addEmploymentPositions:(NSSet *)values;
- (void)removeEmploymentPositions:(NSSet *)values;

@end
