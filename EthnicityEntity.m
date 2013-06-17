//
//  EthnicityEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "EthnicityEntity.h"
#import "DemographicProfileEntity.h"
#import "ExistingEthnicityEntity.h"

@implementation EthnicityEntity

@dynamic order;
@dynamic notes;
@dynamic ethnicityName;
@dynamic demographics;
@dynamic existingEthnicities;

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
