//
//  DemographicEthnicityCounts.m
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicEthnicityCounts.h"
#import "PTTAppDelegate.h"
#import "EthnicityEntity.h"
#import "ClientEntity.h"
#import "EthnicityCombinationCount.h"

@implementation DemographicEthnicityCounts
@synthesize ethnicityMutableArray = ethnicityMutableArray_, multiEthnicityOnlySet = multiEthnicityOnlySet_;
- (id) init
{
    self = [super init];

    if (self)
    {
        self.ethnicityMutableArray = [NSMutableArray array];

        NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClientEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];

        [fetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"demographicInfo.ethnicities"]];

        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];

        NSMutableSet *allethnicitysSet = [NSMutableSet set];
        int numberOfMulitethnicityIndividuals = 0;
        int numberNotSelected = 0;
        for (int i = 0; i < fetchedObjects.count; i++)
        {
            ClientEntity *clientObject = [fetchedObjects objectAtIndex:i];
            NSMutableSet *clientethnicitysSet = [clientObject mutableSetValueForKeyPath:@"demographicInfo.ethnicities"];

            if (clientethnicitysSet && clientethnicitysSet.count > 0 )
            {
                [allethnicitysSet addObject:[NSSet setWithSet:clientethnicitysSet]];
                if (clientethnicitysSet.count > 1)
                {
                    numberOfMulitethnicityIndividuals++;
                }
            }
            else
            {
                numberNotSelected++;
            }
        }

        NSMutableSet *ethnicityCombinatonCountSet = [NSMutableSet set];

        for (NSMutableSet *mutableSet in allethnicitysSet)
        {
            NSString *ethnicityCombinationString = nil;

            for (EthnicityEntity *ethnicity in mutableSet)
            {
                if (ethnicityCombinationString && ethnicityCombinationString.length)
                {
                    ethnicityCombinationString = [ethnicityCombinationString stringByAppendingFormat:@", %@",ethnicity.ethnicityName];
                }
                else
                {
                    ethnicityCombinationString = ethnicity.ethnicityName;
                }
            }

            EthnicityCombinationCount *ethnicityCombinationCountObject = [[EthnicityCombinationCount alloc]initWithEthnicityCombinationStr:ethnicityCombinationString ethnicityMutableSet:mutableSet];
            if (ethnicityCombinationCountObject.ethnicityCombinationCount)
            {
                [ethnicityCombinatonCountSet addObject:ethnicityCombinationCountObject];
            }
        }

        if (numberOfMulitethnicityIndividuals > 0)
        {
            EthnicityCombinationCount *allMultiEthnicityCount = [[EthnicityCombinationCount alloc]init];

            [allMultiEthnicityCount setEthnicityCombinationStr:@"Individuals with Multiple Ethnicities"];
            [allMultiEthnicityCount setEthnicityCombinationCount:numberOfMulitethnicityIndividuals];
            [ethnicityCombinatonCountSet addObject:allMultiEthnicityCount];
        }

        if (numberNotSelected > 0)
        {
            EthnicityCombinationCount *notSelectedCount = [[EthnicityCombinationCount alloc]init];

            [notSelectedCount setEthnicityCombinationStr:@"Not Selected"];
            [notSelectedCount setEthnicityCombinationCount:numberNotSelected];
            [ethnicityCombinatonCountSet addObject:notSelectedCount];
        }

        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"ethnicityCombinationStr"
                                                                       ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

        NSArray *sortedethnicityCombinationArray = [ethnicityCombinatonCountSet.allObjects sortedArrayUsingDescriptors:sortDescriptors];
        [ethnicityMutableArray_ addObjectsFromArray:sortedethnicityCombinationArray];
        fetchRequest = nil;
        sortDescriptor = nil;
        sortDescriptors = nil;
    }

    return self;
}


@end
