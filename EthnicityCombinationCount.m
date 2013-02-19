//
//  EthnicityCombinationCount.m
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "EthnicityCombinationCount.h"
#import "PTTAppDelegate.h"

@implementation EthnicityCombinationCount
@synthesize  ethnicityCombinationCount=ethnicityCombinationCount_, ethnicityCombinationMutableSet=ethnicityCombinationMutableSet_,ethnicityCombinationStr=ethnicityCombinationStr_;




-(id)initWithEthnicityCombinationStr:(NSString *)ethnicityCombinationStrGiven ethnicityMutableSet:(NSMutableSet *)ethnicityMutableSetGiven{
    
    self=[super init];
    
    
    if (self) {
        self.ethnicityCombinationStr=ethnicityCombinationStrGiven;
        
        self.ethnicityCombinationMutableSet=ethnicityMutableSetGiven;
        self.ethnicityCombinationCount=[self getethnicityCombinationCount];
    }
    
    return self;
    
}

-(int)getethnicityCombinationCount{
    
    int returnInt=0;
    
    NSArray *clientDemographicArray=[self fetchObjectsFromEntity:@"DemographicProfileEntity" filterPredicate:[NSPredicate predicateWithFormat:@"clinician == nil "]];
    
    NSArray *filteredArray=[clientDemographicArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"clinician == nil AND ethnicities == %@",ethnicityCombinationMutableSet_]];
    
    
    returnInt=filteredArray.count;
    
    return returnInt;
    
}



-(NSArray *)fetchObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate{
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityStr inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    
    if (filterPredicate) {
        [fetchRequest setPredicate:filterPredicate];
    }
    
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
    
}

@end
