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
    
    NSString *trackPathStartString_;
    
      NSString *monthlyLogNotes_;
}

@property (nonatomic, assign)  PTrackType trackType;;
@property (nonatomic, strong) NSString *trackPathStartString;
@property (nonatomic, strong) id trackTypeObject;
@property (nonatomic, strong)NSString *monthlyLogNotes;
@property (nonatomic, strong) NSString *typeLabelText;

@property (nonatomic, strong) NSString *totalWeek1Str;
@property (nonatomic, strong) NSString *totalWeek2Str;
@property (nonatomic, strong) NSString *totalWeek3Str;
@property (nonatomic, strong) NSString *totalWeek4Str;
@property (nonatomic, strong) NSString *totalWeek5Str;

@property (nonatomic, assign) NSTimeInterval totalWeek1TI;
@property (nonatomic, assign) NSTimeInterval totalWeek2TI;
@property (nonatomic, assign) NSTimeInterval totalWeek3TI;
@property (nonatomic, assign) NSTimeInterval totalWeek4TI;
@property (nonatomic, assign) NSTimeInterval totalWeek5TI;


@property (nonatomic, strong) NSString *totalWeekUndefinedStr;
@property (nonatomic, assign) NSTimeInterval totalWeekUndefinedTI;

@property (nonatomic, strong) NSString *totalForMonthStr;
@property (nonatomic, assign) NSTimeInterval totalForMonthTI;

@property (nonatomic, strong) NSString *totalCummulativeStr;
@property (nonatomic, assign) NSTimeInterval totalCummulativeTI;

@property (nonatomic, strong) NSString *totalToDateStr;
@property (nonatomic, assign) NSTimeInterval totalToDateTI;

-(id)initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician trackTypeObject:(id)trackTypeObjectGiven trainingProgram:(TrainingProgramEntity *)trainingProgramGiven;

-(void ) totalOverallHoursTIForOveralCell:(PTSummaryCell)summaryCell clinician:(ClinicianEntity *)clinician;

-(id)initWithDoctorateLevel:(BOOL)doctoarateLevelSelected clinician:(ClinicianEntity *)supervisor trackTypeObject:(id)trackTypeObjectGiven;
@end
