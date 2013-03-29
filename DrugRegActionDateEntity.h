/*
 *  DrugRegActionDateEntity.h
 *  psyTrack Clinician Tools
 *  Version: 1.0.6
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

@class DrugAppDocEntity, DrugApplicationEntity, DrugDocTypeLookupEntity;

@interface DrugRegActionDateEntity : NSManagedObject

@property (nonatomic, strong) NSString *applNo;
@property (nonatomic, strong) NSString *actionType;
@property (nonatomic, strong) NSDate *actionDate;
@property (nonatomic, strong) NSString *inDocTypeSeqNo;
@property (nonatomic, strong) NSString *docType;
@property (nonatomic, strong) NSString *duplicateCounter;
@property (nonatomic, strong) NSSet *applicationDocuments;
@property (nonatomic, strong) DrugDocTypeLookupEntity *documentType;
@property (nonatomic, strong) DrugApplicationEntity *appl;
@end

@interface DrugRegActionDateEntity (CoreDataGeneratedAccessors)

- (void) addApplicationDocumentsObject:(DrugAppDocEntity *)value;
- (void) removeApplicationDocumentsObject:(DrugAppDocEntity *)value;
- (void) addApplicationDocuments:(NSSet *)values;
- (void) removeApplicationDocuments:(NSSet *)values;

@end
