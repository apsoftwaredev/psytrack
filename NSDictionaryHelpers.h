/*
 *  NSDictionaryHelpers.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.5
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 2/20/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

//this helper was downloaded from coccanetics.com website and edited slightly for ARC (bridges)

#import <Foundation/Foundation.h>

@interface NSDictionary (Helpers)

+ (NSDictionary *) dictionaryWithContentsOfData:(NSData *)data;

@end
