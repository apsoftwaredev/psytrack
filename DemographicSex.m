//
//  DemographicSex.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicSex.h"
#import "PTTAppDelegate.h"


@implementation DemographicSex
@synthesize sex,count;

-(id)initWithSex:(NSString *)sexGiven{
    
    self =[super init];
    
    if (self) {
        
        
        self.sex=sexGiven;
        
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"DemographicProfileEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sex MATCHES ", sexGiven];
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


-(id)initWithSex:(NSString *)sexGiven fromDemographicArray:(NSArray *)demographicArrayGiven{
    
    self =[super init];
    
    if (self) {
        
        
        self.sex=sexGiven;
        
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sex MATCHES ", sexGiven];
        
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
