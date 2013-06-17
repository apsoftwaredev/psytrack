//
//  AllHoursReportTopCell.m
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 9/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "AllHoursReportTopCell.h"
#import "PTTAppDelegate.h"

#import "InterventionTypeSubtypeEntity.h"

#import "InterventionTypeEntity.h"
#import "AssessmentTypeEntity.h"
#import "SupportActivityTypeEntity.h"
#import "SupervisionTypeEntity.h"
#import "SupervisionTypeSubtypeEntity.h"

#import "QuartzCore/QuartzCore.h"
#import "AllHoursReportBottomCell.h"
#import "SupervisorsAndTotalTimesForMonth.h"
#import "SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter.h"
#import "UILabel_VerticalAlignmentExtention.h"

@implementation AllHoursReportTopCell

@synthesize interventionTypesTableView,assessmentTypesTableView,supportActivitieTypesTableView,supervisionReceivedTypesTableView;
@synthesize studentNameLabel,programLabel;

@synthesize interventionHoursTotalHoursLabel;

@synthesize assessmentHoursTotalHoursLabel;

@synthesize supportHoursTotalHoursLabel;

@synthesize supervisionHoursTotalHoursLabel;

@synthesize mainPageScrollView;

@synthesize sectionSubHeaderView;
@synthesize sectionSubHeaderLabel;
@synthesize sectionSubFooterView,sectionSubFooterLabel,sectionSubFooterLabelContainerView,totalInterventionHoursFooterView;
@synthesize interventionTableViewModel = interventionTableViewModel_,assessmentTableViewModel = assessmentTableViewModel_,supportTableViewModel = supportTableViewModel_,supervisionTableViewModel = supervisionTableViewModel_;

@synthesize directHoursHeader;
@synthesize directHoursFooter;
@synthesize indirectHoursHeader;
@synthesize overallHoursFooter;
@synthesize signaturesView, pageHeaderView,subTablesContainerView,sectionSubFooterNotesTextView;
@synthesize clinician;
@synthesize stopScrolling;

@synthesize directHoursTotalHoursLabel;

@synthesize overallHoursTotalHoursLabel;

@synthesize supervisorSummaryHeaderLabel;
@synthesize supervisorSummaryTotalInterventionHeaderLabel;
@synthesize supervisorSummaryTotalAssessmentHeaderLabel;
@synthesize supervisorSummaryTotalSupportHeaderLabel;
@synthesize supervisorSummaryTotalSupervisionHeaderLabel;

@synthesize supervisorSummaryTotalInterventionHoursLabel;
@synthesize supervisorSummaryTotalAssessmentHoursLabel;
@synthesize supervisorSummaryTotalSupportHoursLabel;
@synthesize supervisorSummaryTotalSupervisionHoursLabel;
@synthesize supervisorSummaryTotalToDateHoursLabel;
@synthesize supervisorSummarySignatureLabel;
@synthesize supervisorSummarySignatureTitleUnderLineLabel;
@synthesize supervisorSummaryDateAboveLineLabel;
@synthesize supervisorSummaryDateBelowLineLabel;
@synthesize supervisorSummaryContainerView;
@synthesize containerForSignaturesAndSupervisorSummaries;

@synthesize studentSignatureLabelUnderLine,allHoursReportTitleLabel;
@synthesize schoolNameLabel;
@synthesize programLabelBeforeColon;

static float const MAX_MAIN_SCROLLVIEW_HEIGHT = 1110;

- (void) willDisplay
{
    self.accessoryType = UITableViewCellAccessoryNone;

    //

    CGFloat interventionTVHeight = [self interventionTableViewContentSize].height;
    CGFloat assessmentTVHeight = [self assessmentTypesTableViewContentSize].height;
    CGFloat supportTVHeight = [self supportTypesTableViewContentSize].height;
    CGFloat supervisionTVHeight = [self supervisionTypesTableViewContentSize].height;

    CGFloat shiftAssessmentsDown = 0;
    CGFloat shiftSupportDown = 0;
    CGFloat shiftSupervisionDown = 0;
    CGFloat shiftDirectHoursFooterDown = 0;
    CGFloat shiftIndirectHoursHeaderDown = 0;
//    CGFloat shiftOverallHoursFooterDown=0;
//    CGFloat shiftContainerForSignaturesViewAndSupervisorSummariesDownTo=0;

    CGFloat interventionMoreNeededHeight = interventionTVHeight - self.interventionTypesTableView.frame.size.height;
    CGFloat assessmentMoreNeededHeight = assessmentTVHeight - self.assessmentTypesTableView.frame.size.height;
    CGFloat supportMoreNeededHeight = supportTVHeight - self.supportActivitieTypesTableView.frame.size.height;
    CGFloat supervisionMoreNeededHeight = supportTVHeight - self.supervisionReceivedTypesTableView.frame.size.height;

    CGRect indirectHoursHeaderFrame = self.indirectHoursHeader.frame;

    CGRect interventionsFrame = self.interventionTypesTableView.frame;
    CGRect assessmentsFrame = self.assessmentTypesTableView.frame;
    CGRect supportFrame = self.supportActivitieTypesTableView.frame;
    CGRect supervisionFrame = self.supervisionReceivedTypesTableView.frame;

    CGFloat assessmentsHeightMoreNeededAndOrigin = assessmentMoreNeededHeight + assessmentsFrame.origin.y + assessmentsFrame.size.height;

    if ( (assessmentsHeightMoreNeededAndOrigin > MAX_MAIN_SCROLLVIEW_HEIGHT) && (assessmentsFrame.origin.y + assessmentMoreNeededHeight < MAX_MAIN_SCROLLVIEW_HEIGHT) && (MAX_MAIN_SCROLLVIEW_HEIGHT - assessmentsFrame.origin.y + assessmentMoreNeededHeight < 54) )
    {
        assessmentMoreNeededHeight = assessmentMoreNeededHeight + (MAX_MAIN_SCROLLVIEW_HEIGHT - assessmentsFrame.origin.y + assessmentMoreNeededHeight);
    }

    CGRect containerFrame = (CGRect)self.subTablesContainerView.frame;

    if ( interventionMoreNeededHeight > 0)
    {
        containerFrame.size.height = containerFrame.size.height + interventionMoreNeededHeight;
    }

    if ( assessmentMoreNeededHeight > 0)
    {
        containerFrame.size.height = containerFrame.size.height + assessmentMoreNeededHeight;
    }

    if ( supportMoreNeededHeight > 0)
    {
        containerFrame.size.height = containerFrame.size.height + supportMoreNeededHeight;
    }

    if ( supervisionMoreNeededHeight > 0)
    {
        containerFrame.size.height = containerFrame.size.height + supervisionMoreNeededHeight;
    }

    containerFrame.size.height = containerFrame.size.height + self.containerForSignaturesAndSupervisorSummaries.frame.size.height;

    self.subTablesContainerView.transform = CGAffineTransformIdentity;
    self.subTablesContainerView.frame = containerFrame;

    shiftAssessmentsDown = interventionMoreNeededHeight;
    shiftDirectHoursFooterDown = shiftAssessmentsDown + assessmentMoreNeededHeight;
    shiftIndirectHoursHeaderDown = shiftDirectHoursFooterDown;
    shiftSupportDown = shiftIndirectHoursHeaderDown;
    shiftSupervisionDown = shiftSupportDown + supportMoreNeededHeight;

    self.supervisionReceivedTypesTableView.transform = CGAffineTransformIdentity;

    supervisionFrame.origin.y = supervisionFrame.origin.y + shiftSupervisionDown;
    supervisionFrame.size.height = supervisionTVHeight;
    self.supervisionReceivedTypesTableView.frame = supervisionFrame;

    self.supportActivitieTypesTableView.transform = CGAffineTransformIdentity;

    supportFrame.origin.y = supportFrame.origin.y + shiftSupportDown;
    supportFrame.size.height = supportTVHeight;
    self.supportActivitieTypesTableView.frame = supportFrame;

    self.indirectHoursHeader.transform = CGAffineTransformIdentity;

    indirectHoursHeaderFrame.origin.y = indirectHoursHeaderFrame.origin.y + shiftIndirectHoursHeaderDown;
    self.indirectHoursHeader.frame = indirectHoursHeaderFrame;

    self.assessmentTypesTableView.transform = CGAffineTransformIdentity;

    assessmentsFrame.origin.y = assessmentsFrame.origin.y + shiftAssessmentsDown;
    assessmentsFrame.size.height = assessmentTVHeight;
    self.assessmentTypesTableView.frame = assessmentsFrame;

    self.interventionTypesTableView.transform = CGAffineTransformIdentity;

    interventionsFrame.size.height = interventionTVHeight;
    self.interventionTypesTableView.frame = interventionsFrame;

    self.directHoursFooter.transform = CGAffineTransformIdentity;
    CGRect directHoursFooterFrame = self.directHoursFooter.frame;

    directHoursFooterFrame.origin.y = assessmentsFrame.size.height + assessmentsFrame.origin.y + 5;  //keep an eye on this

    self.directHoursFooter.frame = directHoursFooterFrame;

    self.overallHoursFooter.transform = CGAffineTransformIdentity;
    CGRect overallHoursFooterFrame = self.overallHoursFooter.frame;
    overallHoursFooterFrame.origin.y = supervisionTVHeight + supervisionFrame.origin.y + 15;

    self.overallHoursFooter.frame = overallHoursFooterFrame;

    self.containerForSignaturesAndSupervisorSummaries.transform = CGAffineTransformIdentity;
    CGRect containerForSignaturesAndSupervisorSummariesFrame = self.containerForSignaturesAndSupervisorSummaries.frame;

    containerForSignaturesAndSupervisorSummariesFrame.origin.y = overallHoursFooterFrame.origin.y + overallHoursFooterFrame.size.height + 15;

    self.containerForSignaturesAndSupervisorSummaries.frame = containerForSignaturesAndSupervisorSummariesFrame;

    CGFloat bottomOfDirectHoursFooter = directHoursFooterFrame.size.height + directHoursFooterFrame.origin.y;

    CGFloat changeScrollHeightTo = MAX_MAIN_SCROLLVIEW_HEIGHT;
    if (bottomOfDirectHoursFooter < MAX_MAIN_SCROLLVIEW_HEIGHT)
    {
        changeScrollHeightTo = bottomOfDirectHoursFooter;
    }
    else if (bottomOfDirectHoursFooter > MAX_MAIN_SCROLLVIEW_HEIGHT && directHoursFooterFrame.origin.y <= MAX_MAIN_SCROLLVIEW_HEIGHT)
    {
        changeScrollHeightTo = directHoursFooterFrame.origin.y - 1;
    }

    self.mainPageScrollView.transform = CGAffineTransformIdentity;
    CGRect mainPageScrollViewFrame = self.mainPageScrollView.frame;
    mainPageScrollViewFrame.size.height = changeScrollHeightTo;
    self.mainPageScrollView.frame = mainPageScrollViewFrame;
    @try
    {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
            selector:@selector(scrollToNextPage)
                name:@"ScrollAllHoursVCToNextPage"
              object:nil];
    }
    @catch (NSException *exception)
    {
        //do nothing
    }
}


