/*
 *  ClientsViewController_iPhone.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.2
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 9/26/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ClientsViewController_iPhone.h"
#import "PTTAppDelegate.h"
#import "ButtonCell.h"
#import "ClientPresentations_Shared.h"
#import "PTTEncryption.h"
#import "DrugNameObjectSelectionCell.h"
#import "SCArrayOfObjectsModel_UseSelectionSection.h"

@implementation ClientsViewController_iPhone

@synthesize searchBar;
@synthesize totalClientsLabel;
@synthesize isInDetailSubview;
@synthesize clientObjectSelectionCell;
@synthesize sendingViewController;
@synthesize alreadySelectedClients;
@synthesize clientsViewController_Shared;

#pragma mark -
#pragma mark View lifecycle

- (id) initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(ClientsSelectionCell *)objectSelectionCell sendingViewController:(UIViewController *)viewController allowMultipleSelection:(BOOL)allowMultiSelect
{
    self = [super initWithNibName:nibName bundle:bundle];

    allowMultipleSelection = allowMultiSelect;
    isInDetailSubview = detailSubview;
    clientObjectSelectionCell = objectSelectionCell;

    sendingViewController = viewController;

    return self;
}


- (void) refreshData
{
    [objectsModel reloadBoundValues];
    [objectsModel.modeledTableView reloadData];
}


- (void) viewDidLoad
{
    [super viewDidLoad];

    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

    clientsViewController_Shared = [[ClientsViewController_Shared alloc]init];

    [clientsViewController_Shared setupTheClientsViewModelUsingSTV];

    self.tableView.backgroundColor = [UIColor clearColor];

    // Instantiate the tabel model

    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    //

    // Initialize tableModel

    NSPredicate *currentClientsPredicate = [NSPredicate predicateWithFormat:@"currentClient == %@",[NSNumber numberWithInteger:0]];
    objectsModel = nil;
    if (isInDetailSubview)
    {
        self.navigationBarType = SCNavigationBarTypeNone;

        objectsModel = [[SCArrayOfObjectsModel_UseSelectionSection alloc] initWithTableView:self.tableView entityDefinition:self.clientsViewController_Shared.clientDef ];

        if (searchBar.scopeButtonTitles.count > 1)
        {
            [self.searchBar setSelectedScopeButtonIndex:1];
        }

        objectsModel.allowDeletingItems = FALSE;
        objectsModel.autoSelectNewItemCell = TRUE;

        NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:3];

        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTappedInDetailView)];

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

//        objectsModel.delegate=self;
    }
    else
    {
        objectsModel = [[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:self.clientsViewController_Shared.clientDef filterPredicate:currentClientsPredicate];

        objectsModel.autoSortSections = YES;

        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        objectsModel.editButtonItem = self.navigationItem.leftBarButtonItem;

        self.navigationBarType = SCNavigationBarTypeAddRightEditLeft;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        objectsModel.editButtonItem = self.navigationItem.leftBarButtonItem;

        objectsModel.addButtonItem = self.navigationItem.rightBarButtonItem;
    }

    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];

    objectsModel.searchBar = self.searchBar;
    objectsModel.searchPropertyName = @"clientIDCode;notes";
    objectsModel.allowMovingItems = TRUE;

    objectsModel.autoAssignDelegateForDetailModels = TRUE;
    objectsModel.autoAssignDataSourceForDetailModels = TRUE;

    if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
    {
        UIColor *backgroundColor = nil;

        if (isInDetailSubview)
        {
            backgroundColor = appDelegate.window.backgroundColor;
        }
        else
        {
            backgroundColor = [UIColor clearColor];
        }

        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:backgroundColor]; // Make the table view transparent
        self.view.backgroundColor = backgroundColor;
    }
    else
    {
        [self.view setBackgroundColor:[UIColor clearColor]];
    }

    [self updateClientsTotalLabel];

    objectsModel.modelActions.didRefresh = ^(SCTableViewModel *tableModel)
    {
        [self updateClientsTotalLabel];
    };

    [(PTTAppDelegate *)[UIApplication sharedApplication].delegate application :[UIApplication sharedApplication]
     willChangeStatusBarOrientation :[[UIApplication sharedApplication] statusBarOrientation]
     duration : 5];

    self.tableViewModel = objectsModel;

    NSString *imageNameStr = nil;
    if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
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

    UIViewController *navtitle = self.navigationController.topViewController;

    navtitle.title = @"Clients";
}


- (void) viewDidUnload
{
    [super viewDidUnload];
    self.clientsViewController_Shared = nil;

    objectsModel = nil;
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void) cancelButtonTappedInDetalView
{
    if (self.navigationController)
    {
        // check if self is the rootViewController
        if ([self.navigationController.viewControllers objectAtIndex:0] == self)
        {
            [self dismissModalViewControllerAnimated:YES];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [self dismissModalViewControllerAnimated:YES];
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTableViewCell *cell = (SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];

    [cell setSelected:FALSE];
}


- (BOOL) disablesAutomaticKeyboardDismissal
{
    return NO;
}


- (void) doneButtonTappedInDetailView
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
                NSInteger sectionCount = self.tableViewModel.sectionCount;

                if (sectionCount && !currentlySelectedClientsArray)
                {
                    currentlySelectedClientsArray = [NSMutableArray array];
                }
                else
                {
                    [currentlySelectedClientsArray removeAllObjects];
                }

                for (NSInteger i = 0; i < sectionCount; i++ )
                {
                    SCObjectSelectionSection *sectionAtIndex = (SCObjectSelectionSection *)[self.tableViewModel sectionAtIndex:i];

                    NSEnumerator *enumerator = [sectionAtIndex.selectedItemsIndexes objectEnumerator];
                    id setObject;
                    while ( (setObject = [enumerator nextObject]) != nil )
                    {
                        if (![setObject isEqualToNumber:[NSNumber numberWithInteger:-1]] && [setObject integerValue] < sectionAtIndex.cellCount)
                        {
                            SCTableViewCell *selectedCell = (SCTableViewCell *)[sectionAtIndex cellAtIndex:(NSUInteger)[(NSNumber *)setObject integerValue]];

                            if ([selectedCell.boundObject isKindOfClass:[ClientEntity class]])
                            {
                                ClientEntity *clientnObject = (ClientEntity *)selectedCell.boundObject;
                                [currentlySelectedClientsArray addObject:clientnObject];
                            }
                        }
                    }
                }

                [clientObjectSelectionCell doneButtonTappedInDetailView:(NSObject *)nil selectedClients:(NSArray *)currentlySelectedClientsArray withValue:(BOOL)YES];
            }
            else
            {
                if (objectsSelectionSection.selectedItemIndex && ![objectsSelectionSection.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]] && [objectsSelectionSection.selectedItemIndex intValue] < objectsSelectionSection.items.count)
                {
                    currentlySelectedClient = (ClientEntity *)[objectsSelectionSection.items objectAtIndex:[objectsSelectionSection.selectedItemIndex intValue]];
                }
                else
                {
                    currentlySelectedClient = nil;
                }

                [clientObjectSelectionCell doneButtonTappedInDetailView:(NSObject *)currentlySelectedClient selectedClients:nil withValue:(BOOL)YES];

                currentlySelectedClient = nil;
            }
        }
    }

    [self cancelButtonTappedInDetalView];
}


- (void) setSelectedClients
{
    if (isInDetailSubview)
    {
        SCTableViewSection *section = (SCTableViewSection *)[self.tableViewModel sectionAtIndex:0];

        if ([section isKindOfClass:[SCObjectSelectionSection class]])
        {
            for (int i = 0; i < self.tableViewModel.sectionCount; i++)
            {
                SCObjectSelectionSection *objectSelectionSection = (SCObjectSelectionSection *)[self.tableViewModel sectionAtIndex:i];

                if (allowMultipleSelection)
                {
                    if (currentlySelectedClientsArray.count)
                    {
                        NSMutableSet *selectedIndexesSet = objectSelectionSection.selectedItemsIndexes;
                        for (int p = 0; p < currentlySelectedClientsArray.count; p++)
                        {
                            int clientInSectionIndex;
                            ClientEntity *clientInArray = [currentlySelectedClientsArray objectAtIndex:p];
                            if ([objectSelectionSection.items containsObject:clientInArray])
                            {
                                clientInSectionIndex = (int)[objectSelectionSection.items indexOfObject:clientInArray];

                                [selectedIndexesSet addObject:[NSNumber numberWithInt:clientInSectionIndex]];
                            }
                        }
                    }
                }
            }
        }
    }
}


- (void) createSelectedClientsArray
{
    if (isInDetailSubview)
    {
        SCTableViewSection *section = (SCTableViewSection *)[self.tableViewModel sectionAtIndex:0];

        if ([section isKindOfClass:[SCObjectSelectionSection class]])
        {
            if (allowMultipleSelection)
            {
                if (currentlySelectedClientsArray && currentlySelectedClientsArray.count)
                {
                    [currentlySelectedClientsArray removeAllObjects];
                }
                else if (!currentlySelectedClientsArray)
                {
                    currentlySelectedClientsArray = [NSMutableArray array];
                }

                NSInteger sectionCount = self.tableViewModel.sectionCount;

                for (NSInteger p = 0; p < sectionCount; p++ )
                {
                    SCObjectSelectionSection *sectionAtIndex = (SCObjectSelectionSection *)[self.tableViewModel sectionAtIndex:p];
                    NSEnumerator *enumerator = [sectionAtIndex.selectedItemsIndexes objectEnumerator];
                    id setObject;
                    while ( (setObject = [enumerator nextObject]) != nil )
                    {
                        SCTableViewCell *selectedCell = (SCTableViewCell *)[sectionAtIndex cellAtIndex:(NSUInteger)[(NSNumber *)setObject integerValue]];

                        if ([selectedCell.boundObject isKindOfClass:[ClientEntity class]])
                        {
                            ClientEntity *clientObject = (ClientEntity *)selectedCell.boundObject;
                            [currentlySelectedClientsArray addObject:clientObject];
                        }
                    }
                }
            }
        }
    }
}


#pragma mark -
#pragma mark SCTableViewModelDataSource methods

- (void) tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    [self tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)indexPath.section detailTableViewModel:(SCTableViewModel *)detailTableViewModel];
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)index detailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    if ( ([SCUtilities systemVersion] >= 6 || [SCUtilities is_iPad]) && detailTableViewModel.modeledTableView.backgroundView.backgroundColor != [UIColor clearColor] )
    {
        [detailTableViewModel.modeledTableView setBackgroundView:nil];
        [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
        [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor];
    }
}


- (void) tableViewModel:(SCArrayOfItemsModel *)tableViewModel sectionGenerated:(SCTableViewSection *)section atIndex:(NSInteger)index
{
    if (tableViewModel.tag == 0 && [section isKindOfClass:[SCObjectSelectionSection class]])
    {
        SCObjectSelectionSection *objSelectionSection = (SCObjectSelectionSection *)section;
        objSelectionSection.autoSelectNewItemCell = TRUE;
        objSelectionSection.maximumSelections = 1;
    }
}


- (void) tableViewModelCoreDataObjectsLoaded:(SCArrayOfItemsModel *)tableViewModel
{
    if (isInDetailSubview)
    {
        NSMutableArray *itemsArray = (NSMutableArray *)tableViewModel.items;

        [itemsArray removeObjectsInArray:[NSArray arrayWithArray:[clientObjectSelectionCell.alreadySelectedClients allObjects]]];
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didLayoutSubviewsForCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( (tableViewModel.tag == 3 || tableViewModel.tag == 5) && ([SCSwitchCell class] || [SCTextFieldCell class]) )
    {
        NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;

        if ( cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && ([cellManagedObject.entity.name isEqualToString:@"SubstanceUseEntity"] || [cellManagedObject.entity.name isEqualToString:@"SubstanceUseLogEntity"]) )
        {
            [cell.textLabel sizeToFit];
            if ([cell isKindOfClass:[SCNumericTextFieldCell class]] || [cell isKindOfClass:[SCTextFieldCell class]])
            {
                SCNumericTextFieldCell *numericTextField = (SCNumericTextFieldCell *)cell;
                numericTextField.textField.textAlignment = UITextAlignmentRight;
                numericTextField.textField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
            }
        }
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTableViewSection *section = (SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
    switch (tableViewModel.tag)
    {
        case 0:
        {
            if ([section isKindOfClass:[SCObjectSelectionSection class]])
            {
                SCObjectSelectionSection *objectSelectionSection = (SCObjectSelectionSection *)section;

                if ([cell.boundObject isEqual:currentlySelectedClient])
                {
                    [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:currentlySelectedClient]]];
                }
            }
        }
        break;
        case 1:
        {
            if ([cell isKindOfClass:[SCDateCell class]])
            {
                SCDateCell *dateCell = (SCDateCell *)cell;
                [dateCell.datePicker setMaximumDate:[NSDate date]];
            }
        }
        break;
        case 3:
        {
            if (section.cellCount && cell.boundObject)
            {
                NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;

                if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)])
                {
                    if ([cellManagedObject.entity.name isEqualToString:@"PhoneEntity"]  )
                    {
                        if ( ![SCUtilities is_iPad] && [cell isKindOfClass:[ButtonCell class]])
                        {
                            UIButton *button = (UIButton *)[cell viewWithTag:300];
                            [button setTitle:@"Call Number" forState:UIControlStateNormal];
                        }

                        if ( [cell isKindOfClass:[SCTextFieldCell class]])
                        {
                            SCTextFieldCell *encryptedTextFieldCell = (SCTextFieldCell *)cell;

                            UITextField *textField = (UITextField *)encryptedTextFieldCell.textField;

                            textField.keyboardType = UIKeyboardTypeNumberPad;
                        }

                        if ( [cell isKindOfClass:[SCTextFieldCell class]])
                        {
                            SCTextFieldCell *textFieldCell = (SCTextFieldCell *)cell;

                            textFieldCell.textField.keyboardType = UIKeyboardTypeNumberPad;
                        }
                    }

                    if ([cellManagedObject.entity.name isEqualToString:@"VitalsEntity"] && cell.tag > 2 && [cell isKindOfClass:[SCNumericTextFieldCell class]])
                    {
                        if (cell.tag < 6 && [cell isKindOfClass:[SCNumericTextFieldCell class]])
                        {
                            SCNumericTextFieldCell *textFieldCell = (SCNumericTextFieldCell *)cell;

                            textFieldCell.textField.keyboardType = UIKeyboardTypeNumberPad;
                        }
                    }
                }
            }
        }
        break;
        case 4:
        {
            if (section.cellCount && cell.boundObject)
            {
                //            SCTableViewCell *cellOne=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
                NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;

                if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)])
                {
                    if ([cellManagedObject.entity.name isEqualToString:@"AdditionalVariableEntity"])
                    {
                        UIView *sliderView = [cell viewWithTag:14];

                        if (cell.tag == 3 && [sliderView isKindOfClass:[UISlider class]])
                        {
                            UISlider *sliderOne = (UISlider *)sliderView;
                            UILabel *slabel = (UILabel *)[cell viewWithTag:10];

                            slabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];

                            [sliderOne setMinimumValue:-1.0];
                            [sliderOne setMaximumValue:0];
                        }

                        if (cell.tag == 4 && [sliderView isKindOfClass:[UISlider class]])
                        {
                            UISlider *sliderTwo = (UISlider *)sliderView;

                            UILabel *slabelTwo = (UILabel *)[cell viewWithTag:10];

                            slabelTwo.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
                            [sliderTwo setMinimumValue:0.0];
                            [sliderTwo setMaximumValue:1.0];
                        }
                    }

                    if (cell.tag == 1 && [cellManagedObject.entity.name isEqualToString:@"LanguageSpokenEntity"])
                    {
                        UIView *scaleView = [cell viewWithTag:70];
                        if ([scaleView isKindOfClass:[UISegmentedControl class]])
                        {
                            UILabel *fluencyLevelLabel = (UILabel *)[cell viewWithTag:71];
                            fluencyLevelLabel.text = @"Fluency Level:";
                        }
                    }
                }
            }
        }
        break;

        case 5:
        {
            if (section.cellCount > 0 && cell.boundObject)
            {
                NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;
                if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)])
                {
                    if (cell.tag == 1 && [cell isKindOfClass:[SCCustomCell class]] && [cellManagedObject.entity.name isEqualToString:@"AdditionalSymptomEntity"])
                    {
                        UIView *scaleView = [cell viewWithTag:70];
                        if ([scaleView isKindOfClass:[UISegmentedControl class]])
                        {
                            UILabel *fluencyLevelLabel = (UILabel *)[cell viewWithTag:71];
                            fluencyLevelLabel.text = @"Severity Level:";
                        }
                    }
                }

                if (cell.tag == 5 && tableViewModel.sectionCount > 2)
                {
                    SCTableViewSection *followUpSection = (SCTableViewSection *)[tableViewModel sectionAtIndex:1];
                    SCTableViewCell *cellOne = (SCTableViewCell *)[followUpSection cellAtIndex:0];
                    NSManagedObject *cellOneManagedObject = (NSManagedObject *)cellOne.boundObject;

                    if (cellOneManagedObject && [cellOneManagedObject respondsToSelector:@selector(entity)] && [cellOneManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"])
                    {
                        if ([cell isKindOfClass:[SCCustomCell class]])
                        {
                            UIView *scaleView = [cell viewWithTag:70];
                            if ([scaleView isKindOfClass:[UISegmentedControl class]])
                            {
                                UILabel *satisfactionLevelLabel = (UILabel *)[cell viewWithTag:71];
                                satisfactionLevelLabel.text = @"Satisfaction With Drug:";
                            }
                        }
                    }
                }
            }
        }
        break;
        case 7:
        {
            if (section.cellCount > 0 && cell.boundObject)
            {
                NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;
                if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)])
                {
                    if (cell.tag == 1 && [cell isKindOfClass:[SCCustomCell class]] && [cellManagedObject.entity.name isEqualToString:@"AdditionalSymptomEntity"])
                    {
                        UIView *scaleView = [cell viewWithTag:70];
                        if ([scaleView isKindOfClass:[UISegmentedControl class]])
                        {
                            UILabel *fluencyLevelLabel = (UILabel *)[cell viewWithTag:71];
                            fluencyLevelLabel.text = @"Severity Level:";
                        }
                    }

                    if (cell.tag == 5 && tableViewModel.sectionCount > 2)
                    {
                        SCTableViewSection *followUpSection = (SCTableViewSection *)[tableViewModel sectionAtIndex:1];
                        SCTableViewCell *cellOne = (SCTableViewCell *)[followUpSection cellAtIndex:0];
                        NSManagedObject *cellOneManagedObject = (NSManagedObject *)cellOne.boundObject;

                        if (cellOneManagedObject && [cellOneManagedObject respondsToSelector:@selector(entity)] && [cellOneManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"])
                        {
                            if ([cell isKindOfClass:[SCCustomCell class]])
                            {
                                UIView *scaleView = [cell viewWithTag:70];
                                if ([scaleView isKindOfClass:[UISegmentedControl class]])
                                {
                                    UILabel *satisfactionLevelLabel = (UILabel *)[cell viewWithTag:71];
                                    satisfactionLevelLabel.text = @"Satisfaction With Drug:";
                                }
                            }
                        }
                    }
                }
            }
        }
        break;
        default:
            break;
    } /* switch */
}


