//
//  InterventionTypeSubtypeEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/21/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "InterventionTypeSubtypeEntity.h"
#import "InterventionDeliveredEntity.h"
#import "TimeEntity.h"
#import "PTTAppDelegate.h"


@implementation InterventionTypeSubtypeEntity

@dynamic interventionSubType;
@dynamic order;
@dynamic notes;
@dynamic interventionType;
@dynamic interventionDelivered;


-(NSString *)week1TotalHoursForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{

    
    return [self weekTotalHoursForMonthStr:(NSDate *)dateInMonth week:(NSInteger )0 clinician:(ClinicianEntity*)clinician];        
    
    
 

}
-(int )totalHours:(NSTimeInterval) totalTime{


    return totalTime/3600;

}

-(int )totalMinutes:(NSTimeInterval) totalTime{
    
    
    return round(((totalTime/3600) -[self totalHours:totalTime])*60);;
    
}

-(NSString *)week2TotalHoursForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{

    return [self weekTotalHoursForMonthStr:(NSDate *)dateInMonth week:(NSInteger )1 clinician:(ClinicianEntity*)clinician]; 





}
-(NSString *)week3TotalHoursForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{

    return [self weekTotalHoursForMonthStr:(NSDate *)dateInMonth week:(NSInteger )2 clinician:(ClinicianEntity*)clinician]; 




}
-(NSString *)week4TotalHoursForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{
    return [self weekTotalHoursForMonthStr:(NSDate *)dateInMonth week:(NSInteger )3 clinician:(ClinicianEntity*)clinician]; 

}
-(NSString *)week5TotalHoursForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{

 return [self weekTotalHoursForMonthStr:(NSDate *)dateInMonth week:(NSInteger )4 clinician:(ClinicianEntity*)clinician]; 


}
-(NSString *)unknownWeekTotalHoursForMonthStr:(NSDate *)dateInMonth{}
-(NSString *)monthTotalHoursForMonthStr:(NSDate *)dateInMonth{}
-(NSString *)previousMonthCumulativeForMonthStr:(NSDate *)dateInMonth{}
-(NSString *)totalHoursToDateForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{

    NSTimeInterval totalTime=[self monthTotalHoursForMonthTI:dateInMonth  clinician:(ClinicianEntity*)clinician];
                   
       
    
        if (totalTime) {
            int totalHours =totalTime/3600;
            NSLog(@"total hours float is %i",totalHours);
            int totalMinutes=round(((totalTime/3600) -totalHours)*60);
            NSLog(@"total minutes is %i",totalMinutes);
            if (totalMinutes<10) {
                return [NSString stringWithFormat:@"%i:0%i",totalHours,totalMinutes];
            }
            else {
                 return [NSString stringWithFormat:@"%i:%i",totalHours,totalMinutes];
            }
           
           
        }
        
    
   
    
    

return @"0:00";


}

-(NSTimeInterval )weekTotalHoursForMonthTI:(NSDate *)dateInMonth week:(NSInteger )week clinician:(ClinicianEntity*)clinician{


    NSCalendar *calendar = [NSCalendar currentCalendar];
    
     [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSLog(@"date in monht is d %@",dateInMonth);
    NSDateComponents *startDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSWeekCalendarUnit|NSDayCalendarUnit) fromDate:dateInMonth];
   
    //create week
    startDateComponents.day=1;
    startDateComponents.hour=0;
    startDateComponents.minute=0;
    startDateComponents.second=0;
    NSDateComponents *week2StartDateComponents=[[NSDateComponents alloc]init];
    week2StartDateComponents.week=week;
    week2StartDateComponents.hour=0;
    week2StartDateComponents.minute=0;
    week2StartDateComponents.month=0;
    week2StartDateComponents.year=0;
    
    NSLog(@"week is %i",startDateComponents.week);
    NSLog(@"week 2 startdate cfrom compnents %@",[calendar dateByAddingComponents:week2StartDateComponents toDate:[calendar dateFromComponents:startDateComponents] options:0]);
   
    
    //create a date with these components
    NSRange rangeWeek = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit:NSWeekCalendarUnit
                                  forDate:[calendar dateByAddingComponents:week2StartDateComponents toDate:[calendar dateFromComponents:startDateComponents] options:0]];
    NSLog(@"range week day %d", rangeWeek.location);
    
    NSLog(@"range week end day %d",rangeWeek.location+rangeWeek.length-1);
  
    [startDateComponents setDay:rangeWeek.location]; //reset the other components
   
    NSDate *startDate = [calendar dateFromComponents:startDateComponents]; 
    NSDateComponents *endDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSWeekCalendarUnit|NSDayCalendarUnit) fromDate:startDate];
    
    [endDateComponents setDay:rangeWeek.location+rangeWeek.length];
    NSRange weekRange=[calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:dateInMonth];
    
    
    NSLog(@"week is %i",weekRange.length);
    NSDate *endDate = [calendar dateFromComponents:endDateComponents];
    
    NSLog(@"start date is %@ and end date is %@",startDate, endDate);
    NSPredicate *currentWeekPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND ((dateOfService >= %@) AND (dateOfService < %@)) || (dateOfService = nil) )",clinician.objectID, startDate,endDate];
    NSLog(@"clinicina is %@",clinician);
    
   
    NSArray *interventionDeliveredArray=self.interventionDelivered.allObjects ;
    NSLog(@"intervention delivered array is %@",interventionDeliveredArray);
 
    if (interventionDeliveredArray.count) {
      
        NSArray *totalTimesArray=[(NSArray *)[self.interventionDelivered.allObjects filteredArrayUsingPredicate:currentWeekPredicate ]  valueForKeyPath:@"time.totalTime"];
        NSTimeInterval totalTime=0;
        if (totalTimesArray.count) {
       
        for (NSDate *totalTimeDateObject in totalTimesArray) {
            if (totalTimeDateObject&&[totalTimeDateObject isKindOfClass:[NSDate class]]) {
                 NSLog(@"time is %@",totalTimeDateObject);
                totalTime=totalTime+[totalTimeDateObject timeIntervalSince1970];
               
                NSLog(@"total time is to be added is %e",[totalTimeDateObject timeIntervalSince1970]);
                
            }
        }
    return totalTime;
        }
    }
