//
//  DemographicEducationCounts.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicEducationCounts.h"
#import "PTTAppDelegate.h"
#import "EducationLevelEntity.h"
@implementation DemographicEducationCounts
@synthesize educationMutableArray=educationMutableArray_;
-(id)init{
    
    self=[super init];
    
    if (self) {
        
        
        self.educationMutableArray=[NSMutableArray array];
        
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"EducationLevelEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        
        
        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        for (int i; i<fetchedObjects.count; i++) {
            
            
            
            EducationLevelEntity *educationObject=[fetchedObjects objectAtIndex:i];
            
            [educationMutableArray_ addObject:educationObject];
            
            
            
            
            
        }
        
        
        
        
    }
    
    return self;
    
}

@end
