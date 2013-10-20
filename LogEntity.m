//
//  LogEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "LogEntity.h"
#import "ClientEntity.h"
#import "ClinicianEntity.h"
#import "ConferenceEntity.h"
#import "ConsultationEntity.h"
#import "TrainingProgramEntity.h"

@implementation LogEntity

@dynamic notes;
@dynamic keyString;
@dynamic dateTime;
@dynamic teachingExperience;
@dynamic communityService;
@dynamic trainingProgram;
@dynamic license;
@dynamic advisingGiven;
@dynamic clinician;
@dynamic expertTestemony;
@dynamic consultations;
@dynamic presentation;
@dynamic course;
@dynamic conference;
@dynamic grant;
@dynamic client;
@dynamic otherActivity;

- (void) awakeFromInsert
{
    [super awakeFromInsert];

    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];

    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];

    [self willAccessValueForKey:@"endDate"];
    if ([(NSDate *)self.dateTime isEqualToDate : referenceDate])
    {
        [self didAccessValueForKey:@"dateTime"];
        [self willChangeValueForKey:(NSString *)@"dateTime"];
        self.dateTime = [NSDate date];
        [self didChangeValueForKey:(NSString *)@"dateTime"];
    }

    dateFormatter = nil;
}


@end
