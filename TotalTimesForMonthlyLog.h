//
//  TotalTimesForMonthlyLog.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 7/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClinicianEntity.h"
#import "TrainingProgramEntity.h"

typedef enum {
    kTrackAssessment,
    kTrackIntervention,
    kTrackSupport,
    kTrackSupervisionReceived,
    kTrackExistingHours
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

static NSString *const kTrackAssessmentEntityName = @"AssessmentEntity";
static NSString *const kTrackInterventionEntityName = @"InterventionDeliveredEntity";
static NSString *const kTrackSupportEntityName = @"SupportActivityDeliveredEntity";
static NSString *const kTrackSupervisionReceivedEntityName = @"SupervisionReceivedEntity";

static NSString *const kTrackExistingHoursEntityName = @"ExistingHoursEntity";
static NSString *const kTrackExistingAssessmentEntityName = @"ExistingAssessmentEntity";
static NSString *const kTrackExistingInterventionEntityName = @"ExistingInterventionEntity";
static NSString *const kTrackExistingSupportEntityName = @"ExistingSupportActivityEntity";
static NSString *const kTrackExistingSupervisionReceivedEntityName = @"SupervisionReceivedEntity";

static NSString *const kTrackKeyPathForExistingHoursInterventionHours = @"directInterventions.hours";
static NSString *const kTrackKeyPathForExistingHoursAssessmentHours = @"assessments.hours";
static NSString *const kTrackKeyPathForExistingHoursSupportActivityHours = @"supportActivities.hours";
static NSString *const kTrackKeyPathForExistingHoursSupervisionReceivedHours = @"supervisionReceived.hours";

@interface TotalTimesForMonthlyLog : NSObject {
    NSDate *monthToDisplay_;
    ClinicianEntity *clinician_;
    TrainingProgramEntity *trainingProgram_;
    NSArray *clinicians_;
    NSDate *monthStartDate_;
    NSDate *monthEndDate_;
    NSSet *interventionsDeliveredArray_;
    NSSet *assessmentsDeliveredArray_;
    NSSet *supportActivityDeliveredArray_;
    NSSet *supervisionReceivedArray_;

    NSSet *existingInterventionsArray_;
    NSSet *existingAssessmentsArray_;
    NSSet *existingSupportArray_;
    NSSet *existingSupervisionArray_;
    NSArray *existingHoursArray_;

    NSDate *week1StartDate_;
    NSDate *week1EndDate_;
    NSDate *week2StartDate_;
    NSDate *week2EndDate_;
    NSDate *week3StartDate_;
    NSDate *week3EndDate_;
    NSDate *week4StartDate_;
    NSDate *week4EndDate_;
    NSDate *week5StartDate_;
    NSDate *week5EndDate_;

    BOOL doctorateLevel_;
}

@property (nonatomic, assign) BOOL doctorateLevel;
@property (nonatomic, strong) ClinicianEntity *clinician;

@property (nonatomic, strong) TrainingProgramEntity *trainingProgram;
@property (nonatomic, strong) NSDate *monthToDisplay;
@property (nonatomic, strong) NSDate *monthStartDate;
@property (nonatomic, strong) NSDate *monthEndDate;

@property (nonatomic, strong) NSDate *week1StartDate;
@property (nonatomic, strong) NSDate *week1EndDate;
@property (nonatomic, strong) NSDate *week2StartDate;
@property (nonatomic, strong) NSDate *week2EndDate;
@property (nonatomic, strong) NSDate *week3StartDate;
@property (nonatomic, strong) NSDate *week3EndDate;
@property (nonatomic, strong) NSDate *week4StartDate;
@property (nonatomic, strong) NSDate *week4EndDate;
@property (nonatomic, strong) NSDate *week5StartDate;
@property (nonatomic, strong) NSDate *week5EndDate;

@property (nonatomic, strong) NSSet *interventionsDeliveredArray;
@property (nonatomic, strong) NSSet *assessmentsDeliveredArray;
@property (nonatomic, strong) NSSet *supportActivityDeliveredArray;
@property (nonatomic, strong) NSSet *supervisionReceivedArray;

@property (nonatomic, strong) NSArray *existingHoursArray;

@property (nonatomic, strong) NSSet *existingHInterventionrray;

@property (nonatomic, strong) NSSet *existingAssessmentArray;

@property (nonatomic, strong) NSSet *existingSupportArray;

@property (nonatomic, strong) NSSet *existingSupervisionArray;

- (id) initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician trainingProgram:(TrainingProgramEntity *)trainingProgramGiven;

- (id) initWithDoctorateLevel:(BOOL)doctorateLevelGiven clinician:(ClinicianEntity *)clinician trainingProgram:(TrainingProgramEntity *)trainingProgramGiven;

- (NSPredicate *) predicateForExistingHoursDoctorateLevel;
- (NSPredicate *) predicateForTrackDoctorateLevel;
- (NSTimeInterval) totalTimeIntervalForTotalTimeArray:(NSArray *)totalTimesArray;

- (NSDate *) monthStartDateForDate:(NSDate *)date;

- (NSDate *) monthEndDate:(NSDate *)date;

- (NSDate *) weekStartDate:(PTrackWeek)week;
- (NSDate *) weekEndDate:(PTrackWeek)week;

- (NSDate *) storedStartDateForWeek:(PTrackWeek)week;

- (NSDate *) storedEndDateForWeek:(PTrackWeek)week;

- (int) totalHours:(NSTimeInterval)totalTime;

- (int) totalMinutes:(NSTimeInterval)totalTime;

- (NSString *) totalTimeStr:(NSTimeInterval)totalTimeTI;
- (NSTimeInterval) totalTimeIntervalForTrackArray:(NSSet *)trackArray predicate:(NSPredicate *)predicate;

- (NSTimeInterval) totalTimeIntervalForExistingHoursArray:(NSArray *)filteredExistingHoursArray keyPath:(NSString *)keyPath;

- (NSPredicate *) predicateForClincian;
- (NSPredicate *) priorMonthsHoursPredicate;

- (NSPredicate *) predicateForTrackCurrentMonth;

- (NSPredicate *) predicateForExistingHoursCurrentMonth;

- (NSPredicate *) predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth;

- (NSPredicate *) predicateForExistingHoursAllBeforeAndEqualToEndDateForMonth;

- (NSPredicate *) predicateForExistingHoursAllBeforeEndDate:(NSDate *)date;

- (NSPredicate *) predicateForExistingHoursWeek:(PTrackWeek)week;
- (NSPredicate *) predicateForExistingHoursWeekUndefined;
- (NSPredicate *) predicateForTrackWeek:(PTrackWeek)week;

- (NSArray *) fetchObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate;

- (NSString *) timeStrFromTimeInterval:(NSTimeInterval)totalTime;

- (NSPredicate *) predicateForTrackTrainingProgram;

- (NSPredicate *) predicateForExistingHoursProgramCourse;

- (NSTimeInterval) totalTimeIntervalForExistingHoursArray:(NSArray *)filteredExistingHoursArray;
@end
