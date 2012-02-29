//
//  DrugProductEntity.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/2/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugApplicationEntity, DrugProductTECodeEntity;

@interface DrugProductEntity : NSManagedObject

@property (nonatomic, strong) NSString * applNo;
@property (nonatomic, strong) NSString * dosage;
@property (nonatomic, strong) NSString * tECode;
@property (nonatomic, strong) NSNumber * productMktStatus;
@property (nonatomic, strong) NSString * form;
@property (nonatomic, strong) NSString * productNo;
@property (nonatomic, strong) NSString * drugName;
@property (nonatomic, strong) NSString * activeIngredient;
@property (nonatomic, strong) NSString * referenceDrug;
@property (nonatomic, strong) NSSet *productTECode;
@property (nonatomic, strong) DrugApplicationEntity *appl;
@end

@interface DrugProductEntity (CoreDataGeneratedAccessors)

- (void)addProductTECodeObject:(DrugProductTECodeEntity *)value;
- (void)removeProductTECodeObject:(DrugProductTECodeEntity *)value;
- (void)addProductTECode:(NSSet *)values;
- (void)removeProductTECode:(NSSet *)values;

@end
