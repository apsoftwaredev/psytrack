//
//  MonthlyPracticumLogTopCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/24/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MonthlyPracticumLogTopCell.h"

#import "PTTAppDelegate.h"
#import "MonthlyPracticumLogMiddleSubCell.h"
#import "InterventionTypeSubtypeEntity.h"
#import "MonthlyPracticumLogBottonCell.h"
#import "InterventionTypeEntity.h"
#import "QuartzCore/QuartzCore.h"
#import "MonthlyPracticumLogTableViewController.h"
#import "SupervisorsAndTotalTimesForMonth.h"
#import "SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter.h"

@interface MonthlyPracticumLogTopCell ()

@end

@implementation MonthlyPracticumLogTopCell

@synthesize interventionTypesTableView,assessmentTypesTableView,supportActivitieTypesTableView,supervisionReceivedTypesTableView;
@synthesize supervisorLabel,studentNameLabel,programLabel,monthYearLabel,courseLabel,practicumSiteNameLabel;
@synthesize interventionHoursWeek1Label;
@synthesize interventionHoursWeek2Label;
@synthesize interventionHoursWeek3Label;
@synthesize interventionHoursWeek4Label;
@synthesize interventionHoursWeek5Label;
@synthesize interventionHoursMonthTotalLabel;
@synthesize interventionHoursCummulativeLabel;
@synthesize interventionHoursTotalHoursLabel;

@synthesize assessmentHoursWeek1Label;
@synthesize assessmentHoursWeek2Label;
@synthesize assessmentHoursWeek3Label;
@synthesize assessmentHoursWeek4Label;
@synthesize assessmentHoursWeek5Label;
@synthesize assessmentHoursMonthTotalLabel;
@synthesize assessmentHoursCummulativeLabel;
@synthesize assessmentHoursTotalHoursLabel;

@synthesize supportHoursWeek1Label;
@synthesize supportHoursWeek2Label;
@synthesize supportHoursWeek3Label;
@synthesize supportHoursWeek4Label;
@synthesize supportHoursWeek5Label;
@synthesize supportHoursMonthTotalLabel;
@synthesize supportHoursCummulativeLabel;
@synthesize supportHoursTotalHoursLabel;

@synthesize supervisionHoursWeek1Label;
@synthesize supervisionHoursWeek2Label;
@synthesize supervisionHoursWeek3Label;
@synthesize supervisionHoursWeek4Label;
@synthesize supervisionHoursWeek5Label;
@synthesize supervisionHoursMonthTotalLabel;
@synthesize supervisionHoursCummulativeLabel;
@synthesize supervisionHoursTotalHoursLabel;

@synthesize mainPageScrollView;
@synthesize directHoursScrollView;
@synthesize indirectHoursScrollView;
@synthesize sectionSubHeaderView;
@synthesize sectionSubHeaderLabel;
@synthesize sectionSubFooterView,sectionSubFooterLabel,sectionSubFooterLabelContainerView,totalInterventionHoursFooterView;
@synthesize objectsModel=objectsModel_;

@synthesize directHoursHeader;
@synthesize directHoursFooter;
@synthesize indirectHoursHeader;
@synthesize overallHoursFooter;
@synthesize signaturesView, pageHeaderView,subTablesContainerView,sectionSubFooterNotesTextView;
@synthesize monthToDisplay,clinician;
@synthesize stopScrolling;


@synthesize directHoursWeek1Label;
@synthesize directHoursWeek2Label;
@synthesize directHoursWeek3Label;
@synthesize directHoursWeek4Label;
@synthesize directHoursWeek5Label;
@synthesize directHoursMonthTotalLabel;
@synthesize directHoursCummulativeLabel;
@synthesize directHoursTotalHoursLabel;
@synthesize directHoursWeekUndefinedLabel;

@synthesize overallHoursWeek1Label;
@synthesize overallHoursWeek2Label;
@synthesize overallHoursWeek3Label;
@synthesize overallHoursWeek4Label;
@synthesize overallHoursWeek5Label;
@synthesize overallHoursMonthTotalLabel;
@synthesize overallHoursCummulativeLabel;
@synthesize overallHoursTotalHoursLabel;
@synthesize overallHoursWeekUndefinedLabel;

