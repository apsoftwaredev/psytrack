//
//  DemographicGenderCounts.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicGenderCounts.h"

#import "PTTAppDelegate.h"
#import "GenderEntity.h"

@implementation DemographicGenderCounts

@synthesize genderMutableArray=genderMutableArray_,notSelectedCountStr;
-(id)init{
    
    self=[super init];
    
    if (self) {
        
        
        self.genderMutableArray=[NSMutableArray array];
        
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"GenderEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        
        
        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        DLog(@"fetched objects are  %@",fetchedObjects);
        for (int i=0; i<fetchedObjects.count; i++) {
            
            
            
            GenderEntity *genderObject=[fetchedObjects objectAtIndex:i];
            
            [genderMutableArray_ addObject:genderObject];
            
            
            
            
            
        }
        
        
        
      
        NSFetchRequest *demographicProfileFetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *demographicProfileEntity = [NSEntityDescription entityForName:@"DemographicProfileEntity" inManagedObjectContext:managedObjectContext];
        [demographicProfileFetchRequest setEntity:demographicProfileEntity];
        
        
        
        NSError *demError = nil;
        NSArray *demProfileFetchedObjects = [managedObjectContext executeFetchRequest:demographicProfileFetchRequest error:&demError];
        
        
        
        NSArray *filteredForNull=[demProfileFetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"gender == nil AND clinician == nil"]];
        
        
        
        
        if (filteredForNull && filteredForNull.count>0) {
            self.notSelectedCountStr=[NSString stringWithFormat:@"%i",filteredForNull.count];
        }
        else{
        
            self.notSelectedCountStr=[NSString stringWithFormat:@"%i",0];

        }
        
        
    }
    
    return self;
    
}


@end
