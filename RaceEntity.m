//
//  RaceEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "RaceEntity.h"
#import "DemographicProfileEntity.h"


@implementation RaceEntity

@dynamic order;
@dynamic notes;
@dynamic raceName;
@dynamic demographics;
@dynamic existingRaces;
@selector clientCount;

-(int)clientCount{
    
    int returnInt=0;
    
    
    NSMutableSet *clientSet=[self mutableSetValueForKeyPath:@"demographics.client"];
    
    if (clientSet) {
    
        
         returnInt=clientSet.count;
    }
   
    
    
    return returnInt;
    
    
    
    
}

@end
