//
//  ExistingAssessmentEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ExistingAssessmentEntity.h"
#import "AssessmentTypeEntity.h"
#import "ExistingBatteryEntity.h"
#import "ExistingDemographicsEntity.h"
#import "ExistingHoursEntity.h"
#import "ExistingInstrumentEntity.h"


@implementation ExistingAssessmentEntity

@dynamic monthlyLogNotes;
@dynamic notes;
@dynamic hours;
@dynamic instruments;
@dynamic assessmentType;
@dynamic demographics;
@dynamic existingHours;
@dynamic batteries;


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
