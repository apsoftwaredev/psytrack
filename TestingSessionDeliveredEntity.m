//
//  TestingSessionDeliveredEntity.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/23/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "TestingSessionDeliveredEntity.h"
#import "ClinicianEntity.h"
#import "TimeEntity.h"


@implementation TestingSessionDeliveredEntity

@dynamic eventIdentifier;
@dynamic notes;
@dynamic order;
@dynamic dateOfTesting;
@dynamic paperwork;
@dynamic supervisor;
@dynamic trainingType;
@dynamic administrationType;
@dynamic time;
@dynamic relatedSupportTime;
@dynamic licenseNumbersCredited;
@dynamic degreesCredited;
@dynamic clientPresentations;
@dynamic treatmentSetting;
@dynamic testsAdministered;
@dynamic site;
@dynamic certificationsCredited;


- (void) awakeFromInsert 
{
    [super awakeFromInsert];
    
    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];
    NSLog(@"reference date %@",referenceDate);
    if ([(NSDate *)self.dateOfTesting isEqualToDate:referenceDate]) {
        self.dateOfTesting = [NSDate date];
        
    }
}

@end