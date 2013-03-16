//
//  DemographicRaceCounts.m
//  PsyTrack Clinician Tools
//  Version: 1.05
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
        
      
        NSMutableSet *allRacesSet=[NSMutableSet set];
        int numberOfMulitRaceIndividuals=0;
        int numberOfNilRaces=0;
        for (int i=0; i<fetchedObjects.count; i++) {
            
            ClientEntity *clientObject=[fetchedObjects objectAtIndex:i];
            NSMutableSet *clientRacesSet=[clientObject mutableSetValueForKeyPath:@"demographicInfo.races"];
            
            if (clientRacesSet &&clientRacesSet.count>0 ) {
                [allRacesSet addObject:[NSSet setWithSet:clientRacesSet]];
                if (clientRacesSet.count>1) {
                    numberOfMulitRaceIndividuals++;
                }
            }
            else
            {
                numberOfNilRaces++;
                
                
            }
            
            
            
            
            
            
        }
        
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
                
                
            }
        
        RaceCombinationCount *raceCombinationCountObject=[[RaceCombinationCount alloc]initWithRaceCombinationStr:raceCombinationString raceMutableSet:mutableSet];
        if (raceCombinationCountObject.raceCombinationCount) {
             [raceCombinatonCountSet addObject:raceCombinationCountObject];
        }
       
        
        
    
        
        
        }
       
    if (numberOfMulitRaceIndividuals) {
        RaceCombinationCount *allMultiRaceCount=[[RaceCombinationCount alloc]init];
        
        [allMultiRaceCount setRaceCombinationStr:@"Total Multiracial Individuals"];
        [allMultiRaceCount setRaceCombinationCount:numberOfMulitRaceIndividuals];
        [raceCombinatonCountSet addObject:allMultiRaceCount];
    }
       
        
         RaceCombinationCount *nilCount=[[RaceCombinationCount alloc]init];
    nilCount.raceCombinationStr=@"Not Selected";
    if (numberOfNilRaces>0) {
        [nilCount setRaceCombinationCount:numberOfNilRaces];
    }
    else{
        
        [nilCount setRaceCombinationCount:0];
        
    }
    

    
             
        

       
        
NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"raceCombinationStr"
ascending:YES];
NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

        
        
        NSArray *sortedRaceCombinationArray=[raceCombinatonCountSet.allObjects sortedArrayUsingDescriptors:sortDescriptors];
        [raceMutableArray_ addObjectsFromArray:sortedRaceCombinationArray];
        

    if (nilCount.raceCombinationCount>0) {
        [raceMutableArray_ addObject:nilCount];
    }
        sortDescriptor=nil;
        sortDescriptors=nil;
        fetchRequest=nil;
    }
    

    return self;
    
}


@end


