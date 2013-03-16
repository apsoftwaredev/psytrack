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
#import "TotalTimesForMonthlyLog.h"

@interface SupervisorsAndTotalTimesForMonth : TotalTimesForMonthlyLog {
    NSString *assessmentMonthlyNotes_;
    NSString *supportMonthlyNotes_;
}

@property (nonatomic, assign) NSInteger numberOfProgramCourses;
@property (nonatomic, strong) NSString *trainingProgramsStr;
@property (nonatomic, strong) NSArray *clinicians;
@property (nonatomic, strong) NSString *cliniciansStr;
@property (nonatomic, strong) NSString *practicumSiteNamesStr;
@property (nonatomic, assign) NSInteger numberOfSites;

@property (nonatomic, strong) NSString *studentNameStr;
@property (nonatomic, strong) NSString *practicumSeminarInstructtor;
@property (nonatomic, strong) NSString *schoolNameStr;
@property (nonatomic, strong) NSString *monthAndYearsInParentheses;

@property (nonatomic, strong) NSString *interventionTotalWeek1Str;
@property (nonatomic, strong) NSString *interventionTotalWeek2Str;
@property (nonatomic, strong) NSString *interventionTotalWeek3Str;
@property (nonatomic, strong) NSString *interventionTotalWeek4Str;
@property (nonatomic, strong) NSString *interventionTotalWeek5Str;

@property (nonatomic, assign) NSTimeInterval interventionTotalWeek1TI;
@property (nonatomic, assign) NSTimeInterval interventionTotalWeek2TI;
@property (nonatomic, assign) NSTimeInterval interventionTotalWeek3TI;
@property (nonatomic, assign) NSTimeInterval interventionTotalWeek4TI;
@property (nonatomic, assign) NSTimeInterval interventionTotalWeek5TI;

@property (nonatomic, strong) NSString *interventionTotalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval interventionTotalWeekUndefinedTI;

@property (nonatomic, strong) NSString *interventionTotalForMonthStr;
@property (nonatomic, assign) NSTimeInterval interventionTotalForMonthTI;

@property (nonatomic, strong) NSString *interventionTotalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval interventionTotalCummulativeTI;

@property (nonatomic, strong) NSString *interventionTotalToDateStr;
@property (nonatomic, assign) NSTimeInterval interventionTotalToDateTI;

@property (nonatomic, strong) NSString *assessmentTotalWeek1Str;
@property (nonatomic, strong) NSString *assessmentTotalWeek2Str;
@property (nonatomic, strong) NSString *assessmentTotalWeek3Str;
@property (nonatomic, strong) NSString *assessmentTotalWeek4Str;
@property (nonatomic, strong) NSString *assessmentTotalWeek5Str;

@property (nonatomic, assign) NSTimeInterval assessmentTotalWeek1TI;
@property (nonatomic, assign) NSTimeInterval assessmentTotalWeek2TI;
@property (nonatomic, assign) NSTimeInterval assessmentTotalWeek3TI;
@property (nonatomic, assign) NSTimeInterval assessmentTotalWeek4TI;
@property (nonatomic, assign) NSTimeInterval assessmentTotalWeek5TI;

@property (nonatomic, strong) NSString *assessmentTotalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval assessmentTotalWeekUndefinedTI;

@property (nonatomic, strong) NSString *assessmentTotalForMonthStr;
@property (nonatomic, assign) NSTimeInterval assessmentTotalForMonthTI;

@property (nonatomic, strong) NSString *assessmentTotalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval assessmentTotalCummulativeTI;

@property (nonatomic, strong) NSString *assessmentTotalToDateStr;
@property (nonatomic, assign) NSTimeInterval assessmentTotalToDateTI;

@property (nonatomic, strong) NSString *supportTotalWeek1Str;
@property (nonatomic, strong) NSString *supportTotalWeek2Str;
@property (nonatomic, strong) NSString *supportTotalWeek3Str;
@property (nonatomic, strong) NSString *supportTotalWeek4Str;
@property (nonatomic, strong) NSString *supportTotalWeek5Str;

@property (nonatomic, assign) NSTimeInterval supportTotalWeek1TI;
@property (nonatomic, assign) NSTimeInterval supportTotalWeek2TI;
@property (nonatomic, assign) NSTimeInterval supportTotalWeek3TI;
@property (nonatomic, assign) NSTimeInterval supportTotalWeek4TI;
@property (nonatomic, assign) NSTimeInterval supportTotalWeek5TI;

@property (nonatomic, strong) NSString *supportTotalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval supportTotalWeekUndefinedTI;

@property (nonatomic, strong) NSString *supportTotalForMonthStr;
@property (nonatomic, assign) NSTimeInterval supportTotalForMonthTI;

@property (nonatomic, strong) NSString *supportTotalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval supportTotalCummulativeTI;

