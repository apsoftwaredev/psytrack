/*
 *  PTABGroup.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.5
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
#import "PTABGroup.h"

@implementation PTABGroup

@synthesize groupName, recordID;

- (id) initWithName:(NSString *)name recordID:(int)recordIDNo
{
    self = [super init];
    if (self != nil)
    {
        self.recordID = recordIDNo;
        self.groupName = name;
    }

    return self;
}


@end
