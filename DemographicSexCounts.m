//
//  DemographicSexCounts.m
//  PsyTrack Clinician Tools
//  Version: 1.05
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
        
        if (demographicMale.count) {
             [sexMutableArray_ addObject:demographicMale];
        }
       
        
        DemographicSex *demographicFemale=[[DemographicSex alloc]initWithSex:@"Female" fromDemographicArray:fetchedObjects];
        
        if (demographicFemale.count) {
            [sexMutableArray_ addObject:demographicFemale];
        }
        
        
        DemographicSex *demographicIntersexual=[[DemographicSex alloc]initWithSex:@"Intersexual" fromDemographicArray:fetchedObjects];
        
        if (demographicIntersexual.count) {
             [sexMutableArray_ addObject:demographicIntersexual];
        }
       
        
        DemographicSex *demographicF2M=[[DemographicSex alloc]initWithSex:@"F2M" fromDemographicArray:fetchedObjects];
        
        if (demographicF2M.count) {
             [sexMutableArray_ addObject:demographicF2M];
        }
       
        
        DemographicSex *demographicM2F=[[DemographicSex alloc]initWithSex:@"M2F" fromDemographicArray:fetchedObjects];
        if (demographicM2F.count) {
             [sexMutableArray_ addObject:demographicM2F];
        }
       
        
 
        DemographicSex *demographicUndisclosed=[[DemographicSex alloc]initWithSex:@"Undisclosed" fromDemographicArray:fetchedObjects];
        if (demographicUndisclosed.count) {
              [sexMutableArray_ addObject:demographicUndisclosed];
        }
      
        
        NSArray *filteredForNull=[fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"clinician==nil AND sex == nil AND client != nil"]];
        
        if (filteredForNull && filteredForNull.count>0) {
            DemographicSex *demographicSexNil=[[DemographicSex alloc]initWithSex:@"Not Selected" count:filteredForNull.count];
            [sexMutableArray_ addObject:demographicSexNil];
        }
        

        
        fetchRequest=nil;
    }

    return self;

}





@end