@property (nonatomic, strong) NSString *supportTotalToDateStr;
@property (nonatomic, assign) NSTimeInterval supportTotalToDateTI;

@property (nonatomic, strong) NSString *supervisionTotalWeek1Str;
@property (nonatomic, strong) NSString *supervisionTotalWeek2Str;
@property (nonatomic, strong) NSString *supervisionTotalWeek3Str;
@property (nonatomic, strong) NSString *supervisionTotalWeek4Str;
@property (nonatomic, strong) NSString *supervisionTotalWeek5Str;

@property (nonatomic, assign) NSTimeInterval supervisionTotalWeek1TI;
@property (nonatomic, assign) NSTimeInterval supervisionTotalWeek2TI;
@property (nonatomic, assign) NSTimeInterval supervisionTotalWeek3TI;
@property (nonatomic, assign) NSTimeInterval supervisionTotalWeek4TI;
@property (nonatomic, assign) NSTimeInterval supervisionTotalWeek5TI;

@property (nonatomic, strong) NSString *supervisionTotalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval supervisionTotalWeekUndefinedTI;

@property (nonatomic, strong) NSString *supervisionTotalForMonthStr;
@property (nonatomic, assign) NSTimeInterval supervisionTotalForMonthTI;

@property (nonatomic, strong) NSString *supervisionTotalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval supervisionTotalCummulativeTI;

@property (nonatomic, strong) NSString *supervisionTotalToDateStr;
@property (nonatomic, assign) NSTimeInterval supervisionTotalToDateTI;

@property (nonatomic, strong) NSString *directTotalWeek1Str;
@property (nonatomic, strong) NSString *directTotalWeek2Str;
@property (nonatomic, strong) NSString *directTotalWeek3Str;
@property (nonatomic, strong) NSString *directTotalWeek4Str;
@property (nonatomic, strong) NSString *directTotalWeek5Str;

@property (nonatomic, assign) NSTimeInterval directTotalWeek1TI;
@property (nonatomic, assign) NSTimeInterval directTotalWeek2TI;
@property (nonatomic, assign) NSTimeInterval directTotalWeek3TI;
@property (nonatomic, assign) NSTimeInterval directTotalWeek4TI;
@property (nonatomic, assign) NSTimeInterval directTotalWeek5TI;

@property (nonatomic, strong) NSString *directTotalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval directTotalWeekUndefinedTI;

@property (nonatomic, strong) NSString *directTotalForMonthStr;
@property (nonatomic, assign) NSTimeInterval directTotalForMonthTI;

@property (nonatomic, strong) NSString *directTotalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval directTotalCummulativeTI;

@property (nonatomic, strong) NSString *directTotalToDateStr;
@property (nonatomic, assign) NSTimeInterval directTotalToDateTI;

@property (nonatomic, strong) NSString *overallTotalWeek1Str;
@property (nonatomic, strong) NSString *overallTotalWeek2Str;
@property (nonatomic, strong) NSString *overallTotalWeek3Str;
@property (nonatomic, strong) NSString *overallTotalWeek4Str;
@property (nonatomic, strong) NSString *overallTotalWeek5Str;

@property (nonatomic, assign) NSTimeInterval overallTotalWeek1TI;
@property (nonatomic, assign) NSTimeInterval overallTotalWeek2TI;
@property (nonatomic, assign) NSTimeInterval overallTotalWeek3TI;
@property (nonatomic, assign) NSTimeInterval overallTotalWeek4TI;
@property (nonatomic, assign) NSTimeInterval overallTotalWeek5TI;

@property (nonatomic, strong) NSString *overallTotalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval overallTotalWeekUndefinedTI;

@property (nonatomic, strong) NSString *overallTotalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval overallTotalCummulativeTI;

@property (nonatomic, strong) NSString *overallTotalToDateStr;
@property (nonatomic, assign) NSTimeInterval overallTotalToDateTI;

@property (nonatomic, strong) NSString *overallTotalForMonthStr;
@property (nonatomic, assign) NSTimeInterval overallTotalForMonthTI;

@property (nonatomic, strong) NSString *assessmentMonthlyNotes;
@property (nonatomic, strong) NSString *supportMonthlyNotes;
@property (nonatomic, assign) BOOL markAmended;

- (id) initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician trainingProgram:(TrainingProgramEntity *)trainingProgramGiven markAmended:(BOOL)markAmendedGiven;

- (id) initWithDoctorateLevel:(BOOL)doctoarateLevelSelected clinician:(ClinicianEntity *)supervisor;

- (void) calculateDirectlHours;

- (NSTimeInterval) totalOverallHoursTIForOveralCell:(PTSummaryCell)overallCell clinician:(ClinicianEntity *)clinician;

- (NSString *) monthlyLogNotesForMonth:(PTrackEntity)ptrackEntityType;
@end
