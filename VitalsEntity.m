//
//  VitalsEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 3/24/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "VitalsEntity.h"
#import "ClientEntity.h"


@implementation VitalsEntity

@dynamic diastolicPressure;
@dynamic heightTall;
@dynamic heightUnit;
@dynamic weight;
@dynamic weightUnit;
@dynamic systolicPressure;
@dynamic dateTaken;
@dynamic heartRate;
@dynamic temperature;
@dynamic client;

- (void) awakeFromInsert 
{
    [super awakeFromInsert];
    
    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];
    
    
    if ([(NSDate *)self.dateTaken isEqualToDate:referenceDate]) {
        self.dateTaken = [NSDate date];
        
    }
    dateFormatter=nil;
}


@end
