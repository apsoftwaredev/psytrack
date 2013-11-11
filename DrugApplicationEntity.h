/*
 *  DrugApplicationEntity.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.5
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on  12/31/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugChemicalTypeLookupEntity, DrugEntity, DrugProductEntity, DrugRegActionDateEntity, DrugReviewClassLookupEntity;

@interface DrugApplicationEntity : NSManagedObject

@property (nonatomic, strong) NSString *sponsorApplicant;
@property (nonatomic, strong) NSString *applType;
@property (nonatomic, strong) NSString *currentPatentFlag;
@property (nonatomic, strong) NSString *actionType;
@property (nonatomic, strong) NSString *orphan_Code;
@property (nonatomic, strong) NSString *applNo;
@property (nonatomic, strong) NSString *mostRecentLabelAvailableFlag;
@property (nonatomic, strong) NSString *ther_Potential;
@property (nonatomic, strong) NSNumber *chemical_Type;
@property (nonatomic, strong) DrugReviewClassLookupEntity *reviewClass;
@property (nonatomic, strong) NSSet *reglatoryActions;
@property (nonatomic, strong) DrugEntity *drugGroup;
@property (nonatomic, strong) NSSet *products;
@property (nonatomic, strong) DrugChemicalTypeLookupEntity *chemType;
@end

@interface DrugApplicationEntity (CoreDataGeneratedAccessors)

- (void) addReglatoryActionsObject:(DrugRegActionDateEntity *)value;
- (void) removeReglatoryActionsObject:(DrugRegActionDateEntity *)value;
- (void) addReglatoryActions:(NSSet *)values;
- (void) removeReglatoryActions:(NSSet *)values;

- (void) addProductsObject:(DrugProductEntity *)value;
- (void) removeProductsObject:(DrugProductEntity *)value;
- (void) addProducts:(NSSet *)values;
- (void) removeProducts:(NSSet *)values;

@end
