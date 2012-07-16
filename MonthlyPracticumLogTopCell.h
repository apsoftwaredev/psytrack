//
//  MonthlyPracticumLogTopCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/24/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ClinicianEntity.h"

@interface MonthlyPracticumLogTopCell : SCCustomCell <SCTableViewModelDelegate, SCTableViewControllerDelegate, UITableViewDelegate, SCTableViewModelDataSource>{


    SCArrayOfObjectsModel *interventionObjectsModel_;
    SCArrayOfObjectsModel *assessmentObjectsModel_;
    SCArrayOfObjectsModel *supportObjectsModel_;
    SCArrayOfObjectsModel *supervisionObjectsModel_;
    
    
    
    CGFloat currentOffsetY;

}

@property (nonatomic,strong)  SCArrayOfObjectsModel *interventionObjectsModel;
@property (nonatomic,strong)  SCArrayOfObjectsModel *assessmentObjectsModel;
@property (nonatomic,strong)  SCArrayOfObjectsModel *supportObjectsModel;
@property (nonatomic,strong)  SCArrayOfObjectsModel *supervisionObjectsModel;

@property (nonatomic, weak)IBOutlet UITableView *interventionTypesTableView;
@property (nonatomic, weak)IBOutlet UITableView *assessmentTypesTableView;
@property (nonatomic, weak)IBOutlet UITableView *supportActivitieTypesTableView;
@property (nonatomic, weak)IBOutlet UITableView *supervisionReceivedTypesTableView;

@property (nonatomic, weak)IBOutlet UILabel *studentNameLabel;
@property (nonatomic, weak)IBOutlet UILabel *practicumSiteNameLabel;
@property (nonatomic, weak)IBOutlet UILabel *programLabel;
@property (nonatomic, weak)IBOutlet UILabel *monthYearLabel;

@property (nonatomic, weak)IBOutlet UILabel *supervisorLabel;
@property (nonatomic, weak)IBOutlet UILabel *courseLabel;

@property (nonatomic, weak)IBOutlet UILabel *interventionHoursWeek1Label;
@property (nonatomic, weak)IBOutlet UILabel *interventionHoursWeek2Label;
@property (nonatomic, weak)IBOutlet UILabel *interventionHoursWeek3Label;
@property (nonatomic, weak)IBOutlet UILabel *interventionHoursWeek4Label;
@property (nonatomic, weak)IBOutlet UILabel *interventionHoursWeek5Label;
@property (nonatomic, weak)IBOutlet UILabel *interventionHoursWeekUndefinedLabel;

@property (nonatomic, weak)IBOutlet UILabel *interventionHoursMonthTotalLabel;
@property (nonatomic, weak)IBOutlet UILabel *interventionHoursCummulativeLabel;
@property (nonatomic, weak)IBOutlet UILabel *interventionHoursTotalHoursLabel;

@property (nonatomic, weak)IBOutlet UILabel *assessmentHoursWeek1Label;
@property (nonatomic, weak)IBOutlet UILabel *assessmentHoursWeek2Label;
@property (nonatomic, weak)IBOutlet UILabel *assessmentHoursWeek3Label;
@property (nonatomic, weak)IBOutlet UILabel *assessmentHoursWeek4Label;
@property (nonatomic, weak)IBOutlet UILabel *assessmentHoursWeek5Label;
@property (nonatomic, weak)IBOutlet UILabel *assessmentHoursMonthTotalLabel;
@property (nonatomic, weak)IBOutlet UILabel *assessmentHoursCummulativeLabel;
@property (nonatomic, weak)IBOutlet UILabel *assessmentHoursTotalHoursLabel;
@property (nonatomic, weak)IBOutlet UILabel *assessmentoursWeekUndefinedLabel;

@property (nonatomic, weak)IBOutlet UILabel *supportHoursWeek1Label;
@property (nonatomic, weak)IBOutlet UILabel *supportHoursWeek2Label;
@property (nonatomic, weak)IBOutlet UILabel *supportHoursWeek3Label;
@property (nonatomic, weak)IBOutlet UILabel *supportHoursWeek4Label;
@property (nonatomic, weak)IBOutlet UILabel *supportHoursWeek5Label;
@property (nonatomic, weak)IBOutlet UILabel *supportHoursMonthTotalLabel;
@property (nonatomic, weak)IBOutlet UILabel *supportHoursCummulativeLabel;
@property (nonatomic, weak)IBOutlet UILabel *supportHoursTotalHoursLabel;
@property (nonatomic, weak)IBOutlet UILabel *supportHoursWeekUndefinedLabel;

