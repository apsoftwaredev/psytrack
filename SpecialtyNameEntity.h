//
//  SpecialtyNameEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class SpecialtyEntity;

@interface SpecialtyNameEntity : NSManagedObject

@property (nonatomic, retain) NSString * specialtyName;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSSet *specialties;
@end

@interface SpecialtyNameEntity (CoreDataGeneratedAccessors)

- (void)addSpecialtiesObject:(SpecialtyEntity *)value;
- (void)removeSpecialtiesObject:(SpecialtyEntity *)value;
- (void)addSpecialties:(NSSet *)values;
- (void)removeSpecialties:(NSSet *)values;

@end
