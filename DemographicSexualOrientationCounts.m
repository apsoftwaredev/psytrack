//
//  DemographicSexualOrientationCounts.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicSexualOrientationCounts.h"
#import "DemographicSexualOrientation.h"
#import "PTTAppDelegate.h"

@implementation DemographicSexualOrientationCounts

@synthesize sexualOrientationMutableArray=sexualOrientationMutableArray_;
-(id)init{
    
    self=[super init];
    
    if (self) {
        
        
        self.sexualOrientationMutableArray=[NSMutableArray array];
        
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"DemographicProfileEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        
        
        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        DemographicSexualOrientation *demographicAsexual=[[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Asexual" fromDemographicArray:fetchedObjects];
        
        DemographicSexualOrientation *demographicBisexual=[[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Bisexual" fromDemographicArray:fetchedObjects];
        
        DemographicSexualOrientation *demographicHeterosexual=[[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Heterosexual" fromDemographicArray:fetchedObjects];
        
        DemographicSexualOrientation *demographicGay=[[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Gay" fromDemographicArray:fetchedObjects];
        
        DemographicSexualOrientation *demographicLesbian=[[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Lesbian" fromDemographicArray:fetchedObjects];
        
        DemographicSexualOrientation *demographicQuestioning=[[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Uncertain/Questioning" fromDemographicArray:fetchedObjects];
        
        DemographicSexualOrientation *demographicUndisclosed=[[DemographicSexualOrientation alloc]initWithSexualOrientation:@"Undisclosed" fromDemographicArray:fetchedObjects];
        
        
        [sexualOrientationMutableArray_ addObject:demographicAsexual];
        [sexualOrientationMutableArray_ addObject:demographicBisexual];
        [sexualOrientationMutableArray_ addObject:demographicGay];
        [sexualOrientationMutableArray_ addObject:demographicHeterosexual];
        [sexualOrientationMutableArray_ addObject:demographicLesbian];
        [sexualOrientationMutableArray_ addObject:demographicQuestioning];
        [sexualOrientationMutableArray_ addObject:demographicUndisclosed];
        
        
    }
    
    return self;
    
}

@end
