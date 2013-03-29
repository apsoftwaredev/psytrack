//
//  DemographicSexualOrientation.m
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicSexualOrientation.h"
#import "PTTAppDelegate.h"

@implementation DemographicSexualOrientation
@synthesize sexualOrientation,count;
- (id) initWithSexualOrientation:(NSString *)sexualOrientationGiven count:(int)countGiven
{
    self = [super init];

    if (self)
    {
        self.sexualOrientation = sexualOrientationGiven;
        self.count = countGiven;
    }

    return self;
}


- (id) initWithSexualOrientation:(NSString *)sexualOrientationGiven fromDemographicArray:(NSArray *)demographicArrayGiven
{
    self = [super init];

    if (self)
    {
        self.sexualOrientation = sexualOrientationGiven;

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sexualOrientation MATCHES %@ AND clinician == nil", sexualOrientationGiven];

        NSArray *filteredObjects = [demographicArrayGiven filteredArrayUsingPredicate:predicate];

        if (filteredObjects != nil)
        {
            self.count = filteredObjects.count;
        }
        else
        {
            self.count = 0;
        }
    }

    return self;
}


@end
