//
//  MedicationReviewEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "MedicationReviewEntity.h"
#import "ClinicianEntity.h"
#import "FrequencyEntity.h"
#import "MedicationEntity.h"
#import "SideEffectEntity.h"

@implementation MedicationReviewEntity

@dynamic doseChange;
@dynamic adherence;
@dynamic nextReview;
@dynamic keyString;
@dynamic dosage;
@dynamic notes;
@dynamic satisfaction;
@dynamic logDate;
@dynamic sxChange;
@dynamic lastDose;
@dynamic medication;
@dynamic sideEffects;
@dynamic prescriber;
@dynamic frequency;

- (void) awakeFromInsert
{
    [super awakeFromInsert];

    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];

    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];

    [self willAccessValueForKey:@"logDate"];
    if ([(NSDate *)self.logDate isEqualToDate : referenceDate])
    {
        [self didAccessValueForKey:@"logDate"];
        [self willChangeValueForKey:(NSString *)@"logDate"];
        self.logDate = [NSDate date];
        [self didChangeValueForKey:(NSString *)@"logDate"];
    }
}


@end
