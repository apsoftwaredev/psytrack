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
@synthesize interventionsDeliveredArray=interventionsDeliveredArray_,
assessmentsDeliveredArray=assessmentsDeliveredArray_,
supportActivityDeliveredArray=supportActivityDeliveredArray_,
supervisionReceivedArray=supervisionReceivedArray_,
existingHoursHoursArray=existingHoursArray_;


@synthesize monthStartDate=monthStartDate_, monthEndDate=monthEndDate_;

@synthesize week1StartDate=week1StartDate_;
@synthesize week1EndDate=week1EndDate_;
@synthesize week2StartDate=week2StartDate_;
@synthesize week2EndDate=week2EndDate_;
@synthesize week3StartDate=week3StartDate_;
@synthesize week3EndDate=week3EndDate_;
@synthesize week4StartDate=week4StartDate_;
@synthesize week4EndDate=week4EndDate_;
@synthesize week5StartDate=week5StartDate_;
@synthesize week5EndDate=week5EndDate_;




@synthesize interventionTotalWeek1Str;
@synthesize interventionTotalWeek2Str;
@synthesize interventionTotalWeek3Str;
@synthesize interventionTotalWeek4Str;
@synthesize interventionTotalWeek5Str;

@synthesize interventionTotalWeek1TI;
@synthesize interventionTotalWeek2TI;
@synthesize interventionTotalWeek3TI;
@synthesize interventionTotalWeek4TI;
@synthesize interventionTotalWeek5TI;


@synthesize interventionTotalWeekUndefinedStr;
@synthesize interventionTotalWeekUndefinedTI;

@synthesize interventionTotalForMonthStr;
@synthesize interventionTotalForMonthTI;


@synthesize interventionTotalCummulativeStr;
@synthesize interventionTotalCummulativeTI;

@synthesize interventionTotalToDateStr;
@synthesize interventionTotalToDateTI;



@synthesize assessmentTotalWeek1Str;
@synthesize assessmentTotalWeek2Str;
@synthesize assessmentTotalWeek3Str;
@synthesize assessmentTotalWeek4Str;
@synthesize assessmentTotalWeek5Str;

@synthesize assessmentTotalWeek1TI;
@synthesize assessmentTotalWeek2TI;
@synthesize assessmentTotalWeek3TI;
@synthesize assessmentTotalWeek4TI;
@synthesize assessmentTotalWeek5TI;

@synthesize assessmentTotalWeekUndefinedStr;
@synthesize assessmentTotalWeekUndefinedTI;

@synthesize assessmentTotalForMonthStr;
@synthesize assessmentTotalForMonthTI;


@synthesize assessmentTotalCummulativeStr;
@synthesize assessmentTotalCummulativeTI;

@synthesize assessmentTotalToDateStr;
@synthesize assessmentTotalToDateTI;


@synthesize supportTotalWeek1Str;
@synthesize supportTotalWeek2Str;
@synthesize supportTotalWeek3Str;
@synthesize supportTotalWeek4Str;
@synthesize supportTotalWeek5Str;

@synthesize supportTotalWeek1TI;
@synthesize supportTotalWeek2TI;
@synthesize supportTotalWeek3TI;
@synthesize supportTotalWeek4TI;
@synthesize supportTotalWeek5TI;


@synthesize supportTotalWeekUndefinedStr;
@synthesize supportTotalWeekUndefinedTI;

@synthesize supportTotalForMonthStr;
@synthesize supportTotalForMonthTI;


@synthesize supportTotalCummulativeStr;
@synthesize supportTotalCummulativeTI;

@synthesize supportTotalToDateStr;
@synthesize supportTotalToDateTI;


@synthesize supervisionTotalWeek1Str;
@synthesize supervisionTotalWeek2Str;
@synthesize supervisionTotalWeek3Str;
@synthesize supervisionTotalWeek4Str;
@synthesize supervisionTotalWeek5Str;

@synthesize supervisionTotalWeek1TI;
@synthesize supervisionTotalWeek2TI;
@synthesize supervisionTotalWeek3TI;
@synthesize supervisionTotalWeek4TI;
@synthesize supervisionTotalWeek5TI;


@synthesize supervisionTotalWeekUndefinedStr;
@synthesize supervisionTotalWeekUndefinedTI;

