//
//  MilitaryServiceEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "MilitaryServiceEntity.h"
#import "DemographicProfileEntity.h"
#import "MilitaryServiceDatesEntity.h"


@implementation MilitaryServiceEntity

@dynamic awards;
@dynamic serviceDisability;
@dynamic tsClearance;
@dynamic order;
@dynamic notes;
@dynamic exposureToCombat;
@dynamic militarySpecialties;
@dynamic highestRank;
@dynamic demographics;
@dynamic serviceHistory;

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
