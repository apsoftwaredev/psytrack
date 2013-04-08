//
//  DemographicVariableAndCount.m
//  PsyTrack Clinician Tools
//  Version: 1.5.1
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicVariableAndCount.h"

@implementation DemographicVariableAndCount
@synthesize variableCountStr,variableStr;

- (id) initWithVariableStr:(NSString *)variableStrGiven variableCount:(int)variableCountIntGiven
{
    self = [super init];

    if (self)
    {
        self.variableCountStr = variableStrGiven;

        self.variableCountStr = [NSString stringWithFormat:@"%i",variableCountIntGiven];
    }

    return self;
}


@end
