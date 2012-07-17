//
//  TotalTimesForMonthlyLog.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "TotalTimesForMonthlyLog.h"
#import "PTTAppDelegate.h"
@implementation TotalTimesForMonthlyLog

@synthesize  monthToDisplay;
@synthesize interventionsDeliveredArray=interventionsDeliveredArray_,
assessmentsDeliveredArray=assessmentsDeliveredArray_,
supportActivityDeliveredArray=supportActivityDeliveredArray_,
supervisionReceivedArray=supervisionReceivedArray_,
existingHoursHoursArray=existingHoursArray_;

@synthesize clinician=clinician_;
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


-(id)initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician{
    
    self= [super init];
    
    if (self) {
        
        self.monthToDisplay=date;
        self.clinician=clinician;
        NSLog(@"month to display is %@",self.monthToDisplay);
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
        
        
        
        
       
        
        
        
               
        
        
        
        
    }
    
    return self;
    
    
}


-(NSTimeInterval )totalTimeIntervalForTotalTimeArray:(NSArray *)totalTimesArray{
    
    NSTimeInterval totalTime=0;
    if (totalTimesArray&&totalTimesArray.count) {
        NSLog(@"total times array is %@",totalTimesArray);
        
        for (id totalTimeDateObject in totalTimesArray) {
            NSLog(@"time is %@",totalTimeDateObject);
            NSDate *dateToAdd=nil;
            if ([totalTimeDateObject isKindOfClass:[NSSet class]]) {
                NSSet *totalSet=(NSSet *)totalTimeDateObject;
                if (totalSet.count) {
                    dateToAdd=[totalTimeDateObject objectAtIndex:0];
                }
                
            }else if ([totalTimeDateObject isKindOfClass:[NSDate class]]) {
                dateToAdd=totalTimeDateObject;
            }
            
            NSLog(@"total time is to be added is %e",[totalTimeDateObject timeIntervalSince1970]);
            
            
            if (dateToAdd&&[dateToAdd isKindOfClass:[NSDate class]]) {
                
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
    
    NSMutableArray *existingHoursTimeArray=[NSMutableArray array];
    
    if (filteredExistingHoursArray  &&filteredExistingHoursArray.count) {
        NSSet *existingHoursTempSet=[filteredExistingHoursArray valueForKeyPath:keyPath];
        for (id object in existingHoursTempSet) {
            if ([object isKindOfClass:[NSSet class]]) {
                NSSet *objectSet=(NSSet *)object;
                NSArray *objectSetArray=objectSet.allObjects;
                for (id objectInObject in objectSetArray) {
                    
                    if ([objectInObject isKindOfClass:[NSDate class]]) {
                        
                        [existingHoursTimeArray addObject:objectInObject];
                    }
                }
                
            }
        }
        
        
    }
    
    
    
    
    return  [self totalTimeIntervalForTotalTimeArray:existingHoursTimeArray];
    
    
    
}


-(NSPredicate *)allHoursPredicateForClincian:(ClinicianEntity *)clinician{
    
    NSPredicate *priorMonthsServiceDatesPredicate=nil;
    if (clinician) {
        priorMonthsServiceDatesPredicate=[NSPredicate predicateWithFormat:@"self.supervisor.objectID == %@ ",clinician.objectID];
        
    }
    
    return priorMonthsServiceDatesPredicate;
    
}

-(NSPredicate *)priorMonthsHoursPredicate{
    
    NSPredicate *priorMonthsServiceDatesPredicate=nil;
    if (clinician_) {
        priorMonthsServiceDatesPredicate=[NSPredicate predicateWithFormat:@"(self.supervisor.objectID == %@) AND (dateOfService < %@ )",clinician_.objectID,monthStartDate_];
        
    }else {
        priorMonthsServiceDatesPredicate=[NSPredicate predicateWithFormat:@"dateOfService < %@ ",monthStartDate_];
        
        
    }
    
    return priorMonthsServiceDatesPredicate;
    
}


-(NSPredicate *)predicateForTrackCurrentMonth{
    
    NSPredicate *currentMonthPredicate=nil;
    
    if (clinician_) {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil))",clinician_.objectID, monthStartDate_,monthEndDate_];
    }
    else {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@" ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil) ",monthStartDate_,monthEndDate_];
    }
    
    return currentMonthPredicate;    
}


