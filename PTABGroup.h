//
//  PTABGroup.h
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTABGroup : NSObject

{
	// Name of an ABSource object
	NSString *groupName;
	
    int recordID;
}

@property(nonatomic, retain) NSString *groupName;
@property(nonatomic, assign) int recordID;

-(id)initWithName:(NSString *)groupName recordID:(int)recordID;

@end