/*
 *  DrugProductEntity.h
 *  psyTrack
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on  1/2/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */



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
