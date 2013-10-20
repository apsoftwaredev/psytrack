//
//  AllHoursReportTopCell.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 9/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ClinicianEntity.h"
@interface AllHoursReportTopCell : SCCustomCell <SCTableViewModelDelegate, SCTableViewControllerDelegate, UITableViewDelegate, SCTableViewModelDataSource>{
    SCTableViewModel *interventionTableViewModel_;
    SCTableViewModel *assessmentTableViewModel_;
    SCTableViewModel *supportTableViewModel_;
    SCTableViewModel *supervisionTableViewModel_;

    NSInteger numberOfSupervisors;

    BOOL markAmended;
    CGFloat currentOffsetY;
    NSInteger pageNumber;
}

@property (nonatomic,strong)  SCTableViewModel *interventionTableViewModel;
@property (nonatomic,strong)  SCTableViewModel *assessmentTableViewModel;
@property (nonatomic,strong)  SCTableViewModel *supportTableViewModel;
@property (nonatomic,strong)  SCTableViewModel *supervisionTableViewModel;

@property (nonatomic, weak) IBOutlet UITableView *interventionTypesTableView;
@property (nonatomic, weak) IBOutlet UITableView *assessmentTypesTableView;
@property (nonatomic, weak) IBOutlet UITableView *supportActivitieTypesTableView;
@property (nonatomic, weak) IBOutlet UITableView *supervisionReceivedTypesTableView;

@property (nonatomic, weak) IBOutlet UILabel *studentNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *programLabel;
@property (nonatomic, weak) IBOutlet UILabel *programLabelBeforeColon;

@property (nonatomic, weak) IBOutlet UILabel *supervisorLabelBeforeColon;

@property (nonatomic, weak) IBOutlet UILabel *courseLabel;
@property (nonatomic, weak) IBOutlet UILabel *siteNameLabelBeforeColon;
@property (nonatomic, weak) IBOutlet UILabel *allHoursReportTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *schoolNameLabel;

@property (nonatomic, weak) IBOutlet UILabel *interventionHoursTotalHoursLabel;

@property (nonatomic, weak) IBOutlet UILabel *assessmentHoursTotalHoursLabel;

@property (nonatomic, weak) IBOutlet UILabel *supportHoursTotalHoursLabel;

@property (nonatomic, weak) IBOutlet UILabel *supervisionHoursTotalHoursLabel;

@property (nonatomic, weak) IBOutlet UILabel *directHoursTotalHoursLabel;

@property (nonatomic, weak) IBOutlet UILabel *overallHoursTotalHoursLabel;

@property (nonatomic, weak) IBOutlet UIView *sectionSubHeaderView;
@property (nonatomic, weak) IBOutlet UILabel *sectionSubHeaderLabel;
@property (nonatomic, weak) IBOutlet UIView *sectionSubFooterView;
@property (nonatomic, weak) IBOutlet UIView *sectionSubFooterLabelContainerView;
@property (nonatomic, weak) IBOutlet UILabel *sectionSubFooterLabel;
@property (nonatomic, weak) IBOutlet UITextView *sectionSubFooterNotesTextView;

@property (nonatomic, weak) IBOutlet UIView *directHoursHeader;
@property (nonatomic, weak) IBOutlet UIView *directHoursFooter;
@property (nonatomic, weak) IBOutlet UIView *indirectHoursHeader;
@property (nonatomic, weak) IBOutlet UIView *overallHoursFooter;
@property (nonatomic, weak) IBOutlet UIView *signaturesView;
@property (nonatomic, weak) IBOutlet UIView *totalInterventionHoursFooterView;
@property (nonatomic, weak) IBOutlet UIView *pageHeaderView;
@property (nonatomic, weak) IBOutlet UIView *subTablesContainerView;

@property (nonatomic, weak) IBOutlet UIScrollView *mainPageScrollView;

@property (nonatomic, weak) ClinicianEntity *clinician;

@property (nonatomic, assign) BOOL stopScrolling;

@property (nonatomic, weak) IBOutlet UILabel *supervisorSummaryHeaderLabel;
@property (nonatomic, weak) IBOutlet UILabel *supervisorSummaryTotalInterventionHeaderLabel;
@property (nonatomic, weak) IBOutlet UILabel *supervisorSummaryTotalAssessmentHeaderLabel;
@property (nonatomic, weak) IBOutlet UILabel *supervisorSummaryTotalSupportHeaderLabel;
@property (nonatomic, weak) IBOutlet UILabel *supervisorSummaryTotalSupervisionHeaderLabel;

@property (nonatomic, weak) IBOutlet UILabel *supervisorSummaryTotalInterventionHoursLabel;
@property (nonatomic, weak) IBOutlet UILabel *supervisorSummaryTotalAssessmentHoursLabel;
@property (nonatomic, weak) IBOutlet UILabel *supervisorSummaryTotalSupportHoursLabel;
@property (nonatomic, weak) IBOutlet UILabel *supervisorSummaryTotalSupervisionHoursLabel;
@property (nonatomic, weak) IBOutlet UILabel *supervisorSummaryTotalToDateHoursLabel;
@property (nonatomic, weak) IBOutlet UILabel *supervisorSummarySignatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *supervisorSummarySignatureTitleUnderLineLabel;
@property (nonatomic, weak) IBOutlet UILabel *supervisorSummaryDateAboveLineLabel;
@property (nonatomic, weak) IBOutlet UILabel *supervisorSummaryDateBelowLineLabel;
@property (nonatomic, weak) IBOutlet UIView *supervisorSummaryContainerView;

@property (nonatomic, weak) IBOutlet UIView *containerForSignaturesAndSupervisorSummaries;

@property (nonatomic, weak) IBOutlet UILabel *studentSignatureLabelUnderLine;

- (CGSize) interventionTableViewContentSize;

@end
