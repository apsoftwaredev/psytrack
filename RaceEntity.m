//
//  RaceEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "RaceEntity.h"
#import "DemographicProfileEntity.h"
#import "ExistingRaceEntity.h"


@implementation RaceEntity

@dynamic order;
@dynamic notes;
@dynamic raceName;
@dynamic demographics;
@dynamic existingRaces;

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

+(BOOL)deletesInvalidObjectsAfterFailedSave
{
    return NO;
}

-(void)repairForError:(NSError *)error
{
    if ( [self.class deletesInvalidObjectsAfterFailedSave] ) {
        [self.managedObjectContext deleteObject:self];
    }
}



@end
