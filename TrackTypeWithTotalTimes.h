/*
 *  InterventionTypeWithTotalTimes.h
 *  psyTrack
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 7/10/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import "SupervisorsAndTotalTimesForMonth.h"
#import "InterventionTypeEntity.h"
#import "ClinicianEntity.h"
#import "TrainingProgramEntity.h"
typedef enum {
    kTrackTypeUnknown,
    kTrackTypeIntervention,
    kTrackTypeInterventionSubType,
    kTrackTypeAssessment,
    kTrackTypeSupport,
    kTrackTypeSupervision,
    kTrackTypeSupervisionSubType
} PTrackType;



@interface TrackTypeWithTotalTimes : TotalTimesForMonthlyLog {
    
    
   
    PTrackType trackType_;
    
   __weak NSString *trackPathStartString_;
    
     __weak NSString *monthlyLogNotes_;
}

@property (nonatomic, assign)  PTrackType trackType;;
@property (nonatomic, weak) NSString *trackPathStartString;
@property (nonatomic, weak) id trackTypeObject;
@property (nonatomic, weak)NSString *monthlyLogNotes;
@property (nonatomic, weak) NSString *typeLabelText;

@property (nonatomic, weak) NSString *totalWeek1Str;
@property (nonatomic, weak) NSString *totalWeek2Str;
@property (nonatomic, weak) NSString *totalWeek3Str;
@property (nonatomic, weak) NSString *totalWeek4Str;
@property (nonatomic, weak) NSString *totalWeek5Str;

@property (nonatomic, assign) NSTimeInterval totalWeek1TI;
@property (nonatomic, assign) NSTimeInterval totalWeek2TI;
@property (nonatomic, assign) NSTimeInterval totalWeek3TI;
@property (nonatomic, assign) NSTimeInterval totalWeek4TI;
@property (nonatomic, assign) NSTimeInterval totalWeek5TI;


@property (nonatomic, weak) NSString *totalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval totalWeekUndefinedTI;

@property (nonatomic, weak) NSString *totalForMonthStr;
@property (nonatomic, assign) NSTimeInterval totalForMonthTI;

@property (nonatomic, weak) NSString *totalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval totalCummulativeTI;

@property (nonatomic, weak) NSString *totalToDateStr;
@property (nonatomic, assign) NSTimeInterval totalToDateTI;

-(id)initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician trackTypeObject:(id)trackTypeObjectGiven trainingProgram:(TrainingProgramEntity *)trainingProgramGiven;

-(void ) totalOverallHoursTIForOveralCell:(PTSummaryCell)summaryCell clinician:(ClinicianEntity *)clinician;


@end
