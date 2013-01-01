//
//  FrequencyEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "FrequencyEntity.h"
#import "AdditionalSymptomEntity.h"
#import "DiagnosisHistoryEntity.h"
#import "MedicationReviewEntity.h"


@implementation FrequencyEntity

@dynamic frequencyUnit;
@dynamic order;
@dynamic frequencyUnitLength;
@dynamic frequencyNumber;
@dynamic numberOfTimes;
@dynamic timeOfDay;
@dynamic duration;
@dynamic symptoms;
@dynamic medicationUse;
@dynamic substanceUse;
@dynamic diagnosis;

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
