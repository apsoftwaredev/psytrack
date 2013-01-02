//
//  DegreeSubjectEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class DegreeEntity;

@interface DegreeSubjectEntity : PTManagedObject

@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSSet *degreeMinor;
@property (nonatomic, retain) NSSet *degreeMajor;
@end

@interface DegreeSubjectEntity (CoreDataGeneratedAccessors)

- (void)addDegreeMinorObject:(DegreeEntity *)value;
- (void)removeDegreeMinorObject:(DegreeEntity *)value;
- (void)addDegreeMinor:(NSSet *)values;
- (void)removeDegreeMinor:(NSSet *)values;

- (void)addDegreeMajorObject:(DegreeEntity *)value;
- (void)removeDegreeMajorObject:(DegreeEntity *)value;
- (void)addDegreeMajor:(NSSet *)values;
- (void)removeDegreeMajor:(NSSet *)values;

@end
