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
@synthesize interventionHoursCumulativeLabel;
@synthesize interventionHoursTotalHoursLabel;

@synthesize assessmentHoursWeek1Label;
@synthesize assessmentHoursWeek2Label;
@synthesize assessmentHoursWeek3Label;
@synthesize assessmentHoursWeek4Label;
@synthesize assessmentHoursWeek5Label;
@synthesize assessmentHoursMonthTotalLabel;
@synthesize assessmentHoursCumulativeLabel;
@synthesize assessmentHoursTotalHoursLabel;

@synthesize supportHoursWeek1Label;
@synthesize supportHoursWeek2Label;
@synthesize supportHoursWeek3Label;
@synthesize supportHoursWeek4Label;
@synthesize supportHoursWeek5Label;
@synthesize supportHoursMonthTotalLabel;
@synthesize supportHoursCumulativeLabel;
@synthesize supportHoursTotalHoursLabel;

@synthesize supervisionHoursWeek1Label;
@synthesize supervisionHoursWeek2Label;
@synthesize supervisionHoursWeek3Label;
@synthesize supervisionHoursWeek4Label;
@synthesize supervisionHoursWeek5Label;
@synthesize supervisionHoursMonthTotalLabel;
@synthesize supervisionHoursCumulativeLabel;
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
    
  
    
    if ((signaturesView.frame.origin.y+signaturesView.frame.size.height)< (mainScrollView.frame.size.height+currentOffsetY)) {
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ScrollMonthlyPracticumLogToNextPage" object:nil];
        
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        appDelegate.stopScrollingMonthlyPracticumLog=YES;
        currentOffsetY=0;   
        
    } else {
        
        CGRect mainScrollViewFrame=self.mainPageScrollView.frame;
        if (mainScrollViewFrame.size.height <MAX_MAIN_SCROLLVIEW_HEIGHT) {
            mainScrollViewFrame.size.height=MAX_MAIN_SCROLLVIEW_HEIGHT;
            currentOffsetY=self.indirectHoursHeader.frame.origin.y-5;
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
    self.monthToDisplay=[self.objectBindings valueForKey:@"monthToDisplay"];
    
    
    NSLog(@"self month to display is %@",self.monthToDisplay);
    NSLog(@"toplogcell bound object is %@",self.boundObject);
    self.clinician=(ClinicianEntity *)self.boundObject;
    
    
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
//
//    SCEntityDefinition *interventionTypeDef=[SCEntityDefinition definitionWithEntityName:@"InterventionTypeEntity" managedObjectContext:appDelegate.managedObjectContext propertyNames:[NSArray arrayWithObjects:@"interventionType", nil]];
//    
//    
//    // Create and add the objects section
//	SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil entityDefinition:interventionTypeDef];                                 
//    
//    objectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
//    {
//        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
//        NSString *bindingsString = @"20:subType"; // 1,2,3 are the control tags
//        MonthlyPracticumLogMiddleSubCell *contactOverviewCell = [MonthlyPracticumLogMiddleSubCell cellWithText:nil objectBindingsString:bindingsString nibName:@"MonthlyPracticumLogMiddleSubCell"];
//        
//        
//        return contactOverviewCell;
//    };
//    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
NSEntityDescription *entity = [NSEntityDescription entityForName:@"InterventionTypeEntity" inManagedObjectContext:appDelegate.managedObjectContext];
[fetchRequest setEntity:entity];
    [fetchRequest setRelationshipKeyPathsForPrefetching:
     [NSArray arrayWithObject:@"subTypes"]];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
NSError *error = nil;
NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
if (fetchedObjects == nil) {
   
}
    self.objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.interventionTypesTableView];
    
    SCClassDefinition *subTypesDef=[SCClassDefinition definitionWithClass:[InterventionTypeSubtypeEntity class] autoGeneratePropertyDefinitions:YES];
    
    for (InterventionTypeEntity *interventionType in fetchedObjects) {
        [interventionType willAccessValueForKey:@"subTypes"];
        NSMutableArray *subTypesSet=(NSMutableArray *)[interventionType mutableSetValueForKey:@"subTypes"];
       
        
        NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                                         ascending:YES] ;
        
        
        NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
        NSMutableArray *orderdSubTypesSet=[NSMutableArray arrayWithArray:(NSArray *)[subTypesSet sortedArrayUsingDescriptors:sortDescriptors]];
        
       
        
        SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:interventionType.interventionType items:orderdSubTypesSet itemsDefinition:subTypesDef];
        SCDataFetchOptions *fetchOptions=[SCDataFetchOptions optionsWithSortKey:@"order" sortAscending:YES filterPredicate:nil];
        
        
        objectsSection.dataFetchOptions=fetchOptions;
        
        
        objectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
        {
            // Create & return a custom cell based on the cell in ContactOverviewCell.xib
            NSString *bindingsString = @"20:interventionSubType"; // 1,2,3 are the control tags
            MonthlyPracticumLogBottonCell *contactOverviewCell = [MonthlyPracticumLogBottonCell cellWithText:nil objectBindingsString:bindingsString nibName:@"MonthlyPracticumLogBottomCell"];
            
            
            return contactOverviewCell;
        };
        
       
        
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
        
        
        NSString *monthlyNotes=[interventionType monthlyLogNotesForMonth:self.monthToDisplay clinician:self.clinician];
        if (monthlyNotes.length) {
            footerNotesTextView.text=monthlyNotes;
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
        
        footerLabel.textAlignment=UITextAlignmentCenter;
        [subFooterLabelContainerView addSubview:footerLabel];
        
                
        [footerContainerView addSubview:subFooterLabelContainerView];
        
        
        objectsSection.footerView = footerContainerView;
        
        
        
        
                [objectsModel_ addSection:objectsSection];
        [interventionType didAccessValueForKey:@"subTypes"];
        
    }
    
  
    
//    self.interventionTypesTableView.transform      = CGAffineTransformIdentity;
//   
//
//    
//    
//    CGRect frame=CGRectMake(self.interventionTypesTableView.frame.origin.x, self.interventionTypesTableView.frame.origin.y, self.interventionTypesTableView.frame.size.width, self.interventionTypesTableView.contentSize.height);
//    self.interventionTypesTableView.frame=frame;
    
    
    self.interventionTypesTableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
   NSLog(@"background size height is %g",self.interventionTypesTableView.backgroundView.frame.size.height);
    objectsModel_.delegate=self;
    
    
     







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