- (void) scrollToNextPage
{
    UIScrollView *mainScrollView = self.mainPageScrollView;
    pageNumber++;
    if ( (self.containerForSignaturesAndSupervisorSummaries.frame.origin.y + self.containerForSignaturesAndSupervisorSummaries.frame.size.height) <= (MAX_MAIN_SCROLLVIEW_HEIGHT + currentOffsetY) )
    {
        @try
        {
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ScrollAllHoursVCToNextPage" object:nil];
        }
        @catch (id anException)
        {
            //do nothing, obviously it wasn't attached because an exception was thrown
        }

        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        appDelegate.stopScrollingMonthlyPracticumLog = YES;
        currentOffsetY = 0;
    }
    else
    {
        CGRect mainScrollViewFrame = self.mainPageScrollView.frame;
        
        if (mainScrollViewFrame.size.height < currentOffsetY + MAX_MAIN_SCROLLVIEW_HEIGHT)
        {
            CGFloat mainScrollVieFrameHeightPlusY = MAX_MAIN_SCROLLVIEW_HEIGHT - self.mainPageScrollView.frame.size.height;
            mainScrollViewFrame.size.height = MAX_MAIN_SCROLLVIEW_HEIGHT;
            self.mainPageScrollView.frame = mainScrollViewFrame;

            if (self.assessmentTypesTableView.frame.size.height + self.assessmentTypesTableView.frame.origin.y > MAX_MAIN_SCROLLVIEW_HEIGHT || self.interventionTypesTableView.frame.size.height + self.interventionTypesTableView.frame.origin.y > MAX_MAIN_SCROLLVIEW_HEIGHT)
            {
                currentOffsetY = currentOffsetY + MAX_MAIN_SCROLLVIEW_HEIGHT - mainScrollVieFrameHeightPlusY;
            }
            else if ( (self.directHoursFooter.frame.origin.y + self.directHoursFooter.frame.size.height > MAX_MAIN_SCROLLVIEW_HEIGHT) && self.interventionTypesTableView.frame.size.height + self.interventionTypesTableView.frame.origin.y <= MAX_MAIN_SCROLLVIEW_HEIGHT )
            {
                currentOffsetY = currentOffsetY + self.directHoursFooter.frame.origin.y;
            }
            else if (currentOffsetY < self.indirectHoursHeader.frame.origin.y)
            {
                currentOffsetY = currentOffsetY + self.indirectHoursHeader.frame.origin.y;
            }
            else
            {
                currentOffsetY = currentOffsetY + self.mainPageScrollView.frame.size.height;
            }

            if ( (currentOffsetY + self.mainPageScrollView.frame.size.height) * 2 > self.subTablesContainerView.frame.size.height )
            {
                CGRect subTableContainerFrame = self.subTablesContainerView.frame;
                subTableContainerFrame.size.height = currentOffsetY + self.mainPageScrollView.frame.size.height;
                self.subTablesContainerView.frame = subTableContainerFrame;
            }

            [self.mainPageScrollView setContentOffset:CGPointMake(0, currentOffsetY )];
        }
        else
        {
            [self.mainPageScrollView setContentOffset:CGPointMake(0, mainScrollView.frame.size.height + currentOffsetY )];
            currentOffsetY = currentOffsetY + mainScrollView.frame.size.height;
        }
        
       
            if (self.overallHoursFooter.frame.size.height + self.overallHoursFooter.frame.origin.y > MAX_MAIN_SCROLLVIEW_HEIGHT + currentOffsetY && self.overallHoursFooter.frame.origin.y < MAX_MAIN_SCROLLVIEW_HEIGHT + currentOffsetY)
            {
                CGRect overallHoursFooterFrame = self.overallHoursFooter.frame;
                overallHoursFooterFrame.origin.y = MAX_MAIN_SCROLLVIEW_HEIGHT + currentOffsetY + 10;
                self.overallHoursFooter.frame = overallHoursFooterFrame;

                CGRect containerForSignaturesAndSupervisiorSummariesFrame = self.containerForSignaturesAndSupervisorSummaries.frame;
                containerForSignaturesAndSupervisiorSummariesFrame.origin.y = overallHoursFooterFrame.origin.y + overallHoursFooterFrame.size.height + 10;
                self.containerForSignaturesAndSupervisorSummaries.frame = containerForSignaturesAndSupervisiorSummariesFrame;
            }
            else  {
            CGFloat paddAdditonalY = 0;

            for (NSInteger i = 0; i < self.containerForSignaturesAndSupervisorSummaries.subviews.count; i++)
            {
                UIView *subview = [self.containerForSignaturesAndSupervisorSummaries.subviews objectAtIndex:i];
                CGRect subviewFrame = subview.frame;
                CGFloat subviewHeight=subviewFrame.size.height;
                
                if ((subview.frame.origin.y + self.containerForSignaturesAndSupervisorSummaries.frame.origin.y < currentOffsetY + MAX_MAIN_SCROLLVIEW_HEIGHT) && i > 1)
                {
                    UIView *previousSubview=[self.containerForSignaturesAndSupervisorSummaries.subviews objectAtIndex:i-1];
                    subview.transform = CGAffineTransformIdentity;
                    subviewFrame.origin.y=previousSubview.frame.origin.y+previousSubview.frame.size.height+5;
                    subview.frame = subviewFrame;
                }
                
                if (subview.frame.origin.y + self.containerForSignaturesAndSupervisorSummaries.frame.origin.y < currentOffsetY + MAX_MAIN_SCROLLVIEW_HEIGHT && subview.frame.origin.y + subview.frame.size.height + self.containerForSignaturesAndSupervisorSummaries.frame.origin.y > currentOffsetY + MAX_MAIN_SCROLLVIEW_HEIGHT)
                {
                    paddAdditonalY = (currentOffsetY + MAX_MAIN_SCROLLVIEW_HEIGHT) - (subviewFrame.origin.y + self.containerForSignaturesAndSupervisorSummaries.frame.origin.y) + 5;

                    CGRect contatinerForTableViewsFrame = self.subTablesContainerView.frame;
                    contatinerForTableViewsFrame.size.height = contatinerForTableViewsFrame.size.height + paddAdditonalY * (self.containerForSignaturesAndSupervisorSummaries.subviews.count);
                    self.subTablesContainerView.transform = CGAffineTransformIdentity;
                    self.subTablesContainerView.frame = contatinerForTableViewsFrame;
                    CGRect containerForSignaturesAndSupervisorSummariesFrame = self.containerForSignaturesAndSupervisorSummaries.frame;
                    
                    self.containerForSignaturesAndSupervisorSummaries.transform = CGAffineTransformIdentity;
                    
                    containerForSignaturesAndSupervisorSummariesFrame.size.height = containerForSignaturesAndSupervisorSummariesFrame.size.height + paddAdditonalY+signaturesView.frame.size.height;
                    
                    self.containerForSignaturesAndSupervisorSummaries.frame = containerForSignaturesAndSupervisorSummariesFrame;
                    
                    subviewFrame.origin.y = subviewFrame.origin.y + paddAdditonalY;
                    subview.transform = CGAffineTransformIdentity;
                    subview.frame = subviewFrame;
                    
                    UIView *firstSubview = [self.containerForSignaturesAndSupervisorSummaries.subviews objectAtIndex:0];
                    for ( int p= i+1 ; p < self.containerForSignaturesAndSupervisorSummaries.subviews.count; p++  )
                    {
                        UIView *nextSubview=[self.containerForSignaturesAndSupervisorSummaries.subviews objectAtIndex:p];
                        
                            
                            

                        CGRect nextSubviewFrame = nextSubview.frame;
                        nextSubviewFrame.origin.y = firstSubview.frame.origin.y +(subviewHeight*p)+5;
                        nextSubview.transform = CGAffineTransformIdentity;
                        nextSubview.frame = nextSubviewFrame;
                        
                           
                        
                        
                        
                        
                        

                
                    }
                
                    
                    
                }
            }

            CGRect supervisionTableViewFrame = self.supervisionReceivedTypesTableView.frame;

            CGSize supervisionTVSize = [self supervisionTypesTableViewContentSize];

            supervisionTableViewFrame.size.height = supervisionTVSize.height;
            self.supervisionReceivedTypesTableView.frame = supervisionTableViewFrame;

            CGRect supportTableViewFrame = self.supportActivitieTypesTableView.frame;

            CGSize supportTVSize = [self supportTypesTableViewContentSize];

            supportTableViewFrame.size.height = supportTVSize.height;
            self.supportActivitieTypesTableView.frame = supportTableViewFrame;
                
                
            }
        
        
        if (self.containerForSignaturesAndSupervisorSummaries.subviews.count-2>0) {
        
        UIView * lastSupervisorSummaryContainerView=[self.containerForSignaturesAndSupervisorSummaries.subviews objectAtIndex:self.containerForSignaturesAndSupervisorSummaries.subviews.count-2];
        
        
            
            
        CGRect signaturesViewFrame = self.signaturesView.frame;
        signaturesViewFrame.origin.y = lastSupervisorSummaryContainerView.frame.origin.y+ lastSupervisorSummaryContainerView.frame.size.height +5;

        self.signaturesView.frame = signaturesViewFrame;
            
            CGRect containerForSignaturesAndSupervisorSummariesFrame = self.containerForSignaturesAndSupervisorSummaries.frame;
            
            self.containerForSignaturesAndSupervisorSummaries.transform = CGAffineTransformIdentity;
            
            containerForSignaturesAndSupervisorSummariesFrame.size.height = self.signaturesView.frame.origin.y+self.signaturesView.frame.size.height+2;
            
            self.containerForSignaturesAndSupervisorSummaries.frame = containerForSignaturesAndSupervisorSummariesFrame;
        }
        }
    
    //    CGRect  mainPageScrollViewFrame=mainPageScrollView.frame;
    //    mainPageScrollViewFrame.size.height=MAX_MAIN_SCROLLVIEW_HEIGHT;
    //    mainScrollView.frame=mainPageScrollViewFrame;
}

