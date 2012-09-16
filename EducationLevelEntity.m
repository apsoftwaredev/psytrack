//
//  EducationLevelEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "EducationLevelEntity.h"
#import "DemographicProfileEntity.h"


@implementation EducationLevelEntity

@dynamic order;
@dynamic notes;
@dynamic educationLevel;
@dynamic demographics;
@synthesize clientCount;

-(int)clientCount{
    
    int returnInt=0;
    
    
    NSMutableSet *clientSet=[self mutableSetValueForKeyPath:@"demographics.client"];
    
    
    returnInt=clientSet.count;
    
    
    return returnInt;
    
    
    
    
}

@end
