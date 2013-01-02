//
//  ExistingInterventionEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ExistingInterventionEntity.h"
#import "ExistingDemographicsEntity.h"
#import "ExistingHoursEntity.h"
#import "InterventionModelEntity.h"
#import "InterventionTypeEntity.h"
#import "InterventionTypeSubtypeEntity.h"


@implementation ExistingInterventionEntity

@dynamic monthlyLogNotes;
@dynamic notes;
@dynamic hours;
@dynamic interventionType;
@dynamic models;
@dynamic interventionSubType;
@dynamic demographics;
@dynamic existingHours;

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