@synthesize supervisionTotalForMonthStr;
@synthesize supervisionTotalForMonthTI;


@synthesize supervisionTotalCummulativeStr;
@synthesize supervisionTotalCummulativeTI;

@synthesize supervisionTotalToDateStr;
@synthesize supervisionTotalToDateTI;



@synthesize directTotalWeek1Str;
@synthesize directTotalWeek2Str;
@synthesize directTotalWeek3Str;
@synthesize directTotalWeek4Str;
@synthesize directTotalWeek5Str;

@synthesize directTotalWeek1TI;
@synthesize directTotalWeek2TI;
@synthesize directTotalWeek3TI;
@synthesize directTotalWeek4TI;
@synthesize directTotalWeek5TI;


@synthesize directTotalWeekUndefinedStr;
@synthesize directTotalWeekUndefinedTI;

@synthesize directTotalForMonthStr;
@synthesize directTotalForMonthTI;

@synthesize directTotalCummulativeStr;
@synthesize directTotalCummulativeTI;

@synthesize directTotalToDateStr;
@synthesize directTotalToDateTI;


@synthesize overallTotalWeek1Str;
@synthesize overallTotalWeek2Str;
@synthesize overallTotalWeek3Str;
@synthesize overallTotalWeek4Str;
@synthesize overallTotalWeek5Str;

@synthesize overallTotalWeek1TI;
@synthesize overallTotalWeek2TI;
@synthesize overallTotalWeek3TI;
@synthesize overallTotalWeek4TI;
@synthesize overallTotalWeek5TI;


@synthesize overallTotalWeekUndefinedStr;
@synthesize overallTotalWeekUndefinedTI;

@synthesize overallTotalCummulativeStr;
@synthesize overallTotalCummulativeTI;

@synthesize overallTotalToDateStr;
@synthesize overallTotalToDateTI;

@synthesize overallTotalForMonthStr;
@synthesize overallTotalForMonthTI;






-(id)initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician{

   self= [super init];
    
    if (self) {
        
        self.monthToDisplay=date;
        self.monthStartDate=[self monthStartDateForDate:date];
        self.monthEndDate=[self monthEndDate:date];
       
        self.week1StartDate=[self weekStartDate:kTrackWeekOne];
        self.week1EndDate=[self weekEndDate:kTrackWeekOne];
        self.week2StartDate=[self weekStartDate:kTrackWeekTwo];
        self.week2EndDate=[self weekEndDate:kTrackWeekTwo];
        self.week3StartDate=[self weekStartDate:kTrackWeekThree];
        self.week3EndDate=[self weekEndDate:kTrackWeekThree];
        self.week4StartDate=[self weekStartDate:kTrackWeekFour];
        self.week4EndDate=[self weekEndDate:kTrackWeekFour];
        self.week5StartDate=[self weekStartDate:kTrackWeekFive];
        self.week5EndDate=[self weekEndDate:kTrackWeekFive];
        
        
        
        
        NSPredicate *predicateForTrackEntities=[self predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth:(NSDate *)date];
        
        self.interventionsDeliveredArray=[self fetchObjectsFromEntity:kTrackInterventionEntityName filterPredicate:predicateForTrackEntities];
        
        self.assessmentsDeliveredArray=[self fetchObjectsFromEntity:kTrackAssessmentEntityName filterPredicate:predicateForTrackEntities];
        
        self.supportActivityDeliveredArray=[self fetchObjectsFromEntity:kTrackSupportEntityName filterPredicate:predicateForTrackEntities];
        
        self.supervisionReceivedArray=[self fetchObjectsFromEntity:kTrackSupervisionReceivedEntityName filterPredicate:predicateForTrackEntities];
        
        self.existingHoursHoursArray=[self fetchObjectsFromEntity:kTrackExistingHoursEntityName filterPredicate:[self predicateForExistingHoursAllBeforeAndEqualToEndDateForMonth:date]];
        
       
        
        
        
        self.overallTotalWeek1TI=[self totalOverallHoursTIForOveralCell:kSummaryWeekOne clinician:clinician];
        self.overallTotalWeek2TI=[self totalOverallHoursTIForOveralCell:kSummaryWeekTwo clinician:clinician];
        self.overallTotalWeek3TI=[self totalOverallHoursTIForOveralCell:kSummaryWeekThree clinician:clinician];
        self.overallTotalWeek4TI=[self totalOverallHoursTIForOveralCell:kSummaryWeekFour clinician:clinician];
        self.overallTotalWeek5TI=[self totalOverallHoursTIForOveralCell:kSummaryWeekFive clinician:clinician];
        self.overallTotalWeekUndefinedTI=[self totalOverallHoursTIForOveralCell:kSummaryWeekUndefined clinician:clinician];
        self.overallTotalForMonthTI=[self totalOverallHoursTIForOveralCell:kSummaryTotalForMonth clinician:clinician];
        self.overallTotalCummulativeTI =[self totalOverallHoursTIForOveralCell:kSummaryCummulative clinician:(ClinicianEntity *)clinician];
        self.overallTotalToDateTI=[self totalOverallHoursTIForOveralCell:kSummaryTotalToDate clinician:clinician];
        
        [self calculateDirectlHours];
        
        
        
        
        
    }

    return self;


}


