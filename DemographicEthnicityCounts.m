//
//  DemographicEthnicityCounts.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicEthnicityCounts.h"
#import "PTTAppDelegate.h"
#import "ethnicityEntity.h"
#import "ClientEntity.h"
#import "EthnicityCombinationCount.h"

@implementation DemographicEthnicityCounts
@synthesize ethnicityMutableArray=ethnicityMutableArray_, multiRacialOnlySet=multiRacialOnlySet_;
-(id)init{
    
    self=[super init];
    
    if (self) {
        
        
        self.ethnicityMutableArray=[NSMutableArray array];
        
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClientEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        [fetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"demographicInfo.ethnicities"]];
        
        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        DLog(@"fetched objects count is  %i",fetchedObjects.count);
        NSMutableSet *allethnicitysSet=[NSMutableSet set];
        int numberOfMulitethnicityIndividuals=0;
        for (int i=0; i<fetchedObjects.count; i++) {
            
            ClientEntity *clientObject=[fetchedObjects objectAtIndex:i];
            NSMutableSet *clientethnicitysSet=[clientObject mutableSetValueForKeyPath:@"demographicInfo.ethnicitys"];
            DLog(@"client ethnicitys set is %@",clientethnicitysSet);
            if (clientethnicitysSet ) {
                [allethnicitysSet addObject:[NSSet setWithSet:clientethnicitysSet]];
                if (clientethnicitysSet.count>1) {
                    numberOfMulitethnicityIndividuals++;
                }
            }
            
            
            
            
            
            
            
        }
        DLog(@"all ethnicitys set is %@",allethnicitysSet);
        
        NSMutableSet *ethnicityCombinatonCountSet=[NSMutableSet set];
        
        for (NSMutableSet *mutableSet in allethnicitysSet) {
            NSString *ethnicityCombinationString=nil;
            
            for (EthnicityEntity *ethnicity in mutableSet) {
                
                if (ethnicityCombinationString &&ethnicityCombinationString.length) {
                    ethnicityCombinationString=[ethnicityCombinationString stringByAppendingFormat:@", %@",ethnicity.ethnicityName];
                }
                else{
                    ethnicityCombinationString=ethnicity.ethnicityName;
                    
                }
                
                DLog(@"ethnicity combination string is %@",ethnicityCombinationString);
                
            }
            
            EthnicityCombinationCount *ethnicityCombinationCountObject=[[EthnicityCombinationCount alloc]initWithethnicityCombinationStr:ethnicityCombinationString ethnicityMutableSet:mutableSet];
            [ethnicityCombinatonCountSet addObject:ethnicityCombinationCountObject];
            
            
            
            
            
        }
        
        
        DLog(@"multiracailonly set is  %@",multiRacialOnlySet_);
        EthnicityCombinationCount *allMultiEthnicityCount=[[EthnicityCombinationCount alloc]init];
        
        [allMultiEthnicityCount setEthnicityCombinationStr:@"Total Multiracial Individuals"];
        [allMultiEthnicityCount setEthnicityCombinationCount:numberOfMulitethnicityIndividuals];
        [ethnicityCombinatonCountSet addObject:allMultiEthnicityCount];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"ethnicityCombinationStr"
                                                                       ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        
        
        NSArray *sortedethnicityCombinationArray=[ethnicityCombinatonCountSet.allObjects sortedArrayUsingDescriptors:sortDescriptors];
        [ethnicityMutableArray_ addObjectsFromArray:sortedethnicityCombinationArray];
    }
    
    return self;
    
}




@end