return 0;       




}


-(NSString * )weekTotalHoursForMonthStr:(NSDate *)dateInMonth week:(NSInteger )week clinician:(ClinicianEntity*)clinician{






    NSTimeInterval totalTime=[self weekTotalHoursForMonthTI:(NSDate *)dateInMonth week:(NSInteger )week clinician:(ClinicianEntity*)clinician];
    if (totalTime) {
        
        int totalMinutes=[self totalMinutes:totalTime];
        NSLog(@"total minutes is %i",totalMinutes);
        if (totalMinutes<10) {
            return [NSString stringWithFormat:@"%i:0%i",[self totalHours:totalTime],totalMinutes];
        }
        else {
            return [NSString stringWithFormat:@"%i:%i",[self totalHours:totalTime],totalMinutes];
        }
        
        
    }
    
    
    
    
    
    
    return @"0:00";
    



}


-(NSTimeInterval )week1TotalHoursForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{
   return [self weekTotalHoursForMonthTI:dateInMonth week:0 clinician:(ClinicianEntity*)clinician];

}
-(NSTimeInterval )week2TotalHoursForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{

    return [self weekTotalHoursForMonthTI:dateInMonth week:1 clinician:(ClinicianEntity*)clinician];





}
-(NSTimeInterval )week3TotalHoursForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{

 return [self weekTotalHoursForMonthTI:dateInMonth week:2 clinician:(ClinicianEntity*)clinician];


}
-(NSTimeInterval )week4TotalHoursForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{

     return [self weekTotalHoursForMonthTI:dateInMonth week:3 clinician:(ClinicianEntity*)clinician];

}
-(NSTimeInterval )week5TotalHoursForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{
    return [self weekTotalHoursForMonthTI:dateInMonth week:4 clinician:(ClinicianEntity*)clinician];


}
-(NSTimeInterval )unknownWeekTotalHoursForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{}
-(NSTimeInterval )monthTotalHoursForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{

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
    NSPredicate *currentMonthPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil))",clinician.objectID, startDate,endDate];
    
    
    
    
    NSArray *filteredArray= [self.interventionDelivered.allObjects filteredArrayUsingPredicate:currentMonthPredicate];
    //    if (filteredArray.count) {
    //         NSLog(@"interventions delivered are %@",interventionDeliveredArray);
    //        NSLog(@"filtered array is %@",[filteredArray valueForKeyPath:@"time.totalTime"]);
    //        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    //        NSEntityDescription *entity=[NSEntityDescription entityForName:@"InterventionDeliveredEntity" inManagedObjectContext:appDelegate.managedObjectContext];
    //
    //        for (int i=0; i<10; i++) {
    //            InterventionDeliveredEntity *interventionToAdd=[[InterventionDeliveredEntity alloc]initWithEntity:entity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
    //            InterventionDeliveredEntity *firstInterventionDeliveredInArray=[filteredArray objectAtIndex:0];
    //            
    //            interventionToAdd.interventionType=firstInterventionDeliveredInArray.interventionType;
    //            interventionToAdd.subtype=firstInterventionDeliveredInArray.subtype;
    //            interventionToAdd.dateOfService=firstInterventionDeliveredInArray.dateOfService;
    //            NSEntityDescription *timeDesc=[NSEntityDescription entityForName:@"TimeEntity" inManagedObjectContext:appDelegate.managedObjectContext];
    //            TimeEntity *timeToAdd=[[TimeEntity alloc]initWithEntity:timeDesc insertIntoManagedObjectContext:appDelegate.managedObjectContext];
    //            interventionToAdd.time=timeToAdd;
    //            NSDateComponents *twoYearDateComponents=[[NSDateComponents alloc]init];
    //            twoYearDateComponents.year=1970;
    //            twoYearDateComponents.month=1;
    //            twoYearDateComponents.day=1;
    //            twoYearDateComponents.hour=1;
    //            twoYearDateComponents.minute=00;
    //            [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    //            timeToAdd.totalTime=[calendar dateFromComponents:twoYearDateComponents];
    //            NSLog(@"time to add is %@",timeToAdd.totalTime);
    //        }
    
    
    NSArray *totalTimesArray=(NSArray *)[filteredArray valueForKeyPath:@"time.totalTime"];
    if (totalTimesArray.count) {
        
        NSTimeInterval totalTime=0;
        for (NSDate *totalTimeDateObject in totalTimesArray) {
            if (totalTimeDateObject&&[totalTimeDateObject isKindOfClass:[NSDate class]]) {
                
                totalTime=totalTime+[totalTimeDateObject timeIntervalSince1970];
                NSLog(@"time is %@",totalTimeDateObject);
                NSLog(@"total time is to be added is %e",[totalTimeDateObject timeIntervalSince1970]);
                
            }
        }
    return totalTime;
        
    }
    return 0;





}
-(NSTimeInterval )previousMonthCumulativeForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{}
-(NSTimeInterval )totalHoursToDateForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician{}



@end
