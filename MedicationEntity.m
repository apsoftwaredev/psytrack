//
//  MedicationEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "MedicationEntity.h"
#import "AdditionalSymptomEntity.h"
#import "ClientEntity.h"
#import "DiagnosisHistoryEntity.h"
#import "MedicationReviewEntity.h"


@implementation MedicationEntity

@dynamic discontinued;
@dynamic keyString;
@dynamic productNo;
@dynamic notes;
@dynamic order;
@dynamic drugName;
@dynamic applNo;
@dynamic dateStarted;
@dynamic medLogs;
@dynamic symptomsTargeted;
@dynamic diagnoses;
@dynamic client;

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