- (void) loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];

    SupervisorsAndTotalTimesForMonth *totalsObject = (SupervisorsAndTotalTimesForMonth *)self.boundObject;

    self.allHoursReportTitleLabel.text = totalsObject.doctorateLevel ? @"All Doctorate Level Training Hours" : @"All Master's Level Training Hours";

    numberOfSupervisors = totalsObject.clinicians.count;

    NSString *bottomCellNibName = nil;

    bottomCellNibName = @"AllHoursReportBottomCell";

    self.programLabel.text = totalsObject.trainingProgramsStr;

    [self.programLabel alignTop];

    if (totalsObject.numberOfProgramCourses > 1)
    {
        self.programLabelBeforeColon.text = @"Programs & Courses:";
    }

    self.studentNameLabel.text = totalsObject.studentNameStr;
    //
    //
    self.studentSignatureLabelUnderLine.text = [NSString stringWithFormat:@"%@ (Student)", totalsObject.studentNameStr];

    self.interventionTableViewModel = [[SCTableViewModel alloc]initWithTableView:self.interventionTypesTableView];

    interventionTableViewModel_.modelActions.didAddSection = ^(SCTableViewModel *tableModel, SCTableViewSection *section, NSUInteger sectionIndex)
    {
        SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *objectsSection = nil;
        if ([section isKindOfClass:[SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter class]])
        {
            objectsSection = (SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *)section;
        }

        if (objectsSection.headerTitle && objectsSection.headerTitle.length)
        {
            UIView *containerView = [[UIView alloc] initWithFrame:sectionSubHeaderView.frame];

            UILabel *headerLabel = [[UILabel alloc] initWithFrame:sectionSubHeaderLabel.frame];
            headerLabel.adjustsFontSizeToFitWidth = YES;
            headerLabel.minimumFontSize = sectionSubHeaderLabel.minimumFontSize;
            headerLabel.font = sectionSubHeaderLabel.font;
            containerView.backgroundColor = sectionSubHeaderView.backgroundColor;
            headerLabel.backgroundColor = sectionSubHeaderLabel.backgroundColor;
            headerLabel.textColor = sectionSubHeaderLabel.textColor;
            headerLabel.tag = 60;
            headerLabel.text = objectsSection.headerTitle;
            headerLabel.textAlignment = UITextAlignmentCenter;
            [containerView addSubview:headerLabel];

            objectsSection.headerView = containerView;
        }

        if ( (objectsSection.footerNotes && objectsSection.footerNotes.length) || (objectsSection.footerTotal && objectsSection.footerTotal.length) )
        {
            UITextView *footerNotesTextView = [[UITextView alloc] initWithFrame:sectionSubFooterNotesTextView.frame];
            footerNotesTextView.font = sectionSubFooterNotesTextView.font;

            footerNotesTextView.backgroundColor = sectionSubFooterNotesTextView.backgroundColor;
            footerNotesTextView.textColor = sectionSubFooterNotesTextView.textColor;

            footerNotesTextView.textAlignment = UITextAlignmentLeft;
            footerNotesTextView.tag = 61;

            footerNotesTextView.hidden = YES;

            [footerNotesTextView setContentInset:UIEdgeInsetsMake(-9, 0, 0,0)];

            UIView *footerContainerView = [[UIView alloc] initWithFrame:sectionSubFooterView.frame];

            [footerContainerView addSubview:footerNotesTextView];

            if (footerNotesTextView.contentSize.height - 9 > footerContainerView.frame.size.height)
            {
                CGRect footerContainerViewFrame = footerContainerView.frame;
                footerContainerViewFrame.size.height = footerNotesTextView.contentSize.height - 6;

                footerContainerView.frame = footerContainerViewFrame;
            }

            CGRect footerNotesTextViewFrame = footerNotesTextView.frame;
            NSString *footerTotal = (NSString *)objectsSection.footerTotal;

            if (footerNotesTextView.contentSize.height > footerNotesTextView.frame.size.height)
            {
                footerNotesTextViewFrame.size.height = footerNotesTextView.contentSize.height - 9;
            }

            if (!footerTotal || !footerTotal.length)
            {
                footerNotesTextViewFrame.size.width = footerContainerView.frame.size.width - 7;
            }

            footerNotesTextView.frame = footerNotesTextViewFrame;

            footerContainerView.backgroundColor = sectionSubFooterView.backgroundColor;
            if (footerTotal && footerTotal.length)
            {
                UIView *subFooterLabelContainerView = [[UIView alloc]initWithFrame:self.sectionSubFooterLabelContainerView.frame];
                subFooterLabelContainerView.backgroundColor = self.sectionSubFooterLabelContainerView.backgroundColor;

                UILabel *footerLabel = [[UILabel alloc] initWithFrame:sectionSubFooterLabel.frame];
                footerLabel.font = sectionSubFooterLabel.font;

                footerLabel.backgroundColor = sectionSubFooterLabel.backgroundColor;
                footerLabel.textColor = sectionSubFooterLabel.textColor;
                footerLabel.tag = 60;

                footerLabel.text = footerTotal;
                footerLabel.textAlignment = UITextAlignmentCenter;
                [subFooterLabelContainerView addSubview:footerLabel];

                [footerContainerView addSubview:subFooterLabelContainerView];
            }

            objectsSection.footerView = footerContainerView;
        }
    };

    SCClassDefinition *typesDef = [SCClassDefinition definitionWithClass:[TrackTypeWithTotalTimes class] autoGeneratePropertyDefinitions:YES];

    NSArray *fetchedInterventionObjects = [self fetchObjectsFromEntity:(NSString *)@"InterventionTypeEntity" filterPredicate:nil pathsForPrefetching:(NSArray *)[NSArray arrayWithObjects:@"subTypes",@"subTypes.interventionsDelivered.time", @"subTypes.interventionsDelivered.trainingProgram",@"subTypes.existingInterventions",@"subTypes.existingInterventions.programCourse",nil]];

    for (InterventionTypeEntity *interventionType in fetchedInterventionObjects)
    {
        TrackTypeWithTotalTimes *interventionTypeWithTotalTimes = [[TrackTypeWithTotalTimes alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:clinician trackTypeObject:interventionType];

        [interventionType willAccessValueForKey:@"subTypes"];
        NSSet *interventionSubTypeSet = interventionType.subTypes;

        NSArray *subTypesArray = nil;

        if (interventionSubTypeSet && [interventionSubTypeSet isKindOfClass:[NSSet class]])
        {
            subTypesArray = interventionSubTypeSet.allObjects;
        }

        NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                                        ascending:YES];

        NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
        NSMutableArray *orderdSubTypeArray = [NSMutableArray arrayWithArray:(NSArray *)[subTypesArray sortedArrayUsingDescriptors:sortDescriptors]];

        NSMutableArray *subTypeWithTotalsItemsArray = [NSMutableArray array];

        firstDescriptor = nil;
        for (InterventionTypeSubtypeEntity *interventionSubTypeObject in orderdSubTypeArray )
        {
            TrackTypeWithTotalTimes *trackTypeWithTotalTimeObject = [[TrackTypeWithTotalTimes alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:clinician trackTypeObject:interventionSubTypeObject];

            [subTypeWithTotalsItemsArray addObject:trackTypeWithTotalTimeObject];
        }

        SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *interventionsSection = [SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter sectionWithHeaderTitle:interventionType.interventionType footerNotes:interventionTypeWithTotalTimes.monthlyLogNotes sectionTotalStr:interventionTypeWithTotalTimes.totalToDateStr items:subTypeWithTotalsItemsArray itemsDefinition:typesDef];

        interventionsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell *(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
        {
            NSDictionary *bindingsDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"interventionSubType", nil] forKeys:[NSArray arrayWithObjects:@"20", nil]];

            AllHoursReportBottomCell *allHoursBottomCell = [AllHoursReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];

            return allHoursBottomCell;
        };

        [interventionTableViewModel_ addSection:interventionsSection];
        [interventionType didAccessValueForKey:@"subTypes"];
    }

    self.assessmentTableViewModel = [[SCTableViewModel alloc]initWithTableView:self.assessmentTypesTableView];

    assessmentTableViewModel_.modelActions.didAddSection = ^(SCTableViewModel *tableModel, SCTableViewSection *section, NSUInteger sectionIndex)
    {
        SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *objectsSection = nil;
        if ([section isKindOfClass:[SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter class]])
        {
            objectsSection = (SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *)section;
        }

        if (objectsSection.headerTitle && objectsSection.headerTitle.length)
        {
            UIView *containerView = [[UIView alloc] initWithFrame:sectionSubHeaderView.frame];

            UILabel *headerLabel = [[UILabel alloc] initWithFrame:sectionSubHeaderLabel.frame];
            headerLabel.adjustsFontSizeToFitWidth = YES;
            headerLabel.minimumFontSize = sectionSubHeaderLabel.minimumFontSize;
            headerLabel.font = sectionSubHeaderLabel.font;
            containerView.backgroundColor = sectionSubHeaderView.backgroundColor;
            headerLabel.backgroundColor = sectionSubHeaderLabel.backgroundColor;
            headerLabel.textColor = sectionSubHeaderLabel.textColor;
            headerLabel.tag = 60;
            headerLabel.text = objectsSection.headerTitle;
            headerLabel.textAlignment = UITextAlignmentCenter;
            [containerView addSubview:headerLabel];

            objectsSection.headerView = containerView;
        }

        if ( (objectsSection.footerNotes && objectsSection.footerNotes.length) || (objectsSection.footerTotal && objectsSection.footerTotal.length) )
        {
            UITextView *footerNotesTextView = [[UITextView alloc] initWithFrame:sectionSubFooterNotesTextView.frame];
            footerNotesTextView.font = sectionSubFooterNotesTextView.font;

            footerNotesTextView.backgroundColor = sectionSubFooterNotesTextView.backgroundColor;
            footerNotesTextView.textColor = sectionSubFooterNotesTextView.textColor;

            footerNotesTextView.textAlignment = UITextAlignmentLeft;
            footerNotesTextView.tag = 61;

            footerNotesTextView.hidden = YES;

            [footerNotesTextView setContentInset:UIEdgeInsetsMake(-9, 0, 0,0)];

            UIView *footerContainerView = [[UIView alloc] initWithFrame:sectionSubFooterView.frame];

            [footerContainerView addSubview:footerNotesTextView];

            if (footerNotesTextView.contentSize.height - 9 > footerContainerView.frame.size.height)
            {
                CGRect footerContainerViewFrame = footerContainerView.frame;
                footerContainerViewFrame.size.height = footerNotesTextView.contentSize.height - 6;

                footerContainerView.frame = footerContainerViewFrame;
            }

            CGRect footerNotesTextViewFrame = footerNotesTextView.frame;
            NSString *footerTotal = (NSString *)objectsSection.footerTotal;

            if (footerNotesTextView.contentSize.height > footerNotesTextView.frame.size.height)
            {
                footerNotesTextViewFrame.size.height = footerNotesTextView.contentSize.height - 9;
            }

            if (!footerTotal || !footerTotal.length)
            {
                footerNotesTextViewFrame.size.width = footerContainerView.frame.size.width - 7;
            }

            footerNotesTextView.frame = footerNotesTextViewFrame;

            footerContainerView.backgroundColor = sectionSubFooterView.backgroundColor;
            if (footerTotal && footerTotal.length)
            {
                UIView *subFooterLabelContainerView = [[UIView alloc]initWithFrame:self.sectionSubFooterLabelContainerView.frame];
                subFooterLabelContainerView.backgroundColor = self.sectionSubFooterLabelContainerView.backgroundColor;

                UILabel *footerLabel = [[UILabel alloc] initWithFrame:sectionSubFooterLabel.frame];
                footerLabel.font = sectionSubFooterLabel.font;

                footerLabel.backgroundColor = sectionSubFooterLabel.backgroundColor;
                footerLabel.textColor = sectionSubFooterLabel.textColor;
                footerLabel.tag = 60;

                footerLabel.text = footerTotal;
                footerLabel.textAlignment = UITextAlignmentCenter;
                [subFooterLabelContainerView addSubview:footerLabel];

                [footerContainerView addSubview:subFooterLabelContainerView];
            }

            objectsSection.footerView = footerContainerView;
        }
    };
    NSArray *fetchedAssessmentObjects = [self fetchObjectsFromEntity:(NSString *)@"AssessmentTypeEntity" filterPredicate:nil pathsForPrefetching:(NSArray *)[NSArray arrayWithObjects:@"assessements.time",@"existingAssessments",nil]];

    NSMutableArray *assessmentTypesWithTotalsItemsArray = [NSMutableArray array];

    for (AssessmentTypeEntity *assessmentType in fetchedAssessmentObjects)
    {
        TrackTypeWithTotalTimes *assessmentTypeWithTotalTimes = [[TrackTypeWithTotalTimes alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:clinician trackTypeObject:assessmentType];

        [assessmentTypesWithTotalsItemsArray addObject:assessmentTypeWithTotalTimes];
    }

    SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *assessmentObjectsSection = [SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter sectionWithHeaderTitle:nil footerNotes:totalsObject.assessmentMonthlyNotes sectionTotalStr:nil items:assessmentTypesWithTotalsItemsArray itemsDefinition:typesDef];

    //        NSString *monthlyLogNotes=[interventionType monthlyLogNotesForMonth:self.monthToDisplay clinician:self.clinician];

//    assessmentObjectsSection.dataFetchOptions=dataFetchOptions;

    assessmentObjectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell *(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib

        //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags

        NSDictionary *assessmentBindingsDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"assessmentType", nil] forKeys:[NSArray arrayWithObjects:@"20", nil]];

        AllHoursReportBottomCell *assessmentTypeCell = [AllHoursReportBottomCell cellWithText:nil objectBindings:assessmentBindingsDictionary nibName:bottomCellNibName];

        return assessmentTypeCell;
    };

    [assessmentTableViewModel_ addSection:assessmentObjectsSection];

    self.supportTableViewModel = [[SCTableViewModel alloc]initWithTableView:self.supportActivitieTypesTableView];

