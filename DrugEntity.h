//
//  DrugEntity.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 12/31/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugApplicationEntity;

@interface DrugEntity : NSManagedObject

@property (nonatomic, strong) NSNumber * order;
@property (nonatomic, strong) NSString * notes;
@property (nonatomic, strong) NSSet *clients;
@property (nonatomic, strong) NSSet *drugManufacturers;
@end

@interface DrugEntity (CoreDataGeneratedAccessors)

- (void)addClientsObject:(NSManagedObject *)value;
- (void)removeClientsObject:(NSManagedObject *)value;
- (void)addClients:(NSSet *)values;
- (void)removeClients:(NSSet *)values;

- (void)addDrugManufacturersObject:(DrugApplicationEntity *)value;
- (void)removeDrugManufacturersObject:(DrugApplicationEntity *)value;
- (void)addDrugManufacturers:(NSSet *)values;
- (void)removeDrugManufacturers:(NSSet *)values;

@end