-(NSTimeInterval )totalTimeIntervalForTotalTimeArray:(NSArray *)totalTimesArray{

     NSTimeInterval totalTime=0;
    if (totalTimesArray&&totalTimesArray.count) {
        
       
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


-(NSDate *)storedStartDateForWeek:(PTrackWeek)week{

    NSDate *returnDate=nil;
    switch (week) {
        case kTrackWeekOne:
            returnDate =week1StartDate_;
            break;
        case kTrackWeekTwo:
            returnDate =week2StartDate_;
            break;
        case kTrackWeekThree:
            returnDate =week3StartDate_;
            break;
        case kTrackWeekFour:
            returnDate =week4StartDate_;
            break;
        case kTrackWeekFive:
            returnDate= week5StartDate_;
            break;
        default:
            break;
    }





    return returnDate;


}

-(NSDate *)storedEndDateForWeek:(PTrackWeek)week{
    
    NSDate *returnDate=nil;
    switch (week) {
        case kTrackWeekOne:
            returnDate =week1EndDate_;
            break;
        case kTrackWeekTwo:
            returnDate =week2EndDate_;
            break;
        case kTrackWeekThree:
            returnDate =week3EndDate_;
            break;
        case kTrackWeekFour:
            returnDate =week4EndDate_;
            break;
        case kTrackWeekFive:
            returnDate= week5EndDate_;
            break;
        default:
            break;
    }
    
    
    
    
    
    return returnDate;
    
    
}




-(int )totalHours:(NSTimeInterval) totalTime{
    
    
    return totalTime/3600;
    
}

-(int )totalMinutes:(NSTimeInterval) totalTime{
    
    
    return round(((totalTime/3600) -[self totalHours:totalTime])*60);
    
}

-(NSString *)totalTimeStr:(NSTimeInterval )totalTimeTI{

    NSString *returnString=nil;
    
    if (totalTimeTI>0) {
        NSString *hoursStr=[NSString stringWithFormat:@"%i:",[self totalHours:totalTimeTI]];
        
        int minutes=[self totalMinutes:totalTimeTI];
        NSString *minutesStr=nil;
        
        if (minutes<10) {
            minutesStr=[NSString stringWithFormat:@"0%i", minutes];
        }
        else {
            minutesStr=[NSString stringWithFormat:@"%i",minutes];
            
        }
        returnString=[hoursStr stringByAppendingString:minutesStr];
        
    }
    else {
        returnString=@"0:00";
    }
    
    return returnString;



}

//-(NSString *) totalCummulativeHoursForPTrackEntity:(PTrackEntity )pTrackEntity StrForClinician:(ClinicianEntity *)clinician{
//    
//    
//    NSArray *entityArray=nil;
//    
//    switch (pTrackEntity) {
//        case kTrackIntervention:
//            entityArray=interventionsDeliveredArray_;
//            
//            break;
//        case kTrackAssessment:
//            entityArray=assessmentsDeliveredArray_;
//            
//            break; 
//        case kTrackSupport:
//            entityArray=supportActivityDeliveredArray_;
//            
//            break;
//        case kTrackSupervisionReceived:
//            entityArray=supervisionReceivedArray_;
//            
//            break;
//        default:
//            break;
//    }
//    
//    
//    
//
//    NSPredicate *trackPredicate=[self priorMonthsHoursPredicateForClincian:clinician];
//   
//    
//    NSArray *filteredTrackObjects=[entityArray filteredArrayUsingPredicate:(NSPredicate *)trackPredicate];
//    
//    NSArray *trackTotalTimeArray=[filteredTrackObjects valueForKeyPath:@"time.totalTime"];
//
//    
//    NSTimeInterval trackTotalTimeInterval=[self totalTimeIntervalForTotalTimeArray:trackTotalTimeArray];
//    
//    
//    
//    NSPredicate *existingHoursPredicate=[self predicateForExistingHoursAllBeforeEndDate:monthStartDate_];
//    
//    
//    NSArray *filteredExistingHoursArray=[existingHoursArray_ filteredArrayUsingPredicate:existingHoursPredicate];
//    
//       NSTimeInterval totalTimeInterval=0;
//    
//    switch (pTrackEntity) {
//        case kTrackIntervention:
//        { NSArray *existingInterventionHoursArray=[filteredExistingHoursArray valueForKeyPath:kTrackKeyPathForExistingHoursInterventionHours];
//            
//            totalTimeInterval=[self totalTimeIntervalForTotalTimeArray:existingInterventionHoursArray];
//            
//            
//            break;
//        }
//        case kTrackAssessment:
//        {
//            NSArray *existingAssessmentHoursArray=[filteredExistingHoursArray valueForKeyPath:kTrackKeyPathForExistingHoursAssessmentHours];
//            
//            totalTimeInterval=[self totalTimeIntervalForTotalTimeArray:existingAssessmentHoursArray];
//        }
//        case kTrackSupport:
//        {
//            NSArray *existingSupportActivityHoursArray=[filteredExistingHoursArray valueForKeyPath:kTrackKeyPathForExistingHoursSupportActivityHours];
//            
//            totalTimeInterval=[self totalTimeIntervalForTotalTimeArray:existingSupportActivityHoursArray];
//            
//
//        }
//        case kTrackSupervisionReceived:
//        {
//            
//            NSArray *existingSupervisionReceivedHoursArray=[filteredExistingHoursArray valueForKeyPath:kTrackKeyPathForExistingHoursSupervisionReceivedHours];
//            
//           totalTimeInterval=[self totalTimeIntervalForTotalTimeArray:existingSupervisionReceivedHoursArray];
//        }
//        default:
//            break;
//    }
//    
//    
//    totalTimeInterval=totalTimeInterval+trackTotalTimeInterval;
//   
//    
//    
//   
//   
//    
// 
//    
//    return [self totalTimeStr:totalTimeInterval];
//    
//    
//    
//    
//    
//    
//    
//    
//    return [NSString stringWithFormat:@"%@",[self totalTimeStr:totalTimeInterval]];
//    
//   
//}

-(NSTimeInterval )totalTimeIntervalForTrackArray:(NSArray *)trackArray predicate:(NSPredicate *)predicate{

   
    NSArray *filteredObjects=nil;
    if (trackArray && trackArray.count) {
    
        if (predicate) {
            filteredObjects=[trackArray filteredArrayUsingPredicate:(NSPredicate *)predicate];
            

        }
        else {
            filteredObjects=trackArray;
        }
    }
    NSArray *totalTimeArray=nil;
    
    if (filteredObjects) {
        totalTimeArray=[filteredObjects valueForKeyPath:@"time.totalTime"];
    }
     
    
    
    return [self totalTimeIntervalForTotalTimeArray:totalTimeArray];



}

-(NSTimeInterval )totalTimeIntervalForExistingHoursArray:(NSArray *)filteredExistingHoursArray keyPath:(NSString *)keyPath{
    
    NSArray *existingHoursTimeArray=nil;
    if (filteredExistingHoursArray) {
        existingHoursTimeArray=[filteredExistingHoursArray valueForKeyPath:keyPath];
    }
 
    
   
    
    return  [self totalTimeIntervalForTotalTimeArray:existingHoursTimeArray];
    
    
    
}

-(void ) calculateDirectlHours{


    self.directTotalWeek1TI=self.interventionTotalWeek1TI+self.assessmentTotalWeek1TI;
    self.directTotalWeek2TI=self.interventionTotalWeek2TI+self.assessmentTotalWeek2TI;
    self.directTotalWeek3TI=self.interventionTotalWeek3TI+self.assessmentTotalWeek3TI;
    self.directTotalWeek4TI=self.interventionTotalWeek4TI+self.assessmentTotalWeek4TI;
    self.directTotalWeek5TI=self.interventionTotalWeek5TI+self.assessmentTotalWeek5TI;
    self.directTotalWeekUndefinedTI=self.interventionTotalWeekUndefinedTI+self.assessmentTotalWeekUndefinedTI;
    self.directTotalForMonthTI=self.interventionTotalForMonthTI+self.assessmentTotalForMonthTI;
    self.directTotalCummulativeTI=self.interventionTotalCummulativeTI+self.assessmentTotalCummulativeTI;
    self.directTotalToDateTI=self.interventionTotalToDateTI+self.assessmentTotalToDateTI;
    

    self.directTotalWeek1Str=[self timeStrFromTimeInterval: self.directTotalWeek1TI]; 
    self.directTotalWeek2Str=[self timeStrFromTimeInterval: self.directTotalWeek2TI]; 
    self.directTotalWeek3Str=[self timeStrFromTimeInterval: self.directTotalWeek3TI]; 
    self.directTotalWeek4Str=[self timeStrFromTimeInterval: self.directTotalWeek4TI]; 
    self.directTotalWeek5Str=[self timeStrFromTimeInterval: self.directTotalWeek5TI]; 
    self.directTotalWeekUndefinedStr=[self timeStrFromTimeInterval: self.directTotalWeekUndefinedTI]; 
    self.directTotalForMonthStr =[self timeStrFromTimeInterval: self.directTotalForMonthTI]; 
    self.directTotalCummulativeStr=[self timeStrFromTimeInterval: self.directTotalCummulativeTI]; 
    self.directTotalToDateStr=[self timeStrFromTimeInterval: self.directTotalToDateTI]; 



}

-(NSTimeInterval ) totalOverallHoursTIForOveralCell:(PTSummaryCell)summaryCell clinician:(ClinicianEntity *)clinician{
    
    NSPredicate *trackPredicate=nil;
    NSPredicate *existingHoursPredicate=nil;
    
    switch (summaryCell) {
        case kSummaryWeekOne:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekOne clincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekOne clincian:clinician];
        }
            break;
        case kSummaryWeekTwo:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekTwo clincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekOne clincian:clinician];
        }
            break;
        case kSummaryWeekThree:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekThree clincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekOne clincian:clinician];
        }
            break;
        case kSummaryWeekFour:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekFour clincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekOne clincian:clinician];
        }
            break;
        case kSummaryWeekFive:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekFive clincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekOne clincian:clinician];
        }
            break;
        case kSummaryWeekUndefined:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekUndefined clincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekOne clincian:clinician];
        }
            break;
        case kSummaryTotalForMonth:
        {
            trackPredicate=[self predicateForTrackCurrentMonthsForClincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursCurrentMonthsForClincian:clinician];
        }
            break;
        case kSummaryCummulative:
        {
             trackPredicate=[self priorMonthsHoursPredicateForClincian:clinician];
             existingHoursPredicate=[self predicateForExistingHoursAllBeforeEndDate:monthStartDate_ clinician:clinician];
        }
            break;
        case kSummaryTotalToDate:
        {
            trackPredicate=nil;
            existingHoursPredicate=nil;
        }
            break;
            
        default:
            break;
    }
    
    
   
    
    NSLog(@"predicate string is %@",trackPredicate.predicateFormat);
       
    NSTimeInterval trackTotalInterventionTimeInterval=[self totalTimeIntervalForTrackArray:self.interventionsDeliveredArray predicate:trackPredicate];
    
        
    NSLog(@"time interval is %g,",trackTotalInterventionTimeInterval);
    NSTimeInterval trackTotalAssessmentInterval=[self totalTimeIntervalForTrackArray:self.assessmentsDeliveredArray predicate:trackPredicate];;
    
       
    NSTimeInterval trackTotalSupportTimeInterval=[self totalTimeIntervalForTrackArray:self.supportActivityDeliveredArray predicate:trackPredicate];
    
   
    
    NSTimeInterval trackTotalSupervisionReceivedTimeInterval=[self totalTimeIntervalForTrackArray:self.supervisionReceivedArray predicate:trackPredicate];
    
    
    
    
    NSArray *filteredExistingHoursArray=nil;
   
    if (existingHoursPredicate) {
        filteredExistingHoursArray=[existingHoursArray_ filteredArrayUsingPredicate:existingHoursPredicate];
        

    }
    else {
        filteredExistingHoursArray=existingHoursArray_; //unfiltered
    }
     
    

    NSTimeInterval totalExistingInterventionsTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursInterventionHours];
            
    NSTimeInterval totalExistingAssessmentsTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursAssessmentHours];
    
    
    NSTimeInterval totalExistingSupportTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursSupportActivityHours];
    
    
    NSTimeInterval totalExistingSupervisionReceivedTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursSupervisionReceivedHours];
    
    NSTimeInterval overallTotalTI=0;
    
    switch (summaryCell) {
        case kSummaryWeekOne:
        {
            self.interventionTotalWeek1TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalWeek1TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalWeek1TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalWeek1TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalWeek1TI+self.assessmentTotalWeek1TI+self.supportTotalWeek1TI+self.supervisionTotalWeek1TI;
            
            self.interventionTotalWeek1Str=[self totalTimeStr:self.interventionTotalWeek1TI];
            self.assessmentTotalWeek1Str=[self totalTimeStr:self.assessmentTotalWeek1TI];
            self.supportTotalWeek1Str=[self totalTimeStr:self.supportTotalWeek1TI];
            self.supervisionTotalWeek1Str=[self totalTimeStr:self.supervisionTotalWeek1TI];
            self.overallTotalWeek1Str=[self totalTimeStr:overallTotalTI];
            

        }
            break;
        case kSummaryWeekTwo:
        {
            self.interventionTotalWeek2TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalWeek2TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalWeek2TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalWeek2TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalWeek2TI+self.assessmentTotalWeek2TI+self.supportTotalWeek2TI+self.supervisionTotalWeek2TI;
            
            self.interventionTotalWeek2Str=[self totalTimeStr:self.interventionTotalWeek2TI];
            self.assessmentTotalWeek2Str=[self totalTimeStr:self.assessmentTotalWeek2TI];
            self.supportTotalWeek2Str=[self totalTimeStr:self.supportTotalWeek2TI];
            self.supervisionTotalWeek2Str=[self totalTimeStr:self.supervisionTotalWeek2TI];
            self.overallTotalWeek2Str=[self totalTimeStr:overallTotalTI];
            
            
        }
            break;
        case kSummaryWeekThree:
        {
            self.interventionTotalWeek3TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalWeek3TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalWeek3TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalWeek3TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalWeek3TI+self.assessmentTotalWeek3TI+self.supportTotalWeek3TI+self.supervisionTotalWeek3TI;
            
            self.interventionTotalWeek3Str=[self totalTimeStr:self.interventionTotalWeek3TI];
            self.assessmentTotalWeek3Str=[self totalTimeStr:self.assessmentTotalWeek3TI];
            self.supportTotalWeek3Str=[self totalTimeStr:self.supportTotalWeek3TI];
            self.supervisionTotalWeek3Str=[self totalTimeStr:self.supervisionTotalWeek3TI];
            self.overallTotalWeek3Str=[self totalTimeStr:overallTotalTI];
        }
            break;
        case kSummaryWeekFour:
        {
            self.interventionTotalWeek4TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalWeek4TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalWeek4TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalWeek4TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalWeek4TI+self.assessmentTotalWeek4TI+self.supportTotalWeek4TI+self.supervisionTotalWeek4TI;

            self.interventionTotalWeek4Str=[self totalTimeStr:self.interventionTotalWeek4TI];
            self.assessmentTotalWeek4Str=[self totalTimeStr:self.assessmentTotalWeek4TI];
            self.supportTotalWeek4Str=[self totalTimeStr:self.supportTotalWeek4TI];
            self.supervisionTotalWeek4Str=[self totalTimeStr:self.supervisionTotalWeek4TI];
            self.overallTotalWeek4Str=[self totalTimeStr:overallTotalTI];
        }
            break;
        case kSummaryWeekFive:
        {
            self.interventionTotalWeek5TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalWeek5TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalWeek5TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalWeek5TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalWeek5TI+self.assessmentTotalWeek5TI+self.supportTotalWeek5TI+self.supervisionTotalWeek5TI;
            
            self.interventionTotalWeek5Str=[self totalTimeStr:self.interventionTotalWeek5TI];
            self.assessmentTotalWeek5Str=[self totalTimeStr:self.assessmentTotalWeek5TI];
            self.supportTotalWeek5Str=[self totalTimeStr:self.supportTotalWeek5TI];
            self.supervisionTotalWeek5Str=[self totalTimeStr:self.supervisionTotalWeek5TI];
            self.overallTotalWeek5Str=[self totalTimeStr:overallTotalTI];
            
        }
            break;
        case kSummaryWeekUndefined:
        {
            self.interventionTotalWeekUndefinedTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalWeekUndefinedTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalWeekUndefinedTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalWeekUndefinedTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalWeekUndefinedTI+self.assessmentTotalWeekUndefinedTI+self.supportTotalWeekUndefinedTI+self.supervisionTotalWeekUndefinedTI;
            
            self.interventionTotalWeekUndefinedStr=[self totalTimeStr:self.interventionTotalWeekUndefinedTI];
            self.assessmentTotalWeekUndefinedStr=[self totalTimeStr:self.assessmentTotalWeekUndefinedTI];
            self.supportTotalWeekUndefinedStr=[self totalTimeStr:self.supportTotalWeekUndefinedTI];
            self.supervisionTotalWeekUndefinedStr=[self totalTimeStr:self.supervisionTotalWeekUndefinedTI];
            self.overallTotalWeekUndefinedStr=[self totalTimeStr:overallTotalTI];
            
        }
            break;
        case kSummaryTotalForMonth:
        {
            self.interventionTotalForMonthTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalForMonthTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalForMonthTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalForMonthTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalForMonthTI+self.assessmentTotalForMonthTI+self.supportTotalForMonthTI+self.supervisionTotalForMonthTI;
            
            self.interventionTotalForMonthStr=[self totalTimeStr:self.interventionTotalForMonthTI];
            self.assessmentTotalForMonthStr=[self totalTimeStr:self.assessmentTotalForMonthTI];
            self.supportTotalForMonthStr=[self totalTimeStr:self.supportTotalForMonthTI];
            self.supervisionTotalForMonthStr=[self totalTimeStr:self.supervisionTotalForMonthTI];
            self.overallTotalForMonthStr=[self totalTimeStr:overallTotalTI];
        }
            break;
        case kSummaryCummulative:
        {
            self.interventionTotalCummulativeTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalCummulativeTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalCummulativeTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalCummulativeTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
           overallTotalTI =self.interventionTotalCummulativeTI+self.assessmentTotalCummulativeTI+self.supportTotalCummulativeTI+self.supervisionTotalCummulativeTI;
            
            self.interventionTotalCummulativeStr=[self totalTimeStr:self.interventionTotalCummulativeTI];
            self.assessmentTotalCummulativeStr=[self totalTimeStr:self.assessmentTotalCummulativeTI];
            self.supportTotalCummulativeStr=[self totalTimeStr:self.supportTotalCummulativeTI];
            self.supervisionTotalCummulativeStr=[self totalTimeStr:self.supervisionTotalCummulativeTI];
            self.overallTotalCummulativeStr=[self totalTimeStr:overallTotalTI];
            

        }
            break;
        case kSummaryTotalToDate:
        {
            self.interventionTotalToDateTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalToDateTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalToDateTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalToDateTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalToDateTI+self.assessmentTotalToDateTI+self.supportTotalToDateTI+self.supervisionTotalToDateTI;
            
            self.interventionTotalToDateStr=[self totalTimeStr:self.interventionTotalToDateTI];
            self.assessmentTotalToDateStr=[self totalTimeStr:self.assessmentTotalToDateTI];
            self.supportTotalToDateStr=[self totalTimeStr:self.supportTotalToDateTI];
            self.supervisionTotalToDateStr=[self totalTimeStr:self.supervisionTotalToDateTI];
            self.overallTotalToDateStr=[self totalTimeStr:overallTotalTI];
            


        }

            
        default:
            break;
    }
    
    
   
    return overallTotalTI;

}




