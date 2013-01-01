//
//  EthnicityEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "EthnicityEntity.h"
#import "DemographicProfileEntity.h"
#import "ExistingEthnicityEntity.h"


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
-(BOOL)validateValue:(__autoreleasing id *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error
{
    if ( ![self.managedObjectContext isKindOfClass:[PTManagedObjectContext class]] ) {
        return YES;
    }
    else {
        return [super validateValue:value forKey:key error:error];
    }
}

@end
