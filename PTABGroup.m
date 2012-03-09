//
//  PTABGroup.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "PTABGroup.h"

@implementation PTABGroup

@synthesize groupName, recordID;

-(id)initWithName:(NSString *)name recordID:(int)recordIDNo
{
	self = [super init];
	if(self != nil) 
    {
		self.recordID = recordIDNo;
		self.groupName = name;
    }
	return self;
}



@end
