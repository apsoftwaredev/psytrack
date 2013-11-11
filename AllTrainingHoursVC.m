//
//  AllTrainingHoursVC.m
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 9/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "AllTrainingHoursVC.h"
#import "AllHoursReportTopCell.h"
#import "PTTAppDelegate.h"
#import "SupervisorsAndTotalTimesForMonth.h"
@interface AllTrainingHoursVC ()

@end

@implementation AllTrainingHoursVC

@synthesize studentName;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil doctorateLevel:(BOOL)doctorateLevelSelected
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization

        doctorateLevel = doctorateLevelSelected;
    }

    return self;
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    SCClassDefinition *supervisorsAndTotalTimesForMonthDef = [SCClassDefinition definitionWithClass:[SupervisorsAndTotalTimesForMonth class] autoGeneratePropertyDefinitions:YES];

    // Create and add the objects section
    SupervisorsAndTotalTimesForMonth *supervisorsAndTotalTimesForMonthObject = [[SupervisorsAndTotalTimesForMonth alloc]initWithDoctorateLevel:doctorateLevel clinician:nil];

    self.studentName = supervisorsAndTotalTimesForMonthObject.studentNameStr;
    NSMutableArray *supervisorsAndTotalTimesForMonthMutableArray = [NSMutableArray arrayWithObject:supervisorsAndTotalTimesForMonthObject];

    SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil items:supervisorsAndTotalTimesForMonthMutableArray itemsDefinition:supervisorsAndTotalTimesForMonthDef];

    objectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell *(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        //        NSString *bindingsString = @"20:lastName;"; // 1,2,3 are the control tags

        NSString *topCellNibName = nil;

        topCellNibName = @"AllHoursReportTopCell";

        AllHoursReportTopCell *contactOverviewCell = [AllHoursReportTopCell cellWithText:nil objectBindings:nil nibName:topCellNibName];

        return contactOverviewCell;
    };

    [self.tableViewModel addSection:objectsSection];
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void) tableViewModel:(SCTableViewModel *)tableModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self.tableViewModel removeAllSections];

    self.studentName = nil;
}


- (void) viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

    [self.tableViewModel removeAllSections];

    self.studentName = nil;
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
        @try
        {
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ScrollAllHoursVCToNextPage" object:nil ];
        }
        @catch (NSException *exception)
        {
            //do nothing
        }

        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        appDelegate.stopScrollingMonthlyPracticumLog = YES;
    }
}


@end
