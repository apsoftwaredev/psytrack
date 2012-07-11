//
//  InterventionTypeEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/21/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "InterventionTypeEntity.h"
#import "InterventionDeliveredEntity.h"
#import "InterventionTypeSubtypeEntity.h"


@implementation InterventionTypeEntity

@dynamic order;
@dynamic notes;
@dynamic interventionType;
@dynamic interventionsDelivered;
@dynamic subTypes;
@dynamic existingInterventions;



-(NSString *)monthlyLogNotesForMonth:(NSDate *)dateInMonth clinician:(ClinicianEntity *)clinician{


    NSCalendar *calendar = [NSCalendar currentCalendar];
   
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDateComponents *startDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit) fromDate:dateInMonth];
    //create a date with these components
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit:NSMonthCalendarUnit
                                  forDate:dateInMonth];
    NSLog(@"%d", range.length);
    [startDateComponents setDay:0]; //reset the other components
    
    NSDate *startDate = [calendar dateFromComponents:startDateComponents]; 
    NSDateComponents *endDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit) fromDate:dateInMonth];
    
    [endDateComponents setDay:range.length];
    NSDate *endDate = [calendar dateFromComponents:endDateComponents];
    NSPredicate *currentMonthPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ )AND ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil)) ",clinician.objectID, startDate,endDate];
    
    NSLog(@"clinicina object id is %@",clinician.objectID);
    
    NSArray *filteredArray=nil;
    [self willAccessValueForKey:@"interventionDelivered"];
    if (self.interventionsDelivered &&self.interventionsDelivered.count&&currentMonthPredicate) {
        filteredArray=  [self.interventionsDelivered.allObjects filteredArrayUsingPredicate:currentMonthPredicate];
    }
    
 
    NSLog(@"filtered array new is %@",filteredArray);
    InterventionDeliveredEntity *checkInterventionDelivered=nil;
    if (filteredArray.count) {
        checkInterventionDelivered=[filteredArray objectAtIndex:0];
    }
   
    NSLog(@"check intervention delivered %@",checkInterventionDelivered);
    
    
    
    NSString *monthlyLogNotes=nil;
    int filteredArrayCount=filteredArray.count;
    if (filteredArrayCount) {
        
        NSArray *monthlyLogNotesArray=[filteredArray valueForKey:@"monthlyLogNotes"];
        int monthlyLogNotesArrayCount=monthlyLogNotesArray.count;
        for ( int i=0;i< monthlyLogNotesArrayCount; i++){
           
        
            id logNotesID=[monthlyLogNotesArray objectAtIndex:i];
                if ([logNotesID isKindOfClass:[NSString class]]) {
                    NSString *logNotesStr=(NSString *)logNotesID;
                    if (i==0) {
                        monthlyLogNotes=logNotesStr;
                    }
                    else {
                        monthlyLogNotes=[monthlyLogNotes stringByAppendingFormat:@"; %@",logNotesStr];
                    }
            }
        }
        return monthlyLogNotes;
    }

    return [NSString string];


}




@end
