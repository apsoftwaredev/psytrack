/*
 *  ClinicianViewController.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.5
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 6/19/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ClinicianViewController.h"
#import "PTTAppDelegate.h"
#import "ButtonCell.h"
#import "CliniciansViewController_Shared.h"

#import "SCArrayOfObjectsModel_UseSelectionSection.h"
#import "ValidateMOC.h"

@implementation ClinicianViewController

@synthesize searchBar;

@synthesize totalCliniciansLabel;

#pragma mark -
#pragma mark View lifecycle

- (id) initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(ClinicianSelectionCell *)objectSelectionCell sendingViewController:(UIViewController *)viewController withPredicate:(NSPredicate *)startPredicate usePrescriber:(BOOL)usePresciberBool allowMultipleSelection:(BOOL)allowMultiSelect
{
    self = [super initWithNibName:nibName bundle:bundle];

    filterByPrescriber = usePresciberBool;
    filterPredicate = startPredicate;
    isInDetailSubview = detailSubview;
    clinicianObjectSelectionCell = objectSelectionCell;
    currentlySelectedClinician = clinicianObjectSelectionCell.clinicianObject;
    currentlySelectedCliniciansArray = clinicianObjectSelectionCell.cliniciansArray;
    sendingViewController = viewController;
    allowMultipleSelection = allowMultiSelect;

    return self;
}


- (void) viewDidUnload
{
    [super viewDidUnload];

    totalCliniciansLabel = nil;

    filterByPrescriber = NO;
    isInDetailSubview = NO;
    clinicianObjectSelectionCell = nil;
    sendingViewController = nil;
    currentlySelectedClinician = nil;
    currentlySelectedCliniciansArray = nil;
    filterPredicate = nil;

    self.totalCliniciansLabel = nil;
}


- (IBAction) reloadTableViewData:(id)sender
{
    [objectsModel reloadBoundValues ];
    [self.tableView reloadData];
}


- (void) viewDidLoad
{
    [super viewDidLoad];

    UIViewController *navtitle = self.navigationController.topViewController;

    navtitle.title = @"Clinicians";

        if (isInDetailSubview)
    {
        objectsModel = [[SCArrayOfObjectsModel_UseSelectionSection alloc] initWithTableView:self.tableView entityDefinition:self.clinicianDef];
        objectsModel.tag = 0;
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;
       
        
        if ([SCUtilities systemVersion]>=7) {
            
             CGRect tableViewFrame=objectsModel.modeledTableView.frame;
            
           float tableviewY=objectsModel.modeledTableView.frame.origin.y+30;
            tableViewFrame.origin.y=tableviewY;
            objectsModel.modeledTableView.transform = CGAffineTransformIdentity;
            objectsModel.modeledTableView.frame = tableViewFrame;
            
            CGRect searchBarFrame=self.searchBar.frame;
            
            float searchBarY=self.searchBar.frame.origin.y+60;
            searchBarFrame.origin.y=searchBarY;
            self.searchBar.transform = CGAffineTransformIdentity;
            self.searchBar.frame = searchBarFrame;
        }
        
        [self.view setBackgroundColor:appDelegate.window.backgroundColor];
        // Set the view controller's theme

        if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
        {
            [objectsModel.modeledTableView setBackgroundView:nil];
            UIView *view = [[UIView alloc]init];
            [objectsModel.modeledTableView setBackgroundView:view];
        }

        [objectsModel.modeledTableView setBackgroundColor:appDelegate.window.backgroundColor];

        if (filterPredicate)
        {
            [self.searchBar setSelectedScopeButtonIndex:1];
        }

        objectsModel.autoAssignDelegateForDetailModels = YES;
        objectsModel.allowDeletingItems = FALSE;
        objectsModel.autoSelectNewItemCell = TRUE;
        objectsModel.allowRowSelection = YES;

        NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:2];

        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTappedInDetailSubView)];
        [buttons addObject:doneButton];

        // create a spacer
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
        [buttons addObject:editButton];

        [self editButtonItem];

        // create a standard "add" button
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:NULL];
        addButton.style = UIBarButtonItemStyleBordered;
        [buttons addObject:addButton];

        // stick the buttons in the toolbar
        self.navigationItem.rightBarButtonItems = buttons;
        objectsModel.editButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:1];
        objectsModel.addButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:2];

        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTappedInDetalView)];

        self.navigationItem.leftBarButtonItem = cancelButton;

        if (filterByPrescriber)
        {
            self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"All Clinicians",@"Prescribers",@"At Current Site",nil];
        }
    }
    else
    {
        objectsModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView entityDefinition:self.clinicianDef ];
        if ([SCUtilities is_iPad])
        {
            self.navigationBarType = SCNavigationBarTypeEditLeft;
        }
        else
        {
            self.navigationBarType = SCNavigationBarTypeAddRightEditLeft;
        }

        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        objectsModel.editButtonItem = self.navigationItem.leftBarButtonItem;

        objectsModel.addButtonItem = self.navigationItem.rightBarButtonItem;
        objectsModel.autoAssignDelegateForDetailModels = TRUE;
        objectsModel.autoAssignDataSourceForDetailModels = TRUE;
        if (![SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
        {
            self.tableView.backgroundColor = [UIColor clearColor];
            objectsModel.addButtonItem = self.navigationItem.rightBarButtonItem;
        }

        objectsModel.sectionIndexTitles = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];

        objectsModel.autoSortSections = TRUE;
        self.clinicianDef.titlePropertyName = @"firstName;lastName";
    }

    objectsModel.searchPropertyName = @"firstName;lastName";

    objectsModel.allowMovingItems = TRUE;

    objectsModel.searchBar = self.searchBar;
    objectsModel.addButtonItem = self.addButton;

    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    objectsModel.modelActions.didFetchItemsFromStore = ^(SCArrayOfItemsModel *itemsModel, NSMutableArray *items)
    {
        
        if (items.count == 0)
        {
            self.totalCliniciansLabel.text = @"Tap + To Add Clinicians";
        }
        else
        {
            self.totalCliniciansLabel.text = [NSString stringWithFormat:@"Total Clinicians: %i", items.count];
        }

       
    };

   

    if (![SCUtilities is_iPad])
    {
        objectsModel.modelActions.didRefresh = ^(SCTableViewModel *tableModel)
        {
            [self updateClinicianTotalLabel];
        };
    }

    //change back button image
   
    if ([SCUtilities systemVersion] < 7)
    {
        UIImage *menueBarImage = [UIImage imageNamed:@"iPad-menubar-full.png"];

        if (![SCUtilities is_iPad])
        {
            objectsModel.theme = [SCTheme themeWithPath:@"mapper-iPhone.ptt"];
            self.tableViewModel = objectsModel;

            [self.searchBar setBackgroundImage:menueBarImage];
            [self.searchBar setScopeBarBackgroundImage:menueBarImage];
        }
        else if (isInDetailSubview)
        {
            objectsModel.theme = [SCTheme themeWithPath:@"mapper-ipad-full.ptt"];
            self.tableViewModel = objectsModel;

            [self.searchBar setBackgroundImage:menueBarImage];
            [self.searchBar setScopeBarBackgroundImage:menueBarImage];
        }
    }
    else{
    
        if ([SCUtilities systemVersion]>=7) {
            
            
//            [self.searchBar setBackgroundImage:nil];
            
//            [self.searchBar setBarTintColor:[UIColor clearColor]];
            
            DLog(@"color %@",[self.searchBar backgroundColor]);
            
            [self.searchBar setBackgroundColor:[UIColor colorWithRed:0.217586 green:0.523853 blue:0.67796 alpha:1.0]];
            
        }

    
    
    }
    [(PTTAppDelegate *)[UIApplication sharedApplication].delegate application :[UIApplication sharedApplication]
     willChangeStatusBarOrientation :[[UIApplication sharedApplication] statusBarOrientation]
     duration : 5];
    if (isInDetailSubview)
    {
        [objectsModel reloadBoundValues];
        [objectsModel.modeledTableView reloadData];
        [self setSelectedClinicians];
    }

    if (self.selectMyInformationOnLoad && [SCUtilities is_iPad])
    {
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        if ( UIInterfaceOrientationIsPortrait(self.interfaceOrientation) )
        {
            [appDelegate displayNotification:@"Tap the Clinicians Button in the Upper Left to display clinicians list, then tap your name."];
        }
        else if ( UIInterfaceOrientationIsLandscape(self.interfaceOrientation) )
        {
            [appDelegate displayNotification:@"Select your name from the clinicians list to view/track your information"];
        }
    }
}


#pragma mark -
#pragma mark SCTableViewModelDataSource methods

- (NSString *) tableViewModel:(SCArrayOfItemsModel *)tableViewModel sectionHeaderTitleForItem:(NSObject *)item AtIndex:(NSUInteger)index
{
    if (!isInDetailSubview)
    {
        // Cast not technically neccessary, done just for clarity
        NSManagedObject *managedObject = (NSManagedObject *)item;

        NSString *objectName = (NSString *)[managedObject valueForKey:@"lastName"];

        // Return first charcter of objectName
        return [[objectName substringToIndex:1] uppercaseString];
    }
    else
    {
        return nil;
    }
}


- (void) viewDidAppear:(BOOL)animated
{
    if ( self.selectMyInformationOnLoad)
    {
        [self selectMyInformation];

        self.selectMyInformationOnLoad = NO;
    }
}


- (void) selectMyInformation
{
    NSInteger sectionCount = objectsModel.sectionCount;

    for (int i = 0; i < sectionCount; i++)
    {
        SCTableViewSection *section = (SCTableViewSection *)[objectsModel sectionAtIndex:i];
        BOOL foundMyInformation = NO;
        if ([section isKindOfClass:[SCArrayOfObjectsSection class]])
        {
            SCArrayOfObjectsSection *arrayOfObjectsSection = (SCArrayOfObjectsSection *)section;

            for (int p = 0; p < arrayOfObjectsSection.cellCount; p++)
            {
                SCTableViewCell *cell = (SCTableViewCell *)[section cellAtIndex:p];

                NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;

                if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"ClinicianEntity"])
                {
                    BOOL myInformation = [(NSNumber *)[cellManagedObject valueForKey:@"myInformation"] boolValue];

                    if (myInformation)
                    {
                        [objectsModel setActiveCell:cell];
                        if (![SCUtilities is_iPad])
                        {
                            [arrayOfObjectsSection dispatchEventSelectRowAtIndexPath:[objectsModel indexPathForCell:cell]];
                        }

                        foundMyInformation = YES;
                        break;
                    }
                }
            }
        }

        if (foundMyInformation)
        {
            break;
        }
    }
}


- (void) cancelButtonTappedInDetalView
{
    if (self.navigationController)
    {
        // check if self is the rootViewController
        if ([self.navigationController.viewControllers objectAtIndex:0] == self)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}


- (void) doneButtonTappedInDetailSubView
{
    if (isInDetailSubview && objectsModel.sectionCount)
    {
        SCTableViewSection *section = (SCTableViewSection *)[objectsModel sectionAtIndex:0];

        if ([section isKindOfClass:[SCObjectSelectionSection class]])
        {
            SCObjectSelectionSection *objectsSelectionSection = (SCObjectSelectionSection *)section;

            [objectsSelectionSection commitCellChanges];
            if (allowMultipleSelection)
            {
                NSInteger sectionCount = objectsModel.sectionCount;

                if (sectionCount && !currentlySelectedCliniciansArray)
                {
                    currentlySelectedCliniciansArray = [NSMutableArray array];
                }
                else
                {
                    [currentlySelectedCliniciansArray removeAllObjects];
                    currentlySelectedCliniciansArray = [NSMutableArray array];
                }

                for (NSInteger i = 0; i < sectionCount; i++ )
                {
                    SCObjectSelectionSection *sectionAtIndex = (SCObjectSelectionSection *)[objectsModel sectionAtIndex:i];

                    NSEnumerator *enumerator = [sectionAtIndex.selectedItemsIndexes objectEnumerator];
                    id setObject;
                    while ( (setObject = [enumerator nextObject]) != nil )
                    {
                        if (![setObject isEqualToNumber:[NSNumber numberWithInteger:-1]] && [setObject integerValue] < sectionAtIndex.cellCount)
                        {
                            SCTableViewCell *selectedCell = (SCTableViewCell *)[sectionAtIndex cellAtIndex:(NSUInteger)[(NSNumber *)setObject integerValue]];

                            NSManagedObject *selectedCellManagedObject = (NSManagedObject *)selectedCell.boundObject;
                            if (selectedCellManagedObject && [selectedCellManagedObject respondsToSelector:@selector(entity)] && [selectedCellManagedObject.entity.name isEqualToString:@"ClinicianEntity"])
                            {
                                ClinicianEntity *clinicianObject = (ClinicianEntity *)selectedCellManagedObject;
                                [currentlySelectedCliniciansArray addObject:clinicianObject];
                            }
                        }
                    }
                }

                [clinicianObjectSelectionCell doneButtonTappedInDetailView:nil selectedItems:currentlySelectedCliniciansArray withValue:TRUE];
            }
            else
            {
                if (objectsSelectionSection.selectedItemIndex && ![objectsSelectionSection.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]] && [objectsSelectionSection.selectedItemIndex intValue] < objectsSelectionSection.items.count)
                {
                    currentlySelectedClinician = (ClinicianEntity *)[objectsSelectionSection.items objectAtIndex:[objectsSelectionSection.selectedItemIndex intValue]];
                }
                else
                {
                    currentlySelectedClinician = nil;
                }

                [clinicianObjectSelectionCell doneButtonTappedInDetailView:currentlySelectedClinician selectedItems:nil withValue:TRUE];

                currentlySelectedClinician = nil;
            }

            [self cancelButtonTappedInDetalView];
        }
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableViewModel:tableViewModel willConfigureCell:cell forRowAtIndexPath:indexPath];

    if (tableViewModel.tag == 0)
    {
        SCTableViewSection *section = (SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
        if ([section isKindOfClass:[SCObjectSelectionSection class]])
        {
            SCObjectSelectionSection *objectSelectionSection = (SCObjectSelectionSection *)section;

            if (currentlySelectedClinician && [cell.boundObject isEqual:currentlySelectedClinician])
            {
                [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:currentlySelectedClinician]]];
            }
        }
    }
}


#pragma mark -
#pragma SCTableViewModelDelegate methods

- (void) tableViewModelSearchBarCancelButtonClicked:(SCArrayOfItemsModel *)tableViewModel
{
    [self updateClinicianTotalLabel];
}


- (void) setSelectedClinicians
{
    if (objectsModel.sectionCount && isInDetailSubview && currentlySelectedCliniciansArray && currentlySelectedCliniciansArray.count && allowMultipleSelection)
    {
        SCTableViewSection *section = (SCTableViewSection *)[objectsModel sectionAtIndex:0];

        if ([section isKindOfClass:[SCObjectSelectionSection class]])
        {
            for (int i = 0; i < objectsModel.sectionCount; i++)
            {
                SCObjectSelectionSection *objectSelectionSection = (SCObjectSelectionSection *)[objectsModel sectionAtIndex:i];

                NSMutableSet *selectedIndexesSet = objectSelectionSection.selectedItemsIndexes;
                NSMutableArray *takeOutClinicians = [NSMutableArray array];
                for (int p = 0; p < currentlySelectedCliniciansArray.count; p++)
                {
                    int clinicianInSectionIndex;
                    ClinicianEntity *clinicianInArray = [currentlySelectedCliniciansArray objectAtIndex:p];
                    if ([objectSelectionSection.items containsObject:clinicianInArray])
                    {
                        clinicianInSectionIndex = (int)[objectSelectionSection.items indexOfObject:clinicianInArray];

                        [selectedIndexesSet addObject:[NSNumber numberWithInt:clinicianInSectionIndex]];
                    }
                    else
                    {
                        [takeOutClinicians addObject:clinicianInArray];
                    }
                }

                [currentlySelectedCliniciansArray removeObjectsInArray:takeOutClinicians];
            }
        }
    }
}


- (void) createSelectedCliniciansArray
{
    if (isInDetailSubview)
    {
        SCTableViewSection *section = (SCTableViewSection *)[objectsModel sectionAtIndex:0];

        if ([section isKindOfClass:[SCObjectSelectionSection class]])
        {
            if (allowMultipleSelection)
            {
                if (currentlySelectedCliniciansArray && currentlySelectedCliniciansArray.count)
                {
                    [currentlySelectedCliniciansArray removeAllObjects];
                }
                else if (!currentlySelectedCliniciansArray)
                {
                    currentlySelectedCliniciansArray = [NSMutableArray array];
                }

                NSInteger sectionCount = objectsModel.sectionCount;

                for (NSInteger p = 0; p < sectionCount; p++ )
                {
                    SCObjectSelectionSection *sectionAtIndex = (SCObjectSelectionSection *)[objectsModel sectionAtIndex:p];
                    NSEnumerator *enumerator = [sectionAtIndex.selectedItemsIndexes objectEnumerator];
                    id setObject;
                    while ( (setObject = [enumerator nextObject]) != nil )
                    {
                        SCTableViewCell *selectedCell = (SCTableViewCell *)[sectionAtIndex cellAtIndex:(NSUInteger)[(NSNumber *)setObject integerValue]];

                        if ([selectedCell.boundObject isKindOfClass:[ClinicianEntity class]])
                        {
                            ClinicianEntity *clinicianObject = (ClinicianEntity *)selectedCell.boundObject;
                            [currentlySelectedCliniciansArray addObject:clinicianObject];
                        }
                    }
                }
            }
        }
    }
}


- (BOOL) tableViewModel:(SCTableViewModel *)tableModel willAddItemForSectionAtIndex:(NSUInteger)index item:(NSObject *)item
{
    return YES;
}


- (void)                        tableViewModel:(SCArrayOfItemsModel *)tableViewModel
    searchBarSelectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self createSelectedCliniciansArray];

    if ([tableViewModel isKindOfClass:[SCArrayOfObjectsModel class]])
    {
        SCDataFetchOptions *dataFetchOptions = (SCDataFetchOptions *)objectsModel.dataFetchOptions;
        [self.searchBar setSelectedScopeButtonIndex:selectedScope];

        switch (selectedScope)
        {
            case 1: //All
            {
                NSPredicate *scopeFilter = nil;

                if (filterByPrescriber && isInDetailSubview)
                {
                    scopeFilter = [NSPredicate predicateWithFormat:@"isPrescriber ==%@",[NSNumber numberWithBool:YES]];
                }
                else
                {
                    scopeFilter = [NSPredicate predicateWithFormat:@"myCurrentSupervisor == %i OR myPastSupervisor==%i", TRUE, TRUE];
                }

                [dataFetchOptions setFilterPredicate:scopeFilter];
            }
            break;
            case 2:
                [dataFetchOptions setFilterPredicate:(NSPredicate *)[NSPredicate predicateWithFormat:@"atMyCurrentSite == %i OR myInformation==%i", TRUE, TRUE]];

                break;

            default:
                [dataFetchOptions setFilterPredicate:nil];

                break;
        } /* switch */

        [objectsModel reloadBoundValues];
        [objectsModel.modeledTableView reloadData];

        [self updateClinicianTotalLabel];

        [self setSelectedClinicians];
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didRemoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableViewModel.tag == 0)
    {
        [self updateClinicianTotalLabel];
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didRemoveSectionAtIndex:(NSUInteger)index
{
    if (tableViewModel.tag == 0)
    {
        [self updateClinicianTotalLabel];
    }
}


- (void) updateClinicianTotalLabel
{
    if (objectsModel.tag == 0)
    {
        int cellCount = 0;
        if (objectsModel.sectionCount > 0)
        {
            for (int i = 0; i < objectsModel.sectionCount; i++)
            {
                SCTableViewSection *section = (SCTableViewSection *)[objectsModel sectionAtIndex:i];
                if ([section isKindOfClass:[SCArrayOfObjectsSection class]])
                {
                    SCArrayOfObjectsSection *arrayOfObjectsSection = (SCArrayOfObjectsSection *)section;
                    cellCount = cellCount+ arrayOfObjectsSection.items.count;
                }
                else
                {
                    cellCount = cellCount + section.cellCount;
                }
            }
        }

        if (cellCount == 0)
        {
            self.totalCliniciansLabel.text = @"Tap + To Add Clinicians";
        }
        else
        {
            self.totalCliniciansLabel.text = [NSString stringWithFormat:@"Total Clinicians: %i", cellCount];
        }
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    [super tableViewModel:tableModel detailViewWillPresentForRowAtIndexPath:indexPath withDetailTableViewModel:detailTableViewModel];
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didInsertRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableViewModel:tableViewModel didInsertRowAtIndexPath:indexPath];

    if (tableViewModel.tag == 0)
    {
        [self updateClinicianTotalLabel];
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didLayoutSubviewsForCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[SCNumericTextFieldCell class]])
    {
        SCNumericTextFieldCell *numericCell = (SCNumericTextFieldCell *)cell;

        [numericCell.textLabel sizeToFit];
        numericCell.textField.textAlignment = NSTextAlignmentRight;
        numericCell.textField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableModel didAddSectionAtIndex:(NSUInteger)index
{
    [super tableViewModel:tableModel didAddSectionAtIndex:index];

    SCTableViewSection *section = [tableModel sectionAtIndex:index];

    if ([section isKindOfClass:[SCObjectSelectionSection class]])
    {
        tableModel.delegate = self;
        SCObjectSelectionSection *objectSelectionSection = (SCObjectSelectionSection *)section;

        if (allowMultipleSelection)
        {
            objectSelectionSection.allowMultipleSelection = YES;
            objectSelectionSection.allowNoSelection = YES;
        }
    }
}


- (BOOL) tableViewModel:(SCTableViewModel *)tableViewModel willRemoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTableViewCell *cell = (SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];

    if (tableViewModel.tag == 0)
    {
        NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;
        ClinicianEntity *clinicianObject = (ClinicianEntity *)cellManagedObject;
        if ([cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"ClinicianEntity"])
        {
            
            PTTAppDelegate *appdelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;
            UIView *notificationSuperView;
            
            if (clinicianObject.hasSupervisedTime) {
                [appdelegate displayNotification:@"Delete associated Assessments, Interventions, or Supervision records before deleting this clinician." forDuration:3.5 location:kPTTScreenLocationTop inView:notificationSuperView];
                return NO;
            }
            
            BOOL myInformation = (BOOL)[(NSNumber *)[cell.boundObject valueForKey:@"myInformation"] boolValue];
            if (myInformation)
            {
                
                
                if (!deletePressedOnce)
                {
                    [appdelegate displayNotification:@"Can't Delete Your Own Clinician Record. Press Delete again to clear your information." forDuration:3.5 location:kPTTScreenLocationTop inView:notificationSuperView];

                    deletePressedOnce = YES;
                }
                else
                {
                    NSEntityDescription *entityDescription = (NSEntityDescription *)clinicianObject.entity;

                    NSArray *boundObjectKeys = (NSArray *)[entityDescription attributesByName];

                    for (id attribute in boundObjectKeys)
                    {
                        BOOL setNil = YES;
                        if ([attribute isEqualToString:@"firstName"])
                        {
                            [clinicianObject setValue:@"Enter Your" forKey:attribute];
                            setNil = NO;
                        }

                        if ([attribute isEqualToString:@"lastName"])
                        {
                            [clinicianObject setValue:@"Name Here" forKey:attribute];
                            setNil = NO;
                        }

                        if (setNil && ![attribute isEqualToString:@"myInformation"] && ![attribute isEqualToString:@"atMyCurrentSite"] && ![attribute isEqualToString:@"order"])
                        {
                            [cellManagedObject setValue:nil forKey:attribute];
                        }
                    }

                    NSArray *relationshipsByName = (NSArray *)[entityDescription relationshipsByName];

                    for (id relationship in relationshipsByName)
                    {
                        [clinicianObject setValue:nil forKey:relationship];
                    }

                    [tableViewModel reloadBoundValues];
                    [tableViewModel.modeledTableView reloadData];
                    [appdelegate displayNotification:@"My Personal Information Cleared" forDuration:3.0 location:kPTTScreenLocationTop inView:notificationSuperView];
                    deletePressedOnce = NO;
                }

                return NO;
            }
        }
    }

    return YES;
}


@end
