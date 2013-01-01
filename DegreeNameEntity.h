//
//  DegreeNameEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DegreeNameEntity : NSManagedObject

@property (nonatomic, retain) NSString * degreeName;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSSet *degrees;
@end

@interface DegreeNameEntity (CoreDataGeneratedAccessors)

- (void)addDegreesObject:(NSManagedObject *)value;
- (void)removeDegreesObject:(NSManagedObject *)value;
- (void)addDegrees:(NSSet *)values;
- (void)removeDegrees:(NSSet *)values;

@end
