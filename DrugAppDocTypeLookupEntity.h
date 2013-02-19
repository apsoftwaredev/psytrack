/*
 *  DrugAppDocTypeLookupEntity.h
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

@class DrugAppDocEntity;

@interface DrugAppDocTypeLookupEntity : NSManagedObject

@property (nonatomic, strong) NSString * appDocType;
@property (nonatomic, strong) NSNumber * sortOrder;
@property (nonatomic, strong) NSSet *applicationDocuments;
@end

@interface DrugAppDocTypeLookupEntity (CoreDataGeneratedAccessors)

- (void)addApplicationDocumentsObject:(DrugAppDocEntity *)value;
- (void)removeApplicationDocumentsObject:(DrugAppDocEntity *)value;
- (void)addApplicationDocuments:(NSSet *)values;
- (void)removeApplicationDocuments:(NSSet *)values;

@end
