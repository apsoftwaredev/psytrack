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




-(NSString *)clientCountStr{
    
    int returnInt=0;
    
    
    NSMutableSet *clientSet=[self mutableSetValueForKeyPath:@"demographics.client"];
    
    
    returnInt=clientSet.count;
    
    
    return [NSString stringWithFormat:@"%i",returnInt];
    
    
    
    
}
@end
