/*
 *  DrugReviewClassLookupEntity.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.3
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

@interface DrugReviewClassLookupEntity : NSManagedObject

@property (nonatomic, strong) NSString *shortDesc;
@property (nonatomic, strong) NSString *reviewCode;
@property (nonatomic, strong) NSString *reviewClassID;
@property (nonatomic, strong) NSString *longDesc;
@property (nonatomic, strong) DrugApplicationEntity *appl;

@end
