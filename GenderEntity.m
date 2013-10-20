//
//  GenderEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "GenderEntity.h"
#import "DemographicProfileEntity.h"

@implementation GenderEntity

@dynamic order;
@dynamic notes;
@dynamic genderName;
@dynamic existingGenders;
@dynamic demographics;

@synthesize clientCountStr;

- (NSString *) clientCountStr
{
    int returnInt = 0;

    NSMutableSet *clientSet = [self mutableSetValueForKeyPath:@"demographics.client"];

    returnInt = clientSet.count;

    return [NSString stringWithFormat:@"%i",returnInt];
}


@end
