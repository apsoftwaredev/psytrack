//
//  VitalsEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "VitalsEntity.h"
#import "ClientEntity.h"

@implementation VitalsEntity

@dynamic weight;
@dynamic heightTall;
@dynamic heartRate;
@dynamic diastolicPressure;
@dynamic temperature;
@dynamic weightUnit;
@dynamic heightUnit;
@dynamic systolicPressure;
@dynamic dateTaken;
@dynamic client;

- (void) awakeFromInsert
{
    [super awakeFromInsert];

    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];

    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];

    if ([(NSDate *)self.dateTaken isEqualToDate : referenceDate])
    {
        self.dateTaken = [NSDate date];
    }

    dateFormatter = nil;
}


@end
