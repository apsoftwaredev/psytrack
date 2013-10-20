//
//  TotalTimesForMonthlyLog.m
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 7/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "TotalTimesForMonthlyLog.h"
#import "PTTAppDelegate.h"

@implementation TotalTimesForMonthlyLog

@synthesize  monthToDisplay;
@synthesize interventionsDeliveredArray = interventionsDeliveredArray_,
assessmentsDeliveredArray = assessmentsDeliveredArray_,
supportActivityDeliveredArray = supportActivityDeliveredArray_,
supervisionReceivedArray = supervisionReceivedArray_,
existingHoursArray = existingHoursArray_;
@synthesize existingHInterventionrray = existingInterventionsArray_,
existingAssessmentArray = existingAssessmentsArray_,
existingSupportArray = existingSupportArray_,
existingSupervisionArray = existingSupervisionArray_;

@synthesize trainingProgram = trainingProgram_;

@synthesize clinician = clinician_;
@synthesize monthStartDate = monthStartDate_, monthEndDate = monthEndDate_;

@synthesize week1StartDate = week1StartDate_;
@synthesize week1EndDate = week1EndDate_;
@synthesize week2StartDate = week2StartDate_;
@synthesize week2EndDate = week2EndDate_;
@synthesize week3StartDate = week3StartDate_;
@synthesize week3EndDate = week3EndDate_;
@synthesize week4StartDate = week4StartDate_;
@synthesize week4EndDate = week4EndDate_;
@synthesize week5StartDate = week5StartDate_;
@synthesize week5EndDate = week5EndDate_;
@synthesize doctorateLevel = doctorateLevel_;

- (id) initWithDoctorateLevel:(BOOL)doctorateLevelGiven clinician:(ClinicianEntity *)clinician trainingProgram:(TrainingProgramEntity *)trainingProgramGiven
{
    self = [super init];

    if (self)
    {
        self.clinician = clinician;
        self.trainingProgram = trainingProgramGiven;

        self.doctorateLevel = doctorateLevelGiven;
    }

    return self;
}


- (id) initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician trainingProgram:(TrainingProgramEntity *)trainingProgramGiven
{
    self = [super init];

    if (self)
    {
        self.clinician = clinician;
        self.trainingProgram = trainingProgramGiven;

        if (date)
        {
            self.monthToDisplay = date;

            self.monthStartDate = [self monthStartDateForDate:date];
            self.monthEndDate = [self monthEndDate:date];

            self.week1StartDate = [self weekStartDate:kTrackWeekOne];
            self.week1EndDate = [self weekEndDate:kTrackWeekOne];
            self.week2StartDate = [self weekStartDate:kTrackWeekTwo];
            self.week2EndDate = [self weekEndDate:kTrackWeekTwo];
            self.week3StartDate = [self weekStartDate:kTrackWeekThree];
            self.week3EndDate = [self weekEndDate:kTrackWeekThree];
            self.week4StartDate = [self weekStartDate:kTrackWeekFour];
            self.week4EndDate = [self weekEndDate:kTrackWeekFour];
            self.week5StartDate = [self weekStartDate:kTrackWeekFive];
            self.week5EndDate = [self weekEndDate:kTrackWeekFive];
        }
    }

    return self;
}


- (NSTimeInterval) totalTimeIntervalForTotalTimeArray:(NSArray *)totalTimesArray
{
    NSTimeInterval totalTime = 0;
    if (totalTimesArray && totalTimesArray.count)
    {
        for (id totalTimeDateObject in totalTimesArray)
        {
            NSDate *dateToAdd = nil;
            if ([totalTimeDateObject isKindOfClass:[NSSet class]])
            {
                NSSet *totalSet = (NSSet *)totalTimeDateObject;
                if (totalSet.count)
                {
                    dateToAdd = [totalTimeDateObject objectAtIndex:0];
                }
            }
            else if ([totalTimeDateObject isKindOfClass:[NSDate class]])
            {
                dateToAdd = totalTimeDateObject;
            }

            if (dateToAdd && [dateToAdd isKindOfClass:[NSDate class]])
            {
                totalTime = totalTime + [totalTimeDateObject timeIntervalSince1970];
            }
        }
    }

    return totalTime;
}


