/*
 *  InterventionTypeWithTotalTimes.h
 *  psyTrack
 *  Version: 1.0
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
@property (nonatomic, assign) NSUInteger order;
@property (nonatomic, assign)  PTrackType trackType;
@property (nonatomic, strong) NSString *trackPathStartString;
@property (nonatomic, strong) id trackTypeObject;
@property (nonatomic, strong) NSString *monthlyLogNotes;
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

- (id) initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician trackTypeObject:(id)trackTypeObjectGiven trainingProgram:(TrainingProgramEntity *)trainingProgramGiven;

- (void) totalOverallHoursTIForOveralCell:(PTSummaryCell)summaryCell clinician:(ClinicianEntity *)clinician;

- (id) initWithDoctorateLevel:(BOOL)doctoarateLevelSelected clinician:(ClinicianEntity *)supervisor trackTypeObject:(id)trackTypeObjectGiven;
@end
