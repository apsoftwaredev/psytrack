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
@synthesize disabilityMutableArray=disabilitynMutableArray_;
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
        
        DLog(@"fetched objects count is  %i",fetchedObjects.count);
        NSMutableSet *allDisabilitysSet=[NSMutableSet set];
        int numberOfMulitDisabilityIndividuals=0;
        for (int i=0; i<fetchedObjects.count; i++) {
            
            ClientEntity *clientObject=[fetchedObjects objectAtIndex:i];
            NSMutableSet *clientdisabilitysSet=[clientObject mutableSetValueForKeyPath:@"demographicInfo.disabilities"];
            DLog(@"client disabilitys set is %@",clientdisabilitysSet);
            if (clientdisabilitysSet ) {
                [allDisabilitysSet addObject:[NSSet setWithSet:clientdisabilitysSet]];
                if (clientdisabilitysSet.count>1) {
                    numberOfMulitDisabilityIndividuals++;
                }
            }
            
            
            
            
            
            
            
        }
        DLog(@"all disabilitys set is %@",allDisabilitysSet);
        
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
                
                DLog(@"disability combination string is %@",disabilityCombinationString);
                
            }
            
            DisabilityCombinationCount *disabilityCombinationCountObject=[[DisabilityCombinationCount alloc]initWithDisabilityCombinationStr:disabilityCombinationString disabilityMutableSet:mutableSet];
            [disabilityCombinatonCountSet addObject:disabilityCombinationCountObject];
            
            
            
            
            
        }
        
        
        DLog(@"multiracailonly set is  %@",multiDisabilityOnlySet_);
        DisabilityCombinationCount *allMultiDisabilityCount=[[DisabilityCombinationCount alloc]init];
        
        [allMultiDisabilityCount setDisabilityCombinationStr:@"Individuals with Multiple Disabilities"];
        [allMultiDisabilityCount setDisabilityCombinationCount:numberOfMulitDisabilityIndividuals];
        [disabilityCombinatonCountSet addObject:allMultiDisabilityCount];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"disabilityCombinationStr"
                                                                       ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        
        
        NSArray *sorteddisabilityCombinationArray=[disabilityCombinatonCountSet.allObjects sortedArrayUsingDescriptors:sortDescriptors];
        [disabilityMutableArray_ addObjectsFromArray:sorteddisabilityCombinationArray];
    }
    
    return self;
    
}




@end