- (NSDate *) monthStartDateForDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDateComponents *startDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];

    [startDateComponents setDay:0]; //reset the other components

    NSDate *startDate = [calendar dateFromComponents:startDateComponents];

    return startDate;
}


- (NSDate *) monthEndDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    NSDateComponents *endDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];

    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit:NSMonthCalendarUnit
                                  forDate:date];
    endDateComponents.hour = 23;
    endDateComponents.minute = 59;
    endDateComponents.second = 59;

    [endDateComponents setDay:range.length];
    NSDate *endDate = [calendar dateFromComponents:endDateComponents];

    return endDate;
}


- (NSDate *) weekStartDate:(PTrackWeek)week
{
    NSCalendar *calendar = [NSCalendar currentCalendar];

    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    NSDateComponents *startDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit) fromDate:self.monthToDisplay];

    //create week
    startDateComponents.day = 1;
    startDateComponents.hour = 0;
    startDateComponents.minute = 0;
    startDateComponents.second = 0;
    NSDateComponents *week2StartDateComponents = [[NSDateComponents alloc]init];
    week2StartDateComponents.week = week;
    week2StartDateComponents.hour = 23;
    week2StartDateComponents.minute = 59;
    week2StartDateComponents.second = 59;
    week2StartDateComponents.month = 0;
    week2StartDateComponents.year = 0;

    //create a date with these components
    NSRange rangeWeek = [calendar rangeOfUnit:NSDayCalendarUnit
                                       inUnit:NSWeekCalendarUnit
                                      forDate:[calendar dateByAddingComponents:week2StartDateComponents toDate:[calendar dateFromComponents:startDateComponents] options:0]];

    [startDateComponents setDay:rangeWeek.location]; //reset the other components

    NSDate *startDate = [calendar dateFromComponents:startDateComponents];
    week2StartDateComponents = nil;
    return startDate;
}


- (NSDate *) weekEndDate:(PTrackWeek)week
{
    NSCalendar *calendar = [NSCalendar currentCalendar];

    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    NSDateComponents *startDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit) fromDate:self.monthToDisplay];

    //create week
    startDateComponents.day = 1;
    startDateComponents.hour = 0;
    startDateComponents.minute = 0;
    startDateComponents.second = 0;
    NSDateComponents *week2StartDateComponents = [[NSDateComponents alloc]init];
    week2StartDateComponents.week = week;
    week2StartDateComponents.hour = 23;
    week2StartDateComponents.minute = 59;
    week2StartDateComponents.second = 59;
    week2StartDateComponents.month = 0;
    week2StartDateComponents.year = 0;

    //create a date with these components

    NSRange rangeWeek = [calendar rangeOfUnit:NSDayCalendarUnit
                                       inUnit:NSWeekCalendarUnit
                                      forDate:[calendar dateByAddingComponents:week2StartDateComponents toDate:[calendar dateFromComponents:startDateComponents] options:0]];

    [startDateComponents setDay:rangeWeek.location]; //reset the other components

    NSDate *startDate = [calendar dateFromComponents:startDateComponents];
    NSDateComponents *endDateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit) fromDate:startDate];

    [endDateComponents setDay:rangeWeek.location + rangeWeek.length];

    NSDate *endDate = nil;
    if (week == kTrackWeekFive)
    {
        endDate = [self monthEndDate:self.monthToDisplay];
    }
    else
    {
        endDate = [calendar dateFromComponents:endDateComponents];
    }

    week2StartDateComponents = nil;

    return endDate;
}


