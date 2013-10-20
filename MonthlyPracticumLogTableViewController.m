//
//  MonthlyPracticumLogTableViewControllerViewController.m
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 6/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MonthlyPracticumLogTableViewController.h"
#import "MonthlyPracticumLogTopCell.h"
#import "PTTAppDelegate.h"
#import "SupervisorsAndTotalTimesForMonth.h"

@interface MonthlyPracticumLogTableViewController ()

@end

@implementation MonthlyPracticumLogTableViewController
@synthesize studentName;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil monthToDisplay:(NSDate *)monthGiven trainingProgram:(TrainingProgramEntity *)trainingProgramGiven markAmended:(BOOL)markAmendedGiven
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization

        trainingProgram_ = trainingProgramGiven;
        monthToDisplay_ = monthGiven;
        markAmended = markAmendedGiven;
    }

    return self;
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    @try
    {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
            selector:@selector(scrollToNextSupervisorCell)
                name:@"ScrollPracticumLogToNextSupervisorCell"
              object:nil];
    }
    @catch (NSException *exception)
    {
        //do nothing
    }

    SCClassDefinition *supervisorsAndTotalTimesForMonthDef = [SCClassDefinition definitionWithClass:[SupervisorsAndTotalTimesForMonth class] autoGeneratePropertyDefinitions:YES];

    // Create and add the objects section
    SupervisorsAndTotalTimesForMonth *supervisorsAndTotalTimesForMonthObject = [[SupervisorsAndTotalTimesForMonth alloc]initWithMonth:monthToDisplay_ clinician:nil trainingProgram:trainingProgram_ markAmended:markAmended];

    self.studentName = supervisorsAndTotalTimesForMonthObject.studentNameStr;
    NSMutableArray *supervisorsAndTotalTimesForMonthMutableArray = [NSMutableArray arrayWithObject:supervisorsAndTotalTimesForMonthObject];

    SCMemoryStore *memoryStore = [SCMemoryStore storeWithObjectsArray:supervisorsAndTotalTimesForMonthMutableArray defaultDefiniton:supervisorsAndTotalTimesForMonthDef];

    SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil dataStore:memoryStore];

    objectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell *(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
//        NSString *bindingsString = @"20:lastName;"; // 1,2,3 are the control tags

        NSString *topCellNibName = nil;

        if (supervisorsAndTotalTimesForMonthObject.overallTotalWeekUndefinedTI > 0)
        {
            topCellNibName = @"MonthlyPracticumLogTopCellWithUndefined2";
        }
        else
        {
            topCellNibName = @"MonthlyPracticumLogTopCell";
        }

        NSDictionary *bindingsDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"lastName",monthToDisplay_, nil] forKeys:[NSArray arrayWithObjects:@"20",@"monthToDisplay", nil]];
        MonthlyPracticumLogTopCell *contactOverviewCell = [MonthlyPracticumLogTopCell cellWithText:nil objectBindings:bindingsDictionary nibName:topCellNibName];

        return contactOverviewCell;
    };

    [self.tableViewModel addSection:objectsSection];
}


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self.tableViewModel removeAllSections];

    supervisorObject = nil;
    trainingProgram_ = nil;
    monthToDisplay_ = nil;
    self.studentName = nil;
}


- (void) viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

    [self.tableViewModel removeAllSections];

    supervisorObject = nil;
    trainingProgram_ = nil;
    monthToDisplay_ = nil;
    self.studentName = nil;
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void) tableViewModel:(SCTableViewModel *)tableModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void) scrollToNextSupervisorCell
{
    CGFloat offset = self.tableViewModel.modeledTableView.contentOffset.y;
    CGFloat insetBottom = self.tableViewModel.modeledTableView.contentInset.bottom;
    CGFloat tableViewHeight = self.tableViewModel.modeledTableView.frame.size.height;
    if (offset + tableViewHeight < insetBottom)
    {
        [self.tableViewModel.modeledTableView setContentOffset:CGPointMake(0, offset + tableViewHeight)];

        [self.tableViewModel setActiveCell:[self.tableViewModel cellAfterCell:[self.tableViewModel cellAtIndexPath:self.tableViewModel.activeCellIndexPath] rewind:NO]];
    }
    else
    {
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ScrollPracticumLogToNextSupervisorCell" object:nil ];
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        appDelegate.stopScrollingMonthlyPracticumLog = YES;
    }
}


@end
