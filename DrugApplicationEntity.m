/*
 *  DrugApplicationEntity.m
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

#import "DrugApplicationEntity.h"
#import "DrugChemicalTypeLookupEntity.h"
#import "DrugEntity.h"
#import "DrugProductEntity.h"
#import "DrugRegActionDateEntity.h"
#import "DrugReviewClassLookupEntity.h"

@implementation DrugApplicationEntity

@dynamic sponsorApplicant;
@dynamic applType;
@dynamic currentPatentFlag;
@dynamic actionType;
@dynamic orphan_Code;
@dynamic applNo;
@dynamic mostRecentLabelAvailableFlag;
@dynamic ther_Potential;
@dynamic chemical_Type;
@dynamic reviewClass;
@dynamic reglatoryActions;
@dynamic drugGroup;
@dynamic products;
@dynamic chemType;

@end
