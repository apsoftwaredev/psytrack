/*
 *  ClinicianRootViewController_iPad.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.3
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 9/9/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "CliniciansRootViewController_iPad.h"

#import "LogoBackgroundViewController.h"
#import "PTTAppDelegate.h"
#import "ButtonCell.h"
#import "ClinicianEntity.h"
#import "TrainTrackViewController.h"

#import "CliniciansDetailViewController_iPad.h"

#import "CliniciansViewController_Shared.h"
#import "LookupRemoveLinkButtonCell.h"
#import "AddViewABLinkButtonCell.h"
@implementation CliniciansRootViewController_iPad
@synthesize cliniciansBarButtonItem = cliniciansBarButtonItem_;

#pragma mark -
#pragma mark View lifecycle and setting up table model

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.navigationBarType = SCNavigationBarTypeEditLeft;

    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc] init]];
    [self.view setBackgroundColor:appDelegate.window.backgroundColor];

    objectsModel.addButtonItem = objectsModel.detailViewController.navigationItem.rightBarButtonItem;

    objectsModel.addButtonItem = self.addButton;
    objectsModel.itemsAccessoryType = UITableViewCellAccessoryNone;
    objectsModel.detailViewControllerOptions.modalPresentationStyle = UIModalPresentationPageSheet;
    self.tableViewModel.detailViewController =objectsModel.detailViewController;
    CliniciansDetailViewController_iPad *clinicianDetailViewController = (CliniciansDetailViewController_iPad *)objectsModel.detailViewController;

    clinicianDetailViewController.navigationBarType = SCNavigationBarTypeAddRight;

    objectsModel.addButtonItem = clinicianDetailViewController.navigationItem.rightBarButtonItem;

    NSString *imageNameStr = nil;
    if ([SCUtilities systemVersion] < 7)
    {
        if ([SCUtilities is_iPad])
        {
            imageNameStr = @"ipad-menubar-full.png";
        }
        else
        {
            imageNameStr = @"menubar.png";
        }

        UIImage *menueBarImage = [UIImage imageNamed:imageNameStr];
        [self.searchBar setBackgroundImage:menueBarImage];
        [self.searchBar setScopeBarBackgroundImage:menueBarImage];
    }
    self.cliniciansBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Clinicians" style:UIBarButtonItemStylePlain target:self action:@selector(displayPopover:)];

    objectsModel.modelActions.didRefresh = ^(SCTableViewModel *tableModel)
    {
        [self putAddAndClinicianButtonsOnDetailViewController];
        [self updateClinicianTotalLabel];
    };

    self.tableViewModel = objectsModel;
}


- (void) viewDidUnload
{
    [super viewDidUnload];

    self.cliniciansBarButtonItem = nil;
    currentDetailTableViewModel_ = nil;

    if (personVCFromSelectionList)
    {
        self.personVCFromSelectionList = nil;
    }

    if (personAddNewViewController)
    {
        self.personAddNewViewController = nil;
    }
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations

    return YES;
}


#pragma mark -
#pragma SCTableViewModelDelegate methodds

- (void) tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableViewModel:tableViewModel valueChangedForRowAtIndexPath:indexPath];

    SCTableViewCell *cell = nil;
    if (indexPath.row != NSNotFound)
    {
        cell = (SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
    }

    SCTableViewSection *sectionAtIndexPathThatChanged = (SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
    if ( !addingClinician && tableViewModel.tag == 1 && ( (cell && indexPath.section == 0 && ![cell isKindOfClass:[SCArrayOfObjectsCell class]] && ![cell isKindOfClass:[SCObjectCell class]] && ![cell isKindOfClass:[SCObjectSelectionCell class]]) || (indexPath.section == 1 && sectionAtIndexPathThatChanged.cellCount == 3) ) )
    {
        for (NSInteger i = 0; i < tableViewModel.sectionCount; i++)
        {
            SCTableViewSection *sectionAtIndex = [tableViewModel sectionAtIndex:i];
            [sectionAtIndex commitCellChanges];
        }

        [tableViewModel.masterModel reloadBoundValues];
        [tableViewModel.masterModel.modeledTableView reloadData];
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailViewWillDismissForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableModel.tag == 0)
    {
        addingClinician = NO;
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


- (void) tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableViewModel.tag == 1 || tableViewModel.tag == 0)
    {
        UIView *viewShort = [cell viewWithTag:35];
        UIView *viewLong = [cell viewWithTag:51];
        switch (cell.tag)
        {
            case 0:
                if ([viewShort isKindOfClass:[UILabel class]])
                {
                    UILabel *titleLabel = (UILabel *)viewShort;
                    titleLabel.text = @"Prefix:";
                    tableViewModel.tag = 1;
                    
                    if ([SCUtilities systemVersion]>=7) {
                        titleLabel.textColor=[UIColor blueColor];
                    }
                }

                break;
            case 1:
                if ([viewLong isKindOfClass:[UILabel class]])
                {
                    UILabel *firstNameLabel = (UILabel *)viewLong;
                    firstNameLabel.text = @"First Name:";
                    cell.commitChangesLive = YES;
                    
                    if ([SCUtilities systemVersion]>=7) {
                        firstNameLabel.textColor=[UIColor blueColor];
                    }
                }

                break;

            case 2:
                if ([viewLong isKindOfClass:[UILabel class]])
                {
                    UILabel *middleNameLabel = (UILabel *)viewLong;
                    middleNameLabel.text = @"Middle Name:";
                    if ([SCUtilities systemVersion]>=7) {
                        middleNameLabel.textColor=[UIColor blueColor];
                    }
                }

                break;

            case 3:
                if ([viewLong isKindOfClass:[UILabel class]])
                {
                    UILabel *lastNameLabel = (UILabel *)viewLong;
                    lastNameLabel.text = @"Last Name:";
                    if ([SCUtilities systemVersion]>=7) {
                        lastNameLabel.textColor=[UIColor blueColor];
                    }
                }

                break;
            case 4:
                if ([viewLong isKindOfClass:[UILabel class]])
                {
                    UILabel *suffixLabel = (UILabel *)viewLong;
                    suffixLabel.text = @"Suffix:";
                    if ([SCUtilities systemVersion]>=7) {
                        suffixLabel.textColor=[UIColor blueColor];
                    }
                }

                break;

            case 8:
                if ([cell isKindOfClass:[AddViewABLinkButtonCell class]])
                {
                    AddViewABLinkButtonCell *addViewButtonCell = (AddViewABLinkButtonCell *)cell;

                    int addressBookRecordIdentifier = (int)[(NSNumber *)[cell.boundObject valueForKey:@"aBRecordIdentifier"] intValue];

                    ABAddressBookRef addressBook = ABAddressBookCreate();
                    if (addressBookRecordIdentifier != -1 && ![self checkIfRecordIDInAddressBook:addressBookRecordIdentifier addressBook:(ABAddressBookRef)addressBook])
                    {
                        addressBookRecordIdentifier = -1;
                        [cell.boundObject setValue:[NSNumber numberWithInt:-1 ] forKey:@"aBRecordIdentifier"];
                    }

                    CFRelease(addressBook);

                    if (addressBookRecordIdentifier != -1)
                    {
                        [addViewButtonCell toggleButtonsWithButtonOneHidden:YES];
                    }
                    else
                    {
                        [addViewButtonCell toggleButtonsWithButtonOneHidden:NO];
                    }
                }

                break;

            case 9:
                //this is the root table

            {
                if ([cell isKindOfClass:[LookupRemoveLinkButtonCell class]])
                {
                    int addressBookRecordIdentifier = (int)[(NSNumber *)[cell.boundObject valueForKey:@"aBRecordIdentifier"] intValue];

                    LookupRemoveLinkButtonCell *addViewButtonCell = (LookupRemoveLinkButtonCell *)cell;

                    if (addressBookRecordIdentifier != -1)
                    {
                        [addViewButtonCell toggleButtonsWithButtonOneHidden:YES];
                    }
                    else
                    {
                        [addViewButtonCell toggleButtonsWithButtonOneHidden:NO];
                    }
                }
            }

            break;

            default:
                break;
        } /* switch */
    }

    if (tableViewModel.tag == 4)
    {
        UIView *sliderView = [cell viewWithTag:14];
        UIView *scaleView = [cell viewWithTag:70];
        switch (cell.tag)
        {
            case 1:

                if ([scaleView isKindOfClass:[UISegmentedControl class]])
                {
                    UILabel *fluencyLevelLabel = (UILabel *)[cell viewWithTag:71];
                    fluencyLevelLabel.text = @"Fluency Level:";
                }

                break;

            case 3:

                if ([sliderView isKindOfClass:[UISlider class]])
                {
                    UISlider *sliderOne = (UISlider *)sliderView;
                    UILabel *slabel = (UILabel *)[cell viewWithTag:10];

                    slabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
                    UIImage *sliderLeftTrackImage = [[UIImage imageNamed:@"sliderbackground-gray.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:0];
                    UIImage *sliderRightTrackImage = [[UIImage imageNamed:@"sliderbackground.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:0];
                    [sliderOne setMinimumTrackImage:sliderLeftTrackImage forState:UIControlStateNormal];
                    [sliderOne setMaximumTrackImage:sliderRightTrackImage forState:UIControlStateNormal];
                    [sliderOne setMinimumValue:-1.0];
                    [sliderOne setMaximumValue:0];
                }

                break;
            case 4:

                if ([sliderView isKindOfClass:[UISlider class]])
                {
                    UISlider *sliderTwo = (UISlider *)sliderView;

                    UILabel *slabelTwo = (UILabel *)[cell viewWithTag:10];
                    UIImage *sliderTwoLeftTrackImage = [[UIImage imageNamed:@"sliderbackground.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:0];
                    UIImage *sliderTwoRightTrackImage = [[UIImage imageNamed:@"sliderbackground-gray.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:0];
                    [sliderTwo setMinimumTrackImage:sliderTwoLeftTrackImage forState:UIControlStateNormal];
                    [sliderTwo setMaximumTrackImage:sliderTwoRightTrackImage forState:UIControlStateNormal];

                    slabelTwo.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
                    [sliderTwo setMinimumValue:0.0];
                    [sliderTwo setMaximumValue:1.0];
                }

                break;
        } /* switch */
    }
}


- (NSArray *) tableViewModel:(SCArrayOfItemsModel *)tableModel customSearchResultForSearchText:(NSString *)searchText autoSearchResults:(NSArray *)autoSearchResults
{
    [tableModel dismissAllDetailViewsWithCommit:YES];

    [self putAddAndClinicianButtonsOnDetailViewController];
    return autoSearchResults;
}


- (void) putAddAndClinicianButtonsOnDetailViewController
{
objectsModel.detailViewController.navigationItem.rightBarButtonItem = objectsModel.addButtonItem;

    objectsModel.detailViewController.navigationItem.leftBarButtonItem = cliniciansBarButtonItem_;
}


- (void)                        tableViewModel:(SCArrayOfItemsModel *)tableViewModel
    searchBarSelectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    self.searchBar.text = nil;
    [tableViewModel dismissAllDetailViewsWithCommit:YES];

    [super tableViewModel:tableViewModel searchBarSelectedScopeButtonIndexDidChange:selectedScope];

    [self putAddAndClinicianButtonsOnDetailViewController];
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];

    if ( (tableViewModel.tag == 0 || tableViewModel.tag == 1) && [tableViewModel.viewController isKindOfClass:[CliniciansDetailViewController_iPad class]] )
    {
        if (index == 0)
        {
            currentDetailTableViewModel_ = tableViewModel;
            tableViewModel.tag = 1;
        }
    }

    [super tableViewModel:tableViewModel didAddSectionAtIndex:index];

    [self setSectionHeaderColorWithSection:(SCTableViewSection *)section color:[UIColor whiteColor]];
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    if (tableViewModel.tag == 0 && ![detailTableViewModel.viewController isKindOfClass:[CliniciansDetailViewController_iPad class]])
    {
        addingClinician = YES;
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)index detailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    if (tableViewModel.tag == 0)
    {
        addingClinician = YES;
    }

    detailTableViewModel.tag = tableViewModel.tag + 1;
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    [super tableViewModel:tableModel detailViewWillPresentForRowAtIndexPath:indexPath withDetailTableViewModel:detailTableViewModel];

    if (detailTableViewModel.tag == 1 && indexPath.row != NSNotFound)
    {
        [self putAddAndClinicianButtonsOnDetailViewController];
    }

    if (tableModel.tag == 0 && indexPath.row == NSNotFound)
    {
        addingClinician = YES;
    }
}


- (IBAction) displayPopover:(id)sender
{
    CliniciansDetailViewController_iPad *cliniciansDetailViewController_iPad = (CliniciansDetailViewController_iPad *)objectsModel.detailViewController;

    [cliniciansDetailViewController_iPad.popoverController presentPopoverFromBarButtonItem:self.splitViewController.navigationItem.leftBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}


- (NSString *) tableViewModel:(SCArrayOfItemsModel *)tableViewModel sectionHeaderTitleForItem:(NSObject *)item AtIndex:(NSUInteger)index
{
    // Cast not technically neccessary, done just for clarity
    NSManagedObject *managedObject = (NSManagedObject *)item;

    NSString *objectName = (NSString *)[managedObject valueForKey:@"lastName"];

    // Return first charcter of objectName
    return [[objectName substringToIndex:1] uppercaseString];
}


- (BOOL) checkIfRecordIDInAddressBook:(int)recordID addressBook:(ABAddressBookRef)addressBook
{
    addressBook = nil;
    if (!addressBook)
    {
        addressBook = ABAddressBookCreate();
    }

    BOOL exists = NO;
    if (addressBook)
    {
        ABRecordRef person = nil;

        if (recordID > 0)
        {
            person = (ABRecordRef)ABAddressBookGetPersonWithRecordID(addressBook, recordID);
            if (person)
            {
                exists = YES;
            }
        }
    }

    if (addressBook)
    {
        CFRelease(addressBook);
    }

    return exists;
}


@end
