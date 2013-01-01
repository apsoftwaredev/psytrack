//
//  ExistingInstrumentEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ExistingInstrumentEntity.h"
#import "ExistingAssessmentEntity.h"
#import "InstrumentEntity.h"


@implementation ExistingInstrumentEntity

@dynamic numberAdminstered;
@dynamic numberOfReportsWritten;
@dynamic notes;
@dynamic administeredScoredAndReport;
@dynamic instrument;
@dynamic existingAssessment;

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
