//
//  ServiceCodeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 12/20/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ServiceParentEntity;

@interface ServiceCodeEntity : NSManagedObject

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
