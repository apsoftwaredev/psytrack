//
//  DemographicRaceCounts.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicRaceCounts.h"
#import "PTTAppDelegate.h"
#import "RaceEntity.h"
#import "ClientEntity.h"
#import "RaceCombinationCount.h"

@implementation DemographicRaceCounts
@synthesize raceMutableArray=raceMutableArray_, multiRacialOnlySet=multiRacialOnlySet_;
-(id)init{
    
    self=[super init];
    
    if (self) {
        
        
        self.raceMutableArray=[NSMutableArray array];
        
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClientEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        [fetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"demographicInfo.races"]];
        
        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        DLog(@"fetched objects count is  %i",fetchedObjects.count);
        NSMutableSet *allRacesSet=[NSMutableSet set];
        int numberOfMulitRaceIndividuals=0;
        for (int i=0; i<fetchedObjects.count; i++) {
            
            ClientEntity *clientObject=[fetchedObjects objectAtIndex:i];
            NSMutableSet *clientRacesSet=[clientObject mutableSetValueForKeyPath:@"demographicInfo.races"];
            DLog(@"client races set is %@",clientRacesSet);
            if (clientRacesSet ) {
                 [allRacesSet addObject:[NSSet setWithSet:clientRacesSet]];
                if (clientRacesSet.count>1) {
                    numberOfMulitRaceIndividuals++;
                }
            }
            
           
            
            
            
            
            
        }
        DLog(@"all races set is %@",allRacesSet);
        
        NSMutableSet *raceCombinatonCountSet=[NSMutableSet set];
        
        for (NSMutableSet *mutableSet in allRacesSet) {
            NSString *raceCombinationString=nil;
            
            for (RaceEntity *race in mutableSet) {
                
                if (raceCombinationString &&raceCombinationString.length) {
                    raceCombinationString=[raceCombinationString stringByAppendingFormat:@", %@",race.raceName];
                }
                else{
                    raceCombinationString=race.raceName;
                
                }
                
               DLog(@"race combination string is %@",raceCombinationString);
                
            }
        
        RaceCombinationCount *raceCombinationCountObject=[[RaceCombinationCount alloc]initWithRaceCombinationStr:raceCombinationString raceMutableSet:mutableSet];
         [raceCombinatonCountSet addObject:raceCombinationCountObject];
        
        
    
        
        
        }
       
                
        DLog(@"multiracailonly set is  %@",multiRacialOnlySet_);
        RaceCombinationCount *allMultiRaceCount=[[RaceCombinationCount alloc]init];
        
        [allMultiRaceCount setRaceCombinationStr:@"Total Multiracial Individuals"];
        [allMultiRaceCount setRaceCombinationCount:numberOfMulitRaceIndividuals];
        [raceCombinatonCountSet addObject:allMultiRaceCount];
        
NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"raceCombinationStr"
ascending:YES];
NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

        
        
        NSArray *sortedRaceCombinationArray=[raceCombinatonCountSet.allObjects sortedArrayUsingDescriptors:sortDescriptors];
        [raceMutableArray_ addObjectsFromArray:sortedRaceCombinationArray];
    }
    
    return self;
    
}


@end


