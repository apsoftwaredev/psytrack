//
//  DemographicSexCounts.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicSexCounts.h"
#import "PTTAppDelegate.h"
#import "DemographicSex.h"
@implementation DemographicSexCounts

@synthesize sexMutableArray=sexMutableArray_;
-(id)init{

    self=[super init];
    
    if (self) {
        
        
        self.sexMutableArray=[NSMutableArray array];
        
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"DemographicProfileEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
       
        
        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        DemographicSex *demographicMale=[[DemographicSex alloc]initWithSex:@"Male" fromDemographicArray:fetchedObjects];
        
        [sexMutableArray_ addObject:demographicMale];
        
        DemographicSex *demographicFemale=[[DemographicSex alloc]initWithSex:@"Female" fromDemographicArray:fetchedObjects];
        
        [sexMutableArray_ addObject:demographicFemale];
        
        DemographicSex *demographicIntersexual=[[DemographicSex alloc]initWithSex:@"Intersexual" fromDemographicArray:fetchedObjects];
        
        [sexMutableArray_ addObject:demographicIntersexual];
        
        DemographicSex *demographicF2M=[[DemographicSex alloc]initWithSex:@"F2M" fromDemographicArray:fetchedObjects];
        
        [sexMutableArray_ addObject:demographicF2M];
        
        DemographicSex *demographicM2F=[[DemographicSex alloc]initWithSex:@"M2F" fromDemographicArray:fetchedObjects];
        
        [sexMutableArray_ addObject:demographicM2F];
        
 
        DemographicSex *demographicUndisclosed=[[DemographicSex alloc]initWithSex:@"Undisclosed" fromDemographicArray:fetchedObjects];
        
        [sexMutableArray_ addObject:demographicUndisclosed];
        
        
        
        
    }

    return self;

}





@end