@synthesize interventionHoursWeekUndefinedLabel,assessmentoursWeekUndefinedLabel,supportHoursWeekUndefinedLabel,supervisionHoursWeekUndefinedLabel;


static float const MAX_MAIN_SCROLLVIEW_HEIGHT=705;

-(void)willDisplay{
  
    self.accessoryType=UITableViewCellAccessoryNone;
    
    supervisorLabel.text=self.clinician.combinedName;
    
//    NSLog(@" size needed height is %g",[self interventionTableViewContentSize ].height );
    
    CGFloat interventionTVHeight=[self interventionTableViewContentSize].height;
    CGFloat assessmentTVHeight=[self assessmentTypesTableViewContentSize].height;
    CGFloat supportTVHeight=[self supportTypesTableViewContentSize].height;
    CGFloat supervisionTVHeight=[self supervisionTypesTableViewContentSize].height;
    
    CGFloat shiftAssessmentsDown=0;
    CGFloat shiftSupportDown=0;
    CGFloat shiftSupervisionDown=0;
    CGFloat shiftDirectHoursFooterDown=0;
    CGFloat shiftIndirectHoursHeaderDown=0;
    CGFloat shiftOverallHoursFooterDown=0;
    CGFloat shiftSignaturesViewDown=0;
    
    CGFloat interventionMoreNeededHeight=interventionTVHeight- self.interventionTypesTableView.frame.size.height;
    CGFloat assessmentMoreNeededHeight=assessmentTVHeight-self.assessmentTypesTableView.frame.size.height;
    CGFloat supportMoreNeededHeight=supportTVHeight-self.supportActivitieTypesTableView.frame.size.height;
    CGFloat supervisionMoreNeededHeight=supportTVHeight-self.supervisionReceivedTypesTableView.frame.size.height;
   
    CGRect indirectHoursHeaderFrame=self.indirectHoursHeader.frame;
    
    CGRect assessmentsFrame=self.assessmentTypesTableView.frame;
    CGRect supportFrame=self.supportActivitieTypesTableView.frame;
     CGRect supervisionFrame=self.supervisionReceivedTypesTableView.frame;
    
    CGFloat assessmentsHeightMoreNeededAndOrigin=assessmentMoreNeededHeight+assessmentsFrame.origin.y+assessmentsFrame.size.height;
    
    if ((assessmentsHeightMoreNeededAndOrigin>MAX_MAIN_SCROLLVIEW_HEIGHT)&&(assessmentsFrame.origin.y+assessmentMoreNeededHeight<MAX_MAIN_SCROLLVIEW_HEIGHT) &&(MAX_MAIN_SCROLLVIEW_HEIGHT-assessmentsFrame.origin.y+assessmentMoreNeededHeight<54)) {
        assessmentMoreNeededHeight=assessmentMoreNeededHeight+(MAX_MAIN_SCROLLVIEW_HEIGHT- assessmentsFrame.origin.y+assessmentMoreNeededHeight);
    }
    
    
    CGRect containerFrame=(CGRect ) self.subTablesContainerView.frame;

    
    if ( interventionMoreNeededHeight>0) {
        
        containerFrame.size.height=containerFrame.size.height+interventionMoreNeededHeight;
        
    }
    if ( assessmentMoreNeededHeight>0) {
        
        containerFrame.size.height=containerFrame.size.height+assessmentMoreNeededHeight;
    
    }
    if ( supportMoreNeededHeight>0) {
        
        containerFrame.size.height=containerFrame.size.height+supportMoreNeededHeight;
        
    }
    if ( supervisionMoreNeededHeight>0) {
        
        containerFrame.size.height=containerFrame.size.height+supervisionMoreNeededHeight;
        
    }
    
    self.subTablesContainerView.transform=CGAffineTransformIdentity;
    self.subTablesContainerView.frame=containerFrame;
    
     shiftAssessmentsDown=interventionMoreNeededHeight;
    shiftDirectHoursFooterDown=shiftAssessmentsDown+assessmentMoreNeededHeight;
    shiftIndirectHoursHeaderDown=shiftDirectHoursFooterDown;
    shiftSupportDown=shiftIndirectHoursHeaderDown;
    shiftSupervisionDown=shiftSupportDown+supportMoreNeededHeight;
    shiftOverallHoursFooterDown=shiftSupervisionDown+supervisionMoreNeededHeight;
    shiftSignaturesViewDown=shiftOverallHoursFooterDown;
    
    

    self.signaturesView.transform=CGAffineTransformIdentity;
    CGRect signaturesFrame=self.signaturesView.frame;
    
        signaturesFrame.origin.y=signaturesFrame.origin.y+shiftSignaturesViewDown;
  
    
    self.signaturesView.frame=signaturesFrame;
    
    self.overallHoursFooter.transform=CGAffineTransformIdentity;
    CGRect overalHoursFooterFrame=self.overallHoursFooter.frame;
    overalHoursFooterFrame.origin.y=overalHoursFooterFrame.origin.y+shiftOverallHoursFooterDown;
    self.overallHoursFooter.frame=overalHoursFooterFrame;
   
    self.supervisionReceivedTypesTableView.transform=CGAffineTransformIdentity;
   
    supervisionFrame.origin.y=supervisionFrame.origin.y+shiftSupervisionDown;
    supervisionFrame.size.height=supervisionTVHeight;
    self.supervisionReceivedTypesTableView.frame=supervisionFrame;
    
    self.supportActivitieTypesTableView.transform=CGAffineTransformIdentity;
    
    supportFrame.origin.y=supportFrame.origin.y+shiftSupportDown;
    supportFrame.size.height=supportTVHeight;
    self.supportActivitieTypesTableView.frame=supportFrame;
    
    self.indirectHoursHeader.transform=CGAffineTransformIdentity;
    
    indirectHoursHeaderFrame.origin.y=indirectHoursHeaderFrame.origin.y+shiftIndirectHoursHeaderDown;
    self.indirectHoursHeader.frame=indirectHoursHeaderFrame;
    
    self.assessmentTypesTableView.transform=CGAffineTransformIdentity;
    
    assessmentsFrame.origin.y=assessmentsFrame.origin.y+shiftAssessmentsDown;
    assessmentsFrame.size.height=assessmentTVHeight;
    self.assessmentTypesTableView.frame=assessmentsFrame;
    
    self.directHoursFooter.transform=CGAffineTransformIdentity;
    CGRect directHoursFooterFrame=self.directHoursFooter.frame;
   
        directHoursFooterFrame.origin.y=assessmentsFrame.size.height+assessmentsFrame.origin.y+5;  //keep an eye on this
    
    
    
    self.directHoursFooter.frame=directHoursFooterFrame;
    
   
 
    
    CGFloat bottomOfDirectHoursFooter=directHoursFooterFrame.size.height+directHoursFooterFrame.origin.y;

    CGFloat changeScrollHeightTo=MAX_MAIN_SCROLLVIEW_HEIGHT;
    if (bottomOfDirectHoursFooter<MAX_MAIN_SCROLLVIEW_HEIGHT) {
        changeScrollHeightTo=bottomOfDirectHoursFooter;
    }
    else if(bottomOfDirectHoursFooter>MAX_MAIN_SCROLLVIEW_HEIGHT &&directHoursFooterFrame.origin.y<=MAX_MAIN_SCROLLVIEW_HEIGHT){
    
        changeScrollHeightTo=directHoursFooterFrame.origin.y-1;
    
    
    }
    
    
    
    self.mainPageScrollView.transform=CGAffineTransformIdentity;
    CGRect mainPageScrollViewFrame=self.mainPageScrollView.frame;
    mainPageScrollViewFrame.size.height=changeScrollHeightTo;
    self.mainPageScrollView.frame=mainPageScrollViewFrame;
    NSLog(@"mainpagescrollview frame size height is %f",mainPageScrollViewFrame.size.height);
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(scrollToNextPage)
     name:@"ScrollMonthlyPracticumLogToNextPage"
     object:nil];
}

