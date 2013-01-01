//
//  AdditionalSymptomEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "AdditionalSymptomEntity.h"
#import "FrequencyEntity.h"
#import "MedicationEntity.h"


@implementation AdditionalSymptomEntity

@dynamic onset;
@dynamic order;
@dynamic notes;
@dynamic severity;
@dynamic frequency;
@dynamic symptomName;
@dynamic medicationReview;

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
