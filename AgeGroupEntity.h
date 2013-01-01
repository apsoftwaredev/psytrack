//
//  AgeGroupEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AgeGroupEntity : NSManagedObject

@property (nonatomic, retain) NSString * ageGroup;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSSet *existingAgeGroup;
@end

@interface AgeGroupEntity (CoreDataGeneratedAccessors)

- (void)addExistingAgeGroupObject:(NSManagedObject *)value;
- (void)removeExistingAgeGroupObject:(NSManagedObject *)value;
- (void)addExistingAgeGroup:(NSSet *)values;
- (void)removeExistingAgeGroup:(NSSet *)values;

@end