-(NSPredicate *)allHoursPredicateForClincian:(ClinicianEntity *)clinician{
    
    NSPredicate *priorMonthsServiceDatesPredicate=nil;
    if (clinician) {
        priorMonthsServiceDatesPredicate=[NSPredicate predicateWithFormat:@"self.supervisor.objectID == %@ ",clinician.objectID];
        
    }
    
    return priorMonthsServiceDatesPredicate;
    
}

-(NSPredicate *)priorMonthsHoursPredicateForClincian:(ClinicianEntity *)clinician{

     NSPredicate *priorMonthsServiceDatesPredicate=nil;
    if (clinician) {
        priorMonthsServiceDatesPredicate=[NSPredicate predicateWithFormat:@"(self.supervisor.objectID == %@) AND (dateOfService < %@ )",clinician.objectID,monthStartDate_];
        
    }else {
        priorMonthsServiceDatesPredicate=[NSPredicate predicateWithFormat:@"dateOfService < %@ ",monthStartDate_];
        
        
    }

    return priorMonthsServiceDatesPredicate;

}


-(NSPredicate *)predicateForTrackCurrentMonthsForClincian:(ClinicianEntity *)clinician{
    
    NSPredicate *currentMonthPredicate=nil;
    
    if (clinician) {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil))",clinician.objectID, monthStartDate_,monthEndDate_];
    }
    else {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@" ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil) ",monthStartDate_,monthEndDate_];
    }
    
    return currentMonthPredicate;    
}


