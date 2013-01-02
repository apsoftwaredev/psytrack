//
//  InterventionDeliveredEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "InterventionDeliveredEntity.h"
#import "ClientPresentationEntity.h"
#import "InterventionModelEntity.h"
#import "InterventionTypeEntity.h"
#import "InterventionTypeSubtypeEntity.h"
#import "SupportActivityDeliveredEntity.h"
#import "TimeEntity.h"


@implementation InterventionDeliveredEntity

@dynamic clientPresentations;
@dynamic relatedToIndirect;
@dynamic interventionType;
@dynamic modelsUsed;
@dynamic subtype;
@dynamic time;

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
