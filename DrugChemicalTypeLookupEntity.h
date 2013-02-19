/*
 *  DrugChemicalTypeLookupEntity.h
 *  psyTrack Clinician Tools
 *  Version: 1.05
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
