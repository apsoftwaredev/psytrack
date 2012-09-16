//
//  DemographicReportTopCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicReportTopCell.h"
#import "PTTAppDelegate.h"
#import "MyInformationAndTotalClients.h"
#import "DemographicSexCounts.h"
#import "DemographicSex.h"
#import "DemographicGenderCounts.h"
#import "GenderEntity.h"
#import "DemographicGenderCounts.h"

#import "EthnicityCombinationCount.h"
#import "EthnicityEntity.h"
#import "DemographicEthnicityCounts.h"
#import "RaceEntity.h"
#import "RaceCombinationCount.h"
#import "DemographicRaceCounts.h"
#import "DisabilityEntity.h"


#import "DemographicDisabilityCount.h"
#import "DemographicEducationCounts.h"

@implementation DemographicReportTopCell

@synthesize sexObjectsModel=sexObjectsModel_;
@synthesize genderObjectsModel=genderObjectsModel_;
@synthesize ethnicitiesObjectsModel=ethnicitiesObjectsModel_;
@synthesize racesObjectsModel=racesObjectsModel_;

@synthesize disabilityObjectsModel=disabilityObjectsModel_;
@synthesize educationLevelObjectsModel=educationLevelObjectsModel_;
@synthesize sexualOrientationObjectsModel=sexualOrientationObjectsModel_;



@synthesize sexTableView;
@synthesize genderTableView;
@synthesize ethnicitiesTableView;
@synthesize racesTableView;

@synthesize disabilityTableView;
@synthesize educationTableView;
@synthesize sexualOrientationTableView;
@synthesize mainPageScrollView;

@synthesize clinicianNameLabel;
@synthesize tablesContainerView;

@synthesize totalClientsLabel;

static float const MAX_MAIN_SCROLLVIEW_HEIGHT=1110;

-(void)willDisplay{
    
    self.accessoryType=UITableViewCellAccessoryNone;
    
    
    
    //
    
    CGFloat sexTVHeight=[self sexTableViewContentSize].height;
    CGFloat genderTVHeight=[self genderTableViewContentSize].height;
    CGFloat ethnicityTVHeight=[self ethnicityTableViewContentSize].height;
    CGFloat raceTVHeight=[self raceTableViewContentSize].height;
    
    CGFloat disabilityTVHeight=[self disabilityTableViewContentSize].height;
    CGFloat educationLevelTVHeight=[self educationTableViewContentSize].height;
    CGFloat sexualOrientationTVHeight=[self sexualOrientationViewContentSize].height;
    
    
    CGFloat totalPaddingHeight=35.0;
    CGRect tablesContainerViewFrame=self.tablesContainerView.frame;
    
    tablesContainerViewFrame.size.height=sexTVHeight+genderTVHeight+ethnicityTVHeight+raceTVHeight+disabilityTVHeight+educationLevelTVHeight+sexualOrientationTVHeight+totalPaddingHeight+10.0;
    
    self.tablesContainerView.frame=tablesContainerViewFrame;
    
    CGRect sexTableViewFrame=self.sexTableView.frame;
    CGRect genderTableViewFrame=self.genderTableView.frame;
    CGRect ethnicityTableViewFrame=self.ethnicitiesTableView.frame;
    CGRect raceTableViewFrame=self.racesTableView.frame;
    CGRect disabilityTableViewFrame=self.disabilityTableView.frame;
    CGRect educationLevelTableViewFrame=self.educationTableView.frame;
    CGRect sexualOrientationTableViewFrame=self.sexualOrientationTableView.frame;
    
    CGFloat padding=5.0;
    
    sexTableViewFrame.size.height=sexTVHeight;
    genderTableViewFrame.origin.y=sexTableViewFrame.origin.y+sexTVHeight+padding;
    genderTableViewFrame.size.height=genderTVHeight;
    ethnicityTableViewFrame.origin.y=genderTableViewFrame.origin.y+genderTVHeight+padding;
    ethnicityTableViewFrame.size.height=ethnicityTVHeight;
    raceTableViewFrame.origin.y=ethnicityTableViewFrame.origin.y+ethnicityTVHeight+padding;
    raceTableViewFrame.size.height=raceTVHeight;
    disabilityTableViewFrame.origin.y=raceTableViewFrame.origin.y+raceTVHeight+padding;
    disabilityTableViewFrame.size.height=disabilityTVHeight;
    educationLevelTableViewFrame.origin.y=disabilityTableViewFrame.origin.y+disabilityTVHeight+padding;
    educationLevelTableViewFrame.size.height=educationLevelTVHeight;
    sexualOrientationTableViewFrame.origin.y=educationLevelTableViewFrame.origin.y+educationLevelTVHeight+padding;
    sexualOrientationTableViewFrame.size.height=sexualOrientationTVHeight;
    

    self.sexTableView.frame=sexTableViewFrame;
    self.genderTableView.frame=genderTableViewFrame;
    self.ethnicitiesTableView.frame=ethnicityTableViewFrame;
    self.racesTableView.frame=raceTableViewFrame;
    
    self.disabilityTableView.frame=disabilityTableViewFrame;
    self.educationTableView.frame=educationLevelTableViewFrame;
    self.sexualOrientationTableView.frame=sexualOrientationTableViewFrame;
    
    CGRect mainScrollViewFrame=self.mainPageScrollView.frame;
    
    mainScrollViewFrame.size.height=MAX_MAIN_SCROLLVIEW_HEIGHT;
    
    
    self.mainPageScrollView.frame=mainScrollViewFrame;
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(scrollToNextPage)
     name:@"ScrollDemographicVCToNextPage"
     object:nil];
}

