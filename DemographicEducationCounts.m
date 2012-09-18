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
        
        for (int i=0; i<fetchedObjects.count; i++) {
            
            
            NSManagedObject *educationLevelManagedObject=(NSManagedObject *)[fetchedObjects objectAtIndex:i];
            EducationLevelEntity *educationObject=(EducationLevelEntity *)educationLevelManagedObject;
            
            
            [educationMutableArray_ addObject:educationObject];
            
            
            
            
            
        }
        
        NSFetchRequest *demographicProfileFetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *demographicProfileEntity = [NSEntityDescription entityForName:@"DemographicProfileEntity" inManagedObjectContext:managedObjectContext];
        [demographicProfileFetchRequest setEntity:demographicProfileEntity];
        
        
        
        NSError *demError = nil;
        NSArray *demProfileFetchedObjects = [managedObjectContext executeFetchRequest:demographicProfileFetchRequest error:&demError];
        
        
        
        NSArray *filteredForNull=[demProfileFetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"educationLevel == nil AND clinician == nil"]];
        
        
        
        
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
