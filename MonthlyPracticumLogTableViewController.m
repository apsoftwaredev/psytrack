//
//  MonthlyPracticumLogTableViewControllerViewController.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MonthlyPracticumLogTableViewController.h"
#import "MonthlyPracticumLogTopCell.h"
#import "PTTAppDelegate.h"
@interface MonthlyPracticumLogTableViewController ()

@end

@implementation MonthlyPracticumLogTableViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil month:(NSInteger)monthInteger year:(NSInteger )yearInteger supervisor:(ClinicianEntity *)supervisor
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        month=monthInteger;
        year=yearInteger;
        supervisorObject=supervisor;
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(scrollToNextSupervisorCell)
     name:@"ScrollPracticumLogToNextSupervisorCell"
     object:nil];

    if (supervisorObject) {
   
   
NSLog(@"supervisor object is %@",supervisorObject);
     
    SCEntityDefinition *clinicianDef=[SCEntityDefinition definitionWithEntityName:@"ClinicianEntity" managedObjectContext:appDelegate.managedObjectContext propertyNames:[NSArray arrayWithObject:@"lastName"]];
                       
        NSPredicate *filterPredicate=nil;
        
        if (supervisorObject) {
           filterPredicate  =[NSPredicate predicateWithFormat:@"self.objectID == %@",supervisorObject.objectID];
        }
       
    // Create and add the objects section
	SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil entityDefinition:clinicianDef filterPredicate:filterPredicate];                                 
    
    objectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
//        NSString *bindingsString = @"20:lastName;"; // 1,2,3 are the control tags
        
        NSCalendar *calander=[NSCalendar currentCalendar];
        //define the calandar unit flags
//        NSUInteger unitFlags = NSDayCalendarUnit  | NSMonthCalendarUnit | NSYearCalendarUnit;
        
        
        
        NSDateComponents *dateComponents=[[NSDateComponents alloc]init];
        [dateComponents setCalendar:calander];
        [dateComponents setTimeZone:[NSTimeZone timeZoneWithAbbreviation:(NSString *)@"UTC"]];
        
        [dateComponents setYear:year];
        [dateComponents setMonth:month];
        [dateComponents setDay:1];
       
        
        NSDate *monthToDisplay=[calander dateFromComponents:dateComponents];
        
        
        
        
        

        
        NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"lastName",monthToDisplay, nil] forKeys:[NSArray arrayWithObjects:@"20",@"monthToDisplay", nil]];
        MonthlyPracticumLogTopCell *contactOverviewCell = [MonthlyPracticumLogTopCell cellWithText:nil objectBindings:bindingsDictionary nibName:@"MonthlyPracticumLogTopCell"];
        
        
        return contactOverviewCell;
    };
   
    
    objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView];
    
    [objectsModel addSection:objectsSection];
    self.tableViewModel=objectsModel;
    
   
    }
    else {
        [appDelegate displayNotification:@"Please select a supervisor"];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


-(void)tableViewModel:(SCTableViewModel *)tableModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{




}

-(void) scrollToNextSupervisorCell  {


   
             
            CGFloat offset=objectsModel.modeledTableView.contentOffset.y;
            CGFloat insetBottom=objectsModel.modeledTableView.contentInset.bottom;
            CGFloat tableViewHeight=objectsModel.modeledTableView.frame.size.height;
            if (offset+tableViewHeight<insetBottom) {
               
                [objectsModel.modeledTableView setContentOffset:CGPointMake(0, offset+tableViewHeight)];
                   
                [objectsModel setActiveCell:[objectsModel cellAfterCell:[objectsModel cellAtIndexPath:objectsModel.activeCellIndexPath] rewind:NO]];
            }
            else {
               
                [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ScrollPracticumLogToNextSupervisorCell" object:nil ];
                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                

                appDelegate.stopScrollingMonthlyPracticumLog=YES;
            }
            



}
  






@end