-(NSPredicate *)predicateForExistingHoursCurrentMonthsForClincian:(ClinicianEntity *)clinician{
    
    NSPredicate *currentMonthPredicate=nil;
    
    if (clinician) {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@"(self.supervisor.objectID == %@ ) AND (startDate >= %@) AND (endDate <= %@)",clinician.objectID, monthStartDate_,monthEndDate_];
    }
    else {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@" ((startDate >= %@) AND (dateOfService <= %@)))", monthStartDate_,monthEndDate_];
    }
    
    return currentMonthPredicate;    
}


-(NSPredicate *)predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth:(NSDate *)dateInMonth{
  
  NSPredicate *returnPredicate=nil;
  
    if (dateInMonth) {
    
      returnPredicate = [NSPredicate predicateWithFormat:@" (dateOfService <= %@)", monthEndDate_];
  }
  
  return returnPredicate;    
}                                          

-(NSPredicate *)predicateForExistingHoursAllBeforeAndEqualToEndDateForMonth:(NSDate *)dateInMonth{
    
    NSPredicate *returnPredicate=nil;
    
    if (dateInMonth) {
        
        returnPredicate = [NSPredicate predicateWithFormat:@" (endDate <= %@)", [self monthEndDate:dateInMonth]];
    }
    
    return returnPredicate;    
}     
                                          