- (NSDate *) storedStartDateForWeek:(PTrackWeek)week
{
    NSDate *returnDate = nil;
    switch (week)
    {
        case kTrackWeekOne:
            returnDate = week1StartDate_;
            break;
        case kTrackWeekTwo:
            returnDate = week2StartDate_;
            break;
        case kTrackWeekThree:
            returnDate = week3StartDate_;
            break;
        case kTrackWeekFour:
            returnDate = week4StartDate_;
            break;
        case kTrackWeekFive:
            returnDate = week5StartDate_;
            break;
        default:
            break;
    } /* switch */

    return returnDate;
}


- (NSDate *) storedEndDateForWeek:(PTrackWeek)week
{
    NSDate *returnDate = nil;
    switch (week)
    {
        case kTrackWeekOne:
            returnDate = week1EndDate_;
            break;
        case kTrackWeekTwo:
            returnDate = week2EndDate_;
            break;
        case kTrackWeekThree:
            returnDate = week3EndDate_;
            break;
        case kTrackWeekFour:
            returnDate = week4EndDate_;
            break;
        case kTrackWeekFive:
            returnDate = week5EndDate_;
            break;
        default:
            break;
    } /* switch */

    return returnDate;
}


- (int) totalHours:(NSTimeInterval)totalTime
{
    return totalTime / 3600;
}


- (int) totalMinutes:(NSTimeInterval)totalTime
{
    return round( ( (totalTime / 3600) - [self totalHours:totalTime] ) * 60 );
}


- (NSString *) totalTimeStr:(NSTimeInterval)totalTimeTI
{
    NSString *returnString = nil;

    if (totalTimeTI > 0)
    {
        NSString *hoursStr = [NSString stringWithFormat:@"%i:",[self totalHours:totalTimeTI]];

        int minutes = [self totalMinutes:totalTimeTI];
        NSString *minutesStr = nil;

        if (minutes < 10)
        {
            minutesStr = [NSString stringWithFormat:@"0%i", minutes];
        }
        else
        {
            minutesStr = [NSString stringWithFormat:@"%i",minutes];
        }

        returnString = [hoursStr stringByAppendingString:minutesStr];
    }
    else
    {
        returnString = @"0:00";
    }

    return returnString;
}


- (NSTimeInterval) totalTimeIntervalForTrackArray:(NSSet *)trackArray predicate:(NSPredicate *)predicate
{
    NSArray *filteredObjects = nil;

    if (trackArray && trackArray.count)
    {
        if (predicate)
        {
            filteredObjects = [trackArray.allObjects filteredArrayUsingPredicate:(NSPredicate *)predicate];
        }
        else
        {
            filteredObjects = trackArray.allObjects;
        }
    }

    NSArray *totalTimeArray = nil;

    if (filteredObjects)
    {
        totalTimeArray = [filteredObjects mutableArrayValueForKeyPath:@"time.totalTime"];
    }

    NSMutableArray *returnTimeArray = [NSMutableArray array];

    for (id object in totalTimeArray)
    {
        if ([object isKindOfClass:[NSSet class]])
        {
            NSSet *objectSet = (NSSet *)object;
            NSArray *objectSetArray = objectSet.allObjects;
            for (id objectInObject in objectSetArray)
            {
                if ([objectInObject isKindOfClass:[NSDate class]])
                {
                    [returnTimeArray addObject:objectInObject];
                }
            }
        }
        else if ([object isKindOfClass:[NSDate class]])
        {
            [returnTimeArray addObject:object];
        }
    }

    return [self totalTimeIntervalForTotalTimeArray:returnTimeArray];
}


- (NSTimeInterval) totalTimeIntervalForExistingHoursArray:(NSArray *)filteredExistingHoursArray keyPath:(NSString *)keyPath
{
    NSMutableArray *existingHoursTimeArray = [NSMutableArray array];

    if (filteredExistingHoursArray && filteredExistingHoursArray.count)
    {
        NSMutableArray *existingHoursTempMutableArray = [filteredExistingHoursArray mutableArrayValueForKeyPath:keyPath];

        for (id object in existingHoursTempMutableArray)
        {
            if ([object isKindOfClass:[NSSet class]])
            {
                NSSet *objectSet = (NSSet *)object;
                NSArray *objectSetArray = objectSet.allObjects;
                for (id objectInObject in objectSetArray)
                {
                    if ([objectInObject isKindOfClass:[NSDate class]])
                    {
                        [existingHoursTimeArray addObject:objectInObject];
                    }
                }
            }
            else if ([object isKindOfClass:[NSDate class]])
            {
                [existingHoursTimeArray addObject:object];
            }
        }
    }

    return [self totalTimeIntervalForTotalTimeArray:existingHoursTimeArray];
}


