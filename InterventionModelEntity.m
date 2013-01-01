//
//  InterventionModelEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "InterventionModelEntity.h"
#import "ExistingInterventionEntity.h"
#import "InterventionDeliveredEntity.h"


@implementation InterventionModelEntity

@dynamic modelName;
@dynamic notes;
@dynamic acronym;
@dynamic evidenceBased;
@dynamic interventionDelivered;
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

@end