-(void)scrollToNextPage{

UIScrollView *mainScrollView=self.mainPageScrollView;
           
NSLog(@"current offset %f",currentOffsetY);
    
  
    NSLog(@"signatures view fram e origin y %g",signaturesView.frame.origin.y+self.signaturesView.frame.size.height);
    
  
    if ((self.signaturesView.frame.origin.y+self.signaturesView.frame.size.height)<=(mainScrollView.frame.size.height+currentOffsetY+5)) {
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ScrollMonthlyPracticumLogToNextPage" object:nil];
        
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        appDelegate.stopScrollingMonthlyPracticumLog=YES;
        currentOffsetY=0;   
        
    } else {
        
        CGRect mainScrollViewFrame=self.mainPageScrollView.frame;
        if (mainScrollViewFrame.size.height <MAX_MAIN_SCROLLVIEW_HEIGHT) {
            mainScrollViewFrame.size.height=MAX_MAIN_SCROLLVIEW_HEIGHT;
            self.mainPageScrollView.frame=mainScrollViewFrame;
            currentOffsetY=currentOffsetY+ self.indirectHoursHeader.frame.origin.y-5;
            [self.mainPageScrollView setContentOffset:CGPointMake(0, currentOffsetY )];
            
           
        }else {
            [self.mainPageScrollView setContentOffset:CGPointMake(0, mainScrollView.frame.size.height+currentOffsetY )];
            currentOffsetY=currentOffsetY+mainScrollView.frame.size.height;
        }
        
    }       
    
//    CGRect  mainPageScrollViewFrame=mainPageScrollView.frame;
//    mainPageScrollViewFrame.size.height=MAX_MAIN_SCROLLVIEW_HEIGHT;
//    mainScrollView.frame=mainPageScrollViewFrame;

}
-(void)loadBindingsIntoCustomControls{

    [super loadBindingsIntoCustomControls];
    
    SupervisorsAndTotalTimesForMonth *totalsObject=(SupervisorsAndTotalTimesForMonth *)self.boundObject;
    

    NSString *bottomCellNibName=nil;    
    if (totalsObject.overallTotalWeekUndefinedTI) {
        bottomCellNibName=@"MonthlyPracticumLogBottomCellWithUndefined";
    }
    else {
        bottomCellNibName=@"MonthlyPracticumLogBottomCell";
    }

    self.monthToDisplay=totalsObject.monthToDisplay;    
    
    NSLog(@"self month to display is %@",self.monthToDisplay);
    NSLog(@"toplogcell bound object is %@",self.boundObject);
   
    
    
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
NSEntityDescription *entity = [NSEntityDescription entityForName:@"InterventionTypeEntity" inManagedObjectContext:appDelegate.managedObjectContext];
[fetchRequest setEntity:entity];
    [fetchRequest setRelationshipKeyPathsForPrefetching:
     [NSArray arrayWithObjects:@"subTypes",@"subTypes.interventionDelivered.time",@"subTypes.existingInterventions",nil]];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
NSError *error = nil;
NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
if (fetchedObjects == nil) {
   
}
    self.objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.interventionTypesTableView];
    
    SCClassDefinition *subTypesDef=[SCClassDefinition definitionWithClass:[TrackTypeWithTotalTimes class] autoGeneratePropertyDefinitions:YES];
    
    for (InterventionTypeEntity *interventionType in fetchedObjects) {
        
       TrackTypeWithTotalTimes *interventionTypeWithTotalTimes=[[TrackTypeWithTotalTimes alloc]initWithMonth:self.monthToDisplay clinician:self.clinician trackTypeObject:interventionType];
        
        
        SCClassDefinition *trackTypeWithTotalTimesDef=[SCClassDefinition definitionWithClass:[TrackTypeWithTotalTimes class] autoGeneratePropertyDefinitions:YES];
        
        [interventionType willAccessValueForKey:@"subTypes"];
        NSSet *interventionSubTypeSet=interventionType.subTypes;
        
        NSArray *subTypesArray=nil;
    
        if (interventionSubTypeSet &&[interventionSubTypeSet isKindOfClass:[NSSet class]]) {
            
            subTypesArray=interventionSubTypeSet.allObjects;
        }
        
       
        NSLog(@"subtypes array is %@",subTypesArray);
        
        NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                                         ascending:YES] ;
        
        
        NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
        NSMutableArray *orderdSubTypeArray=[NSMutableArray arrayWithArray:(NSArray *)[subTypesArray sortedArrayUsingDescriptors:sortDescriptors]];
        
        NSMutableArray *subTypeWithTotalsItemsArray=[NSMutableArray array];
        
        for (InterventionTypeSubtypeEntity *interventionSubTypeObject in orderdSubTypeArray ) {
            TrackTypeWithTotalTimes *trackTypeWithTotalTimeObject=[[TrackTypeWithTotalTimes alloc]initWithMonth:self.monthToDisplay clinician:[totalsObject.clinicians objectAtIndex:0] trackTypeObject:interventionSubTypeObject];
            
            NSLog(@"tracktype with total times object %@",trackTypeWithTotalTimeObject);
            NSLog(@"track type with total times text is %@",trackTypeWithTotalTimeObject.typeLabelText);
            [subTypeWithTotalsItemsArray addObject:trackTypeWithTotalTimeObject];
            
        }
        NSLog(@"subytpe total items array is %@",subTypeWithTotalsItemsArray);
        
        
        SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *objectsSection = [SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter sectionWithHeaderTitle:interventionType.interventionType footerNotes:interventionTypeWithTotalTimes.monthlyLogNotes sectionTotalStr:interventionTypeWithTotalTimes.totalForMonthStr items:subTypeWithTotalsItemsArray itemsDefinition:subTypesDef];
        
