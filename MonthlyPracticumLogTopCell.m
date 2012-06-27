//
//  MonthlyPracticumLogTopCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/24/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MonthlyPracticumLogTopCell.h"
#import "ClinicianEntity.h"
#import "PTTAppDelegate.h"
#import "MonthlyPracticumLogMiddleSubCell.h"
#import "InterventionTypeSubtypeEntity.h"
#import "MonthlyPracticumLogBottonCell.h"
#import "InterventionTypeEntity.h"
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
@synthesize sectionSubFooterView,sectionSubFooterLabel,sectionSubFooterLabelContainerView;
@synthesize objectsModel=objectsModel_;

-(void)willDisplay{

    self.accessoryType=UITableViewCellAccessoryNone;
    ClinicianEntity *clinician=(ClinicianEntity *)self.boundObject;

    supervisorLabel.text=clinician.combinedName;
    
//    NSLog(@" size needed height is %g",[self interventionTableViewContentSize ].height );
    
    CGSize heightNeeded=[self interventionTableViewContentSize];
    NSLog(@" size needed height is %g",[self interventionTableViewContentSize ].height );
    
    NSLog(@"height needed is %g",heightNeeded.height);
    if (  heightNeeded.height>self.interventionTypesTableView.frame.size.height) {
        self.interventionTypesTableView.transform=CGAffineTransformIdentity;
        CGRect monthlyPracticumLogTopCellFrame =(CGRect ) self.interventionTypesTableView.frame;
        monthlyPracticumLogTopCellFrame.size.height=heightNeeded.height;
        self.interventionTypesTableView.frame=monthlyPracticumLogTopCellFrame;
    }

    
}


-(void)loadBindingsIntoCustomControls{

    [super loadBindingsIntoCustomControls];
    
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
        
        NSLog(@"subtype array is %@",subTypesSet);
        
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
        

        UIView *footerContainerView = [[UIView alloc] initWithFrame:sectionSubFooterView.frame];
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

@end
