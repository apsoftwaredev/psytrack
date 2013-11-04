//
//  DemographicSexualOrientationCounts.m
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicSexualOrientationCounts.h"
#import "DemographicSexualOrientation.h"
#import "PTTAppDelegate.h"

@implementation DemographicSexualOrientationCounts

@synthesize sexualOrientationMutableArray = sexualOrientationMutableArray_;
- (id) init
{
    self = [super init];

    if (self)
    {
        self.sexualOrientationMutableArray = [NSMutableArray array];

        NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"DemographicProfileEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];

        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];

        DemographicSexualOrientation *demographicAsexual = [[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Asexual" fromDemographicArray:fetchedObjects];

        DemographicSexualOrientation *demographicBisexual = [[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Bisexual" fromDemographicArray:fetchedObjects];

        DemographicSexualOrientation *demographicHeterosexual = [[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Heterosexual" fromDemographicArray:fetchedObjects];

        DemographicSexualOrientation *demographicGay = [[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Gay" fromDemographicArray:fetchedObjects];

        DemographicSexualOrientation *demographicLesbian = [[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Lesbian" fromDemographicArray:fetchedObjects];

        DemographicSexualOrientation *demographicQuestioning = [[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Uncertain/Questioning" fromDemographicArray:fetchedObjects];

        DemographicSexualOrientation *demographicUndisclosed = [[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Undisclosed" fromDemographicArray:fetchedObjects];

        NSArray *filteredForNull = [fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"clinician == nil AND sexualOrientation == nil AND client!= nil"]];

        if (filteredForNull && filteredForNull.count > 0)
        {
            DemographicSexualOrientation *demographicSexualOrientationNil = [[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Not Selected" count:filteredForNull.count];
            if (demographicSexualOrientationNil.count)
            {
                [sexualOrientationMutableArray_ addObject:demographicSexualOrientationNil];
            }
        }

        if (demographicAsexual.count)
        {
            [sexualOrientationMutableArray_ addObject:demographicAsexual];
        }

        if (demographicBisexual.count)
        {
            [sexualOrientationMutableArray_ addObject:demographicBisexual];
        }

        if (demographicGay.count)
        {
            [sexualOrientationMutableArray_ addObject:demographicGay];
        }

        if (demographicHeterosexual.count)
        {
            [sexualOrientationMutableArray_ addObject:demographicHeterosexual];
        }

        if (demographicLesbian.count)
        {
            [sexualOrientationMutableArray_ addObject:demographicLesbian];
        }

        if (demographicQuestioning.count)
        {
            [sexualOrientationMutableArray_ addObject:demographicQuestioning];
        }

        if (demographicUndisclosed.count)
        {
            [sexualOrientationMutableArray_ addObject:demographicUndisclosed];
        }

        fetchRequest = nil;
    }

    return self;
}


@end
