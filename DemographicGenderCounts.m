//
//  DemographicGenderCounts.m
//  PsyTrack Clinician Tools
//  Version: 1.5.1
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicGenderCounts.h"

#import "PTTAppDelegate.h"
#import "GenderEntity.h"

@implementation DemographicGenderCounts

@synthesize genderMutableArray = genderMutableArray_,notSelectedCountUInteger;
- (id) init
{
    self = [super init];

    if (self)
    {
        self.genderMutableArray = [NSMutableArray array];

        NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"GenderEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];

        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        for (int i = 0; i < fetchedObjects.count; i++)
        {
            GenderEntity *genderObject = [fetchedObjects objectAtIndex:i];
            if (genderObject && [genderObject.clientCountStr intValue])
            {
                [genderMutableArray_ addObject:genderObject];
            }
        }

        NSFetchRequest *demographicProfileFetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *demographicProfileEntity = [NSEntityDescription entityForName:@"DemographicProfileEntity" inManagedObjectContext:managedObjectContext];
        [demographicProfileFetchRequest setEntity:demographicProfileEntity];

        NSError *demError = nil;
        NSArray *demProfileFetchedObjects = [managedObjectContext executeFetchRequest:demographicProfileFetchRequest error:&demError];

        NSArray *filteredForNull = [demProfileFetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"gender == nil AND clinician == nil AND client != nil"]];

        if (filteredForNull && filteredForNull.count > 0)
        {
            self.notSelectedCountUInteger = filteredForNull.count;
        }
        else
        {
            self.notSelectedCountUInteger = 0;
        }

        fetchRequest = nil;
        demographicProfileFetchRequest = nil;
    }

    return self;
}


@end
