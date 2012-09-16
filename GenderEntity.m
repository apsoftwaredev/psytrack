//
//  GenderEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "GenderEntity.h"
#import "DemographicProfileEntity.h"


@implementation GenderEntity

@dynamic order;
@dynamic notes;
@dynamic genderName;
@dynamic existingGenders;
@dynamic demographics;
@synthesize clientCount;


-(int)clientCount{

    int returnInt=0;
   
    
    NSMutableSet *clientSet=[self mutableSetValueForKeyPath:@"demographics.client"];
    
    
    returnInt=clientSet.count;
    
    
    return returnInt;
    
    


}
@end
