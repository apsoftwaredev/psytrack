//
//  DrugChemicalTypeLookupEntity.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 12/31/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugApplicationEntity;

@interface DrugChemicalTypeLookupEntity : NSManagedObject

@property (nonatomic, strong) NSNumber * chemicalTypeID;
@property (nonatomic, strong) NSNumber * chemicalTypeCode;
@property (nonatomic, strong) NSString * chemicalTypeDescription;
@property (nonatomic, strong) NSSet *applications;
@end

@interface DrugChemicalTypeLookupEntity (CoreDataGeneratedAccessors)

- (void)addApplicationsObject:(DrugApplicationEntity *)value;
- (void)removeApplicationsObject:(DrugApplicationEntity *)value;
- (void)addApplications:(NSSet *)values;
- (void)removeApplications:(NSSet *)values;

@end
