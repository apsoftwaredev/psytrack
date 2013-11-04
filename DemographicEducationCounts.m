//
//  DemographicEducationCounts.m
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicEducationCounts.h"
#import "PTTAppDelegate.h"
#import "EducationLevelEntity.h"

@implementation DemographicEducationCounts
@synthesize educationMutableArray = educationMutableArray_,notSelectedCountUInteger;
- (id) init
{
    self = [super init];

    if (self)
    {
        self.educationMutableArray = [NSMutableArray array];

        NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"EducationLevelEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];

        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];

        for (int i = 0; i < fetchedObjects.count; i++)
        {
            NSManagedObject *educationLevelManagedObject = (NSManagedObject *)[fetchedObjects objectAtIndex:i];
            EducationLevelEntity *educationObject = (EducationLevelEntity *)educationLevelManagedObject;

            if (educationObject && [educationObject.clientCountStr intValue])
            {
                [educationMutableArray_ addObject:educationObject];
            }
        }

        NSFetchRequest *demographicProfileFetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *demographicProfileEntity = [NSEntityDescription entityForName:@"DemographicProfileEntity" inManagedObjectContext:managedObjectContext];
        [demographicProfileFetchRequest setEntity:demographicProfileEntity];

        NSError *demError = nil;
        NSArray *demProfileFetchedObjects = [managedObjectContext executeFetchRequest:demographicProfileFetchRequest error:&demError];

        NSArray *filteredForNull = [demProfileFetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"educationLevel == nil AND clinician == nil AND client != nil"]];

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
