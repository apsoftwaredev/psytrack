//
//  EthnicityEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "EthnicityEntity.h"
#import "DemographicProfileEntity.h"


@implementation EthnicityEntity

@dynamic order;
@dynamic notes;
@dynamic ethnicityName;
@dynamic demographics;

@dynamic existingEthnicities;

@synthesize clientCount;

-(int)clientCount{
    
    int returnInt=0;
    
    
    NSMutableSet *clientSet=[self mutableSetValueForKeyPath:@"demographics.client"];
    
    if (clientSet) {
        
        
        returnInt=clientSet.count;
    }
    
    
    
    return returnInt;
    
    
    
    
}
@end
