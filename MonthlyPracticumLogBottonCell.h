/*
 *  MonthlyPracticumLogBottonCell.h
 *  psyTrack
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 6/26/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import "ClinicianEntity.h"
#import "TrackTypeWithTotalTimes.h"

@interface MonthlyPracticumLogBottonCell : SCCustomCell {

    __weak ClinicianEntity *clinician_;
    __weak NSDate *monthToDisplay_;
    __weak TrackTypeWithTotalTimes *trackTypeWithTotalTimesObject_;
}



@property (nonatomic, weak)  TrackTypeWithTotalTimes *trackTypeWithTotalTimesObject;
@property (nonatomic, weak)IBOutlet UIView *cellsContainerView;
@property (nonatomic, weak)IBOutlet UILabel *cellSubTypeLabel;
@property (nonatomic, weak)IBOutlet UILabel *hoursWeek1Label;
@property (nonatomic, weak)IBOutlet UILabel *hoursWeek2Label;
@property (nonatomic, weak)IBOutlet UILabel *hoursWeek3Label;
@property (nonatomic, weak)IBOutlet UILabel *hoursWeek4Label;
@property (nonatomic, weak)IBOutlet UILabel *hoursWeek5Label;
@property (nonatomic, weak)IBOutlet UILabel *hoursWeekUndefinedLabel;
@property (nonatomic, weak)IBOutlet UILabel *hoursMonthTotalLabel;
@property (nonatomic, weak)IBOutlet UILabel *hoursCumulativeLabel;
@property (nonatomic, weak)IBOutlet UILabel *hoursTotalHoursLabel;




@end
