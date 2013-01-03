//
//  EducationLevelEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "EducationLevelEntity.h"
#import "DemographicProfileEntity.h"


@implementation EducationLevelEntity

@dynamic order;
@dynamic notes;
@dynamic educationLevel;
@dynamic demographics;
@synthesize clientCountStr;






-(NSString *)clientCountStr{
    
    int returnInt=0;
    
    
    NSMutableSet *clientSet=[self mutableSetValueForKeyPath:@"demographics.client"];
    
    
    returnInt=clientSet.count;
    
    
    return [NSString stringWithFormat:@"%i",returnInt];
    
    
    
    
}
@end
