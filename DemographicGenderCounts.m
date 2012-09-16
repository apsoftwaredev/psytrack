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

@synthesize genderMutableArray=genderMutableArray_;
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
        
        for (int i; i<fetchedObjects.count; i++) {
            
            
            
            GenderEntity *genderObject=[fetchedObjects objectAtIndex:i];
            
            [genderMutableArray_ addObject:genderObject];
            
            
            
            
            
        }
        
       
        
        
    }
    
    return self;
    
}


@end
