//
//  DemographicDisabilityCount.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicDisabilityCount.h"
#import "PTTAppDelegate.h"
#import "DisabilityEntity.h"
#import "ClientEntity.h"
#import "DisabilityCombinationCount.h"

@implementation DemographicDisabilityCount
@synthesize disabilityMutableArray=disabilityMutableArray_;
@synthesize  multiDisabilityOnlySet=multiDisabilityOnlySet_;
-(id)init{
    
    self=[super init];
    
    if (self) {
        
        
        self.disabilityMutableArray=[NSMutableArray array];
        
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClientEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        [fetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"demographicInfo.disabilities"]];
        
        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
       
        NSMutableSet *allDisabilitysSet=[NSMutableSet set];
        int numberOfMulitDisabilityIndividuals=0;
        int numberOfNilDisabilities=0;
        for (int i=0; i<fetchedObjects.count; i++) {
            
            ClientEntity *clientObject=[fetchedObjects objectAtIndex:i];
            NSMutableSet *clientdisabilitysSet=[clientObject mutableSetValueForKeyPath:@"demographicInfo.disabilities"];
            
            if (clientdisabilitysSet &&clientdisabilitysSet.count>0 ) {
                [allDisabilitysSet addObject:[NSSet setWithSet:clientdisabilitysSet]];
                if (clientdisabilitysSet.count>1) {
                    numberOfMulitDisabilityIndividuals++;
                }
            }
            else
            {
                numberOfNilDisabilities++;
            
            
            }
            
            
            
            
            
            
        }
       
        
        NSMutableSet *disabilityCombinatonCountSet=[NSMutableSet set];
        
        for (NSMutableSet *mutableSet in allDisabilitysSet) {
            NSString *disabilityCombinationString=nil;
            
            for (DisabilityEntity *disability in mutableSet) {
                
                if (disabilityCombinationString &&disabilityCombinationString.length) {
                    disabilityCombinationString=[disabilityCombinationString stringByAppendingFormat:@", %@",disability.disabilityName];
                }
                else{
                    disabilityCombinationString=disability.disabilityName;
                    
                }
                
                
            }
            
            DisabilityCombinationCount *disabilityCombinationCountObject=[[DisabilityCombinationCount alloc]initWithDisabilityCombinationStr:disabilityCombinationString disabilityMutableSet:mutableSet];
            [disabilityCombinatonCountSet addObject:disabilityCombinationCountObject];
            
            
            
            
            
        }
        
        

        if (numberOfMulitDisabilityIndividuals>0) {
            DisabilityCombinationCount *allMultiDisabilityCount=[[DisabilityCombinationCount alloc]init];
            
            
            [allMultiDisabilityCount setDisabilityCombinationStr:@"Individuals with Multiple Disabilities"];
            [allMultiDisabilityCount setDisabilityCombinationCount:numberOfMulitDisabilityIndividuals];
            
            [disabilityCombinatonCountSet addObject:allMultiDisabilityCount];
            

        }
               
        
        
        
        DisabilityCombinationCount *nilCount=[[DisabilityCombinationCount alloc]init];
        nilCount.disabilityCombinationStr=@"Not Selected";
        if (numberOfNilDisabilities>0) {
            [nilCount setDisabilityCombinationCount:numberOfNilDisabilities];
        }
        else{
            
            [nilCount setDisabilityCombinationCount:0];
            
        }

        
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"disabilityCombinationStr"
                                                                       ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        
        
        NSArray *sorteddisabilityCombinationArray=[disabilityCombinatonCountSet.allObjects sortedArrayUsingDescriptors:sortDescriptors];
        [disabilityMutableArray_ addObjectsFromArray:sorteddisabilityCombinationArray];
        
        if (nilCount.disabilityCombinationCount>0) {
            [disabilityMutableArray_ addObject:nilCount];
        }

    }
    
    return self;
    
}




@end
