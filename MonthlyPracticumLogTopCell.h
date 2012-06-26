//
//  MonthlyPracticumLogTopCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/24/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//



@interface MonthlyPracticumLogTopCell : SCCustomCell



@property (nonatomic, strong)IBOutlet UITableView *interventionTypesTableView;
@property (nonatomic, strong)IBOutlet UITableView *assessmentTypesTableView;
@property (nonatomic, strong)IBOutlet UITableView *supportActivitieTypesTableView;
@property (nonatomic, strong)IBOutlet UITableView *supervisionReceivedTypesTableView;

@property (nonatomic, strong)IBOutlet UILabel *studentNameLabel;
@property (nonatomic, strong)IBOutlet UILabel *practicumSiteNameLabel;
@property (nonatomic, strong)IBOutlet UILabel *programLabel;
@property (nonatomic, strong)IBOutlet UILabel *monthYearLabel;

@property (nonatomic, strong)IBOutlet UILabel *supervisorLabel;
@property (nonatomic, strong)IBOutlet UILabel *courseLabel;

@property (nonatomic, strong)IBOutlet UILabel *interventionHoursWeek1Label;
@property (nonatomic, strong)IBOutlet UILabel *interventionHoursWeek2Label;
@property (nonatomic, strong)IBOutlet UILabel *interventionHoursWeek3Label;
@property (nonatomic, strong)IBOutlet UILabel *interventionHoursWeek4Label;
@property (nonatomic, strong)IBOutlet UILabel *interventionHoursWeek5Label;
@property (nonatomic, strong)IBOutlet UILabel *interventionHoursMonthTotalLabel;
@property (nonatomic, strong)IBOutlet UILabel *interventionHoursCumulativeLabel;
@property (nonatomic, strong)IBOutlet UILabel *interventionHourTotalHoursLabel;

@property (nonatomic, strong)IBOutlet UILabel *assessmentHoursWeek1Label;
@property (nonatomic, strong)IBOutlet UILabel *assessmentHoursWeek2Label;
@property (nonatomic, strong)IBOutlet UILabel *assessmentHoursWeek3Label;
@property (nonatomic, strong)IBOutlet UILabel *assessmentHoursWeek4Label;
@property (nonatomic, strong)IBOutlet UILabel *assessmentHoursWeek5Label;
@property (nonatomic, strong)IBOutlet UILabel *assessmentHoursMonthTotalLabel;
@property (nonatomic, strong)IBOutlet UILabel *assessmentHoursCumulativeLabel;
@property (nonatomic, strong)IBOutlet UILabel *assessmentHourTotalHoursLabel;

@property (nonatomic, strong)IBOutlet UILabel *supportHoursWeek1Label;
@property (nonatomic, strong)IBOutlet UILabel *supportHoursWeek2Label;
@property (nonatomic, strong)IBOutlet UILabel *supportHoursWeek3Label;
@property (nonatomic, strong)IBOutlet UILabel *supportHoursWeek4Label;
@property (nonatomic, strong)IBOutlet UILabel *supportHoursWeek5Label;
@property (nonatomic, strong)IBOutlet UILabel *supportHoursMonthTotalLabel;
@property (nonatomic, strong)IBOutlet UILabel *supportHoursCumulativeLabel;
@property (nonatomic, strong)IBOutlet UILabel *supportHourTotalHoursLabel;

@property (nonatomic, strong)IBOutlet UILabel *supervisionHoursWeek1Label;
@property (nonatomic, strong)IBOutlet UILabel *supervisionHoursWeek2Label;
@property (nonatomic, strong)IBOutlet UILabel *supervisionHoursWeek3Label;
@property (nonatomic, strong)IBOutlet UILabel *supervisionHoursWeek4Label;
@property (nonatomic, strong)IBOutlet UILabel *supervisionHoursWeek5Label;
@property (nonatomic, strong)IBOutlet UILabel *supervisionHoursMonthTotalLabel;
@property (nonatomic, strong)IBOutlet UILabel *supervisionHoursCumulativeLabel;
@property (nonatomic, strong)IBOutlet UILabel *supervisionHourTotalHoursLabel;








@end