-(NSPredicate *)predicateForExistingHoursCurrentMonth{
    
    NSPredicate *currentMonthPredicate=nil;
    
    if (clinician_) {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@"(self.supervisor.objectID == %@ ) AND (startDate >= %@) AND (endDate <= %@)",clinician_.objectID, monthStartDate_,monthEndDate_];
    }
    else {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@" (startDate >= %@) AND (endDate <= %@)", monthStartDate_,monthEndDate_];
    }
    
    return currentMonthPredicate;    
}


-(NSPredicate *)predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth{
    
    NSPredicate *returnPredicate=nil;
    
    if (monthEndDate_) {
        
        returnPredicate = [NSPredicate predicateWithFormat:@" (dateOfService <= %@)", monthEndDate_];
    }
    
    return returnPredicate;    
}                                          

-(NSPredicate *)predicateForExistingHoursAllBeforeAndEqualToEndDateForMonth{
    
    NSPredicate *returnPredicate=nil;
    
    if (monthEndDate_) {
        
        returnPredicate = [NSPredicate predicateWithFormat:@" (endDate <= %@)", monthEndDate_];
    }
    
    return returnPredicate;    
}     


-(NSPredicate *)predicateForExistingHoursAllBeforeEndDate:(NSDate *)date;{
    
    NSPredicate *returnPredicate=nil;
    
    if (date &&[date isKindOfClass:[NSDate class]]) {
        if (clinician_) {
            returnPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND  (endDate < %@))",clinician_.objectID, date];
        }
        else {
            returnPredicate = [NSPredicate predicateWithFormat:@" (endDate < %@)", date];
        }
    }
    
    return returnPredicate;    
}     


-(NSPredicate *)predicateForExistingHoursWeek:(PTrackWeek)week{
    
    NSPredicate *weekPredicate=nil;
    
    if (clinician_) {
        weekPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND (startDate >= %@) AND (endDate <= %@))",clinician_.objectID, [self storedStartDateForWeek:week],[self storedEndDateForWeek:week]];
    }
    else {
        weekPredicate = [NSPredicate predicateWithFormat:@" ((startDate >= %@) AND (endDate <= %@))", [self storedStartDateForWeek:week],[self storedEndDateForWeek:week]];
    }
    
    return weekPredicate;
    
}


-(NSPredicate *)predicateForExistingHoursWeekUndefined{
    
    NSPredicate *undefinedWeekPredicate=nil;
    
    if (clinician_) {
        undefinedWeekPredicate = [NSPredicate predicateWithFormat:@" ((self.supervisor.objectID == %@ )  AND NOT ((startDate >= %@) AND (endDate <= %@)) AND (   ((startDate >= %@) AND (endDate > %@)) OR ((startDate >= %@) AND (endDate > %@)) OR ((startDate >= %@) AND (endDate > %@)) OR ((startDate >= %@) AND (endDate > %@)) ))",clinician_.objectID, monthStartDate_,monthEndDate_,week1StartDate_,week1EndDate_,week2StartDate_,week2EndDate_,week3StartDate_,week3EndDate_,week4StartDate_,week4EndDate_];
        
        
    }
    else {
        undefinedWeekPredicate = [NSPredicate predicateWithFormat:@"((startDate >= %@) AND (endDate <= %@)) AND NOT (   ((startDate >= %@) AND (endDate > %@)) OR ((startDate >= %@) AND (endDate > %@)) OR ((startDate >= %@) AND (endDate > %@)) OR ((startDate >= %@) AND (endDate > %@))) ", monthStartDate_,monthEndDate_,week1StartDate_,week1EndDate_,week2StartDate_,week2EndDate_,week3StartDate_,week3EndDate_,week4StartDate_,week4EndDate_];
    }
    
    NSLog(@"undefined week predicate format is startDate is week one %@ two %@ three %@ week 4i s %@ end date is week one %@ week 2 %@  week 3 %@  week 4 %@ predicat format is%@ ", week1StartDate_,week2StartDate_,week3StartDate_,week4StartDate_,week1EndDate_,week2EndDate_,week3EndDate_,week4EndDate_,undefinedWeekPredicate.predicateFormat);
    return undefinedWeekPredicate;
    
}

-(NSPredicate *)predicateForTrackWeek:(PTrackWeek)week{
    
    NSPredicate *weekPredicate=nil;
    
    if (clinician_) {
        weekPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil))",clinician_.objectID, [self storedStartDateForWeek:week],[self storedEndDateForWeek:week]];
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
