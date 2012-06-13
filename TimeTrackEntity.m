//
//  TimeTrackEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/6/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "TimeTrackEntity.h"
#import "ClinicianEntity.h"


@implementation TimeTrackEntity

@dynamic order;
@dynamic notes;
@dynamic eventIdentifier;
@dynamic dateOfService;
@dynamic site;
@dynamic supervisor;
@dynamic trainingType;


-(void)awakeFromInsert{

 

        [super awakeFromInsert];
        
        //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        
        [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
        NSDate *referenceDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];
        //NSLog(@"reference date %@",referenceDate);
        [self willAccessValueForKey:@"dateOfService"];
        if ([(NSDate *)self.dateOfService isEqualToDate:referenceDate]) {
            [self didAccessValueForKey:@"dateOfService"];
            
            [self willChangeValueForKey:@"dateOfService"];
            self.dateOfService = [NSDate date];
            [self didChangeValueForKey:@"dateOfService"];
            
        }




}


@end