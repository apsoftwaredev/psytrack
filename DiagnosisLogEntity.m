//
//  DiagnosisLogEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "DiagnosisLogEntity.h"
#import "AdditionalSymptomNameEntity.h"
#import "DiagnosisHistoryEntity.h"


@implementation DiagnosisLogEntity

@dynamic frequency;
@dynamic onset;
@dynamic order;
@dynamic notes;
@dynamic prognosis;
@dynamic logDate;
@dynamic severity;
@dynamic symptoms;
@dynamic diagnosisHistory;


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
