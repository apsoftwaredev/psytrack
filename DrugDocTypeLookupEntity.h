//
//  DrugDocTypeLookupEntity.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 12/31/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugRegActionDateEntity;

@interface DrugDocTypeLookupEntity : NSManagedObject

@property (nonatomic, strong) NSString * docType;
@property (nonatomic, strong) NSString * docTypeDesc;
@property (nonatomic, strong) NSSet *reglatoryActions;
@end

@interface DrugDocTypeLookupEntity (CoreDataGeneratedAccessors)

- (void)addReglatoryActionsObject:(DrugRegActionDateEntity *)value;
- (void)removeReglatoryActionsObject:(DrugRegActionDateEntity *)value;
- (void)addReglatoryActions:(NSSet *)values;
- (void)removeReglatoryActions:(NSSet *)values;

@end