-(NSPredicate *)predicateForExistingHoursAllBeforeEndDate:(NSDate *)date clinician:(ClinicianEntity *)clinician{
    
    NSPredicate *returnPredicate=nil;
    
    if (date &&[date isKindOfClass:[NSDate class]]) {
        if (clinician) {
            returnPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND  (endDate < %@))",clinician.objectID, date];
        }
        else {
        returnPredicate = [NSPredicate predicateWithFormat:@" (endDate < %@)", date];
        }
    }
    
    return returnPredicate;    
}     


-(NSPredicate *)predicateForExistingHoursWeek:(PTrackWeek)week clincian:(ClinicianEntity *)clinician{
    
    NSPredicate *weekPredicate=nil;
    
    if (clinician) {
        weekPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND (startDate >= %@) AND (endDate <= %@))",clinician.objectID, [self storedStartDateForWeek:week],[self storedEndDateForWeek:week]];
    }
    else {
        weekPredicate = [NSPredicate predicateWithFormat:@" ((startDate >= %@) AND (endDate <= %@))", [self storedStartDateForWeek:week],[self storedEndDateForWeek:week]];
    }
    
    return weekPredicate;
    
}


-(NSPredicate *)predicateForTrackWeek:(PTrackWeek)week clincian:(ClinicianEntity *)clinician{
    
    NSPredicate *weekPredicate=nil;
    
    if (clinician) {
        weekPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil))",clinician.objectID, [self weekStartDate:week],[self weekEndDate:week]];
    }
    else {
        weekPredicate = [NSPredicate predicateWithFormat:@" ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil) ", [self storedStartDateForWeek:week],[self storedEndDateForWeek:week]];
    }
    
    return weekPredicate;
    
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





@end
