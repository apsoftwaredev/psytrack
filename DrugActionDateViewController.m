/*
 *  DrugActionDateViewController.m
 *  psyTrack Clinician Tools
 *  Version: 1.05
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on   1/5/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import "DrugActionDateViewController.h"
#import "PTTAppDelegate.h"
#import "DrugDocOverviewCell.h"

@implementation DrugActionDateViewController
@synthesize applNoString;
@synthesize  docTypesArray = _docTypesArray;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withApplNo:(NSString *)applNo
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        applNoString = applNo;

        // Custom initialization
    }

    return self;
}


- (void) viewDidLoad
{
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor clearColor];

    NSManagedObjectContext *drugsManagedObjectContext = (NSManagedObjectContext *)[(PTTAppDelegate *)[UIApplication sharedApplication].delegate drugsManagedObjectContext];

    NSPredicate *applNoPredicate = [NSPredicate predicateWithFormat:@"applNo matches %@",applNoString];

    NSFetchRequest *actionDateFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DrugRegActionDateEntity"
                                              inManagedObjectContext:drugsManagedObjectContext];
    [actionDateFetchRequest setEntity:entity];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"actionDate"
                                                                   ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [actionDateFetchRequest setSortDescriptors:sortDescriptors];

    [actionDateFetchRequest setPredicate:applNoPredicate];
    //    [fetchRequest setFetchBatchSize:10];

    NSError *error = nil;
    NSArray *fetchedObjectsArray = [drugsManagedObjectContext executeFetchRequest:actionDateFetchRequest error:&error];

    NSMutableSet *_actionDateSet = (NSMutableSet *)[NSMutableSet setWithArray:fetchedObjectsArray];
    if (_actionDateSet == nil)
    {
        // Handle the error
    }

    NSFetchRequest *docTypesFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *docTypeEntity = [NSEntityDescription entityForName:@"DrugDocTypeLookupEntity"
                                                     inManagedObjectContext:drugsManagedObjectContext];
    [docTypesFetchRequest setEntity:docTypeEntity];

    NSError *docTypesError = nil;
    _docTypesArray = [drugsManagedObjectContext executeFetchRequest:docTypesFetchRequest error:&docTypesError];
    if (_docTypesArray == nil)
    {
        // Handle the error
    }

//

    SCEntityDefinition *actionDateDef = [SCEntityDefinition definitionWithEntityName:@"DrugRegActionDateEntity" managedObjectContext:drugsManagedObjectContext propertyNames:[NSArray arrayWithObjects:@"actionDate", @"docType", nil]];

    actionDateDef.keyPropertyName = @"actionDate";
    actionDateDef.titlePropertyName = @"actionDate";

    for (NSManagedObject *managedObject in fetchedObjectsArray)
    {
        [managedObject willAccessValueForKey:@"actionDate"];
    }

    SCMemoryStore *memoryStore = [SCMemoryStore storeWithObjectsArray:[NSMutableArray arrayWithArray:fetchedObjectsArray] defaultDefiniton:actionDateDef];

    objectsModel = [[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView dataStore:memoryStore];

    objectsModel.allowEditDetailView = NO;
    objectsModel.allowDeletingItems = FALSE;
    objectsModel.allowEditDetailView = FALSE;
    objectsModel.allowMovingItems = FALSE;
    objectsModel.allowAddingItems = FALSE;
    objectsModel.allowRowSelection = NO;

    objectsModel.sectionActions.cellForRowAtIndexPath = ^SCCustomCell *(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        NSDictionary *actionOverviewBindings = [NSDictionary
                                                dictionaryWithObjects:[NSArray arrayWithObjects:@"actionDate", @"docTypeDesc",@"actionDate",@"DrugAppDocsViewController",   nil]
                                                              forKeys:[NSArray arrayWithObjects:@"1",  @"top",@"bottom",@"openNib",nil]]; // 1,2,3 are the control tags
        SCCustomCell *actionOverviewCell = [SCCustomCell cellWithText:nil boundObject:nil objectBindings:actionOverviewBindings nibName:@"DrugDocOverviewCell_iPhone"];

        actionOverviewCell.cellActions.didSelect = ^(SCTableViewCell *aCell, NSIndexPath *indexPath)
        {
            [(SCArrayOfObjectsSection *)actionOverviewCell.ownerSection dispatchEventSelectRowAtIndexPath : indexPath];
            // code goes here
        };

        actionOverviewCell.cellActions.didLayoutSubviews = ^(SCTableViewCell *aCell, NSIndexPath *path)
        {
            // code goes here
        };

        return actionOverviewCell;
    };

    if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
    {
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];

        [self.tableView setBackgroundColor:appDelegate.window.backgroundColor]; // Make the table view transparent
    }

    objectsModel.allowRowSelection = YES;

    self.tableViewModel = objectsModel;

    sortDescriptor = nil;
    sortDescriptors = nil;
    actionDateFetchRequest = nil;
    docTypesFetchRequest = nil;
    [objectsModel reloadBoundValues];
    [objectsModel.modeledTableView reloadData];
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations

    return YES;
}


#pragma mark -
#pragma mark SCTableViewModelDataSource methods

- (void) tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];

    if (section.headerTitle != nil)
    {
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];

        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.text = section.headerTitle;
        [containerView addSubview:headerLabel];

        section.headerView = containerView;
    }
}


@end
