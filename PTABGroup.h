/*
 *  PTABGroup.h
 *  psyTrack Clinician Tools
 *  Version: 1.05
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 3/7/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <Foundation/Foundation.h>

@interface PTABGroup : NSObject

{
    // Name of an ABSource object
    NSString *groupName;

    int recordID;
}

@property(nonatomic, retain) NSString *groupName;
@property(nonatomic, assign) int recordID;

- (id) initWithName:(NSString *)groupName recordID:(int)recordID;

@end
