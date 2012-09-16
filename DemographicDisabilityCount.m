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

@implementation DemographicDisabilityCount
@synthesize disabilityMutableArray=disabilitynMutableArray_;
-(id)init{
    
    self=[super init];
    
    if (self) {
        
        
        self.disabilityMutableArray=[NSMutableArray array];
        
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"DisabilityEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        
        
        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        for (int i; i<fetchedObjects.count; i++) {
            
            
            
            DisabilityEntity *disabilityObject=[fetchedObjects objectAtIndex:i];
            
            [disabilityMutableArray_ addObject:disabilityObject];
            
            
            
            
            
        }
        
        
        
        
    }
    
    return self;
    
}

@end
