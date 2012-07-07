//
//  SupervisorsForMonth.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "SupervisorsAndTotalTimesForMonth.h"
#import "PTTAppDelegate.h"

@implementation SupervisorsAndTotalTimesForMonth
@synthesize  monthToDisplay;
@synthesize  clinicians;



-(id)initWithMonth:(NSDate *)date{

   self= [super init];
    
    if (self) {
        
        self.monthToDisplay=date;
        
    }

    return self;


}


-(NSTimeInterval )totalTimeIntervalForTotalTimeArray:(NSArray *)totalTimesArray{

     NSTimeInterval totalTime=0;
    if (totalTimesArray.count) {
        
       
        for (NSDate *totalTimeDateObject in totalTimesArray) {
            if (totalTimeDateObject&&[totalTimeDateObject isKindOfClass:[NSDate class]]) {
                
                totalTime=totalTime+[totalTimeDateObject timeIntervalSince1970];
                NSLog(@"time is %@",totalTimeDateObject);
                NSLog(@"total time is to be added is %e",[totalTimeDateObject timeIntervalSince1970]);
                
            }
        }
    }
        return totalTime;


}

-(NSDate *)monthStartDateForDate:(NSDate *)date{


    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDateComponents *startDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit) fromDate:date];
   
    [startDateComponents setDay:0]; //reset the other components
    
    NSDate *startDate = [calendar dateFromComponents:startDateComponents]; 
   
    return startDate;

}


-(NSDate *)monthEndDate:(NSDate *)date{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    NSDateComponents *endDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit) fromDate:date];
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit:NSMonthCalendarUnit
                                  forDate:date];
    
    [endDateComponents setDay:range.length];
    NSDate *endDate = [calendar dateFromComponents:endDateComponents];
    
    return endDate;

}

-(NSDate *)weekStartDate:(PTrackWeek )week{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSLog(@"date in monht is d %@",self.monthToDisplay);
    NSDateComponents *startDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSWeekCalendarUnit|NSDayCalendarUnit) fromDate:self.monthToDisplay];
    
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
    
    return startDate;
    






}
-(NSDate *)weekEndDate:(PTrackWeek )week{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSLog(@"date in monht is d %@",self.monthToDisplay);
    NSDateComponents *startDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSWeekCalendarUnit|NSDayCalendarUnit) fromDate:self.monthToDisplay];
    
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
    NSRange weekRange=[calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self.monthToDisplay];
    
    
    NSLog(@"week is %i",weekRange.length);
    NSDate *endDate = [calendar dateFromComponents:endDateComponents];
    
    
    return endDate;
    
    
    
    
}


-(NSArray *)interventionsArrayForClinician:(ClinicianEntity *) clinician{

   return [self fetchObjectsFromEntity:kTrackInterventionEntityName filterPredicate:[self allHoursPredicateForClincian:clinician]];



}
-(NSArray *)assessmentsArrayForClinician:(ClinicianEntity *) clinician{


return [self fetchObjectsFromEntity:kTrackAssessmentEntityName filterPredicate:[self allHoursPredicateForClincian:clinician]];

}
-(NSArray *)supportArrayForClinician:(ClinicianEntity *) clinician{

return [self fetchObjectsFromEntity:kTrackAssessmentEntityName filterPredicate:[self allHoursPredicateForClincian:clinician]];


}
-(NSArray *)supervisionReceivedArrayForClinician:(ClinicianEntity *) clinician {

return [self fetchObjectsFromEntity:kTrackAssessmentEntityName filterPredicate:[self allHoursPredicateForClincian:clinician]];

}





-(NSString *) totalCummulativeHoursForPTrackEntity:(PTrackEntity )pTrackEntity StrForClinician:(ClinicianEntity *)clinician{

   

   
    
   
}


-(NSPredicate *)allHoursPredicateForClincian:(ClinicianEntity *)clinician{
    
    NSPredicate *priorMonthsServiceDatesPredicate=nil;
    if (clinician) {
        priorMonthsServiceDatesPredicate=[NSPredicate predicateWithFormat:@"self.supervisor.objectID == %@ ",clinician];
        
    }
    
    return priorMonthsServiceDatesPredicate;
    
}