- (BOOL) checkStringIsNumber:(NSString *)str
{
    BOOL valid = NO;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *numberStr = [str stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSNumber *number = [numberFormatter numberFromString:numberStr];
    if (numberStr.length && [numberStr floatValue] < 1000000000000 && number)
    {
        valid = YES;

        if ([str rangeOfString:@"Number"].location != NSNotFound)
        {
            NSScanner *scan = [NSScanner scannerWithString:numberStr];
            int val;

            valid = [scan scanInt:&val] && [scan isAtEnd];
        }
    }

    numberFormatter = nil;
    return valid;
}


- (BOOL) tableViewModel:(SCTableViewModel *)tableViewModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL valid = TRUE;

    if (tableViewModel.tag == 1 && tableViewModel.sectionCount)
    {
        SCTableViewSection *section = [tableViewModel sectionAtIndex:0];
        if (section.cellCount)
        {
            SCTableViewCell *clientIDCodeCell = (SCTableViewCell *)[section cellAtIndex:0];

            if ([clientIDCodeCell isKindOfClass:[SCTextFieldCell class]])
            {
                SCTextFieldCell *clientIDCodeEncryptedCell = (SCTextFieldCell *)clientIDCodeCell;

                if ( clientIDCodeEncryptedCell.textField.text.length )
                {
                    valid = TRUE;
                }
                else
                {
                    valid = FALSE;
                }
            }
        }
    }
    else if (tableViewModel.tag == 3 && tableViewModel.sectionCount)
    {
        SCTableViewSection *section = [tableViewModel sectionAtIndex:0];

        if (section.cellCount > 1)
        {
            SCTableViewCell *notesCell = (SCTableViewCell *)[section cellAtIndex:1];
            NSManagedObject *notesManagedObject = (NSManagedObject *)notesCell.boundObject;
            SCTableViewCell *cell = (SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];

            NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;
            if (notesManagedObject && [notesManagedObject respondsToSelector:@selector(entity)])
            {
                if ([ notesManagedObject.entity.name isEqualToString:@"LogEntity"] && [notesCell isKindOfClass:[SCTextViewCell class]])
                {
                    SCTextViewCell *encryptedNoteCell = (SCTextViewCell *)notesCell;

                    if (encryptedNoteCell.textView.text.length)
                    {
                        valid = TRUE;
                    }
                    else
                    {
                        valid = FALSE;
                    }
                }
                else if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [ cellManagedObject.entity.name isEqualToString:@"SubstanceUseEntity"])
                {
                    if (cell.tag == 0 && [cell isKindOfClass:[SCObjectSelectionCell class]])
                    {
                        SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cell;

                        if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]])
                        {
                            valid = TRUE;
                        }
                        else
                        {
                            valid = FALSE;
                        }
                    }

                    if (cell.tag == 1 && [cell isKindOfClass:[SCNumericTextFieldCell class]])
                    {
                        SCNumericTextFieldCell *numericTextFieldCell = (SCNumericTextFieldCell *)cell;
                        int ageOfFirstUse = [numericTextFieldCell.textField.text intValue];
                        if ( ageOfFirstUse < 140 && ageOfFirstUse >= 0)
                        {
                            valid = TRUE;
                        }
                        else
                        {
                            valid = FALSE;
                        }
                    }
                }
                //here it is not the notes cell
                else if ([notesManagedObject.entity.name isEqualToString:@"MedicationEntity"] && [notesCell isKindOfClass:[SCTextFieldCell class]])
                {
                    SCTextFieldCell *drugNameCell = (SCTextFieldCell *)notesCell;

                    if (drugNameCell.textField.text.length)
                    {
                        valid = TRUE;
                    }
                    else
                    {
                        valid = FALSE;
                    }
                }

                if ([notesManagedObject.entity.name isEqualToString:@"PhoneEntity"] && [notesCell isKindOfClass:[SCTextFieldCell class]])
                {
                    SCTextFieldCell *phoneNumberCell = (SCTextFieldCell *)notesCell;

                    if (phoneNumberCell.textField.text.length)
                    {
                        valid = [self checkStringIsNumber:(NSString *)phoneNumberCell.textField.text];
                    }
                    else
                    {
                        valid = FALSE;
                    }
                }
            }

            if (section.cellCount > 6)
            {
                SCTableViewCell *cell = [tableViewModel cellAtIndexPath:indexPath];
                NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;

                if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"VitalsEntity"] && [cell isKindOfClass:[SCTextFieldCell class]])
                {
                    SCTextFieldCell *textFieldCell = (SCTextFieldCell *)cell;
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];

                    NSNumber *number = [numberFormatter numberFromString:textFieldCell.textField.text];

                    if (textFieldCell.textField.text.length)
                    {
                        switch (cell.tag)
                        {
                            case 3:
                            {
                                if ([textFieldCell.textField.text integerValue] < 500 && number)
                                {
                                    valid = YES;
                                }
                                else
                                {
                                    valid = NO;
                                }
                            }
                            break;
                            case 4:
                            {
                                if ([textFieldCell.textField.text integerValue] < 500 && number)
                                {
                                    valid = YES;
                                }
                                else
                                {
                                    valid = NO;
                                }
                            }
                            break;
                            case 5:
                            {
                                if ( [textFieldCell.textField.text integerValue] < 500 && number)
                                {
                                    valid = YES;
                                }
                                else
                                {
                                    valid = NO;
                                }
                            }
                            break;
                            case 6:
                            {
                                if ([textFieldCell.textField.text floatValue] < 130 && number)
                                {
                                    valid = YES;
                                }
                                else
                                {
                                    valid = NO;
                                }
                            }
                            break;
                            default:
                                break;
                        } /* switch */
                    }

                    numberFormatter = nil;
                }
            }
        }
    }
    else if (tableViewModel.tag == 5 && tableViewModel.sectionCount)
    {
        SCTableViewSection *section = [tableViewModel sectionAtIndex:0];

        if (section.cellCount > 0)
        {
            SCTableViewCell *firstCell = (SCTableViewCell *)[section cellAtIndex:0];
            NSManagedObject *firstCellManagedObject = (NSManagedObject *)firstCell.boundObject;

            if (firstCellManagedObject && [firstCellManagedObject respondsToSelector:@selector(entity)] && [firstCellManagedObject.entity.name isEqualToString:@"AdditionalSymptomEntity"] && [firstCell isKindOfClass:[SCObjectSelectionCell class]])
            {
                SCObjectSelectionCell *symptomCell = (SCObjectSelectionCell *)firstCell;

                if (symptomCell.label.text.length)
                {
                    valid = TRUE;
                }
                else
                {
                    valid = FALSE;
                }
            }

            SCTableViewCell *cell = [tableViewModel cellAtIndexPath:indexPath];
            NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;

            if (cell.tag == 1 && cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"MedicationEntity"] && [cell isKindOfClass:[SCTextFieldCell class]])
            {
                SCTextFieldCell *textFieldCell = (SCTextFieldCell *)cell;

                if (textFieldCell.textField.text.length)
                {
                    valid = TRUE;
                }
                else
                {
                    valid = FALSE;
                }
            }
        }
    }
    else if (tableViewModel.tag == 4 && tableViewModel.sectionCount)
    {
        SCTableViewSection *section = [tableViewModel sectionAtIndex:0];

        if (section.cellCount > 3)
        {
            SCTableViewCell *cellFrom = (SCTableViewCell *)[section cellAtIndex:0];
            SCTableViewCell *cellTo = (SCTableViewCell *)[section cellAtIndex:1];
            SCTableViewCell *cellArrivedDate = (SCTableViewCell *)[section cellAtIndex:2];
            NSManagedObject *cellManagedObject = (NSManagedObject *)cellFrom.boundObject;

            if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"MigrationHistoryEntity"] && [cellFrom isKindOfClass:[SCTextViewCell class]])
            {
                SCTextViewCell *encryptedFrom = (SCTextViewCell *)cellFrom;
                SCTextViewCell *encryptedTo = (SCTextViewCell *)cellTo;

                SCDateCell *arrivedDateCell = (SCDateCell *)cellArrivedDate;

                if (encryptedFrom.textView.text.length && encryptedTo.textView.text.length && arrivedDateCell.label.text.length)
                {
                    valid = YES;
                }
                else
                {
                    valid = NO;
                }
            }
        }
    }

    return valid;
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
    {
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        UIColor *backgroundColor = nil;

        if (indexPath.row == NSNotFound || detailTableViewModel.tag > 0)
        {
            backgroundColor = (UIColor *)appDelegate.window.backgroundColor;
        }
        else
        {
            backgroundColor = [UIColor clearColor];
        }

        if (detailTableViewModel.modeledTableView.backgroundColor != backgroundColor)
        {
            [detailTableViewModel.modeledTableView setBackgroundView:nil];
            UIView *view = [[UIView alloc]init];
            [detailTableViewModel.modeledTableView setBackgroundView:view];
            [detailTableViewModel.modeledTableView setBackgroundColor:backgroundColor];
        }
    }
    else if (detailTableViewModel.tag == 3 && detailTableViewModel.sectionCount > 0)
    {
        SCTableViewSection *section = (SCTableViewSection *)[detailTableViewModel sectionAtIndex:0];

        if ([section isKindOfClass:[SCObjectSection class]])
        {
            SCObjectSection *objectSection = (SCObjectSection *)section;

            NSManagedObject *sectionManagedObject = (NSManagedObject *)objectSection.boundObject;

            if (sectionManagedObject && [sectionManagedObject respondsToSelector:@selector(entity)] && [sectionManagedObject.entity.name isEqualToString:@"DiagnosisHistoryEntity"] && objectSection.cellCount > 1)
            {
                //specifiers cell
                SCTableViewCell *cellAtOne = (SCTableViewCell *)[objectSection cellAtIndex:1];
                if ([cellAtOne isKindOfClass:[SCObjectSelectionCell class]])
                {
                    SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cellAtOne;

                    NSObject *disorderObject = [sectionManagedObject valueForKeyPath:@"disorder"];

                    if ( indexPath.row != NSNotFound && ( selectedDisorder || (disorderObject && [disorderObject isKindOfClass:[DisorderEntity class]]) ) )
                    {
                        if (!selectedDisorder)
                        {
                            selectedDisorder = (DisorderEntity *)disorderObject;
                        }

                        if (selectedDisorder.disorderName.length)
                        {
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                      @"disorder.disorderName like %@",[NSString stringWithString:(NSString *)selectedDisorder.disorderName]];

                            SCDataFetchOptions *dataFetchOptions = [SCDataFetchOptions optionsWithSortKey:@"specifier" sortAscending:YES filterPredicate:predicate];

                            objectSelectionCell.selectionItemsFetchOptions = dataFetchOptions;

                            [objectSelectionCell reloadBoundValue];
                        }
                    }
                    else
                    {
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                  @"disorder.disorderName = nil"];

                        SCDataFetchOptions *dataFetchOptions = [SCDataFetchOptions optionsWithSortKey:@"specifier" sortAscending:YES filterPredicate:predicate];

                        objectSelectionCell.selectionItemsFetchOptions = dataFetchOptions;
                        [objectSelectionCell reloadBoundValue];
                    }
                }
            }
        }
    }
    else if (detailTableViewModel.tag == 4 && detailTableViewModel.sectionCount)
    {
        SCTableViewSection *section = (SCTableViewSection *)[detailTableViewModel sectionAtIndex:0];

        if ([section isKindOfClass:[SCObjectSection class]])
        {
            SCObjectSection *objectSection = (SCObjectSection *)section;

            NSManagedObject *sectionManagedObject = (NSManagedObject *)objectSection.boundObject;

            if (sectionManagedObject && [sectionManagedObject respondsToSelector:@selector(entity)] && [sectionManagedObject.entity.name isEqualToString:@"AdditionalVariableEntity"] && objectSection.cellCount > 1)
            {
                SCTableViewCell *cellAtZero = (SCTableViewCell *)[objectSection cellAtIndex:1];
                if ([cellAtZero isKindOfClass:[SCObjectSelectionCell class]])
                {
                    SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cellAtZero;

                    NSObject *additionalVariableNameObject = [sectionManagedObject valueForKeyPath:@"variableName"];

                    if ( indexPath.row != NSNotFound && ( selectedVariableName || (additionalVariableNameObject && [additionalVariableNameObject isKindOfClass:[AdditionalVariableNameEntity class]]) ) )
                    {
                        if (!selectedVariableName)
                        {
                            selectedVariableName = (AdditionalVariableNameEntity *)additionalVariableNameObject;
                        }

                        if (selectedVariableName.variableName.length)
                        {
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                      @"variableName.variableName like %@",[NSString stringWithString:(NSString *)selectedVariableName.variableName]];

                            SCDataFetchOptions *dataFetchOptions = [SCDataFetchOptions optionsWithSortKey:@"variableValue" sortAscending:YES filterPredicate:predicate];

                            objectSelectionCell.selectionItemsFetchOptions = dataFetchOptions;

                            [objectSelectionCell reloadBoundValue];
                        }
                    }
                    else
                    {
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                  @"variableName.variableName = nil"];

                        SCDataFetchOptions *dataFetchOptions = [SCDataFetchOptions optionsWithSortKey:@"variableValue" sortAscending:YES filterPredicate:predicate];

                        objectSelectionCell.selectionItemsFetchOptions = dataFetchOptions;
                        [objectSelectionCell reloadBoundValue];
                    }
                }
            }
        }
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailViewWillDismissForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableModel.tag == 2)
    {
        selectedDisorder = nil;
    }
    else if (tableModel.tag == 3)
    {
        selectedVariableName = nil;
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillPresentForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    if (detailTableViewModel.modeledTableView.backgroundView.backgroundColor != [UIColor clearColor])
    {
        [detailTableViewModel.modeledTableView setBackgroundView:nil];
        [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
        [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor];
    }

    if (tableViewModel.tag == 4)
    {
        //this is so the second section will not appear if it is the second log, because that info does not pertain
        SCTableViewSection *section = (SCTableViewSection *)[tableViewModel sectionAtIndex:index];

        //        BOOL sectionContainsMedLog=FALSE;

        if (tableViewModel.sectionCount)
        {
            SCTableViewCell *cell = tableViewModel.activeCell;

            if ( !cell || ([section indexForCell:cell] == 0) )
            {
                SCTableViewSection *detailSectionZero = (SCTableViewSection *)[detailTableViewModel sectionAtIndex:0];
                SCTableViewCell *cellZeroSectionZero = (SCTableViewCell *)[detailSectionZero cellAtIndex:0];

                NSManagedObject *cellManagedObject = (NSManagedObject *)cellZeroSectionZero.boundObject;

                if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"] && detailTableViewModel.sectionCount > 2)
                {
                    [detailTableViewModel removeSectionAtIndex:1];
                }
                else
                {
                    [detailTableViewModel.modeledTableView reloadData];
                }
            }
        }
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForSectionAtIndex:(NSUInteger)index
{
    if (tableViewModel.tag == 0)
    {
        [self updateClientsTotalLabel];
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel customButtonTapped:(UIButton *)button forRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (tableViewModel.tag == 3)
    {
        SCTableViewSection *section = [tableViewModel sectionAtIndex:indexPath.section];
        SCTableViewCell *cell = (SCTableViewCell *)[section cellAtIndex:0];
        NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;
        if ([cellManagedObject respondsToSelector:@selector(entity)])
        {
            if ([cellManagedObject.entity.name isEqualToString:@"PhoneEntity"] && section.cellCount > 1)
            {
                SCTextFieldCell *phoneNumberCell = (SCTextFieldCell *)[section cellAtIndex:1];

                if (phoneNumberCell.textField.text.length)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call Phone Number:" message:phoneNumberCell.textField.text
                                                                   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

                    alert.tag = 1;

                    [alert show];
                }
            }
        }
    }
}


- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // use "buttonIndex" to decide your action
    //

    if (alertView.tag == 1)
    {
        if (buttonIndex == 1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel:" stringByAppendingString : alertView.message]]];
        }
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)IndexPath
{
    SCTableViewCell *cell = [tableViewModel cellAtIndexPath:IndexPath];

    if ( (tableViewModel.tag == 1 || tableViewModel.tag == 0) && cell.tag == 1 )
    {
        if ([cell isKindOfClass:[SCDateCell class]])
        {
            SCDateCell *dateCell = (SCDateCell *)cell;

            if (dateCell.datePicker.date)
            {
                [self addWechlerAgeCellToSection:[tableViewModel sectionAtIndex:0]];
            }
        }
    }
    else if ( (tableViewModel.tag == 3 || tableViewModel.tag == 5) && [cell isKindOfClass:[DrugNameObjectSelectionCell class]] )
    {
        DrugNameObjectSelectionCell *drugNameObjectSelectionCell = (DrugNameObjectSelectionCell *)cell;

        if (drugNameObjectSelectionCell.drugProduct)
        {
            SCTableViewCell *drugNameCell = (SCTableViewCell *)[tableViewModel cellAfterCell:cell rewind:NO];

            if ([drugNameCell isKindOfClass:[SCTextFieldCell class]] )
            {
                SCTextFieldCell *textFieldCell = (SCTextFieldCell *)drugNameCell;
                textFieldCell.textField.text = drugNameObjectSelectionCell.drugProduct.drugName;
            }
        }
    }
    else if (tableViewModel.tag == 4)
    {
        NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;

        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"AdditionalVariableEntity"])
        {
            if (cell.tag == 0 && [cell isKindOfClass:[SCObjectSelectionCell class]] )
            {
                SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cell;

                if ([objectSelectionCell.selectedItemIndex intValue] > -1)
                {
                    NSManagedObject *selectedVariableNameManagedObject = [objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];
                    if ([selectedVariableNameManagedObject isKindOfClass:[AdditionalVariableNameEntity class]])
                    {
                        selectedVariableName = (AdditionalVariableNameEntity *)selectedVariableNameManagedObject;

                        SCTableViewCell *variableValueCell = (SCTableViewCell *)[tableViewModel cellAfterCell:objectSelectionCell rewind:NO];

                        if ([variableValueCell isKindOfClass:[SCObjectSelectionCell class]])
                        {
                            SCObjectSelectionCell *variableValueObjectSelectionCell = (SCObjectSelectionCell *)variableValueCell;

                            if (selectedVariableName.variableName.length)
                            {
                                NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                          @"variableName.variableName like %@",[NSString stringWithString:(NSString *)selectedVariableName.variableName]];

                                SCDataFetchOptions *dataFetchOptions = [SCDataFetchOptions optionsWithSortKey:@"variableValue" sortAscending:YES filterPredicate:predicate];

                                variableValueObjectSelectionCell.selectionItemsFetchOptions = dataFetchOptions;

                                [variableValueObjectSelectionCell reloadBoundValue];
                            }
                        }
                    }
                }
            }

            UIView *viewOne = [cell viewWithTag:14];
            switch (cell.tag)
            {
                case 3:

                    if ([viewOne isKindOfClass:[UISlider class]])
                    {
                        UISlider *sliderOne = (UISlider *)viewOne;
                        UILabel *sOnelabel = (UILabel *)[cell viewWithTag:10];

                        sOnelabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
                    }

                    break;

                case 4:

                    if ([viewOne isKindOfClass:[UISlider class]])
                    {
                        UISlider *sliderTwo = (UISlider *)viewOne;
                        UILabel *sTwolabel = (UILabel *)[cell viewWithTag:10];

                        sTwolabel.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
                    }

                default:
                    break;
            } /* switch */
        }
    }
    else if (tableViewModel.tag == 3)
    {
        //begin

        NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;

        if (cell.tag == 0 && cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"DiagnosisHistoryEntity"] && [cell isKindOfClass:[SCObjectSelectionCell class]])
        {
            SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cell;

            if ([objectSelectionCell.selectedItemIndex intValue] > -1)
            {
                DisorderEntity *selectedDisorderManagedObject = (DisorderEntity *)[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];

                if (selectedDisorderManagedObject && [selectedDisorderManagedObject respondsToSelector:@selector(entity)] && [selectedDisorderManagedObject.entity.name isEqualToString:@"DisorderEntity"])
                {
                    selectedDisorder = (DisorderEntity *)selectedDisorderManagedObject;

                    SCTableViewCell *specifierCell = (SCTableViewCell *)[tableViewModel cellAfterCell:objectSelectionCell rewind:NO];

                    if ([specifierCell isKindOfClass:[SCObjectSelectionCell class]])
                    {
                        SCObjectSelectionCell *specifierObjectSelectionCell = (SCObjectSelectionCell *)specifierCell;

                        if (selectedDisorder.disorderName.length)
                        {
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                      @"disorder.disorderName like %@",[NSString stringWithString:(NSString *)selectedDisorder.disorderName]];

                            SCDataFetchOptions *dataFetchOptions = [SCDataFetchOptions optionsWithSortKey:@"specifier" sortAscending:YES filterPredicate:predicate];

                            specifierObjectSelectionCell.selectionItemsFetchOptions = dataFetchOptions;

                            [specifierObjectSelectionCell reloadBoundValue];
                        }
                    }
                }
            }
        }

        //end
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTableViewCell *cell = tableViewModel.activeCell;

    switch (tableViewModel.tag)
    {
        case 1:
        {
            UITextField *view = (UITextField *)[cell viewWithTag:3];

            [view becomeFirstResponder];
            [view resignFirstResponder];
        }
        break;
        case 3:
        {
            UIView *textViewView = (UIView *)[cell viewWithTag:80];
            if ([textViewView isKindOfClass:[UITextView class]])
            {
                UITextView *textView = (UITextView *)textViewView;
                [textView becomeFirstResponder];
                [textView resignFirstResponder];
            }
        }
        default:
            break;
    } /* switch */
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel
        willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTableViewSection *section = [tableViewModel sectionAtIndex:0];

    NSManagedObject *managedObject = (NSManagedObject *)cell.boundObject;

    switch (tableViewModel.tag)
    {
        case 1:
            if (cell.tag == 1)
            {
                if ([cell isKindOfClass:[SCDateCell class]])
                {
                    SCDateCell *dateCell = (SCDateCell *)cell;

                    if (dateCell.datePicker.date)
                    {
                        [self addWechlerAgeCellToSection:[tableViewModel sectionAtIndex:0]];
                    }
                }
            }

            break;

        case 2:
        {
            //identify the if the cell has a managedObject
            if (managedObject && [managedObject respondsToSelector:@selector(entity)])
            {
                //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
                if (![section isKindOfClass:[SCArrayOfStringsSection class]])
                {
                    //identify the Languages Spoken table
                    if ([managedObject.entity.name isEqualToString:@"LogEntity"])
                    {
                        //define and initialize a date formatter
                        NSDateFormatter *dateTimeDateFormatter = [[NSDateFormatter alloc] init];

                        //set the date format
                        [dateTimeDateFormatter setDateFormat:@"ccc M/d/yy h:mm a"];

                        NSDate *logDate = [managedObject valueForKey:@"dateTime"];
                        NSString *notes = [managedObject valueForKey:@"notes"];

                        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@",[dateTimeDateFormatter stringFromDate:logDate],notes];
                        dateTimeDateFormatter = nil;
                        return;
                    }
                    else if ([managedObject.entity.name isEqualToString:@"SubstanceUseEntity"])
                    {
                        NSNumber *currentTreatmentIssue = [managedObject valueForKey:@"currentTreatmentIssue"];
                        BOOL currentTreatmentIssueBool = currentTreatmentIssue ? [currentTreatmentIssue boolValue] : NO;

                        if (currentTreatmentIssueBool)
                        {
                            cell.textLabel.textColor = [UIColor redColor];
                        }
                        else
                        {
                            cell.textLabel.textColor = [UIColor blackColor];
                        }

                        return;
                    }
                    else if ([managedObject.entity.name isEqualToString:@"MedicationEntity"])
                    {
                        //define and initialize a date formatter
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

                        //set the date format
                        [dateFormatter setDateFormat:@"M/d/yyyy"];

                        NSDate *startedDate = [managedObject valueForKey:@"dateStarted"];
                        NSDate *discontinued = [managedObject valueForKey:@"discontinued"];
                        NSString *drugName = [managedObject valueForKey:@"drugName"];
                        //                        NSString *notes=[managedObject valueForKey:@"notes"];

                        NSString *labelString = [NSString string];
                        if (drugName.length)
                        {
                            labelString = drugName;
                        }

                        if (startedDate)
                        {
                            NSString *startedDateStr = [dateFormatter stringFromDate:startedDate];
                            if (labelString.length && startedDateStr.length)
                            {
                                labelString = [labelString stringByAppendingFormat:@"; started: %@",startedDateStr];
                            }
                        }

                        if (discontinued)
                        {
                            NSString *discontinueddDateStr = [dateFormatter stringFromDate:discontinued];
                            if (labelString.length && discontinueddDateStr.length)
                            {
                                labelString = [labelString stringByAppendingFormat:@"; discontinued: %@",discontinueddDateStr];
                            }
                        }
                        else
                        {
                            cell.textLabel.textColor = [UIColor blueColor];
                        }

                        cell.textLabel.text = labelString;
                        dateFormatter = nil;
                        return;
                    }
                    else if ([managedObject.entity.name isEqualToString:@"VitalsEntity"])
                    {
                        NSDate *dateTaken = (NSDate *)[cell.boundObject valueForKey:@"dateTaken"];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];

                        [dateFormatter setDateFormat:@"ccc M/d/yy h:mm a"];

                        NSString *dateTakenStr = [dateFormatter stringFromDate:dateTaken];
                        NSNumber *systolic = [cell.boundObject valueForKey:@"systolicPressure"];
                        NSNumber *diastolic = [cell.boundObject valueForKey:@"diastolicPressure"];
                        NSNumber *heartRate = [cell.boundObject valueForKey:@"heartRate"];
                        NSNumber *temperature = [cell.boundObject valueForKey:@"temperature"];

                        NSString *labelText = [NSString string];
                        if (dateTakenStr.length && systolic && diastolic)
                        {
                            labelText = [dateTakenStr stringByAppendingFormat:@": %@/%@",[systolic stringValue],[diastolic stringValue]];
                        }
                        else if (dateTakenStr.length)
                        {
                            labelText = dateTakenStr;
                        }

                        if (labelText.length && heartRate)
                        {
                            labelText = [labelText stringByAppendingFormat:@"; %@ bpm",[heartRate stringValue]];
                        }

                        if (labelText.length && temperature)
                        {
                            labelText = [labelText stringByAppendingFormat:@"; %@\u00B0",[temperature stringValue]];
                        }

                        cell.textLabel.text = labelText;
                        //change the text color to red
                        dateFormatter = nil;
                        return;
                    }
                    else if ([managedObject.entity.name isEqualToString:@"DiagnosisHistoryEntity"])
                    {
                        NSString *axisStr = [managedObject valueForKey:@"axis"];
                        NSString *disorderName = [managedObject valueForKeyPath:@"disorder.disorderName"];
                        NSMutableSet *specifiersSet = [managedObject mutableSetValueForKeyPath:@"specifiers.specifier"];
                        NSDate *dateEnded = [managedObject valueForKey:@"dateEnded"];
                        NSNumber *primary = [managedObject valueForKey:@"primary"];
                        NSString *classificationSystem = [managedObject valueForKeyPath:@"disorder.classificationSystem.abbreviatedName"];

                        BOOL primaryBool = primary ? (BOOL)[primary boolValue] : NO;

                        NSString *specifiersStr = nil;
                        for (NSString *specifier in specifiersSet)
                        {
                            specifiersStr = specifiersStr ? [specifiersStr stringByAppendingFormat:@", %@",specifier] : specifier;
                        }

                        NSString *labelText = axisStr && axisStr.length ? axisStr : nil;

                        if (dateEnded)
                        {
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

                            //set the date format
                            [dateFormatter setDateFormat:@"M/d/yyyy"];
                            [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];

                            if (labelText && labelText.length)
                            {
                                labelText = [labelText stringByAppendingFormat:@" (Ended %@)",[dateFormatter stringFromDate:dateEnded]];
                            }
                            else
                            {
                                labelText = [dateFormatter stringFromDate:dateEnded];
                            }

                            cell.textLabel.textColor = [UIColor blackColor];
                            dateFormatter = nil;
                        }
                        else
                        {
                            if (primaryBool)
                            {
                                cell.textLabel.textColor = [UIColor redColor];
                            }
                            else
                            {
                                cell.textLabel.textColor = [UIColor blueColor];
                            }
                        }

                        if (classificationSystem && classificationSystem.length )
                        {
                            if (labelText && labelText.length)
                            {
                                labelText = [labelText stringByAppendingFormat:@" %@", classificationSystem];
                            }
                            else
                            {
                                labelText = classificationSystem;
                            }
                        }

                        if (disorderName && disorderName.length )
                        {
                            if (labelText && labelText.length)
                            {
                                labelText = [labelText stringByAppendingFormat:@" %@", disorderName];
                            }
                            else
                            {
                                labelText = disorderName;
                            }
                        }

                        if (specifiersStr && specifiersStr.length )
                        {
                            if (labelText && labelText.length)
                            {
                                labelText = [labelText stringByAppendingFormat:@", %@", specifiersStr];
                            }
                            else
                            {
                                labelText = specifiersStr;
                            }
                        }

                        cell.textLabel.text = labelText;
                        //change the text color to red

                        return;
                    }
                }
            }
        }
        break;

        case 3:
            //this is a third level table

            //identify the if the cell has a managedObject
            if (managedObject && [managedObject respondsToSelector:@selector(entity)])
            {
                //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
                if (![section isKindOfClass:[SCArrayOfStringsSection class]])
                {
                    //identify the Languages Spoken table
                    if ([managedObject.entity.name isEqualToString:@"LanguageSpokenEntity"])
                    {
                        //get the value of the primaryLangugage attribute
                        NSNumber *primaryLanguageNumber = (NSNumber *)[managedObject valueForKey:@"primaryLanguage"];

                        //if the primaryLanguage selection is Yes
                        if (primaryLanguageNumber == [NSNumber numberWithInteger:0])
                        {
                            //get the language
                            NSString *languageString = cell.textLabel.text;
                            //add (Primary) after the language
                            languageString = [languageString stringByAppendingString:@" (Primary)"];
                            //set the cell textlable text to the languageString -the language with (Primary) after it
                            cell.textLabel.text = languageString;
                            //change the text color to red
                            cell.textLabel.textColor = [UIColor redColor];
                        }

                        return;
                    }

                    if ([managedObject.entity.name isEqualToString:@"MigrationHistoryEntity"])
                    {
                        NSDate *arrivedDate = (NSDate *)[cell.boundObject valueForKey:@"arrivedDate"];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];

                        [dateFormatter setDateFormat:@"M/yyyy"];

                        NSString *arrivedDateStr = [dateFormatter stringFromDate:arrivedDate];
                        NSString *migratedFrom = [cell.boundObject valueForKey:@"migratedFrom"];
                        NSString *migratedTo = [cell.boundObject valueForKey:@"migratedTo"];
                        NSString *notes = [cell.boundObject valueForKey:@"notes"];

                        if (arrivedDateStr.length && migratedFrom.length && migratedTo.length)
                        {
                            NSString *historyString = [arrivedDateStr stringByAppendingFormat:@":%@ to %@",migratedFrom,migratedTo];

                            if (notes.length)
                            {
                                historyString = [historyString stringByAppendingFormat:@"; %@",notes];
                            }

                            cell.textLabel.text = historyString;
                            //change the text color to red
                            dateFormatter = nil;
                        }

                        return;
                    }
                }
            }

            break;

        case 4:
            //this is a fourth level detail view
            if (managedObject && [managedObject respondsToSelector:@selector(entity)])
            {
                if ([managedObject.entity.name isEqualToString:@"MedicationEntity"])
                {
                    //define and initialize a date formatter
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

                    //set the date format
                    [dateFormatter setDateFormat:@"M/d/yyyy"];
                    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];

                    NSDate *startedDate = [managedObject valueForKey:@"dateStarted"];
                    NSDate *discontinued = [managedObject valueForKey:@"discontinued"];
                    NSString *drugName = [managedObject valueForKey:@"drugName"];
                    //                        NSString *notes=[managedObject valueForKey:@"notes"];

                    NSString *labelString = [NSString string];
                    if (drugName.length)
                    {
                        labelString = drugName;
                    }

                    if (startedDate)
                    {
                        NSString *startedDateStr = [dateFormatter stringFromDate:startedDate];
                        if (labelString.length && startedDateStr.length)
                        {
                            labelString = [labelString stringByAppendingFormat:@"; started: %@",startedDateStr];
                        }
                    }

                    if (discontinued)
                    {
                        NSString *discontinueddDateStr = [dateFormatter stringFromDate:discontinued];
                        if (labelString.length && discontinueddDateStr.length)
                        {
                            labelString = [labelString stringByAppendingFormat:@"; discontinued: %@",discontinueddDateStr];
                        }
                    }
                    else
                    {
                        cell.textLabel.textColor = [UIColor blueColor];
                    }

                    cell.textLabel.text = labelString;
                    dateFormatter = nil;
                    return;
                }
                else if ([managedObject.entity.name isEqualToString:@"DiagnosisLogEntity"])
                {
                    NSDate *logDate = [managedObject valueForKey:@"logDate"];
                    NSSet *symptoms = [managedObject mutableSetValueForKeyPath:@"symptoms.symptomName"];

                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    NSString *logDateStr = nil;
                    if (logDate)
                    {
                        [dateFormatter setDateFormat:@"M/d/yyyy"];
                        [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
                        logDateStr = [dateFormatter stringFromDate:logDate];
                    }

                    NSString *symptomNamesStr = nil;
                    for (NSString *symptomName in symptoms)
                    {
                        symptomNamesStr = symptomNamesStr ? [symptomNamesStr stringByAppendingFormat:@", %@",symptomName] : symptomName;
                    }

                    cell.textLabel.text = logDateStr && symptomNamesStr ? [logDateStr stringByAppendingFormat:@": %@",symptomNamesStr] : logDateStr;

                    dateFormatter = nil;
                }
                else if ([managedObject.entity.name isEqualToString:@"SubstanceUseLogEntity"])
                {
                    NSDate *logDate = [managedObject valueForKey:@"logDate"];
                    NSNumber *numberOfTimes = [managedObject valueForKey:@"timesUsedInLastThirtyDays"];

                    NSString *notes = [managedObject valueForKey:@"notes"];

                    NSString *displayStr = nil;
                    if (logDate)
                    {
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

                        [dateFormatter setDateFormat:@"M/d/yyyy"];
                        [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
                        displayStr = [dateFormatter stringFromDate:logDate];

                        dateFormatter = nil;
                    }

                    if (numberOfTimes)
                    {
                        if (displayStr && displayStr.length)
                        {
                            displayStr = [displayStr stringByAppendingFormat:@" (%@ times in past 30 days)",numberOfTimes];
                        }
                        else
                        {
                            displayStr = [NSString stringWithFormat:@"%@",numberOfTimes];
                        }
                    }

                    if (notes)
                    {
                        if (displayStr && displayStr.length)
                        {
                            displayStr = [displayStr stringByAppendingFormat:@"; %@ ",notes];
                        }
                        else
                        {
                            displayStr = [NSString stringWithFormat:@"%@",notes];
                        }
                    }

                    cell.textLabel.text = displayStr;

                    return;
                }

                if ([managedObject.entity.name isEqualToString:@"MedicationReviewEntity"])
                {
                    //define and initialize a date formatter
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

                    //set the date format
                    [dateFormatter setDateFormat:@"M/d/yy"];

                    NSInteger doseChange = (NSInteger)[(NSNumber *)[cell.boundObject valueForKey:@"doseChange"] integerValue];

                    NSString *doseChangeString;
                    switch (doseChange)
                    {
                        case 0:
                            doseChangeString = @"No Change";
                            break;
                        case 1:
                            doseChangeString = @"Decrease to";
                            break;
                        case 2:
                            doseChangeString = @"Increase to";
                            break;

                        default:
                            break;
                    }

                    NSString *notes = (NSString *)[cell.boundObject valueForKey:@"notes"];
                    NSDate *logDate = (NSDate *)[cell.boundObject valueForKey:@"logDate"];
                    NSString *dosage = (NSString *)[cell.boundObject valueForKey:@"dosage"];
                    if (doseChangeString && doseChangeString.length)
                    {
                        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@ %@",[dateFormatter stringFromDate:logDate],doseChangeString,dosage];
                    }
                    else
                    {
                        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@",[dateFormatter stringFromDate:logDate],dosage];
                    }

                    if (notes && notes.length)
                    {
                        cell.textLabel.text = [cell.textLabel.text stringByAppendingFormat:@", %@",notes];
                    }

                    dateFormatter = nil;
                }

                if (cell.tag == 3)
                {
                    UIView *viewOne = [cell viewWithTag:14];

                    if ([viewOne isKindOfClass:[UISlider class]])
                    {
                        UISlider *sliderOne = (UISlider *)viewOne;
                        UILabel *slabel = (UILabel *)[cell viewWithTag:10];

                        slabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];

                        return;
                    }
                }

                if (cell.tag == 4)
                {
                    UIView *viewTwo = [cell viewWithTag:14];
                    if ([viewTwo isKindOfClass:[UISlider class]])
                    {
                        UISlider *sliderTwo = (UISlider *)viewTwo;
                        UILabel *slabelTwo = (UILabel *)[cell viewWithTag:10];

                        slabelTwo.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
                    }
                }

                //identify the if the cell has a managedObject

                return;
            }

            break;
        case 5:

        {
            if (managedObject && [managedObject respondsToSelector:@selector(entity)])
            {
                if ([managedObject.entity.name isEqualToString:@"DiagnosisLogEntity"] && cell.tag == 6 && [cell viewWithTag:70])
                {
                    UIView *scaleView = [cell viewWithTag:70];
                    if ([scaleView isKindOfClass:[UISegmentedControl class]])
                    {
                        UILabel *fluencyLevelLabel = (UILabel *)[cell viewWithTag:71];
                        fluencyLevelLabel.text = @"Severity Level:";
                        break;
                    }

                    break;
                }
            }

            return;
        }
        break;
        case 6:
        {
            if (managedObject && [managedObject respondsToSelector:@selector(entity)])
            {
                if ([managedObject.entity.name isEqualToString:@"MedicationReviewEntity"])
                {
                    //define and initialize a date formatter
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

                    //set the date format
                    [dateFormatter setDateFormat:@"M/d/yy"];

                    NSInteger doseChange = (NSInteger)[(NSNumber *)[cell.boundObject valueForKey:@"doseChange"] integerValue];

                    NSString *doseChangeString;
                    switch (doseChange)
                    {
                        case 0:
                            doseChangeString = @"No Change";
                            break;
                        case 1:
                            doseChangeString = @"Decrease to";
                            break;
                        case 2:
                            doseChangeString = @"Increase to";
                            break;

                        default:
                            break;
                    }

                    NSString *notes = (NSString *)[cell.boundObject valueForKey:@"notes"];
                    NSDate *logDate = (NSDate *)[cell.boundObject valueForKey:@"logDate"];
                    NSString *dosage = (NSString *)[cell.boundObject valueForKey:@"dosage"];
                    if (doseChangeString && doseChangeString.length)
                    {
                        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@ %@",[dateFormatter stringFromDate:logDate],doseChangeString,dosage];
                    }
                    else
                    {
                        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@",[dateFormatter stringFromDate:logDate],dosage];
                    }

                    if (notes && notes.length)
                    {
                        cell.textLabel.text = [cell.textLabel.text stringByAppendingFormat:@", %@",notes];
                    }

                    dateFormatter = nil;
                }
            }
        }
        break;
        default:
            break;
    } /* switch */
}


