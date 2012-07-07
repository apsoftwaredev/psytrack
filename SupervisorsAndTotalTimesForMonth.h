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


static NSString * const kTrackAssessmentEntityName=@"AssessmentEntity";
static NSString * const kTrackInterventionEntityName=@"InterventionDeliveredEntity";
static NSString * const kTrackSupportEntityName=@"SupportActivityDeliveredEntity";
static NSString * const kTrackSupervisionReceivedEntityName=@"SupervisionReceivedEntity";

static NSString * const kTrackExistingAssessmentEntityName=@"ExistingAssessmentEntity";
static NSString * const kTrackExistingInterventionEntityName=@"ExistingInterventionEntity";
static NSString * const kTrackExistingSupportEntityName=@"ExistingSupportActivityEntity";
static NSString * const kTrackExistingSupervisionReceivedEntityName=@"SupervisionReceivedEntity";



@interface SupervisorsAndTotalTimesForMonth : NSObject



@property (nonatomic, strong) NSDate *monthToDisplay;
@property (nonatomic, strong) NSArray *clinicians;




-(id)initWithMonth:(NSDate *)date;

-(NSArray *)interventionsArrayForClinician:(ClinicianEntity *) clinician;
-(NSArray *)assessmentsArrayForClinician:(ClinicianEntity *) clinician;
-(NSArray *)supportArrayForClinician:(ClinicianEntity *) clinician;
-(NSArray *)supervisionReceivedArrayForClinician:(ClinicianEntity *) clinician;



-(NSString *) totalCummulativeHoursStrForClinician:(ClinicianEntity *)clinician;
-(NSString *) totalOverallHoursMonthStrForclinician:(ClinicianEntity *)clinician;
-(NSString *) totalHoursToDateStrForClinician:(ClinicianEntity *)clinician;

-(NSString *) totalWeekHoursStrForClinician:(ClinicianEntity *)clinician week:(PTrackWeek )week;


-(NSString *) totalInterventionHoursStrForWeek:(PTrackWeek )week;

-(NSString *) totalInterventionHoursWeekUndefinedStr;
-(NSString *) totalInterventionHoursMonthStrForClinician:(ClinicianEntity *)clinician;
-(NSString *) totalInterventionHoursCummulativeStrForClinician:(ClinicianEntity *)clinician;
-(NSString *) totalInterventionHoursToDateStrForClinician:(ClinicianEntity *)clinician;

-(NSString *) totalAssessmentHoursStrForWeek:(PTrackWeek )week;

-(NSString *) totalAssessmentHoursWeekUndefinedStr;
-(NSString *) totalAssessmentHoursMonthStrForClinician:(ClinicianEntity *)clinician;
-(NSString *) totalAssessmentHoursCummulativeStrForClinician:(ClinicianEntity *)clinician;
-(NSString *) totalAssessmentHoursToDateStrForClinician:(ClinicianEntity *)clinician;



-(NSString *) totalDirectHoursStrForWeek:(PTrackWeek )week;

-(NSString *) totalDirectHoursWeekUndefinedStr;
-(NSString *) totalDirectHoursMonthStrForClinician:(ClinicianEntity *)clinician;
-(NSString *) totalDirectHoursCummulativeStrForClinician:(ClinicianEntity *)clinician;
-(NSString *) totalDirectHoursToDateStrForClinician:(ClinicianEntity *)clinician;






-(NSString *) totalSupportHoursStrForWeek:(PTrackWeek )week;

-(NSString *) totalSupportHoursMonthStrForClinician:(ClinicianEntity *)clinician;
-(NSString *) totalSupportHoursCummulativeStrForClinician:(ClinicianEntity *)clinician;
-(NSString *) totalSupportHoursToDateStrForClinician:(ClinicianEntity *)clinician;


-(NSString *) totalSupervisiontHoursStrForWeek:(PTrackWeek )week;

-(NSString *) totalSupervisionHoursMonthStrForClinician:(ClinicianEntity *)clinician;
-(NSString *) totalSupervisionHoursCummulativeStrForClinician:(ClinicianEntity *)clinician;
-(NSString *) totalSupervisionHoursToDateStrForClinician:(ClinicianEntity *)clinician;


-(NSTimeInterval )totalTimeIntervalForArray:(NSArray *)totalTimesArray;

@end
