//
//  RaceCombinationCount.m
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "RaceCombinationCount.h"
#import "PTTAppDelegate.h"
@implementation RaceCombinationCount
@synthesize  raceCombinationCount = raceCombinationCount_, raceCombinationMutableSet = raceCombinationMutableSet_,raceCombinationStr = raceCombinationStr_;

- (id) initWithNilSelectionCount:(NSUInteger)countGiven
{
    self = [super init];

    if (self)
    {
        self.raceCombinationStr = @"Not Selected";

        self.raceCombinationCount = countGiven;
    }

    return self;
}


- (id) initWithRaceCombinationStr:(NSString *)raceCombinationStrGiven raceMutableSet:(NSMutableSet *)raceMutableSetGiven
{
    self = [super init];

    if (self)
    {
        self.raceCombinationStr = raceCombinationStrGiven;

        self.raceCombinationMutableSet = raceMutableSetGiven;
        self.raceCombinationCount = [self getRaceCombinationCount];
    }

    return self;
}


- (int) getRaceCombinationCount
{
    int returnInt = 0;

    NSArray *clientDemographicArray = [self fetchObjectsFromEntity:@"DemographicProfileEntity" filterPredicate:[NSPredicate predicateWithFormat:@"clinician == nil AND client != nil"]];

    NSArray *filteredArray = [clientDemographicArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@" races == %@ ",raceCombinationMutableSet_]];

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