- (void)                        tableViewModel:(SCArrayOfItemsModel *)tableViewModel
    searchBarSelectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self createSelectedClientsArray];

    if ([tableViewModel isKindOfClass:[SCArrayOfObjectsModel class]])
    {
        if (objectsModel.sectionCount > 0)
        {
            SCTableViewSection *section = (SCTableViewSection *)[tableViewModel sectionAtIndex:0];

            if ([section isKindOfClass:[SCObjectSelectionSection class]])
            {
                SCObjectSelectionSection *objectSelectionSection = (SCObjectSelectionSection *)section;

                SCTableViewCell *cell = (SCTableViewCell *)[objectsModel cellAtIndexPath:objectSelectionSection.selectedCellIndexPath];

                currentlySelectedClient = (ClientEntity *)cell.boundObject;
            }
        }

        SCDataFetchOptions *dataFetchOptions = (SCDataFetchOptions *)objectsModel.dataFetchOptions;
        [self.searchBar setSelectedScopeButtonIndex:selectedScope];

        switch (selectedScope)
        {
            case 0: //current
                dataFetchOptions.filterPredicate = [NSPredicate predicateWithFormat:@"currentClient == %@",[NSNumber numberWithInteger:0]];

                break;

            default:
                dataFetchOptions.filterPredicate = nil;

                break;
        }

        [objectsModel reloadBoundValues];

        [objectsModel.modeledTableView reloadData];

        [self updateClientsTotalLabel];
        [self setSelectedClients];
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];

    if (isInDetailSubview && tableViewModel.tag == 0 && [section isKindOfClass:[SCObjectSelectionSection class]])
    {
        SCObjectSelectionSection *objectSelectionSection = (SCObjectSelectionSection *)section;

        objectSelectionSection.allowMultipleSelection = allowMultipleSelection;
    }

    if ( tableViewModel.tag == 1 && index == 0 && section.cellCount > 3)
    {
        [section insertCell:[SCLabelCell cellWithText:@"Age"] atIndex:2];
        [section insertCell:[SCLabelCell cellWithText:@"Age (30-Day Months)"] atIndex:3];
    }

    if (tableViewModel.tag == 3 && index == 0)
    {
        if (section.cellCount > 1)
        {
            SCTableViewCell *cellOne = (SCTableViewCell *)[section cellAtIndex:1];

            NSManagedObject *cellOneBoundObject = (NSManagedObject *)cellOne.boundObject;

            if (cellOneBoundObject && [cellOneBoundObject respondsToSelector:@selector(entity)] && [cellOneBoundObject.entity.name isEqualToString:@"MedicationEntity"])
            {
                section.footerTitle = @"Select the drug then add the current dosage in the Med Logs section.";
            }
        }
    }

    if (section.footerTitle != nil)
    {
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 100)];
        footerLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        footerLabel.numberOfLines = 6;
        footerLabel.lineBreakMode = UILineBreakModeWordWrap;
        footerLabel.backgroundColor = [UIColor clearColor];
        footerLabel.textColor = [UIColor whiteColor];
        footerLabel.tag = 60;
        footerLabel.text = section.footerTitle;
        footerLabel.textAlignment = UITextAlignmentCenter;
        section.footerHeight = (CGFloat)100;
        [containerView addSubview:footerLabel];
        //        [footerLabel sizeToFit];
        section.footerView = containerView;
    }

    if (section.headerTitle != nil)
    {
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];

        headerLabel.text = section.headerTitle;
        headerLabel.textColor = [UIColor whiteColor];

        headerLabel.backgroundColor = [UIColor clearColor];

        [containerView addSubview:headerLabel];
        section.headerView = containerView;
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didRemoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableViewModel.tag == 0)
    {
        [self updateClientsTotalLabel];
    }
}