-(NSPredicate *)priorMonthsHoursPredicateForClincian:(ClinicianEntity *)clinician{

     NSPredicate *priorMonthsServiceDatesPredicate=nil;
    if (clinician) {
        priorMonthsServiceDatesPredicate=[NSPredicate predicateWithFormat:@"self.supervisor.objectID == %@ AND dateOfService < %@ ",clinician,[self monthStartDateForDate:self.monthToDisplay]];
        
    }else {
        priorMonthsServiceDatesPredicate=[NSPredicate predicateWithFormat:@"dateOfService < %@ ",[self monthStartDateForDate:self.monthToDisplay]];
        
        
    }

    return priorMonthsServiceDatesPredicate;

}


-(NSPredicate *)currentMonthsHoursPredicateForClincian:(ClinicianEntity *)clinician{
    
    NSPredicate *currentMonthPredicate=nil;
    
    if (clinician) {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil))",clinician.objectID, [self monthStartDateForDate:self.monthToDisplay],[self monthEndDate:self.monthToDisplay]];
    }
    else {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@" ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil) ", [self monthStartDateForDate:self.monthToDisplay],[self monthEndDate:self.monthToDisplay]];
    }
    
    return currentMonthPredicate;    
}



-(NSPredicate *)predicateForWeek:(PTrackWeek)week clincian:(ClinicianEntity *)clinician{
    
    NSPredicate *weekPredicate=nil;
    
    if (clinician) {
        weekPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil))",clinician.objectID, [self weekStartDate:week],[self weekEndDate:week]];
    }
    else {
        weekPredicate = [NSPredicate predicateWithFormat:@" ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil) ", [self weekStartDate:week],[self weekEndDate:week]];
    }
    
    return weekPredicate;
    
}




-(NSTimeInterval )totalTimeIntervalForMonthForPTrackEntityName:(NSString *)pTrackEntityName clinician:(ClinicianEntity *)clinician{

    NSArray *trackArray=nil;
    NSArray *totalTimeArray=nil;
    NSTimeInterval totalTimeInterval=0;
    
    NSPredicate *filterPredicate=[self currentMonthsHoursPredicateForClincian:clinician];
    
    trackArray=[self fetchObjectsFromEntity:pTrackEntityName filterPredicate:filterPredicate];
    totalTimeArray=[trackArray valueForKeyPath:@"time.totalTime"];
    if (totalTimeArray.count) {
         totalTimeInterval=[self totalTimeIntervalForTotalTimeArray:totalTimeArray];
    }
    
    return totalTimeInterval;

}

-(NSArray *)priorMonthsInterventionArrayForClinician:(ClinicianEntity *)clinician{

   
    
 return  [self fetchObjectsFromEntity:kTrackInterventionEntityName filterPredicate:[self priorMonthsHoursPredicateForClincian:clinician]];


}




-(NSArray *)priorMonthsAssessmentsArrayForClinician:(ClinicianEntity *)clinician{
    
    
    
    return  [self fetchObjectsFromEntity:@"AssessmentEntity" filterPredicate:[self priorMonthsHoursPredicateForClincian:clinician]];
    
    
}
-(NSArray *)priorMonthsSupportActivityArrayForClinician:(ClinicianEntity *)clinician{
    
    
    
    return  [self fetchObjectsFromEntity:@"SupportActivityDeliveredEntity" filterPredicate:[self priorMonthsHoursPredicateForClincian:clinician]];
    
    
}
-(NSArray *)priorMonthsSupervisionRecivedArrayForClinician:(ClinicianEntity *)clinician{
    
    
    
    return  [self fetchObjectsFromEntity:@"SupervisionReceivedEntity" filterPredicate:[self priorMonthsHoursPredicateForClincian:clinician]];
    
    
}



-(NSArray *)fetchObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate{
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    



    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:entityStr inManagedObjectContext:appDelegate.managedObjectContext];

    [fetchRequest setEntity:entity];
   
   
    if (filterPredicate) {
        [fetchRequest setPredicate:filterPredicate];
    }


    NSError *error = nil;
    NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    return fetchedObjects;

}