//    supportTableViewModel_.delegate=self;

    supportTableViewModel_.modelActions.didAddSection = ^(SCTableViewModel *tableModel, SCTableViewSection *section, NSUInteger sectionIndex)
    {
        SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *objectsSection = nil;
        if ([section isKindOfClass:[SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter class]])
        {
            objectsSection = (SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *)section;
        }

        if (objectsSection.headerTitle && objectsSection.headerTitle.length)
        {
            UIView *containerView = [[UIView alloc] initWithFrame:sectionSubHeaderView.frame];

            UILabel *headerLabel = [[UILabel alloc] initWithFrame:sectionSubHeaderLabel.frame];
            headerLabel.adjustsFontSizeToFitWidth = YES;
            headerLabel.minimumFontSize = sectionSubHeaderLabel.minimumFontSize;
            headerLabel.font = sectionSubHeaderLabel.font;
            containerView.backgroundColor = sectionSubHeaderView.backgroundColor;
            headerLabel.backgroundColor = sectionSubHeaderLabel.backgroundColor;
            headerLabel.textColor = sectionSubHeaderLabel.textColor;
            headerLabel.tag = 60;
            headerLabel.text = objectsSection.headerTitle;
            headerLabel.textAlignment = UITextAlignmentCenter;
            [containerView addSubview:headerLabel];

            objectsSection.headerView = containerView;
        }

        if ( (objectsSection.footerNotes && objectsSection.footerNotes.length) || (objectsSection.footerTotal && objectsSection.footerTotal.length) )
        {
            UITextView *footerNotesTextView = [[UITextView alloc] initWithFrame:sectionSubFooterNotesTextView.frame];
            footerNotesTextView.font = sectionSubFooterNotesTextView.font;

            footerNotesTextView.backgroundColor = sectionSubFooterNotesTextView.backgroundColor;
            footerNotesTextView.textColor = sectionSubFooterNotesTextView.textColor;

            footerNotesTextView.textAlignment = UITextAlignmentLeft;
            footerNotesTextView.tag = 61;

            footerNotesTextView.hidden = YES;

            [footerNotesTextView setContentInset:UIEdgeInsetsMake(-9, 0, 0,0)];

            UIView *footerContainerView = [[UIView alloc] initWithFrame:sectionSubFooterView.frame];

            [footerContainerView addSubview:footerNotesTextView];

            if (footerNotesTextView.contentSize.height - 9 > footerContainerView.frame.size.height)
            {
                CGRect footerContainerViewFrame = footerContainerView.frame;
                footerContainerViewFrame.size.height = footerNotesTextView.contentSize.height - 6;

                footerContainerView.frame = footerContainerViewFrame;
            }

            CGRect footerNotesTextViewFrame = footerNotesTextView.frame;
            NSString *footerTotal = (NSString *)objectsSection.footerTotal;

            if (footerNotesTextView.contentSize.height > footerNotesTextView.frame.size.height)
            {
                footerNotesTextViewFrame.size.height = footerNotesTextView.contentSize.height - 9;
            }

            if (!footerTotal || !footerTotal.length)
            {
                footerNotesTextViewFrame.size.width = footerContainerView.frame.size.width - 7;
            }

            footerNotesTextView.frame = footerNotesTextViewFrame;

            footerContainerView.backgroundColor = sectionSubFooterView.backgroundColor;
            if (footerTotal && footerTotal.length)
            {
                UIView *subFooterLabelContainerView = [[UIView alloc]initWithFrame:self.sectionSubFooterLabelContainerView.frame];
                subFooterLabelContainerView.backgroundColor = self.sectionSubFooterLabelContainerView.backgroundColor;

                UILabel *footerLabel = [[UILabel alloc] initWithFrame:sectionSubFooterLabel.frame];
                footerLabel.font = sectionSubFooterLabel.font;

                footerLabel.backgroundColor = sectionSubFooterLabel.backgroundColor;
                footerLabel.textColor = sectionSubFooterLabel.textColor;
                footerLabel.tag = 60;

                footerLabel.text = footerTotal;
                footerLabel.textAlignment = UITextAlignmentCenter;
                [subFooterLabelContainerView addSubview:footerLabel];

                [footerContainerView addSubview:subFooterLabelContainerView];
            }

            objectsSection.footerView = footerContainerView;
        }
    };

    NSArray *fetchedSupportObjects = [self fetchObjectsFromEntity:(NSString *)@"SupportActivityTypeEntity" filterPredicate:nil pathsForPrefetching:(NSArray *)[NSArray arrayWithObjects:@"supportActivitiesDelivered.time",@"existingSupportActivities",nil]];

    NSMutableArray *supportActivitytTypesWithTotalsItemsArray = [NSMutableArray array];

    for (SupportActivityTypeEntity *supportActivityType in fetchedSupportObjects)
    {
        TrackTypeWithTotalTimes *supportActivityTypeWithTotalTimes = [[TrackTypeWithTotalTimes alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:clinician trackTypeObject:supportActivityType];

        [supportActivitytTypesWithTotalsItemsArray addObject:supportActivityTypeWithTotalTimes];
    }

    SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *supportObjectsSection = [SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter sectionWithHeaderTitle:nil footerNotes:totalsObject.supportMonthlyNotes sectionTotalStr:nil items:supportActivitytTypesWithTotalsItemsArray itemsDefinition:typesDef];

    supportObjectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell *(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        NSDictionary *bindingsDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"supportType", nil] forKeys:[NSArray arrayWithObjects:@"20", nil]];

        AllHoursReportBottomCell *allHoursBottomCell = [AllHoursReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];

        return allHoursBottomCell;
    };

    [supportTableViewModel_ addSection:supportObjectsSection];

    self.supervisionTableViewModel = [[SCTableViewModel alloc]initWithTableView:self.supervisionReceivedTypesTableView];

    supervisionTableViewModel_.modelActions.didAddSection = ^(SCTableViewModel *tableModel, SCTableViewSection *section, NSUInteger sectionIndex)
    {
        SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *objectsSection = nil;
        if ([section isKindOfClass:[SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter class]])
        {
            objectsSection = (SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *)section;
        }

        if (objectsSection.headerTitle && objectsSection.headerTitle.length)
        {
            UIView *containerView = [[UIView alloc] initWithFrame:sectionSubHeaderView.frame];

            UILabel *headerLabel = [[UILabel alloc] initWithFrame:sectionSubHeaderLabel.frame];
            headerLabel.adjustsFontSizeToFitWidth = YES;
            headerLabel.minimumFontSize = sectionSubHeaderLabel.minimumFontSize;
            headerLabel.font = sectionSubHeaderLabel.font;
            containerView.backgroundColor = sectionSubHeaderView.backgroundColor;
            headerLabel.backgroundColor = sectionSubHeaderLabel.backgroundColor;
            headerLabel.textColor = sectionSubHeaderLabel.textColor;
            headerLabel.tag = 60;
            headerLabel.text = objectsSection.headerTitle;
            headerLabel.textAlignment = UITextAlignmentCenter;
            [containerView addSubview:headerLabel];

            objectsSection.headerView = containerView;
        }

        if ( (objectsSection.footerNotes && objectsSection.footerNotes.length) || (objectsSection.footerTotal && objectsSection.footerTotal.length) )
        {
            UITextView *footerNotesTextView = [[UITextView alloc] initWithFrame:sectionSubFooterNotesTextView.frame];
            footerNotesTextView.font = sectionSubFooterNotesTextView.font;

            footerNotesTextView.backgroundColor = sectionSubFooterNotesTextView.backgroundColor;
            footerNotesTextView.textColor = sectionSubFooterNotesTextView.textColor;

            footerNotesTextView.textAlignment = UITextAlignmentLeft;
            footerNotesTextView.tag = 61;

            footerNotesTextView.hidden = YES;

            [footerNotesTextView setContentInset:UIEdgeInsetsMake(-9, 0, 0,0)];

            UIView *footerContainerView = [[UIView alloc] initWithFrame:sectionSubFooterView.frame];

            [footerContainerView addSubview:footerNotesTextView];

            if (footerNotesTextView.contentSize.height - 9 > footerContainerView.frame.size.height)
            {
                CGRect footerContainerViewFrame = footerContainerView.frame;
                footerContainerViewFrame.size.height = footerNotesTextView.contentSize.height - 6;

                footerContainerView.frame = footerContainerViewFrame;
            }

            CGRect footerNotesTextViewFrame = footerNotesTextView.frame;
            NSString *footerTotal = (NSString *)objectsSection.footerTotal;

            if (footerNotesTextView.contentSize.height > footerNotesTextView.frame.size.height)
            {
                footerNotesTextViewFrame.size.height = footerNotesTextView.contentSize.height - 9;
            }

            if (!footerTotal || !footerTotal.length)
            {
                footerNotesTextViewFrame.size.width = footerContainerView.frame.size.width - 7;
            }

            footerNotesTextView.frame = footerNotesTextViewFrame;

            footerContainerView.backgroundColor = sectionSubFooterView.backgroundColor;
            if (footerTotal && footerTotal.length)
            {
                UIView *subFooterLabelContainerView = [[UIView alloc]initWithFrame:self.sectionSubFooterLabelContainerView.frame];
                subFooterLabelContainerView.backgroundColor = self.sectionSubFooterLabelContainerView.backgroundColor;

                UILabel *footerLabel = [[UILabel alloc] initWithFrame:sectionSubFooterLabel.frame];
                footerLabel.font = sectionSubFooterLabel.font;

                footerLabel.backgroundColor = sectionSubFooterLabel.backgroundColor;
                footerLabel.textColor = sectionSubFooterLabel.textColor;
                footerLabel.tag = 60;

                footerLabel.text = footerTotal;
                footerLabel.textAlignment = UITextAlignmentCenter;
                [subFooterLabelContainerView addSubview:footerLabel];

                [footerContainerView addSubview:subFooterLabelContainerView];
            }

            objectsSection.footerView = footerContainerView;
        }
    };

    //

    NSArray *fetchedSupervisionObjects = [self fetchObjectsFromEntity:(NSString *)@"SupervisionTypeEntity" filterPredicate:nil pathsForPrefetching:(NSArray *)[NSArray arrayWithObjects:@"supervisionReceived.startTime",@"supervisionReceived.endTime",@"subTypes.existingHours",@"supervisionReceived.time",@"existingSupervision",nil]];
    //

    for (SupervisionTypeEntity *supervisionType in fetchedSupervisionObjects)
    {
        TrackTypeWithTotalTimes *supervisionTypeWithTotalTimes = [[TrackTypeWithTotalTimes alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:clinician trackTypeObject:supervisionType];

        [supervisionType willAccessValueForKey:@"subTypes"];
        NSSet *supervisionSubTypeSet = supervisionType.subTypes;

        NSArray *subTypesArray = nil;

        if (supervisionSubTypeSet && [supervisionSubTypeSet isKindOfClass:[NSSet class]])
        {
            subTypesArray = supervisionSubTypeSet.allObjects;
        }

        NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                                        ascending:YES];

        NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
        NSMutableArray *orderdSubTypeArray = [NSMutableArray arrayWithArray:(NSArray *)[subTypesArray sortedArrayUsingDescriptors:sortDescriptors]];

        NSMutableArray *subTypeWithTotalsItemsArray = [NSMutableArray array];

        for (SupervisionTypeSubtypeEntity *supervisionSubTypeObject in orderdSubTypeArray )
        {
            TrackTypeWithTotalTimes *trackTypeWithTotalTimeObject = [[TrackTypeWithTotalTimes alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:clinician trackTypeObject:supervisionSubTypeObject];

            [subTypeWithTotalsItemsArray addObject:trackTypeWithTotalTimeObject];
        }

        SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *supervisionSection = [SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter sectionWithHeaderTitle:supervisionType.supervisionType footerNotes:supervisionTypeWithTotalTimes.monthlyLogNotes sectionTotalStr:supervisionTypeWithTotalTimes.totalToDateStr items:subTypeWithTotalsItemsArray itemsDefinition:typesDef];

        supervisionSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell *(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
        {
            NSDictionary *bindingsDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"supervisionSubType", nil] forKeys:[NSArray arrayWithObjects:@"20", nil]];

            AllHoursReportBottomCell *allHoursBottomCell = [AllHoursReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];

            return allHoursBottomCell;
        };

        [supervisionTableViewModel_ addSection:supervisionSection];
        [supervisionType didAccessValueForKey:@"subTypes"];
    }

    self.interventionHoursTotalHoursLabel.text = totalsObject.interventionTotalToDateStr;
    self.assessmentHoursTotalHoursLabel.text = totalsObject.assessmentTotalToDateStr;
    self.supportHoursTotalHoursLabel.text = totalsObject.supportTotalToDateStr;
    self.supervisionHoursTotalHoursLabel.text = totalsObject.supervisionTotalToDateStr;
    self.directHoursTotalHoursLabel.text = totalsObject.directTotalToDateStr;
    self.overallHoursTotalHoursLabel.text = totalsObject.overallTotalToDateStr;

    CGFloat yPositionToPutSupervisorSummaryConatinerView = 0;

    if (!numberOfSupervisors)
    {
        CGRect containerForSignaturesAndSupervisorSummariesFrame = self.containerForSignaturesAndSupervisorSummaries.frame;

        containerForSignaturesAndSupervisorSummariesFrame.size.height = self.signaturesView.frame.size.height + 15;
        self.containerForSignaturesAndSupervisorSummaries.frame = containerForSignaturesAndSupervisorSummariesFrame;

        yPositionToPutSupervisorSummaryConatinerView = 0;

        CGRect signaturesViewFrame = self.signaturesView.frame;

        signaturesViewFrame.origin.y = yPositionToPutSupervisorSummaryConatinerView;
        self.signaturesView.frame = signaturesViewFrame;

        [self.containerForSignaturesAndSupervisorSummaries addSubview:self.signaturesView];
        [self.subTablesContainerView addSubview:self.containerForSignaturesAndSupervisorSummaries];
    }
    else
    {
        for ( int i = 0; i < numberOfSupervisors; i++)
        {
            ClinicianEntity *supervisor = [totalsObject.clinicians objectAtIndex:i];
            SupervisorsAndTotalTimesForMonth *supervisorTotalsObject = [[SupervisorsAndTotalTimesForMonth alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:supervisor];
            if (i == 0)
            {
                self.supervisorSummaryHeaderLabel.text = [NSString stringWithFormat:@"Summary of Hours Supervised by %@ (Total:%@)",supervisor.combinedName,supervisorTotalsObject.overallTotalToDateStr];

                self.supervisorSummaryTotalInterventionHoursLabel.text = totalsObject.interventionTotalToDateStr;
                self.supervisorSummaryTotalAssessmentHoursLabel.text = totalsObject.assessmentTotalToDateStr;
                self.supervisorSummaryTotalSupportHoursLabel.text = totalsObject.supportTotalToDateStr;
                self.supervisorSummaryTotalSupervisionHoursLabel.text = totalsObject.supervisionTotalToDateStr;
                self.supervisorSummaryTotalToDateHoursLabel.text = [NSString stringWithFormat:@"Total Hours with %@: %@",supervisor.combinedName, supervisorTotalsObject.overallTotalToDateStr];
                self.supervisorSummarySignatureLabel.text = nil;
                self.supervisorSummarySignatureTitleUnderLineLabel.text = [NSString stringWithFormat:@"Signature for %@",supervisor.combinedName];
                self.supervisorSummaryDateAboveLineLabel.text = nil;
                [self.containerForSignaturesAndSupervisorSummaries addSubview:self.supervisorSummaryContainerView];

                yPositionToPutSupervisorSummaryConatinerView = yPositionToPutSupervisorSummaryConatinerView + self.supervisorSummaryContainerView.frame.size.height + 15;
            }
            else
            {
                UILabel *nibSupervisorSummaryHeader = self.supervisorSummaryHeaderLabel;
                UILabel *headerLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummaryHeader.frame];
                headerLabel.backgroundColor = [UIColor whiteColor];
                headerLabel.font = nibSupervisorSummaryHeader.font;
                headerLabel.textAlignment = nibSupervisorSummaryHeader.textAlignment;
                headerLabel.text = [NSString stringWithFormat:@"Summary of Hours Supervised by %@ (Total:%@)",supervisor.combinedName,supervisorTotalsObject.overallTotalToDateStr];

                UILabel *nibSupervisorSummaryInterventionHeader = self.supervisorSummaryTotalInterventionHeaderLabel;
                UILabel *interventionHeaderLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummaryInterventionHeader.frame];
                interventionHeaderLabel.backgroundColor = [UIColor whiteColor];
                interventionHeaderLabel.font = nibSupervisorSummaryInterventionHeader.font;
                interventionHeaderLabel.textAlignment = nibSupervisorSummaryInterventionHeader.textAlignment;
                interventionHeaderLabel.text = nibSupervisorSummaryInterventionHeader.text;
                interventionHeaderLabel.lineBreakMode = UILineBreakModeWordWrap;
                interventionHeaderLabel.numberOfLines = 2;

                UILabel *nibSupervisorSummaryAssessmentHeader = self.supervisorSummaryTotalAssessmentHeaderLabel;
                UILabel *assessmentHeaderLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummaryAssessmentHeader.frame];
                assessmentHeaderLabel.backgroundColor = [UIColor whiteColor];
                assessmentHeaderLabel.font = nibSupervisorSummaryAssessmentHeader.font;
                assessmentHeaderLabel.textAlignment = nibSupervisorSummaryAssessmentHeader.textAlignment;
                assessmentHeaderLabel.text = nibSupervisorSummaryAssessmentHeader.text;
                assessmentHeaderLabel.lineBreakMode = UILineBreakModeWordWrap;
                assessmentHeaderLabel.numberOfLines = 2;

                UILabel *nibSupervisorSummarySupportHeader = self.supervisorSummaryTotalSupportHeaderLabel;
                UILabel *supportHeaderLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummarySupportHeader.frame];
                supportHeaderLabel.backgroundColor = [UIColor whiteColor];
                supportHeaderLabel.font = nibSupervisorSummarySupportHeader.font;
                supportHeaderLabel.textAlignment = nibSupervisorSummarySupportHeader.textAlignment;
                supportHeaderLabel.text = nibSupervisorSummarySupportHeader.text;
                supportHeaderLabel.lineBreakMode = UILineBreakModeWordWrap;
                supportHeaderLabel.numberOfLines = 2;

                UILabel *nibSupervisorSummarySupervisionHeader = self.supervisorSummaryTotalSupervisionHeaderLabel;
                UILabel *supervisionHeaderLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummarySupervisionHeader.frame];
                supervisionHeaderLabel.backgroundColor = [UIColor whiteColor];
                supervisionHeaderLabel.font = nibSupervisorSummarySupervisionHeader.font;
                supervisionHeaderLabel.textAlignment = nibSupervisorSummarySupervisionHeader.textAlignment;
                supervisionHeaderLabel.text = nibSupervisorSummarySupervisionHeader.text;
                supervisionHeaderLabel.lineBreakMode = UILineBreakModeWordWrap;
                supervisionHeaderLabel.numberOfLines = 2;

                UILabel *nibSupervisorSummaryInterventionHours = self.supervisorSummaryTotalInterventionHoursLabel;
                UILabel *interventionHoursLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummaryInterventionHours.frame];
                interventionHoursLabel.backgroundColor = [UIColor whiteColor];
                interventionHoursLabel.font = nibSupervisorSummaryInterventionHours.font;
                interventionHoursLabel.textAlignment = nibSupervisorSummaryInterventionHours.textAlignment;
                interventionHoursLabel.text = supervisorTotalsObject.interventionTotalForMonthStr;

                UILabel *nibSupervisorSummaryAssessmentHours = self.supervisorSummaryTotalAssessmentHoursLabel;
                UILabel *assessmentHoursLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummaryAssessmentHours.frame];
                assessmentHoursLabel.backgroundColor = [UIColor whiteColor];
                assessmentHoursLabel.font = nibSupervisorSummaryAssessmentHours.font;
                assessmentHoursLabel.textAlignment = nibSupervisorSummaryAssessmentHours.textAlignment;
                assessmentHoursLabel.text = supervisorTotalsObject.assessmentTotalForMonthStr;

                UILabel *nibSupervisorSummarySupportHours = self.supervisorSummaryTotalSupportHoursLabel;
                UILabel *supportHoursLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummarySupportHours.frame];
                supportHoursLabel.backgroundColor = [UIColor whiteColor];
                supportHoursLabel.font = nibSupervisorSummarySupportHours.font;
                supportHoursLabel.textAlignment = nibSupervisorSummarySupportHours.textAlignment;
                supportHoursLabel.text = supervisorTotalsObject.supportTotalForMonthStr;

                UILabel *nibSupervisorSummarySupervisionHours = self.supervisorSummaryTotalSupervisionHoursLabel;
                UILabel *supervisionHoursLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummarySupervisionHours.frame];
                supervisionHoursLabel.backgroundColor = [UIColor whiteColor];
                supervisionHoursLabel.font = nibSupervisorSummarySupervisionHours.font;
                supervisionHoursLabel.textAlignment = nibSupervisorSummarySupervisionHours.textAlignment;
                supervisionHoursLabel.text = supervisorTotalsObject.supervisionTotalForMonthStr;

                UILabel *nibSupervisorSummarySignature = self.supervisorSummarySignatureLabel;
                UILabel *signatureLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummarySignature.frame];
                signatureLabel.backgroundColor = [UIColor whiteColor];
                signatureLabel.font = nibSupervisorSummarySignature.font;
                signatureLabel.textAlignment = nibSupervisorSummarySignature.textAlignment;
                signatureLabel.text = nil;

                UILabel *nibSupervisorSummarySignatureTitleUnderLineLabel = self.supervisorSummarySignatureTitleUnderLineLabel;
                UILabel *signatureUnderLineLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummarySignatureTitleUnderLineLabel.frame];
                signatureUnderLineLabel.backgroundColor = [UIColor whiteColor];
                signatureUnderLineLabel.font = nibSupervisorSummarySignatureTitleUnderLineLabel.font;
                signatureUnderLineLabel.textAlignment = nibSupervisorSummarySignatureTitleUnderLineLabel.textAlignment;
                signatureUnderLineLabel.text = [NSString stringWithFormat:@"Signature for %@",supervisor.combinedName];

                UILabel *nibSupervisorSummaryDateAboveLineLabel = self.supervisorSummaryDateAboveLineLabel;
                UILabel *dateAboveLineLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummaryDateAboveLineLabel.frame];
                dateAboveLineLabel.backgroundColor = [UIColor whiteColor];
                dateAboveLineLabel.font = nibSupervisorSummarySignatureTitleUnderLineLabel.font;
                dateAboveLineLabel.textAlignment = nibSupervisorSummarySignatureTitleUnderLineLabel.textAlignment;
                dateAboveLineLabel.text = nil;

                UILabel *nibSupervisorSummaryDateBelowLineLabel = self.supervisorSummaryDateBelowLineLabel;
                UILabel *dateBelowLineLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummaryDateBelowLineLabel.frame];
                dateBelowLineLabel.backgroundColor = [UIColor whiteColor];
                dateBelowLineLabel.font = nibSupervisorSummarySignatureTitleUnderLineLabel.font;
                dateBelowLineLabel.textAlignment = nibSupervisorSummarySignatureTitleUnderLineLabel.textAlignment;
                dateBelowLineLabel.text = nibSupervisorSummaryDateBelowLineLabel.text;

                UILabel *nibSupervisorSummaryTotalToDateLabel = self.supervisorSummaryTotalToDateHoursLabel;
                UILabel *totalToDateLabel = [[UILabel alloc]initWithFrame:nibSupervisorSummaryTotalToDateLabel.frame];
                totalToDateLabel.backgroundColor = [UIColor whiteColor];
                totalToDateLabel.font = nibSupervisorSummaryTotalToDateLabel.font;
                totalToDateLabel.textAlignment = nibSupervisorSummaryTotalToDateLabel.textAlignment;
                totalToDateLabel.text = [NSString stringWithFormat:@"Total Hours with %@: %@",supervisor.combinedName, supervisorTotalsObject.overallTotalToDateStr];

                CGRect summaryContainerViewFrame = CGRectMake(self.supervisorSummaryContainerView.frame.origin.x, yPositionToPutSupervisorSummaryConatinerView,self.supervisorSummaryContainerView.frame.size.width, self.supervisorSummaryContainerView.frame.size.height);

                UIView *summaryContainerView = [[UIView alloc]initWithFrame:summaryContainerViewFrame];
                summaryContainerView.backgroundColor = [UIColor blackColor];
                [summaryContainerView addSubview:headerLabel];
                [summaryContainerView addSubview:interventionHeaderLabel];
                [summaryContainerView addSubview:assessmentHeaderLabel];
                [summaryContainerView addSubview:supportHeaderLabel];
                [summaryContainerView addSubview:supervisionHeaderLabel];
                [summaryContainerView addSubview:interventionHoursLabel];
                [summaryContainerView addSubview:assessmentHoursLabel];
                [summaryContainerView addSubview:supportHoursLabel];
                [summaryContainerView addSubview:supervisionHoursLabel];
                [summaryContainerView addSubview:signatureLabel];
                [summaryContainerView addSubview:signatureUnderLineLabel];
                [summaryContainerView addSubview:dateAboveLineLabel];
                [summaryContainerView addSubview:dateBelowLineLabel];
                [summaryContainerView addSubview:totalToDateLabel];

                CGRect containerForSignaturesAndSupervisorSummariesFrame = self.containerForSignaturesAndSupervisorSummaries.frame;

                containerForSignaturesAndSupervisorSummariesFrame.size.height = containerForSignaturesAndSupervisorSummariesFrame.size.height + summaryContainerView.frame.size.height + 15;
                self.containerForSignaturesAndSupervisorSummaries.frame = containerForSignaturesAndSupervisorSummariesFrame;

                [self.containerForSignaturesAndSupervisorSummaries addSubview:summaryContainerView];

               
                
                yPositionToPutSupervisorSummaryConatinerView = yPositionToPutSupervisorSummaryConatinerView + summaryContainerView.frame.size.height + 15;
            }

            [self.containerForSignaturesAndSupervisorSummaries addSubview:self.signaturesView];
            CGRect signaturesViewFrame = self.signaturesView.frame;

            signaturesViewFrame.origin.y = yPositionToPutSupervisorSummaryConatinerView;
            self.signaturesView.frame = signaturesViewFrame;
        }
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableModel didAddSectionAtIndex:(NSUInteger)index
{
    SCTableViewSection *section = (SCTableViewSection *)[tableModel sectionAtIndex:index];
    SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *objectsSection = nil;
    if ([section isKindOfClass:[SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter class]])
    {
        objectsSection = (SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *)section;
    }

    if (objectsSection.headerTitle && objectsSection.headerTitle.length)
    {
        UIView *containerView = [[UIView alloc] initWithFrame:sectionSubHeaderView.frame];

        UILabel *headerLabel = [[UILabel alloc] initWithFrame:sectionSubHeaderLabel.frame];
        headerLabel.adjustsFontSizeToFitWidth = YES;
        headerLabel.minimumFontSize = sectionSubHeaderLabel.minimumFontSize;
        headerLabel.font = sectionSubHeaderLabel.font;
        containerView.backgroundColor = sectionSubHeaderView.backgroundColor;
        headerLabel.backgroundColor = sectionSubHeaderLabel.backgroundColor;
        headerLabel.textColor = sectionSubHeaderLabel.textColor;
        headerLabel.tag = 60;
        headerLabel.text = objectsSection.headerTitle;
        headerLabel.textAlignment = UITextAlignmentCenter;
        [containerView addSubview:headerLabel];

        objectsSection.headerView = containerView;
    }

    if ( (objectsSection.footerNotes && objectsSection.footerNotes.length) || (objectsSection.footerTotal && objectsSection.footerTotal.length) )
    {
        UITextView *footerNotesTextView = [[UITextView alloc] initWithFrame:sectionSubFooterNotesTextView.frame];
        footerNotesTextView.font = sectionSubFooterNotesTextView.font;

        footerNotesTextView.backgroundColor = sectionSubFooterNotesTextView.backgroundColor;
        footerNotesTextView.textColor = sectionSubFooterNotesTextView.textColor;

        footerNotesTextView.textAlignment = UITextAlignmentLeft;
        footerNotesTextView.tag = 61;

        footerNotesTextView.hidden = YES;

        [footerNotesTextView setContentInset:UIEdgeInsetsMake(-9, 0, 0,0)];

        UIView *footerContainerView = [[UIView alloc] initWithFrame:sectionSubFooterView.frame];

        [footerContainerView addSubview:footerNotesTextView];

        if (footerNotesTextView.contentSize.height - 9 > footerContainerView.frame.size.height)
        {
            CGRect footerContainerViewFrame = footerContainerView.frame;
            footerContainerViewFrame.size.height = footerNotesTextView.contentSize.height - 6;

            footerContainerView.frame = footerContainerViewFrame;
        }

        CGRect footerNotesTextViewFrame = footerNotesTextView.frame;
        NSString *footerTotal = (NSString *)objectsSection.footerTotal;

        if (footerNotesTextView.contentSize.height > footerNotesTextView.frame.size.height)
        {
            footerNotesTextViewFrame.size.height = footerNotesTextView.contentSize.height - 9;
        }

        if (!footerTotal || !footerTotal.length)
        {
            footerNotesTextViewFrame.size.width = footerContainerView.frame.size.width - 7;
        }

        footerNotesTextView.frame = footerNotesTextViewFrame;

        footerContainerView.backgroundColor = sectionSubFooterView.backgroundColor;
        if (footerTotal && footerTotal.length)
        {
            UIView *subFooterLabelContainerView = [[UIView alloc]initWithFrame:self.sectionSubFooterLabelContainerView.frame];
            subFooterLabelContainerView.backgroundColor = self.sectionSubFooterLabelContainerView.backgroundColor;

            UILabel *footerLabel = [[UILabel alloc] initWithFrame:sectionSubFooterLabel.frame];
            footerLabel.font = sectionSubFooterLabel.font;

            footerLabel.backgroundColor = sectionSubFooterLabel.backgroundColor;
            footerLabel.textColor = sectionSubFooterLabel.textColor;
            footerLabel.tag = 60;

            footerLabel.text = footerTotal;
            footerLabel.textAlignment = UITextAlignmentCenter;
            [subFooterLabelContainerView addSubview:footerLabel];

            [footerContainerView addSubview:subFooterLabelContainerView];
        }

        objectsSection.footerView = footerContainerView;
    }
}


