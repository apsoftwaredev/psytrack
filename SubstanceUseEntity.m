//
//  SubstanceUseEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "SubstanceUseEntity.h"
#import "ClientEntity.h"
#import "FrequencyEntity.h"
#import "SubstanceNameEntity.h"


@implementation SubstanceUseEntity

@dynamic lastUse;
@dynamic currentTreatmentIssue;
@dynamic notes;
@dynamic order;
@dynamic ageOfFirstUse;
@dynamic historyOfDependence;
@dynamic historyOfTreatment;
@dynamic currentDrugOfChoice;
@dynamic historyOfAbuse;
@dynamic substance;
@dynamic substanceUseLogs;
@dynamic client;
@dynamic frequency;


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