- (NSTimeInterval) totalTimeIntervalForExistingHoursArray:(NSArray *)filteredExistingHoursArray
{
    NSMutableArray *existingHoursTimeArray = [NSMutableArray array];

    if (filteredExistingHoursArray && filteredExistingHoursArray.count)
    {
        NSMutableArray *existingHoursTempArray = [filteredExistingHoursArray mutableArrayValueForKeyPath:@"hours"];

        for (id object in existingHoursTempArray)
        {
            if ([object isKindOfClass:[NSSet class]])
            {
                NSSet *objectSet = (NSSet *)object;
                NSArray *objectSetArray = objectSet.allObjects;
                for (id objectInObject in objectSetArray)
                {
                    if ([objectInObject isKindOfClass:[NSDate class]])
                    {
                        [existingHoursTimeArray addObject:objectInObject];
                    }
                }
            }
            else if ([object isKindOfClass:[NSDate class]])
            {
                [existingHoursTimeArray addObject:object];
            }
        }
    }

    return [self totalTimeIntervalForTotalTimeArray:existingHoursTimeArray];
}


- (NSPredicate *) predicateForClincian
{
    NSPredicate *priorMonthsServiceDatesPredicate = nil;
    if (clinician_)
    {
        priorMonthsServiceDatesPredicate = [NSPredicate predicateWithFormat:@"self.supervisor.objectID == %@ ",clinician_.objectID];
    }

    return priorMonthsServiceDatesPredicate;
}


- (NSPredicate *) priorMonthsHoursPredicate
{
    NSPredicate *priorMonthsServiceDatesPredicate = nil;

    priorMonthsServiceDatesPredicate = [NSPredicate predicateWithFormat:@"dateOfService < %@ ",monthStartDate_];

    return priorMonthsServiceDatesPredicate;
}


- (NSPredicate *) predicateForTrackCurrentMonth
{
    NSPredicate *currentMonthPredicate = nil;

    currentMonthPredicate = [NSPredicate predicateWithFormat:@" ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil) ",monthStartDate_,monthEndDate_];

    return currentMonthPredicate;
}


- (NSPredicate *) predicateForExistingHoursCurrentMonth
{
    NSPredicate *currentMonthPredicate = nil;

    currentMonthPredicate = [NSPredicate predicateWithFormat:@" (existingHours.startDate >= %@) AND (existingHours.endDate <= %@)", monthStartDate_,monthEndDate_];

    return currentMonthPredicate;
}


- (NSPredicate *) predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth
{
    NSPredicate *returnPredicate = nil;

    if (monthEndDate_)
    {
        returnPredicate = [NSPredicate predicateWithFormat:@" (dateOfService <= %@)", monthEndDate_];
    }

    return returnPredicate;
}


- (NSPredicate *) predicateForExistingHoursAllBeforeAndEqualToEndDateForMonth
{
    NSPredicate *returnPredicate = nil;

    if (monthEndDate_)
    {
        returnPredicate = [NSPredicate predicateWithFormat:@" (existingHours.endDate <= %@)", monthEndDate_];
    }

    return returnPredicate;
}


- (NSPredicate *) predicateForExistingHoursAllBeforeEndDate:(NSDate *)date; {
    NSPredicate *returnPredicate = nil;

    if (date && [date isKindOfClass:[NSDate class]])
    {
        returnPredicate = [NSPredicate predicateWithFormat:@" (existingHours.endDate < %@)", date];
    }

    return returnPredicate;
}