@property (nonatomic, weak)IBOutlet UILabel *supervisionHoursWeek1Label;
@property (nonatomic, weak)IBOutlet UILabel *supervisionHoursWeek2Label;
@property (nonatomic, weak)IBOutlet UILabel *supervisionHoursWeek3Label;
@property (nonatomic, weak)IBOutlet UILabel *supervisionHoursWeek4Label;
@property (nonatomic, weak)IBOutlet UILabel *supervisionHoursWeek5Label;
@property (nonatomic, weak)IBOutlet UILabel *supervisionHoursMonthTotalLabel;
@property (nonatomic, weak)IBOutlet UILabel *supervisionHoursCummulativeLabel;
@property (nonatomic, weak)IBOutlet UILabel *supervisionHoursTotalHoursLabel;
@property (nonatomic, weak)IBOutlet UILabel *supervisionHoursWeekUndefinedLabel;

@property (nonatomic, weak)IBOutlet UILabel *directHoursWeek1Label;
@property (nonatomic, weak)IBOutlet UILabel *directHoursWeek2Label;
@property (nonatomic, weak)IBOutlet UILabel *directHoursWeek3Label;
@property (nonatomic, weak)IBOutlet UILabel *directHoursWeek4Label;
@property (nonatomic, weak)IBOutlet UILabel *directHoursWeek5Label;
@property (nonatomic, weak)IBOutlet UILabel *directHoursMonthTotalLabel;
@property (nonatomic, weak)IBOutlet UILabel *directHoursCummulativeLabel;
@property (nonatomic, weak)IBOutlet UILabel *directHoursTotalHoursLabel;
@property (nonatomic, weak)IBOutlet UILabel *directHoursWeekUndefinedLabel;

@property (nonatomic, weak)IBOutlet UILabel *overallHoursWeek1Label;
@property (nonatomic, weak)IBOutlet UILabel *overallHoursWeek2Label;
@property (nonatomic, weak)IBOutlet UILabel *overallHoursWeek3Label;
@property (nonatomic, weak)IBOutlet UILabel *overallHoursWeek4Label;
@property (nonatomic, weak)IBOutlet UILabel *overallHoursWeek5Label;
@property (nonatomic, weak)IBOutlet UILabel *overallHoursMonthTotalLabel;
@property (nonatomic, weak)IBOutlet UILabel *overallHoursCummulativeLabel;
@property (nonatomic, weak)IBOutlet UILabel *overallHoursTotalHoursLabel;
@property (nonatomic, weak)IBOutlet UILabel *overallHoursWeekUndefinedLabel;



@property (nonatomic, weak)IBOutlet UIView *sectionSubHeaderView;
@property (nonatomic, weak)IBOutlet UILabel *sectionSubHeaderLabel;
@property (nonatomic, weak)IBOutlet UIView *sectionSubFooterView;
@property (nonatomic, weak)IBOutlet UIView *sectionSubFooterLabelContainerView;
@property (nonatomic, weak)IBOutlet UILabel *sectionSubFooterLabel;
@property (nonatomic, weak)IBOutlet UITextView *sectionSubFooterNotesTextView;

@property (nonatomic, weak)IBOutlet UIView *directHoursHeader;
@property (nonatomic, weak)IBOutlet UIView *directHoursFooter;
@property (nonatomic, weak)IBOutlet UIView *indirectHoursHeader;
@property (nonatomic, weak)IBOutlet UIView *overallHoursFooter;
@property (nonatomic, weak)IBOutlet UIView *signaturesView;
@property (nonatomic, weak)IBOutlet UIView *totalInterventionHoursFooterView;
@property (nonatomic, weak)IBOutlet UIView *pageHeaderView;
@property (nonatomic, weak)IBOutlet UIView *subTablesContainerView;

@property (nonatomic, weak)IBOutlet UIScrollView *mainPageScrollView;
@property (nonatomic, weak)IBOutlet UIScrollView *directHoursScrollView;
@property (nonatomic, weak)IBOutlet UIScrollView *indirectHoursScrollView;

@property (nonatomic, weak) NSDate *monthToDisplay;
@property (nonatomic, weak) ClinicianEntity *clinician;

- (CGSize)interventionTableViewContentSize;
@property (nonatomic, assign)BOOL stopScrolling;


@end
