//
//  MonthlyPracticumLogTableViewControllerViewController.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MonthlyPracticumLogTableViewController.h"
#import "PTTAppDelegate.h"
@interface MonthlyPracticumLogTableViewController ()

@end

@implementation MonthlyPracticumLogTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil month:(NSInteger)monthInteger year:(NSInteger )yearInteger
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    SCEntityDefinition *clinicianDef=[SCEntityDefinition definitionWithEntityName:@"ClinicianEntity" managedObjectContext:appDelegate.managedObjectContext propertyNames:[NSArray arrayWithObjects:@"clinician", nil]];
                                      
    // Create and add the objects section
	SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil entityDefinition:clinicianDef];                                 
    
    objectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        NSString *bindingsString = @"15:clinician"; // 1,2,3 are the control tags
        SCCustomCell *contactOverviewCell = [SCCustomCell cellWithText:nil objectBindingsString:bindingsString nibName:@"MonthlyPracticumLogView"];
        
        
        return contactOverviewCell;
    };
   
    
    
    
    
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

@end
