//
//  DemographicSex.m
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicSex.h"
#import "PTTAppDelegate.h"

@implementation DemographicSex
@synthesize sex,count;

- (id) initWithSex:(NSString *)sexGiven count:(int)countGiven
{
    self = [super init];

    if (self)
    {
        self.sex = sexGiven;

        self.count = countGiven;
    }

    return self;
}


- (id) initWithSex:(NSString *)sexGiven fromDemographicArray:(NSArray *)demographicArrayGiven
{
    self = [super init];

    if (self)
    {
        self.sex = sexGiven;

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sex MATCHES %@ AND clinician == nil ", sexGiven];

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
