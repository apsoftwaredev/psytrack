//
//  DemographicSexualOrientation.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicSexualOrientation.h"
#import "PTTAppDelegate.h"


@implementation DemographicSexualOrientation
@synthesize sexualOrientation,count;
-(id)initWithSex:(NSString *)sexualOrientationGiven{
    
    self =[super init];
    
    if (self) {
        
        
        self.sexualOrientation=sexualOrientationGiven;
        
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"DemographicProfileEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sexualOrientation MATCHES ", sexualOrientationGiven];
        [fetchRequest setPredicate:predicate];
        
        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if (fetchedObjects != nil) {
            self.count=fetchedObjects.count;
        }
        else
            self.count=0;
        
        
        
        
    }
    
    return self;
    
}


-(id)initWithSexualOrientation:(NSString *)sexualOrientationGiven fromDemographicArray:(NSArray *)demographicArrayGiven{
    
    self =[super init];
    
    if (self) {
        
        
        self.sexualOrientation=sexualOrientationGiven;
        
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sexualOrientation MATCHES ", sexualOrientationGiven];
        
        NSArray *filteredObjects =  [demographicArrayGiven filteredArrayUsingPredicate:predicate];
        
        if (filteredObjects != nil) {
            self.count=filteredObjects.count;
        }
        else
            self.count=0;
        
        
        
        
    }
    
    return self;
    
}


@end