-(NSString *)timeStringFromPTrackWeek:(PTrackWeek)week entity:(PTrackEntity)pTrackEntity{

    NSArray *trackArray=nil;
    NSArray *totalTimeArray=nil;
    NSTimeInterval totalTimeInterval=0;
    
    NSPredicate *filterPredicate=[self predicateForWeek:(PTrackWeek)week clincian:nil];
    NSString *pTrackEntityName=nil;
    switch (pTrackEntity) {
        case kTrackIntervention:
            pTrackEntityName=kTrackInterventionEntityName;
            break;
        case kTrackAssessment:
            pTrackEntityName=kTrackAssessmentEntityName;
            break;
        case kTrackSupport:
            pTrackEntityName=kTrackSupportEntityName;
            break;
        case kTrackSupervisionReceived:
            pTrackEntityName=kTrackSupervisionReceivedEntityName;
            break;

        default:
            break;
    }
    
    
    trackArray=[self fetchObjectsFromEntity:pTrackEntityName filterPredicate:filterPredicate];
    totalTimeArray=[trackArray valueForKeyPath:@"time.totalTime"];
    if (totalTimeArray.count) {
        totalTimeInterval=[self totalTimeIntervalForTotalTimeArray:totalTimeArray];
    }
    
        
    return [self timeStrFromTimeInterval:totalTimeInterval];






}
-(NSString *)timeStrFromTimeInterval:(NSTimeInterval )totalTime{
    
     
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


-(NSString *) totalOverallHoursMonthStrForclinician:(ClinicianEntity *)clinician{}
-(NSString *) totalHoursToDateStrForClinician:(ClinicianEntity *)clinician{}

-(NSString *) totalWeekHoursStrForClinician:(ClinicianEntity *)clinician week:(PTrackWeek)week
{

}

-(NSString *) totalInterventionHoursStrForWeek:(PTrackWeek )week{}


-(NSString *) totalInterventionHoursMonthStrForClinician:(ClinicianEntity *)clinician{}
-(NSString *) totalInterventionHoursCummulativeStrForClinician:(ClinicianEntity *)clinician{}
-(NSString *) totalInterventionHoursToDateStrForClinician:(ClinicianEntity *)clinician{}

-(NSString *) totalAssessmentHoursStrForWeek:(NSInteger )week{}

-(NSString *) totalAssessmentHoursMonthStrForClinician:(ClinicianEntity *)clinician{}
-(NSString *) totalAssessmentHoursCummulativeStrForClinician:(ClinicianEntity *)clinician{}
-(NSString *) totalAssessmentHoursToDateStrForClinician:(ClinicianEntity *)clinician{}



-(NSString *) totalDirectHoursStrForWeek:(NSInteger )week{}

-(NSString *) totalDirectHoursMonthStrForClinician:(ClinicianEntity *)clinician{}
-(NSString *) totalDirectHoursCummulativeStrForClinician:(ClinicianEntity *)clinician{}
-(NSString *) totalDirectHoursToDateStrForClinician:(ClinicianEntity *)clinician{}







-(NSString *) totalSupportHoursWeek1Str{}
-(NSString *) totalSupportHoursWeek2Str{}
-(NSString *) totalSupportHoursWeek3Str{}
-(NSString *) totalSupportHoursWeek4Str{}
-(NSString *) totalSupportHoursWeek5Str{}
-(NSString *) totalSupportHoursWeekUndefinedStr{}
-(NSString *) totalSupportHoursMonthStrForClinician:(ClinicianEntity *)clinician{}
-(NSString *) totalSupportHoursCummulativeStrForClinician:(ClinicianEntity *)clinician{}
-(NSString *) totalSupportHoursToDateStrForClinician:(ClinicianEntity *)clinician{}



-(NSString *) totalSupervisionHoursWeek1Str{}
-(NSString *) totalSupervisionHoursWeek2Str{}
-(NSString *) totalSupervisionHoursWeek3Str{}
-(NSString *) totalSupervisionHoursWeek4Str{}
-(NSString *) totalSupervisionHoursWeek5Str{}
-(NSString *) totalSupervisionHoursMonthStrForClinician:(ClinicianEntity *)clinician{}
-(NSString *) totalSupervisionHoursCummulativeStrForClinician:(ClinicianEntity *)clinician{}
-(NSString *) totalSupervisionHoursToDateStrForClinician:(ClinicianEntity *)clinician{}




@end