- (void) updateClientsTotalLabel
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
                    cellCount = arrayOfObjectsSection.items.count;
                }
                else
                {
                    cellCount = cellCount + section.cellCount;
                }
            }
        }

        if (cellCount == 0)
        {
            self.totalClientsLabel.text = @"Tap + To Add Clients";
        }
        else
        {
            self.totalClientsLabel.text = [NSString stringWithFormat:@"Total Clients: %i", cellCount];
        }
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didInsertRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableViewModel.tag == 0)
    {
        [self updateClientsTotalLabel];
        if (isInDetailSubview)
        {
            SCTableViewCell *cell = (SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
            NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;
            NSMutableArray *mutableArray = (NSMutableArray *)[NSMutableArray arrayWithArray:clientObjectSelectionCell.items];
            [mutableArray addObject:cellManagedObject];

            //                clientObjectSelectionCell.items=mutableArray;
        }
    }
}


- (void) addWechlerAgeCellToSection:(SCTableViewSection *)section
{
    if (section.cellCount > 3)
    {
        SCLabelCell *actualAgeCell = (SCLabelCell *)[section cellAtIndex:2];
        SCLabelCell *wechslerAgeCell = (SCLabelCell *)[section cellAtIndex:3];
        SCDateCell *birthdateCell = (SCDateCell *)[section cellAtIndex:1];

        actualAgeCell.label.text = [clientsViewController_Shared calculateActualAgeWithBirthdate:birthdateCell.datePicker.date];
        wechslerAgeCell.label.text = [clientsViewController_Shared calculateWechslerAgeWithBirthdate:birthdateCell.datePicker.date];
    }
}


@end
