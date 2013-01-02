//
//  ServiceCodeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class ServiceParentEntity;

@interface ServiceCodeEntity : PTManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *services;
@end

@interface ServiceCodeEntity (CoreDataGeneratedAccessors)

- (void)addServicesObject:(ServiceParentEntity *)value;
- (void)removeServicesObject:(ServiceParentEntity *)value;
- (void)addServices:(NSSet *)values;
- (void)removeServices:(NSSet *)values;

@end
