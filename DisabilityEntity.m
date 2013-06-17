//
//  DisabilityEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "DisabilityEntity.h"
#import "DemographicProfileEntity.h"

@implementation DisabilityEntity

@dynamic order;
@dynamic notes;
@dynamic disabilityName;
@dynamic demographics;
@dynamic existingDisabilities;

@synthesize clientCount;

- (int) clientCount
{
    int returnInt = 0;

    NSMutableSet *clientSet = [self mutableSetValueForKeyPath:@"demographics.client"];

    returnInt = clientSet.count;

    return returnInt;
}


@end
