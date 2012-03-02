/*
 *  DrugAppDocEntity.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
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

@class DrugAppDocTypeLookupEntity, DrugRegActionDateEntity;

@interface DrugAppDocEntity : NSManagedObject

@property (nonatomic, strong) NSString * docUrl;
@property (nonatomic, strong) NSString * applNo;
@property (nonatomic, strong) NSDate * docDate;
@property (nonatomic, strong) NSString * seqNo;
@property (nonatomic, strong) NSNumber * appDocID;
@property (nonatomic, strong) NSString * actionType;
@property (nonatomic, strong) NSString * docTitle;
@property (nonatomic, strong) NSString * docType;
@property (nonatomic, strong) NSNumber * duplicateCounter;
@property (nonatomic, strong) DrugRegActionDateEntity *regAction;
@property (nonatomic, strong) DrugAppDocTypeLookupEntity *documentType;

@end