- (NSArray *) fetchUnorderedObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:entityStr inManagedObjectContext:appDelegate.managedObjectContext];

    [fetchRequest setEntity:entity];

    if (filterPredicate)
    {
        [fetchRequest setPredicate:filterPredicate];
    }

    NSError *error = nil;
    NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    return fetchedObjects;
}


- (NSArray *) fetchObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate pathsForPrefetching:(NSArray *)pathsForPrefetching
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:entityStr inManagedObjectContext:appDelegate.managedObjectContext];

    [fetchRequest setEntity:entity];
    [fetchRequest setRelationshipKeyPathsForPrefetching:
     pathsForPrefetching];

    if (filterPredicate)
    {
        [fetchRequest setPredicate:filterPredicate];
    }

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSError *error = nil;
    NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    return fetchedObjects;
}


- (CGSize) interventionTableViewContentSize
{
    [self.interventionTypesTableView layoutIfNeeded];
    return [self.interventionTypesTableView contentSize];
}


- (CGSize) assessmentTypesTableViewContentSize
{
    [self.assessmentTypesTableView layoutIfNeeded];
    return [self.assessmentTypesTableView contentSize];
}


- (CGSize) supportTypesTableViewContentSize
{
    [self.supportActivitieTypesTableView layoutIfNeeded];
    return [self.supportActivitieTypesTableView contentSize];
}


- (CGSize) supervisionTypesTableViewContentSize
{
    [self.supervisionReceivedTypesTableView layoutIfNeeded];
    return [self.supervisionReceivedTypesTableView contentSize];
}


@end
