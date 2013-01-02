//
//  InterventionTypeEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "InterventionTypeEntity.h"
#import "ExistingInterventionEntity.h"
#import "InterventionDeliveredEntity.h"
#import "InterventionTypeSubtypeEntity.h"


@implementation InterventionTypeEntity

@dynamic order;
@dynamic notes;
@dynamic interventionType;
@dynamic subTypes;
@dynamic interventionsDelivered;
@dynamic existingInterventions;


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
