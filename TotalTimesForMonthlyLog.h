//
//  TotalTimesForMonthlyLog.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

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


@interface TotalTimesForMonthlyLog : NSObject {



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


@property (nonatomic, weak) NSDate *monthToDisplay;
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


@property (nonatomic, weak) NSArray *interventionsDeliveredArray;
@property (nonatomic, weak) NSArray *assessmentsDeliveredArray;
@property (nonatomic, weak) NSArray *supportActivityDeliveredArray;
@property (nonatomic, weak) NSArray *supervisionReceivedArray;
@property (nonatomic, weak) NSArray *existingHoursHoursArray;


-(id)initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician;


-(NSTimeInterval )totalTimeIntervalForTotalTimeArray:(NSArray *)totalTimesArray;

-(NSDate *)monthStartDateForDate:(NSDate *)date;


-(NSDate *)monthEndDate:(NSDate *)date;

-(NSDate *)weekStartDate:(PTrackWeek )week;
-(NSDate *)weekEndDate:(PTrackWeek )week;


-(NSDate *)storedStartDateForWeek:(PTrackWeek)week;

-(NSDate *)storedEndDateForWeek:(PTrackWeek)week;



-(int )totalHours:(NSTimeInterval) totalTime;


-(int )totalMinutes:(NSTimeInterval) totalTime;

-(NSString *)totalTimeStr:(NSTimeInterval )totalTimeTI;
-(NSTimeInterval )totalTimeIntervalForTrackArray:(NSArray *)trackArray predicate:(NSPredicate *)predicate;


-(NSTimeInterval )totalTimeIntervalForExistingHoursArray:(NSArray *)filteredExistingHoursArray keyPath:(NSString *)keyPath;



-(NSPredicate *)allHoursPredicateForClincian:(ClinicianEntity *)clinician;

-(NSPredicate *)priorMonthsHoursPredicateForClincian:(ClinicianEntity *)clinician;

-(NSPredicate *)predicateForTrackCurrentMonthsForClincian:(ClinicianEntity *)clinician;

-(NSPredicate *)predicateForExistingHoursCurrentMonthsForClincian:(ClinicianEntity *)clinician;


-(NSPredicate *)predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth:(NSDate *)dateInMonth;

-(NSPredicate *)predicateForExistingHoursAllBeforeAndEqualToEndDateForMonth:(NSDate *)dateInMonth;

-(NSPredicate *)predicateForExistingHoursAllBeforeEndDate:(NSDate *)date clinician:(ClinicianEntity *)clinician;


-(NSPredicate *)predicateForExistingHoursWeek:(PTrackWeek)week clincian:(ClinicianEntity *)clinician;

-(NSPredicate *)predicateForExistingHoursWeekUndefinedForClincian:(ClinicianEntity *)clinician;

-(NSPredicate *)predicateForTrackWeek:(PTrackWeek)week clincian:(ClinicianEntity *)clinician;



-(NSArray *)fetchObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate;


-(NSString *)timeStrFromTimeInterval:(NSTimeInterval )totalTime;  






@end
