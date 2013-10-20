//
//  ValidateMOC.h
//  PsyTrack
//
//  Created by Daniel Boice on 10/19/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateMOC : NSObject

-(BOOL)supervisorsAllPresent;
-(BOOL)siteAllPresent;

-(BOOL)dateOfServiceAllPresent;
-(BOOL)trainingProgramAllPresent;

-(BOOL)interventionTypeAllPresent;

-(BOOL)assessmentTypeAllPresent;

-(BOOL)supervisionTypeAllPresent;



@end