-(void)scrollToNextPage{
    
    UIScrollView *mainScrollView=self.mainPageScrollView;
    
    
    
    
    
    if ((self.sexualOrientationTableView.frame.origin.y+self.sexualOrientationTableView.frame.size.height)<=(MAX_MAIN_SCROLLVIEW_HEIGHT+currentOffsetY)) {
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ScrollDemographicReportVCToNextPage" object:nil];
        
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        appDelegate.stopScrollingMonthlyPracticumLog=YES;
        currentOffsetY=0;
        
    } else {
        
         
        
            [self.mainPageScrollView setContentOffset:CGPointMake(0, mainScrollView.frame.size.height+currentOffsetY )];
            currentOffsetY=currentOffsetY+mainScrollView.frame.size.height;
        
        
        CGFloat paddAdditonalY=0;
        
        
        for (NSInteger i=0; i<self.tablesContainerView.subviews.count; i++) {
            UIView *subview =[self.tablesContainerView.subviews objectAtIndex:i];
            CGRect subviewFrame=subview.frame;
            if ((currentOffsetY+MAX_MAIN_SCROLLVIEW_HEIGHT )-subview.frame.origin.y+subview.frame.size.height<66.0
               ) {
                
                
                
                paddAdditonalY=(currentOffsetY+MAX_MAIN_SCROLLVIEW_HEIGHT)-(subviewFrame.origin.y+subview.frame.origin.y)+5;
                
                CGRect tableContainerViewFrame=self.tablesContainerView.frame;
                tableContainerViewFrame.size.height=tableContainerViewFrame.size.height+paddAdditonalY;
                self.tablesContainerView.transform=CGAffineTransformIdentity;
                self.tablesContainerView.frame=tableContainerViewFrame;
                
               
                subviewFrame.origin.y=subviewFrame.origin.y+paddAdditonalY;
                subview.transform=CGAffineTransformIdentity;
                subview.frame=subviewFrame;
                
                for (NSInteger p=i+1; p<self.tablesContainerView.subviews.count; p++) {
                    UIView *nextSubview=[self.tablesContainerView.subviews objectAtIndex:p];
                    
                    CGRect nextSubviewFrame=nextSubview.frame;
                    nextSubviewFrame.origin.y=nextSubviewFrame.origin.y+paddAdditonalY;
                    nextSubview.transform=CGAffineTransformIdentity;
                    nextSubview.frame=nextSubviewFrame;
                    paddAdditonalY=paddAdditonalY+nextSubviewFrame.origin.y+nextSubviewFrame.size.height;
                    
                    
                }
                
                
                
            }
            
            
        }}
        
      
    
}
-(void)loadBindingsIntoCustomControls{
    
    [super loadBindingsIntoCustomControls];
    
    MyInformationAndTotalClients *totalsObject=(MyInformationAndTotalClients *)self.boundObject;
    
    
   
    numberOfSupervisors=totalsObject.totalClients;
    
    
    NSString *bottomCellNibName=nil;
    
    
    
    bottomCellNibName=@"DemographicReportBottomCell";
    
    
    
   
    self.clinicianNameLabel.text=totalsObject.myName;
    //
 
    
    self.sexObjectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.sexTableView];
    
    sexObjectsModel_.delegate=self;
    //
   
   
    
    for (InterventionTypeEntity *interventionType in fetchedInterventionObjects) {
        
        TrackTypeWithTotalTimes *interventionTypeWithTotalTimes=[[TrackTypeWithTotalTimes alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:clinician trackTypeObject:interventionType];
        
        
        
        
        [interventionType willAccessValueForKey:@"subTypes"];
        NSSet *interventionSubTypeSet=interventionType.subTypes;
        
        NSArray *subTypesArray=nil;
        
        if (interventionSubTypeSet &&[interventionSubTypeSet isKindOfClass:[NSSet class]]) {
            
            subTypesArray=interventionSubTypeSet.allObjects;
        }
        
        
        
        NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                                        ascending:YES] ;
        
        
        NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
        NSMutableArray *orderdSubTypeArray=[NSMutableArray arrayWithArray:(NSArray *)[subTypesArray sortedArrayUsingDescriptors:sortDescriptors]];
        
        NSMutableArray *subTypeWithTotalsItemsArray=[NSMutableArray array];
        
        
        
        for (InterventionTypeSubtypeEntity *interventionSubTypeObject in orderdSubTypeArray ) {
            TrackTypeWithTotalTimes *trackTypeWithTotalTimeObject=[[TrackTypeWithTotalTimes alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:clinician trackTypeObject:interventionSubTypeObject];
            
            [subTypeWithTotalsItemsArray addObject:trackTypeWithTotalTimeObject];
            
        }
        
        
        SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *interventionsSection = [SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter sectionWithHeaderTitle:interventionType.interventionType footerNotes:interventionTypeWithTotalTimes.monthlyLogNotes sectionTotalStr: interventionTypeWithTotalTimes.totalToDateStr items:subTypeWithTotalsItemsArray itemsDefinition:typesDef];
        
        //        NSString *monthlyLogNotes=[interventionType monthlyLogNotesForMonth:self.monthToDisplay clinician:self.clinician];
        
        
        
        interventionsSection.dataFetchOptions=dataFetchOptions;
        
        
        interventionsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
        {
            // Create & return a custom cell based on the cell in ContactOverviewCell.xib
            
            
            //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
            
            NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"interventionSubType", nil] forKeys:[NSArray arrayWithObjects:@"20", nil]];
            
            AllHoursReportBottomCell *allHoursBottomCell = [AllHoursReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];
            
            
            return allHoursBottomCell;
        };
        
        
        
        
        
        
        
        [interventionObjectsModel_ addSection:interventionsSection];
        [interventionType didAccessValueForKey:@"subTypes"];
        
    }
    
    
    self.assessmentObjectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.assessmentTypesTableView];
    
    assessmentObjectsModel_.delegate=self;
    NSArray *fetchedAssessmentObjects =  [self fetchObjectsFromEntity:(NSString *)@"AssessmentTypeEntity" filterPredicate:nil pathsForPrefetching:(NSArray *)[NSArray arrayWithObjects:@"assessements.time",@"existingAssessments",nil]];
    
    NSMutableArray *assessmentTypesWithTotalsItemsArray=[NSMutableArray array];
    
    for (AssessmentTypeEntity *assessmentType in fetchedAssessmentObjects) {
        
        TrackTypeWithTotalTimes *assessmentTypeWithTotalTimes=[[TrackTypeWithTotalTimes alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:clinician trackTypeObject:assessmentType];
        
        
        
        
        
        
        [assessmentTypesWithTotalsItemsArray addObject:assessmentTypeWithTotalTimes];
        
    }
    
    
    
    
    
    
    
    SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *assessmentObjectsSection = [SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter sectionWithHeaderTitle:nil footerNotes:totalsObject.assessmentMonthlyNotes sectionTotalStr:nil items:assessmentTypesWithTotalsItemsArray itemsDefinition:typesDef];
    
    //        NSString *monthlyLogNotes=[interventionType monthlyLogNotesForMonth:self.monthToDisplay clinician:self.clinician];
    
    
    assessmentObjectsSection.dataFetchOptions=dataFetchOptions;
    
    assessmentObjectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        
        
        //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
        
        NSDictionary *assessmentBindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"assessmentType", nil] forKeys:[NSArray arrayWithObjects:@"20", nil]];
        
        AllHoursReportBottomCell *assessmentTypeCell = [AllHoursReportBottomCell cellWithText:nil objectBindings:assessmentBindingsDictionary nibName:bottomCellNibName];
        
        return assessmentTypeCell;
    };
    
    
    
    
    
    
    
    [assessmentObjectsModel_ addSection:assessmentObjectsSection];
    
    
    
    self.supportObjectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.supportActivitieTypesTableView];
    
    supportObjectsModel_.delegate=self;
    NSArray *fetchedSupportObjects =  [self fetchObjectsFromEntity:(NSString *)@"SupportActivityTypeEntity" filterPredicate:nil pathsForPrefetching:(NSArray *)[NSArray arrayWithObjects:@"supportActivitiesDelivered.time",@"existingSupportActivities",nil]];
    
    NSMutableArray *supportActivitytTypesWithTotalsItemsArray=[NSMutableArray array];
    
    for (SupportActivityTypeEntity *supportActivityType in fetchedSupportObjects) {
        
        TrackTypeWithTotalTimes *supportActivityTypeWithTotalTimes=[[TrackTypeWithTotalTimes alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:clinician trackTypeObject:supportActivityType];
        
        
        
        
        
        
        [supportActivitytTypesWithTotalsItemsArray addObject:supportActivityTypeWithTotalTimes];
        
    }
    
    
    
    
    
    
    
    
    SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *supportObjectsSection = [SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter sectionWithHeaderTitle:nil footerNotes:totalsObject.supportMonthlyNotes sectionTotalStr:nil items:supportActivitytTypesWithTotalsItemsArray itemsDefinition:typesDef];
    
    //        NSString *monthlyLogNotes=[interventionType monthlyLogNotesForMonth:self.monthToDisplay clinician:self.clinician];
    
    
    
    
    
    
    supportObjectsSection.dataFetchOptions=dataFetchOptions;
    
    
    supportObjectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        
        
        //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
        
        NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"supportType", nil] forKeys:[NSArray arrayWithObjects:@"20", nil]];
        
        AllHoursReportBottomCell *allHoursBottomCell = [AllHoursReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];
        
        
        return allHoursBottomCell;    };
    
    
    
    
    
    
    
    [supportObjectsModel_ addSection:supportObjectsSection];
    
    
    self.supervisionObjectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.supervisionReceivedTypesTableView];
    
    supervisionObjectsModel_.delegate=self;
    //
    
    NSArray *fetchedSupervisionObjects =  [self fetchObjectsFromEntity:(NSString *)@"SupervisionTypeEntity" filterPredicate:nil pathsForPrefetching:(NSArray *)[NSArray arrayWithObjects:@"supervisionReceived.time",@"existingSupervision",nil]];
    //
    
    for (SupervisionTypeEntity *supervisionType in fetchedSupervisionObjects) {
        
        TrackTypeWithTotalTimes *supervisionTypeWithTotalTimes=[[TrackTypeWithTotalTimes alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:clinician trackTypeObject:supervisionType];
        
        
        
        
        [supervisionType willAccessValueForKey:@"subTypes"];
        NSSet *supervisionSubTypeSet=supervisionType.subTypes;
        
        NSArray *subTypesArray=nil;
        
        if (supervisionSubTypeSet &&[supervisionSubTypeSet isKindOfClass:[NSSet class]]) {
            
            subTypesArray=supervisionSubTypeSet.allObjects;
        }
        
        
        
        
        NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                                        ascending:YES] ;
        
        
        NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
        NSMutableArray *orderdSubTypeArray=[NSMutableArray arrayWithArray:(NSArray *)[subTypesArray sortedArrayUsingDescriptors:sortDescriptors]];
        
        NSMutableArray *subTypeWithTotalsItemsArray=[NSMutableArray array];
        
        
        
        for (SupervisionTypeSubtypeEntity *supervisionSubTypeObject in orderdSubTypeArray ) {
            TrackTypeWithTotalTimes *trackTypeWithTotalTimeObject=[[TrackTypeWithTotalTimes alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:clinician trackTypeObject:supervisionSubTypeObject];
            
            [subTypeWithTotalsItemsArray addObject:trackTypeWithTotalTimeObject];
            
        }
        
        
        SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *supervisionSection = [SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter sectionWithHeaderTitle:supervisionType.supervisionType footerNotes:supervisionTypeWithTotalTimes.monthlyLogNotes sectionTotalStr: supervisionTypeWithTotalTimes.totalToDateStr items:subTypeWithTotalsItemsArray itemsDefinition:typesDef];
        
        //        NSString *monthlyLogNotes=[interventionType monthlyLogNotesForMonth:self.monthToDisplay clinician:self.clinician];
        
        
        
        supervisionSection.dataFetchOptions=dataFetchOptions;
        
        
        supervisionSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
        {
            // Create & return a custom cell based on the cell in ContactOverviewCell.xib
            
            
            //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
            
            NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"supervisionSubType", nil] forKeys:[NSArray arrayWithObjects:@"20", nil]];
            
            AllHoursReportBottomCell *allHoursBottomCell = [AllHoursReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];
            
            
            return allHoursBottomCell;
        };
        
        
        
        
        
        
        
        [supervisionObjectsModel_ addSection:supervisionSection];
        [supervisionType didAccessValueForKey:@"subTypes"];
        
    }
    
    
    
    
    
    
    
    //    self.interventionTypesTableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    
    
    
    
    
    
    self.interventionHoursTotalHoursLabel.text=totalsObject.interventionTotalToDateStr;
    self.assessmentHoursTotalHoursLabel.text=totalsObject.assessmentTotalToDateStr;
    self.supportHoursTotalHoursLabel.text=totalsObject.supportTotalToDateStr;
    self.supervisionHoursTotalHoursLabel.text=totalsObject.supervisionTotalToDateStr;
    self.directHoursTotalHoursLabel.text=totalsObject.directTotalToDateStr;
    self.overallHoursTotalHoursLabel.text=totalsObject.overallTotalToDateStr;
    
    CGFloat yPositionToPutSupervisorSummaryConatinerView=0;
    
    if (!numberOfSupervisors) {
        CGRect containerForSignaturesAndSupervisorSummariesFrame=self.containerForSignaturesAndSupervisorSummaries.frame;
        
        containerForSignaturesAndSupervisorSummariesFrame.size.height=self.signaturesView.frame.size.height+15;
        self.containerForSignaturesAndSupervisorSummaries.frame=containerForSignaturesAndSupervisorSummariesFrame;
        
        
        yPositionToPutSupervisorSummaryConatinerView=0;
        
        CGRect signaturesViewFrame=self.signaturesView.frame;
        
        signaturesViewFrame.origin.y=yPositionToPutSupervisorSummaryConatinerView;
        self.signaturesView.frame=signaturesViewFrame;
        
        
        [self.containerForSignaturesAndSupervisorSummaries addSubview:self.signaturesView];
        [self.subTablesContainerView addSubview:self.containerForSignaturesAndSupervisorSummaries];
    }
    else {
        
        for ( int i=0;i<numberOfSupervisors;i++) {
            ClinicianEntity *supervisor=[totalsObject.clinicians objectAtIndex:i];
            SupervisorsAndTotalTimesForMonth *supervisorTotalsObject=[[SupervisorsAndTotalTimesForMonth alloc]initWithDoctorateLevel:totalsObject.doctorateLevel clinician:supervisor];
            if (i==0) {
                
                self.supervisorSummaryHeaderLabel.text=[NSString stringWithFormat:@"Summary of Hours Supervised by %@ (Total:%@)",supervisor.combinedName,supervisorTotalsObject.overallTotalToDateStr];
                
                
                self.supervisorSummaryTotalInterventionHoursLabel.text=totalsObject.interventionTotalToDateStr;
                self.supervisorSummaryTotalAssessmentHoursLabel.text=totalsObject.assessmentTotalToDateStr;
                self.supervisorSummaryTotalSupportHoursLabel.text=totalsObject.supportTotalToDateStr;
                self.supervisorSummaryTotalSupervisionHoursLabel.text=totalsObject.supervisionTotalToDateStr;
                self.supervisorSummaryTotalToDateHoursLabel.text=[NSString stringWithFormat:@"Total Hours with %@: %@",supervisor.combinedName, supervisorTotalsObject.overallTotalToDateStr];
                self.supervisorSummarySignatureLabel.text=nil;
                self.supervisorSummarySignatureTitleUnderLineLabel.text=[NSString stringWithFormat:@"Signature for %@",supervisor.combinedName];
                self.supervisorSummaryDateAboveLineLabel.text=nil;
                [self.containerForSignaturesAndSupervisorSummaries addSubview:self.supervisorSummaryContainerView];
                
                yPositionToPutSupervisorSummaryConatinerView=yPositionToPutSupervisorSummaryConatinerView+self.supervisorSummaryContainerView.frame.size.height+15;
                
            }
            else {
                
                
                
                UILabel *nibSupervisorSummaryHeader=self.supervisorSummaryHeaderLabel;
                UILabel *headerLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummaryHeader.frame];
                headerLabel.backgroundColor=[UIColor whiteColor];
                headerLabel.font=nibSupervisorSummaryHeader.font;
                headerLabel.textAlignment=nibSupervisorSummaryHeader.textAlignment;
                headerLabel.text=[NSString stringWithFormat:@"Summary of Hours Supervised by %@ (Month Total:%@)",supervisor.combinedName,supervisorTotalsObject.overallTotalForMonthStr];
                
                UILabel *nibSupervisorSummaryInterventionHeader=self.supervisorSummaryTotalInterventionHeaderLabel;
                UILabel *interventionHeaderLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummaryInterventionHeader.frame];
                interventionHeaderLabel.backgroundColor=[UIColor whiteColor];
                interventionHeaderLabel.font=nibSupervisorSummaryInterventionHeader.font;
                interventionHeaderLabel.textAlignment=nibSupervisorSummaryInterventionHeader.textAlignment;
                interventionHeaderLabel.text=nibSupervisorSummaryInterventionHeader.text;
                interventionHeaderLabel.lineBreakMode=UILineBreakModeWordWrap;
                interventionHeaderLabel.numberOfLines=2;
                
                UILabel *nibSupervisorSummaryAssessmentHeader=self.supervisorSummaryTotalAssessmentHeaderLabel;
                UILabel *assessmentHeaderLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummaryAssessmentHeader.frame];
                assessmentHeaderLabel.backgroundColor=[UIColor whiteColor];
                assessmentHeaderLabel.font=nibSupervisorSummaryAssessmentHeader.font;
                assessmentHeaderLabel.textAlignment=nibSupervisorSummaryAssessmentHeader.textAlignment;
                assessmentHeaderLabel.text=nibSupervisorSummaryAssessmentHeader.text;
                assessmentHeaderLabel.lineBreakMode=UILineBreakModeWordWrap;
                assessmentHeaderLabel.numberOfLines=2;
                
                UILabel *nibSupervisorSummarySupportHeader=self.supervisorSummaryTotalSupportHeaderLabel;
                UILabel *supportHeaderLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummarySupportHeader.frame];
                supportHeaderLabel.backgroundColor=[UIColor whiteColor];
                supportHeaderLabel.font=nibSupervisorSummarySupportHeader.font;
                supportHeaderLabel.textAlignment=nibSupervisorSummarySupportHeader.textAlignment;
                supportHeaderLabel.text=nibSupervisorSummarySupportHeader.text;
                supportHeaderLabel.lineBreakMode=UILineBreakModeWordWrap;
                supportHeaderLabel.numberOfLines=2;
                
                
                UILabel *nibSupervisorSummarySupervisionHeader=self.supervisorSummaryTotalSupervisionHeaderLabel;
                UILabel *supervisionHeaderLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummarySupervisionHeader.frame];
                supervisionHeaderLabel.backgroundColor=[UIColor whiteColor];
                supervisionHeaderLabel.font=nibSupervisorSummarySupervisionHeader.font;
                supervisionHeaderLabel.textAlignment=nibSupervisorSummarySupervisionHeader.textAlignment;
                supervisionHeaderLabel.text=nibSupervisorSummarySupervisionHeader.text;
                supervisionHeaderLabel.lineBreakMode=UILineBreakModeWordWrap;
                supervisionHeaderLabel.numberOfLines=2;
                
                UILabel *nibSupervisorSummaryInterventionHours=self.supervisorSummaryTotalInterventionHoursLabel;
                UILabel *interventionHoursLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummaryInterventionHours.frame];
                interventionHoursLabel.backgroundColor=[UIColor whiteColor];
                interventionHoursLabel.font=nibSupervisorSummaryInterventionHours.font;
                interventionHoursLabel.textAlignment=nibSupervisorSummaryInterventionHours.textAlignment;
                interventionHoursLabel.text=supervisorTotalsObject.interventionTotalForMonthStr;
                
                UILabel *nibSupervisorSummaryAssessmentHours=self.supervisorSummaryTotalAssessmentHoursLabel;
                UILabel *assessmentHoursLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummaryAssessmentHours.frame];
                assessmentHoursLabel.backgroundColor=[UIColor whiteColor];
                assessmentHoursLabel.font=nibSupervisorSummaryAssessmentHours.font;
                assessmentHoursLabel.textAlignment=nibSupervisorSummaryAssessmentHours.textAlignment;
                assessmentHoursLabel.text=supervisorTotalsObject.assessmentTotalForMonthStr;
                
                UILabel *nibSupervisorSummarySupportHours=self.supervisorSummaryTotalSupportHoursLabel;
                UILabel *supportHoursLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummarySupportHours.frame];
                supportHoursLabel.backgroundColor=[UIColor whiteColor];
                supportHoursLabel.font=nibSupervisorSummarySupportHours.font;
                supportHoursLabel.textAlignment=nibSupervisorSummarySupportHours.textAlignment;
                supportHoursLabel.text=supervisorTotalsObject.supportTotalForMonthStr;
                
                
                UILabel *nibSupervisorSummarySupervisionHours=self.supervisorSummaryTotalSupervisionHoursLabel;
                UILabel *supervisionHoursLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummarySupervisionHours.frame];
                supervisionHoursLabel.backgroundColor=[UIColor whiteColor];
                supervisionHoursLabel.font=nibSupervisorSummarySupervisionHours.font;
                supervisionHoursLabel.textAlignment=nibSupervisorSummarySupervisionHours.textAlignment;
                supervisionHoursLabel.text=supervisorTotalsObject.supervisionTotalForMonthStr;
                
                
                
                
                
                UILabel *nibSupervisorSummarySignature=self.supervisorSummarySignatureLabel;
                UILabel *signatureLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummarySignature.frame];
                signatureLabel.backgroundColor=[UIColor whiteColor];
                signatureLabel.font=nibSupervisorSummarySignature.font;
                signatureLabel.textAlignment=nibSupervisorSummarySignature.textAlignment;
                signatureLabel.text=nil;
                
                UILabel *nibSupervisorSummarySignatureTitleUnderLineLabel=self.supervisorSummarySignatureTitleUnderLineLabel;
                UILabel *signatureUnderLineLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummarySignatureTitleUnderLineLabel.frame];
                signatureUnderLineLabel.backgroundColor=[UIColor whiteColor];
                signatureUnderLineLabel.font=nibSupervisorSummarySignatureTitleUnderLineLabel.font;
                signatureUnderLineLabel.textAlignment=nibSupervisorSummarySignatureTitleUnderLineLabel.textAlignment;
                signatureUnderLineLabel.text=[NSString stringWithFormat:@"Signature for %@",supervisor.combinedName];
                
                UILabel *nibSupervisorSummaryDateAboveLineLabel=self.supervisorSummaryDateAboveLineLabel;
                UILabel *dateAboveLineLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummaryDateAboveLineLabel.frame];
                dateAboveLineLabel.backgroundColor=[UIColor whiteColor];
                dateAboveLineLabel.font=nibSupervisorSummarySignatureTitleUnderLineLabel.font;
                dateAboveLineLabel.textAlignment=nibSupervisorSummarySignatureTitleUnderLineLabel.textAlignment;
                dateAboveLineLabel.text=nil;
                
                UILabel *nibSupervisorSummaryDateBelowLineLabel=self.supervisorSummaryDateBelowLineLabel;
                UILabel *dateBelowLineLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummaryDateBelowLineLabel.frame];
                dateBelowLineLabel.backgroundColor=[UIColor whiteColor];
                dateBelowLineLabel.font=nibSupervisorSummarySignatureTitleUnderLineLabel.font;
                dateBelowLineLabel.textAlignment=nibSupervisorSummarySignatureTitleUnderLineLabel.textAlignment;
                dateBelowLineLabel.text=nibSupervisorSummaryDateBelowLineLabel.text;
                
                UILabel *nibSupervisorSummaryTotalToDateLabel=self.supervisorSummaryTotalToDateHoursLabel;
                UILabel *totalToDateLabel=[[UILabel alloc]initWithFrame:nibSupervisorSummaryTotalToDateLabel.frame];
                totalToDateLabel.backgroundColor=[UIColor whiteColor];
                totalToDateLabel.font=nibSupervisorSummaryTotalToDateLabel.font;
                totalToDateLabel.textAlignment=nibSupervisorSummaryTotalToDateLabel.textAlignment;
                totalToDateLabel.text=[NSString stringWithFormat:@"Total Hours with %@ (including previous months): %@",supervisor.combinedName, supervisorTotalsObject.overallTotalToDateStr];
                
                CGRect summaryContainerViewFrame=CGRectMake(self.supervisorSummaryContainerView.frame.origin.x, yPositionToPutSupervisorSummaryConatinerView,self.supervisorSummaryContainerView.frame.size.width, self.supervisorSummaryContainerView.frame.size.height);
                
                UIView *summaryContainerView=[[UIView alloc]initWithFrame:summaryContainerViewFrame];
                summaryContainerView.backgroundColor=[UIColor blackColor];
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
                
                CGRect containerForSignaturesAndSupervisorSummariesFrame=self.containerForSignaturesAndSupervisorSummaries.frame;
                
                containerForSignaturesAndSupervisorSummariesFrame.size.height=containerForSignaturesAndSupervisorSummariesFrame.size.height+summaryContainerView.frame.size.height+15;
                self.containerForSignaturesAndSupervisorSummaries.frame=containerForSignaturesAndSupervisorSummariesFrame;
                
                
                [self.containerForSignaturesAndSupervisorSummaries addSubview:summaryContainerView];
                
                yPositionToPutSupervisorSummaryConatinerView=yPositionToPutSupervisorSummaryConatinerView+summaryContainerView.frame.size.height+15;
                
                
                
                
                
            }
            
            [self.containerForSignaturesAndSupervisorSummaries addSubview:self.signaturesView];
            CGRect signaturesViewFrame=self.signaturesView.frame;
            
            signaturesViewFrame.origin.y=yPositionToPutSupervisorSummaryConatinerView;
            self.signaturesView.frame=signaturesViewFrame;
            
        }
        
    }
    
    
    
    
    
}

- (CGSize)sexTableViewContentSize
{
    
    [self.sexTableView layoutIfNeeded];
    return [self.sexTableView contentSize];
}

- (CGSize)genderTableViewContentSize
{
    
    [self.genderTableView layoutIfNeeded];
    return [self.genderTableView contentSize];
}

- (CGSize)ethnicityTableViewContentSize
{
    
    [self.ethnicitiesTableView layoutIfNeeded];
    return [self.ethnicitiesTableView contentSize];
}
- (CGSize)raceTableViewContentSize
{
    
    [self.racesTableView layoutIfNeeded];
    return [self.racesTableView contentSize];
}

- (CGSize)disabilityTableViewContentSize
{
    
    [self.disabilityTableView layoutIfNeeded];
    return [self.disabilityTableView contentSize];
}


- (CGSize)educationTableViewContentSize
{
    
    [self.educationTableView layoutIfNeeded];
    return [self.educationTableView contentSize];
}
- (CGSize)sexualOrientationViewContentSize
{
    
    [self.sexualOrientationTableView layoutIfNeeded];
    return [self.sexualOrientationTableView contentSize];
}

@end