//        NSString *monthlyLogNotes=[interventionType monthlyLogNotesForMonth:self.monthToDisplay clinician:self.clinician];
        
       
        
        SCDataFetchOptions *fetchOptions=[SCDataFetchOptions optionsWithSortKey:@"order" sortAscending:YES filterPredicate:nil];
        
        
        objectsSection.dataFetchOptions=fetchOptions;
        
        
        objectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
        {
            // Create & return a custom cell based on the cell in ContactOverviewCell.xib
            
            NSLog(@"month to display is %@",self.monthToDisplay);
//            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
            
            NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"interventionSubType",totalsObject.monthToDisplay, nil] forKeys:[NSArray arrayWithObjects:@"20",@"21", nil]];
            
            MonthlyPracticumLogBottonCell *contactOverviewCell = [MonthlyPracticumLogBottonCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];
            
            
            return contactOverviewCell;
        };
        
       
        
               
        
        
        objectsModel_.delegate=self;
                [objectsModel_ addSection:objectsSection];
        [interventionType didAccessValueForKey:@"subTypes"];
        
    }
    
  
    
    
    self.interventionTypesTableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
   NSLog(@"background size height is %g",self.interventionTypesTableView.backgroundView.frame.size.height);
    objectsModel_.delegate=self;
    
   
    self.interventionHoursWeek1Label.text=totalsObject.interventionTotalWeek1Str;
    self.assessmentHoursWeek1Label.text=totalsObject.assessmentTotalWeek1Str;
    self.supportHoursWeek1Label.text=totalsObject.supportTotalWeek1Str;
    self.supervisionHoursWeek1Label.text=totalsObject.supervisionTotalWeek1Str;
    
    self.interventionHoursWeek2Label.text=totalsObject.interventionTotalWeek2Str;
    self.assessmentHoursWeek2Label.text=totalsObject.assessmentTotalWeek2Str;
    self.supportHoursWeek2Label.text=totalsObject.supportTotalWeek2Str;
    self.supervisionHoursWeek2Label.text=totalsObject.supervisionTotalWeek2Str;
    
    self.interventionHoursWeek3Label.text=totalsObject.interventionTotalWeek3Str;
    self.assessmentHoursWeek3Label.text=totalsObject.assessmentTotalWeek3Str;
    self.supportHoursWeek3Label.text=totalsObject.supportTotalWeek3Str;
    self.supervisionHoursWeek3Label.text=totalsObject.supervisionTotalWeek3Str;
    
    self.interventionHoursWeek4Label.text=totalsObject.interventionTotalWeek4Str;
    self.assessmentHoursWeek4Label.text=totalsObject.assessmentTotalWeek4Str;
    self.supportHoursWeek4Label.text=totalsObject.supportTotalWeek4Str;
    self.supervisionHoursWeek4Label.text=totalsObject.supervisionTotalWeek4Str;
    
    self.interventionHoursWeek5Label.text=totalsObject.interventionTotalWeek5Str;
    self.assessmentHoursWeek5Label.text=totalsObject.assessmentTotalWeek5Str;
    self.supportHoursWeek5Label.text=totalsObject.supportTotalWeek5Str;
    self.supervisionHoursWeek5Label.text=totalsObject.supervisionTotalWeek5Str;
  
    if (self.interventionHoursWeekUndefinedLabel) {
        self.interventionHoursWeekUndefinedLabel.text=totalsObject.interventionTotalWeekUndefinedStr;
        self.assessmentoursWeekUndefinedLabel.text=totalsObject.assessmentTotalWeekUndefinedStr;
        self.supportHoursWeekUndefinedLabel.text=totalsObject.supportTotalWeekUndefinedStr;
        self.supervisionHoursWeekUndefinedLabel.text=totalsObject.supervisionTotalWeekUndefinedStr;
        self.directHoursWeekUndefinedLabel.text=totalsObject.directTotalWeekUndefinedStr;
        self.overallHoursWeekUndefinedLabel.text=totalsObject.overallTotalWeekUndefinedStr;
    }
   
    self.directHoursWeek1Label.text=totalsObject.directTotalWeek1Str;
    self.directHoursWeek2Label.text=totalsObject.directTotalWeek2Str;
    self.directHoursWeek3Label.text=totalsObject.directTotalWeek3Str;
    self.directHoursWeek4Label.text=totalsObject.directTotalWeek4Str;
    self.directHoursWeek5Label.text=totalsObject.directTotalWeek5Str;
    
    
    self.overallHoursWeek1Label.text=totalsObject.overallTotalWeek1Str;
    self.overallHoursWeek2Label.text=totalsObject.overallTotalWeek2Str;
    self.overallHoursWeek3Label.text=totalsObject.overallTotalWeek3Str;
    self.overallHoursWeek4Label.text=totalsObject.overallTotalWeek4Str;
    self.overallHoursWeek5Label.text=totalsObject.overallTotalWeek5Str;
    
    self.interventionHoursMonthTotalLabel.text=totalsObject.interventionTotalForMonthStr;
    self.assessmentHoursMonthTotalLabel.text=totalsObject.assessmentTotalForMonthStr;
    self.supportHoursMonthTotalLabel.text=totalsObject.supportTotalForMonthStr;
    self.supervisionHoursMonthTotalLabel.text=totalsObject.supervisionTotalForMonthStr;
    self.directHoursMonthTotalLabel.text=totalsObject.directTotalForMonthStr;
    self.overallHoursMonthTotalLabel.text=totalsObject.overallTotalForMonthStr;
    
    
    self.interventionHoursCummulativeLabel.text=totalsObject.interventionTotalCummulativeStr;
    self.assessmentHoursCummulativeLabel.text=totalsObject.assessmentTotalCummulativeStr;
    self.supportHoursCummulativeLabel.text=totalsObject.supportTotalCummulativeStr;
    self.supervisionHoursCummulativeLabel.text=totalsObject.supervisionTotalCummulativeStr;
    self.directHoursCummulativeLabel.text=totalsObject.directTotalCummulativeStr;
    self.overallHoursCummulativeLabel.text=totalsObject.overallTotalCummulativeStr;
    
    self.interventionHoursTotalHoursLabel.text=totalsObject.interventionTotalToDateStr;
    self.assessmentHoursTotalHoursLabel.text=totalsObject.assessmentTotalToDateStr;
    self.supportHoursTotalHoursLabel.text=totalsObject.supportTotalToDateStr;
    self.supervisionHoursTotalHoursLabel.text=totalsObject.supervisionTotalToDateStr;
    self.directHoursTotalHoursLabel.text=totalsObject.directTotalToDateStr;
    self.overallHoursTotalHoursLabel.text=totalsObject.overallTotalToDateStr;
    

    

    
  




}
-(void)tableViewModel:(SCTableViewModel *)tableModel didAddSectionAtIndex:(NSUInteger)index{


    SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:index];
    SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *objectsSection=nil;
    if ([section isKindOfClass:[SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter class]]) {
        objectsSection=(SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter *)section;
    }
    
    UIView *containerView = [[UIView alloc] initWithFrame:sectionSubHeaderView.frame];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:sectionSubHeaderLabel.frame];
    headerLabel.font=sectionSubHeaderLabel.font;
    containerView.backgroundColor=sectionSubHeaderView.backgroundColor;
    headerLabel.backgroundColor = sectionSubHeaderLabel.backgroundColor;
    headerLabel.textColor = sectionSubHeaderLabel.textColor;
    headerLabel.tag=60;
    headerLabel.text=objectsSection.headerTitle;
    headerLabel.textAlignment=UITextAlignmentCenter;
    [containerView addSubview:headerLabel];
    
    objectsSection.headerView = containerView;
    
    
    UITextView *footerNotesTextView = [[UITextView alloc] initWithFrame:sectionSubFooterNotesTextView.frame];
    footerNotesTextView.font=sectionSubFooterNotesTextView.font;
    
    footerNotesTextView.backgroundColor = sectionSubFooterNotesTextView.backgroundColor;
    footerNotesTextView.textColor = sectionSubFooterNotesTextView.textColor;
    
    footerNotesTextView.textAlignment=UITextAlignmentLeft;
    footerNotesTextView.tag=61;
    
    
    NSLog(@"section bound object is %@",objectsSection.boundObject);
      
