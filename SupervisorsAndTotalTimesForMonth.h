/*
 *  SupervisorsAndTotalTimesForMonth.
 *  psyTrack
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 7/7/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import <Foundation/Foundation.h>
#import "ClinicianEntity.h"

typedef enum {
    kTrackAssessment,
    kTrackIntervention,
    kTrackSupport,
    kTrackSupervisionReceived
} PTrackEntity;

typedef enum {
    kTrackWeekOne,
    kTrackWeekTwo,
    kTrackWeekThree,
    kTrackWeekFour,
    kTrackWeekFive,
    kTrackWeekUndefined,
} PTrackWeek;
typedef enum {
    kSummaryWeekOne,
    kSummaryWeekTwo,
    kSummaryWeekThree,
    kSummaryWeekFour,
    kSummaryWeekFive,
    kSummaryWeekUndefined,
    kSummaryTotalForMonth,
    kSummaryCummulative,
    kSummaryTotalToDate,
} PTSummaryCell;


static NSString * const kTrackAssessmentEntityName=@"AssessmentEntity";
static NSString * const kTrackInterventionEntityName=@"InterventionDeliveredEntity";
static NSString * const kTrackSupportEntityName=@"SupportActivityDeliveredEntity";
static NSString * const kTrackSupervisionReceivedEntityName=@"SupervisionReceivedEntity";

static NSString * const kTrackExistingHoursEntityName=@"ExistingHoursEntity";
static NSString * const kTrackExistingAssessmentEntityName=@"ExistingAssessmentEntity";
static NSString * const kTrackExistingInterventionEntityName=@"ExistingInterventionEntity";
static NSString * const kTrackExistingSupportEntityName=@"ExistingSupportActivityEntity";
static NSString * const kTrackExistingSupervisionReceivedEntityName=@"SupervisionReceivedEntity";

static NSString * const kTrackKeyPathForExistingHoursInterventionHours=@"directInterventions.hours";
static NSString * const kTrackKeyPathForExistingHoursAssessmentHours=@"assessments.hours";
static NSString * const kTrackKeyPathForExistingHoursSupportActivityHours=@"supportActivities.hours";
static NSString * const kTrackKeyPathForExistingHoursSupervisionReceivedHours=@"supervisionReceived.hours";



@interface SupervisorsAndTotalTimesForMonth : NSObject{


    __weak NSDate  *monthToDisplay_;
    __weak NSArray *clinicians_;
    __weak NSDate *monthStartDate_;
    __weak NSDate *monthEndDate_;
    __weak NSArray *interventionsDeliveredArray_;
    __weak NSArray *assessmentsDeliveredArray_;
    __weak NSArray *supportActivityDeliveredArray_;
    __weak NSArray *supervisionReceivedArray_;
    __weak NSArray *existingHoursArray_;
   
    __weak NSDate  *week1StartDate_;
    __weak NSDate *week1EndDate_;
    __weak NSDate  *week2StartDate_;
    __weak NSDate *week2EndDate_;
    __weak NSDate  *week3StartDate_;
    __weak NSDate *week3EndDate_;
    __weak NSDate  *week4StartDate_;
    __weak NSDate *week4EndDate_;
    __weak NSDate *week5StartDate_;
    __weak NSDate *week5EndDate_;



}



@property (nonatomic, weak) NSDate  *monthToDisplay;
@property (nonatomic, weak) NSDate *monthStartDate;
@property (nonatomic, weak) NSDate *monthEndDate;

@property (nonatomic, weak) NSDate *week1StartDate;
@property (nonatomic, weak) NSDate *week1EndDate;
@property (nonatomic, weak) NSDate *week2StartDate;
@property (nonatomic, weak) NSDate *week2EndDate;
@property (nonatomic, weak) NSDate *week3StartDate;
@property (nonatomic, weak) NSDate *week3EndDate;
@property (nonatomic, weak) NSDate *week4StartDate;
@property (nonatomic, weak) NSDate *week4EndDate;
@property (nonatomic, weak) NSDate *week5StartDate;
@property (nonatomic, weak) NSDate *week5EndDate;




@property (nonatomic, weak) NSArray *clinicians;

@property (nonatomic, weak) NSArray *interventionsDeliveredArray;
@property (nonatomic, weak) NSArray *assessmentsDeliveredArray;
@property (nonatomic, weak) NSArray *supportActivityDeliveredArray;
@property (nonatomic, weak) NSArray *supervisionReceivedArray;
@property (nonatomic, weak) NSArray *existingHoursHoursArray;

@property (nonatomic, weak) NSString *interventionTotalWeek1Str;
@property (nonatomic, weak) NSString *interventionTotalWeek2Str;
@property (nonatomic, weak) NSString *interventionTotalWeek3Str;
@property (nonatomic, weak) NSString *interventionTotalWeek4Str;
@property (nonatomic, weak) NSString *interventionTotalWeek5Str;

@property (nonatomic, assign) NSTimeInterval interventionTotalWeek1TI;
@property (nonatomic, assign) NSTimeInterval interventionTotalWeek2TI;
@property (nonatomic, assign) NSTimeInterval interventionTotalWeek3TI;
@property (nonatomic, assign) NSTimeInterval interventionTotalWeek4TI;
@property (nonatomic, assign) NSTimeInterval interventionTotalWeek5TI;


@property (nonatomic, weak) NSString *interventionTotalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval interventionTotalWeekUndefinedTI;

@property (nonatomic, weak) NSString *interventionTotalForMonthStr;
@property (nonatomic, assign) NSTimeInterval interventionTotalForMonthTI;

@property (nonatomic, weak) NSString *interventionTotalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval interventionTotalCummulativeTI;

@property (nonatomic, weak) NSString *interventionTotalToDateStr;
@property (nonatomic, assign) NSTimeInterval interventionTotalToDateTI;



@property (nonatomic, weak) NSString *assessmentTotalWeek1Str;
@property (nonatomic, weak) NSString *assessmentTotalWeek2Str;
@property (nonatomic, weak) NSString *assessmentTotalWeek3Str;
@property (nonatomic, weak) NSString *assessmentTotalWeek4Str;
@property (nonatomic, weak) NSString *assessmentTotalWeek5Str;

@property (nonatomic, assign) NSTimeInterval assessmentTotalWeek1TI;
@property (nonatomic, assign) NSTimeInterval assessmentTotalWeek2TI;
@property (nonatomic, assign) NSTimeInterval assessmentTotalWeek3TI;
@property (nonatomic, assign) NSTimeInterval assessmentTotalWeek4TI;
@property (nonatomic, assign) NSTimeInterval assessmentTotalWeek5TI;

@property (nonatomic, weak) NSString *assessmentTotalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval assessmentTotalWeekUndefinedTI;

@property (nonatomic, weak) NSString *assessmentTotalForMonthStr;
@property (nonatomic, assign) NSTimeInterval assessmentTotalForMonthTI;

@property (nonatomic, weak) NSString *assessmentTotalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval assessmentTotalCummulativeTI;

@property (nonatomic, weak) NSString *assessmentTotalToDateStr;
@property (nonatomic, assign) NSTimeInterval assessmentTotalToDateTI;


@property (nonatomic, weak) NSString *supportTotalWeek1Str;
@property (nonatomic, weak) NSString *supportTotalWeek2Str;
@property (nonatomic, weak) NSString *supportTotalWeek3Str;
@property (nonatomic, weak) NSString *supportTotalWeek4Str;
@property (nonatomic, weak) NSString *supportTotalWeek5Str;

@property (nonatomic, assign) NSTimeInterval supportTotalWeek1TI;
@property (nonatomic, assign) NSTimeInterval supportTotalWeek2TI;
@property (nonatomic, assign) NSTimeInterval supportTotalWeek3TI;
@property (nonatomic, assign) NSTimeInterval supportTotalWeek4TI;
@property (nonatomic, assign) NSTimeInterval supportTotalWeek5TI;


@property (nonatomic, weak) NSString *supportTotalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval supportTotalWeekUndefinedTI;

@property (nonatomic, weak) NSString *supportTotalForMonthStr;
@property (nonatomic, assign) NSTimeInterval supportTotalForMonthTI;

@property (nonatomic, weak) NSString *supportTotalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval supportTotalCummulativeTI;

@property (nonatomic, weak) NSString *supportTotalToDateStr;
@property (nonatomic, assign) NSTimeInterval supportTotalToDateTI;


@property (nonatomic, weak) NSString *supervisionTotalWeek1Str;
@property (nonatomic, weak) NSString *supervisionTotalWeek2Str;
@property (nonatomic, weak) NSString *supervisionTotalWeek3Str;
@property (nonatomic, weak) NSString *supervisionTotalWeek4Str;
@property (nonatomic, weak) NSString *supervisionTotalWeek5Str;

@property (nonatomic, assign) NSTimeInterval supervisionTotalWeek1TI;
@property (nonatomic, assign) NSTimeInterval supervisionTotalWeek2TI;
@property (nonatomic, assign) NSTimeInterval supervisionTotalWeek3TI;
@property (nonatomic, assign) NSTimeInterval supervisionTotalWeek4TI;
@property (nonatomic, assign) NSTimeInterval supervisionTotalWeek5TI;


@property (nonatomic, weak) NSString *supervisionTotalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval supervisionTotalWeekUndefinedTI;

@property (nonatomic, weak) NSString *supervisionTotalForMonthStr;
@property (nonatomic, assign) NSTimeInterval supervisionTotalForMonthTI;

@property (nonatomic, weak) NSString *supervisionTotalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval supervisionTotalCummulativeTI;

@property (nonatomic, weak) NSString *supervisionTotalToDateStr;
@property (nonatomic, assign) NSTimeInterval supervisionTotalToDateTI;



@property (nonatomic, weak) NSString *directTotalWeek1Str;
@property (nonatomic, weak) NSString *directTotalWeek2Str;
@property (nonatomic, weak) NSString *directTotalWeek3Str;
@property (nonatomic, weak) NSString *directTotalWeek4Str;
@property (nonatomic, weak) NSString *directTotalWeek5Str;

@property (nonatomic, assign) NSTimeInterval directTotalWeek1TI;
@property (nonatomic, assign) NSTimeInterval directTotalWeek2TI;
@property (nonatomic, assign) NSTimeInterval directTotalWeek3TI;
@property (nonatomic, assign) NSTimeInterval directTotalWeek4TI;
@property (nonatomic, assign) NSTimeInterval directTotalWeek5TI;


@property (nonatomic, weak) NSString *directTotalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval directTotalWeekUndefinedTI;

@property (nonatomic, weak) NSString *directTotalForMonthStr;
@property (nonatomic, assign) NSTimeInterval directTotalForMonthTI;

@property (nonatomic, weak) NSString *directTotalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval directTotalCummulativeTI;

@property (nonatomic, weak) NSString *directTotalToDateStr;
@property (nonatomic, assign) NSTimeInterval directTotalToDateTI;


@property (nonatomic, weak) NSString *overallTotalWeek1Str;
@property (nonatomic, weak) NSString *overallTotalWeek2Str;
@property (nonatomic, weak) NSString *overallTotalWeek3Str;
@property (nonatomic, weak) NSString *overallTotalWeek4Str;
@property (nonatomic, weak) NSString *overallTotalWeek5Str;

@property (nonatomic, assign) NSTimeInterval overallTotalWeek1TI;
@property (nonatomic, assign) NSTimeInterval overallTotalWeek2TI;
@property (nonatomic, assign) NSTimeInterval overallTotalWeek3TI;
@property (nonatomic, assign) NSTimeInterval overallTotalWeek4TI;
@property (nonatomic, assign) NSTimeInterval overallTotalWeek5TI;


@property (nonatomic, weak) NSString *overallTotalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval overallTotalWeekUndefinedTI;

@property (nonatomic, weak) NSString *overallTotalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval overallTotalCummulativeTI;

@property (nonatomic, weak) NSString *overallTotalToDateStr;
@property (nonatomic, assign) NSTimeInterval overallTotalToDateTI;

@property (nonatomic, weak) NSString *overallTotalForMonthStr;
@property (nonatomic, assign) NSTimeInterval overallTotalForMonthTI;






-(id)initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician;


-(NSTimeInterval )totalTimeIntervalForTotalTimeArray:(NSArray *)totalTimesArray;

-(NSDate *)monthStartDateForDate:(NSDate *)date;

-(NSDate *)monthEndDate:(NSDate *)date;

-(NSDate *)weekStartDate:(PTrackWeek )week;
-(NSDate *)weekEndDate:(PTrackWeek )week;





-(int )totalHours:(NSTimeInterval) totalTime;

-(int )totalMinutes:(NSTimeInterval) totalTime;

-(NSString *)totalTimeStr:(NSTimeInterval )totalTimeTI;

-(NSTimeInterval )totalTimeIntervalForTrackArray:(NSArray *)trackArray predicate:(NSPredicate *)predicate;

-(NSTimeInterval )totalTimeIntervalForExistingHoursArray:(NSArray *)filteredExistingHoursArray keyPath:(NSString *)keyPath;

-(void ) calculateDirectlHours;

-(NSTimeInterval ) totalOverallHoursTIForOveralCell:(PTSummaryCell)overallCell clinician:(ClinicianEntity *)clinician;
-(NSPredicate *)allHoursPredicateForClincian:(ClinicianEntity *)clinician;

-(NSPredicate *)priorMonthsHoursPredicateForClincian:(ClinicianEntity *)clinician;

-(NSPredicate *)predicateForTrackCurrentMonthsForClincian:(ClinicianEntity *)clinician;

-(NSPredicate *)predicateForExistingHoursCurrentMonthsForClincian:(ClinicianEntity *)clinician;

-(NSPredicate *)predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth:(NSDate *)dateInMonth;                                        

-(NSPredicate *)predicateForExistingHoursAllBeforeAndEqualToEndDateForMonth:(NSDate *)dateInMonth;

-(NSPredicate *)predicateForExistingHoursAllBeforeEndDate:(NSDate *)date clinician:(ClinicianEntity *)clinician;

-(NSPredicate *)predicateForExistingHoursWeek:(PTrackWeek)week clincian:(ClinicianEntity *)clinician;

-(NSPredicate *)predicateForTrackWeek:(PTrackWeek)week clincian:(ClinicianEntity *)clinician;



-(NSArray *)fetchObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate;

-(NSString *)timeStrFromTimeInterval:(NSTimeInterval )totalTime;



@end