- (NSPredicate *) predicateForExistingHoursWeek:(PTrackWeek)week
{
    NSPredicate *weekPredicate = nil;

    weekPredicate = [NSPredicate predicateWithFormat:@" ((existingHours.startDate >= %@) AND (existingHours.endDate <= %@))", [self storedStartDateForWeek:week],[self storedEndDateForWeek:week]];

    return weekPredicate;
}


- (NSPredicate *) predicateForExistingHoursWeekUndefined
{
    NSPredicate *undefinedWeekPredicate = nil;

    undefinedWeekPredicate = [NSPredicate predicateWithFormat:@"((existingHours.startDate >= %@) AND (existingHours.endDate <= %@)) AND NOT (   ((existingHours.startDate >= %@) AND (existingHours.endDate < %@)) OR ((existingHours.startDate >= %@) AND (existingHours.endDate < %@)) OR ((existingHours.startDate >= %@) AND (existingHours.endDate < %@)) OR ((existingHours.startDate >= %@) AND (existingHours.endDate < %@)) OR  ((existingHours.startDate >= %@) AND (existingHours.endDate < %@))) ", monthStartDate_,monthEndDate_,week1StartDate_,week1EndDate_,week2StartDate_,week2EndDate_,week3StartDate_,week3EndDate_,week4StartDate_,week4EndDate_,week5StartDate_,week5EndDate_];

    return undefinedWeekPredicate;
}


- (NSPredicate *) predicateForTrackTrainingProgram
{
    NSPredicate *trainingProgramPredicate = nil;

    trainingProgramPredicate = [NSPredicate predicateWithFormat:@"trainingProgram.objectID == %@", trainingProgram_.objectID];

    return trainingProgramPredicate;
}


- (NSPredicate *) predicateForExistingHoursProgramCourse
{
    NSPredicate *trainingProgramPredicate = nil;

    trainingProgramPredicate = [NSPredicate predicateWithFormat:@"existingHours.programCourse.objectID == %@", trainingProgram_.objectID];

    return trainingProgramPredicate;
}


- (NSPredicate *) predicateForExistingHoursDoctorateLevel
{
    NSPredicate *doctorateLevelPredicate = nil;

    doctorateLevelPredicate = [NSPredicate predicateWithFormat:@"existingHours.programCourse.doctorateLevel == %@", [NSNumber numberWithBool:doctorateLevel_]];

    return doctorateLevelPredicate;
}


- (NSPredicate *) predicateForTrackDoctorateLevel
{
    NSPredicate *doctorateLevelPredicate = nil;

    doctorateLevelPredicate = [NSPredicate predicateWithFormat:@"trainingProgram.doctorateLevel == %@", [NSNumber numberWithBool:doctorateLevel_]];

    return doctorateLevelPredicate;
}


- (NSPredicate *) predicateForTrackWeek:(PTrackWeek)week
{
    NSPredicate *weekPredicate = nil;

    weekPredicate = [NSPredicate predicateWithFormat:@" ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil) ", [self storedStartDateForWeek:week],[self storedEndDateForWeek:week]];

    return weekPredicate;
}


- (NSArray *) fetchObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:entityStr inManagedObjectContext:appDelegate.managedObjectContext];

    [fetchRequest setEntity:entity];

    if (filterPredicate)
    {
        [fetchRequest setPredicate:filterPredicate];
    }

    NSError *error = nil;
    NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    fetchRequest = nil;
    return fetchedObjects;
}


- (NSString *) timeStrFromTimeInterval:(NSTimeInterval)totalTime
{
    if (totalTime)
    {
        int totalHours = totalTime / 3600;

        int totalMinutes = round( ( (totalTime / 3600) - totalHours ) * 60 );
        if (totalMinutes < 10)
        {
            return [NSString stringWithFormat:@"%i:0%i",totalHours,totalMinutes];
        }
        else
        {
            return [NSString stringWithFormat:@"%i:%i",totalHours,totalMinutes];
        }
    }

    return @"0:00";
}


@end
