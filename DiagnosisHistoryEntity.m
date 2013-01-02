//
//  DiagnosisHistoryEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "DiagnosisHistoryEntity.h"
#import "ClientEntity.h"
#import "ClinicianEntity.h"
#import "DisorderEntity.h"
#import "DisorderSpecifierEntity.h"
#import "MedicationEntity.h"


@implementation DiagnosisHistoryEntity

@dynamic treatmentStarted;
@dynamic dateDiagnosed;
@dynamic onset;
@dynamic notes;
@dynamic order;
@dynamic axis;
@dynamic primary;
@dynamic dateEnded;
@dynamic status;
@dynamic medications;
@dynamic diagnosedBy;
@dynamic clients;
@dynamic specifiers;
@dynamic disorder;
@dynamic diagnosisLog;
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
