//
//  DisabilityCombinationCount.m
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DisabilityCombinationCount.h"
#import "PTTAppDelegate.h"
@implementation DisabilityCombinationCount
@synthesize  disabilityCombinationCount = disabilityCombinationCount_, disabilityCombinationMutableSet = disabilityCombinationMutableSet_,disabilityCombinationStr = disabilityCombinationStr_;

- (id) initWithDisabilityCombinationStr:(NSString *)disabilityCombinationStrGiven disabilityMutableSet:(NSMutableSet *)disabilityMutableSetGiven
{
    self = [super init];

    if (self)
    {
        self.disabilityCombinationStr = disabilityCombinationStrGiven;

        self.disabilityCombinationMutableSet = disabilityMutableSetGiven;
        self.disabilityCombinationCount = [self getDisabilityCombinationCount];
    }

    return self;
}


- (int) getDisabilityCombinationCount
{
    int returnInt = 0;

    NSArray *clientDemographicArray = [self fetchObjectsFromEntity:@"DemographicProfileEntity" filterPredicate:[NSPredicate predicateWithFormat:@"clinician == nil "]];

    NSArray *filteredArray = [clientDemographicArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"disabilities == %@",disabilityCombinationMutableSet_]];

    returnInt = filteredArray.count;

    return returnInt;
}


- (NSArray *) fetchObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate
{
    NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:entityStr inManagedObjectContext:managedObjectContext];

    [fetchRequest setEntity:entity];

    if (filterPredicate)
    {
        [fetchRequest setPredicate:filterPredicate];
    }

    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    fetchRequest = nil;
    return fetchedObjects;
}


@end
