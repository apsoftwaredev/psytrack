//
//  DemographicReportViewController.m
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicReportViewController.h"
#import "MyInformationAndTotalClients.h"
#import "DemographicReportTopCell.h"
@interface DemographicReportViewController ()

@end

@implementation DemographicReportViewController
@synthesize clinicianName = clinicianName_;

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    SCClassDefinition *myInformationandTotalClientshDef = [SCClassDefinition definitionWithClass:[MyInformationAndTotalClients class] autoGeneratePropertyDefinitions:YES];

    // Create and add the objects section
    MyInformationAndTotalClients *myInformationAndTotalClients = [[MyInformationAndTotalClients alloc]init];

    self.clinicianName = myInformationAndTotalClients.myName;

    NSMutableArray *myInformationMutableArray = [NSMutableArray arrayWithObject:myInformationAndTotalClients];

    SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil items:myInformationMutableArray itemsDefinition:myInformationandTotalClientshDef];

    objectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell *(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        //        NSString *bindingsString = @"20:lastName;"; // 1,2,3 are the control tags

        NSString *topCellNibName = nil;

        topCellNibName = @"DemographicReportTopCell";

        DemographicReportTopCell *demographicReportTopCell = [DemographicReportTopCell cellWithText:nil objectBindings:nil nibName:topCellNibName];

        return demographicReportTopCell;
    };

    [self.tableViewModel addSection:objectsSection];
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


@end
