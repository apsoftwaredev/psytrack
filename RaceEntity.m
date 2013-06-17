//
//  RaceEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "RaceEntity.h"
#import "DemographicProfileEntity.h"
#import "ExistingRaceEntity.h"

@implementation RaceEntity

@dynamic order;
@dynamic notes;
@dynamic raceName;
@dynamic demographics;
@dynamic existingRaces;

@synthesize clientCount;

- (int) clientCount
{
    int returnInt = 0;

    NSMutableSet *clientSet = [self mutableSetValueForKeyPath:@"demographics.client"];

    if (clientSet)
    {
        returnInt = clientSet.count;
    }

    return returnInt;
}


@end