NSLog(@"objectSection bound object is %@",objectsSection.dataStore.data);
   
     
        
       
      
        
        
        if (objectsSection.footerNotes.length) {
            footerNotesTextView.text=objectsSection.footerNotes;
        }
        else {
            footerNotesTextView.hidden=YES;
        }
        
    
    
    
        
    
    
           
    
    
    
    [footerNotesTextView setContentInset:UIEdgeInsetsMake(-9, 0, 0,0)];
    
    
    UIView *footerContainerView = [[UIView alloc] initWithFrame:sectionSubFooterView.frame];
    
    [footerContainerView addSubview:footerNotesTextView];
    CGSize footerNotesContentSize=footerNotesTextView.contentSize;
    
    NSLog(@"content size height is %g",footerNotesContentSize.height);
    
    NSLog(@"footernotestextview size height is %g",footerNotesTextView.frame.size.height);
    //        footerNotesTextView.contentSize.width=footerNotesTextView.frame.size.width;
    if (footerNotesTextView.contentSize.height -9>footerContainerView.frame.size.height) {
        CGRect footerContainerViewFrame=footerContainerView.frame;
        footerContainerViewFrame.size.height=footerNotesTextView.contentSize.height-6;
        
        
        footerContainerView.frame=footerContainerViewFrame;
        
        
    }
    
    if (footerNotesTextView.contentSize.height>footerNotesTextView.frame.size.height) {
        
        CGRect footerNotesTextViewFrame=footerNotesTextView.frame;
        footerNotesTextViewFrame.size.height=footerNotesTextView.contentSize.height-9;
        footerNotesTextView.frame=footerNotesTextViewFrame;
        
        
        
    }
    
    UIView *subFooterLabelContainerView=[[UIView alloc]initWithFrame:self.sectionSubFooterLabelContainerView.frame];
    subFooterLabelContainerView.backgroundColor=self.sectionSubFooterLabelContainerView.backgroundColor;
    
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:sectionSubFooterLabel.frame];
    footerLabel.font=sectionSubFooterLabel.font;
    footerContainerView.backgroundColor=sectionSubFooterView.backgroundColor;
    footerLabel.backgroundColor = sectionSubFooterLabel.backgroundColor;
    footerLabel.textColor = sectionSubFooterLabel.textColor;
    footerLabel.tag=60;
    footerLabel.text=objectsSection.footerTotal;
    footerLabel.textAlignment=UITextAlignmentCenter;
    [subFooterLabelContainerView addSubview:footerLabel];
    
    
    [footerContainerView addSubview:subFooterLabelContainerView];
    
    
    objectsSection.footerView = footerContainerView;








}

-(NSArray *)fetchObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate{
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityStr inManagedObjectContext:appDelegate.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    
    if (filterPredicate) {
        [fetchRequest setPredicate:filterPredicate];
    }
    
    
    NSError *error = nil;
    NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
    
}


- (CGSize)interventionTableViewContentSize
{
    
    [self.interventionTypesTableView layoutIfNeeded];
    return [self.interventionTypesTableView contentSize];
} 

- (CGSize)assessmentTypesTableViewContentSize
{
    
    [self.assessmentTypesTableView layoutIfNeeded];
    return [self.assessmentTypesTableView contentSize];
} 

- (CGSize)supportTypesTableViewContentSize
{
    
    [self.supportActivitieTypesTableView layoutIfNeeded];
    return [self.supportActivitieTypesTableView contentSize];
} 
- (CGSize)supervisionTypesTableViewContentSize
{
    
    [self.supervisionReceivedTypesTableView layoutIfNeeded];
    return [self.supervisionReceivedTypesTableView contentSize];
} 
@end
