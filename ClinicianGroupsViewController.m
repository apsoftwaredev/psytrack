/*
 *  ClinicianGroupsViewController.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.3
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 2/1/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ClinicianGroupsViewController.h"
#import "PTTAppDelegate.h"
#import "MySource.h"
#import "ClinicianEntity.h"
#import "CliniciansRootViewController_iPad.h"
#import "ClinicianViewController.h"
#import "ABSourcesSCObjectSelectionCell.h"
#import "ClientGroupEntity.h"
#import "PTABGroup.h"

@implementation ClinicianGroupsViewController
@synthesize eventsList,eventStore,eventViewController,psyTrackCalendar,rootNavController;

#pragma mark -
#pragma mark LifeCycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad || [SCUtilities systemVersion] >= 6)
    {
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    }

    @try
    {
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];

        SCEntityDefinition *clinicianGroupDef = [SCEntityDefinition definitionWithEntityName:@"ClinicianGroupEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"groupName",@"addressBookSync",@"addNewClinicians", nil]];

        objectsModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView entityDefinition:clinicianGroupDef ];
        if ([SCUtilities systemVersion] < 6)
        {
            SCCustomPropertyDefinition *groupNameUpdateCProperty = [SCCustomPropertyDefinition definitionWithName:@"addressBookButtonCell" uiElementNibName:@"ABGroupNameChangeCell" objectBindings:nil];

            //add the property definition to the clinician class
            [clinicianGroupDef addPropertyDefinition:groupNameUpdateCProperty];
        }

        SCPropertyGroup *mainGroup = [SCPropertyGroup groupWithHeaderTitle:@"Clinician Group Details" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"groupName",@"addressBookSync",@"addNewClinicians",@"addressBookButtonCell", nil]];

        [clinicianGroupDef.propertyGroups addGroup:mainGroup];

        objectsModel.editButtonItem = self.navigationItem.rightBarButtonItem;
        //        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
        //        self.navigationItem.rightBarButtonItem = addButton;

        self.navigationBarType = SCNavigationBarTypeAddEditRight;

        objectsModel.editButtonItem = self.editButton;

        objectsModel.addButtonItem = self.addButton;

        objectsModel.dataFetchOptions = [SCDataFetchOptions optionsWithSortKey:@"groupName" sortAscending:YES filterPredicate:nil];
        objectsModel.addButtonItem = self.navigationItem.rightBarButtonItem;

        objectsModel.allowAddingItems = YES;
        objectsModel.allowDeletingItems = YES;
        objectsModel.allowEditDetailView = YES;
        objectsModel.allowRowSelection = YES;

        objectsModel.addButtonItem = self.navigationItem.rightBarButtonItem;
        //create a custom property definition for the addressbook button cell

        UIViewController *navtitle = self.navigationController.topViewController;

        navtitle.title = @"Client Groups";

        objectsModel.autoAssignDataSourceForDetailModels = YES;
        objectsModel.autoAssignDelegateForDetailModels = YES;
        self.tableViewModel = objectsModel;

//        if (addressBook) {
//            CFRelease(addressBook);
//        }
    }
    @catch (NSException *exception)
    {
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        [appDelegate displayNotification:@"Problem Connecting to the Address Book Occured" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
    }

    @finally
    {
    }
}


- (void) viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

    self.eventStore = nil;
    self.psyTrackCalendar = nil;
    self.eventsList = nil;
    self.eventViewController = nil;

    _valuesDictionary = nil;
    objectsModel = nil;

    dictionaryABGroupIdentifierValueForArrayOfStringsIndexKey = nil;
    dictionaryArrayOfStringsIndexForGroupIdentifierKey = nil;
    groupArray = nil;
//    CFRelease(addressBook);
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


//#pragma mark -
//#pragma mark calander settings
//
//// Set the calendar edited by EKEventEditViewController to our chosen calendar - the default calendar.
//- (EKCalendar *) defaultCalendarName
//{
//    // Get the default calendar from store.
//    //    settingsDictionary=(NSDictionary *)[(PTTAppDelegate *)[UIApplication sharedApplication].delegate settingsPlistDictionary];
//    NSString *defaultCalendarIdentifier = [[NSUserDefaults standardUserDefaults] valueForKey:@"defaultCalendarIdentifier"];
//
//    // find local source
//    EKSource *mySource = nil;
//
////    BOOL iCloudEnabled=(BOOL)[[NSUserDefaults standardUserDefaults] valueForKey:@"icloud_preference"];
//
//    for (EKSource *sourceInSources in eventStore.sources)
//    {
//        if ([sourceInSources.title isEqualToString:@"iCloud"])
//        {
//            mySource = sourceInSources;
////
//
//            break;
//        }
//    }
//
//    if (!mySource)
//    {
//        for (EKSource *sourceInSources in eventStore.sources)
//        {
//            if (sourceInSources.sourceType == EKSourceTypeLocal)
//            {
//                mySource = sourceInSources;
//
//                break;
//            }
//        }
//    }
//
//    if (mySource)
//    {
//        NSString *defaultCalendarName = [[NSUserDefaults standardUserDefaults] valueForKey:@"calendar_name"];
//        //        NSSet *calendars=(NSSet *)[localSource calendars];
//        if (defaultCalendarIdentifier.length)
//        {
//            self.psyTrackCalendar = [self.eventStore calendarWithIdentifier:defaultCalendarIdentifier];
//            mySource = psyTrackCalendar.source;
//        }
//
//        if (!self.psyTrackCalendar)
//        {
//            for (EKCalendar *calanderInStore in eventStore.calendars)
//            {
//                if ([calanderInStore.title isEqualToString:@"Client Appointments"])
//                {
//                    self.psyTrackCalendar = calanderInStore;
//                    break;
//                }
//            }
//
//            //try again
//            if (!self.psyTrackCalendar)
//            {
//                self.psyTrackCalendar = [EKCalendar calendarWithEventStore:self.eventStore];
//
//                [[NSUserDefaults standardUserDefaults] setValue:psyTrackCalendar.calendarIdentifier forKey:@"defaultCalendarIdentifier"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                self.psyTrackCalendar.source = mySource;
//            }
//        }
//
//        if (defaultCalendarName.length)
//        {
//            self.psyTrackCalendar.title = defaultCalendarName;
//        }
//        else
//        {
//            self.psyTrackCalendar.title = @"Client Appointments";
//        }
//    }
//
//    NSError *error;
//
//    if (![self.eventStore saveCalendar:self.psyTrackCalendar commit:YES error:&error ])
//    {
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults]setValue:psyTrackCalendar.calendarIdentifier forKey:@"defaultCalendarIdentifier"];
//    }
//
//    if (self.psyTrackCalendar)
//    {
//    }
//
//    return self.psyTrackCalendar;
//}
//

#pragma mark -
#pragma mark EKCalendarChooserDelegate methods

- (void) calendarChooserDidCancel:(EKCalendarChooser *)calendarChooser
{
    [calendarChooser dismissViewControllerAnimated:YES completion:nil];
}


- (void) calendarChooserSelectionDidChange:(EKCalendarChooser *)calendarChooser
{
    NSArray *calendarArray = [calendarChooser.selectedCalendars allObjects];
    if (calendarArray.count > 0)
    {
        self.psyTrackCalendar = (EKCalendar *)[calendarArray objectAtIndex:0];
        NSString *calendarName = (NSString *)[self.psyTrackCalendar title];
        NSString *calenderIdentifier = self.psyTrackCalendar.calendarIdentifier;
        [[NSUserDefaults standardUserDefaults] setValue:calenderIdentifier forKey:@"defaultCalendarIdentifier"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        if (objectsModel.sectionCount)
        {
            SCTableViewSection *section = (SCTableViewSection *)[objectsModel sectionAtIndex:0];
            if (section.cellCount > 1)
            {
                SCTableViewCell *firstCell = (SCTableViewCell *)[section cellAtIndex:0];
                SCTableViewCell *secondCell = (SCTableViewCell *)[section cellAtIndex:1];

                if ([firstCell isKindOfClass:[SCLabelCell class]])
                {
                    SCLabelCell *calenderLabelCell = (SCLabelCell *)firstCell;
                    [calenderLabelCell.label setText:calendarName];
                }

                if ([secondCell isKindOfClass:[SCTextFieldCell class]])
                {
                    SCTextFieldCell *calenderNameTextFieldCell = (SCTextFieldCell *)secondCell;
                    [calenderNameTextFieldCell.textField setText:calendarName];
                }
            }
        }
    }

    [calendarChooser dismissViewControllerAnimated:YES completion:nil];
}


- (NSArray *) fetchArrayOfAddressBookSources
{
    NSMutableArray *list = [NSMutableArray array];
    if ( [[[UIDevice currentDevice] systemVersion] intValue] < 6  )
    {
        ABAddressBookRef addressBookToGetAddressBookSources = ABAddressBookCreate();
        // Get all the sources from the address book
        CFArrayRef allSources = ABAddressBookCopyArrayOfAllSources(addressBookToGetAddressBookSources);

        for (CFIndex i = 0; i < CFArrayGetCount(allSources); i++)
        {
            ABRecordRef aSource = CFArrayGetValueAtIndex(allSources,i);

            // Fetch all groups included in the current source
            CFArrayRef result = nil;
            result = ABAddressBookCopyArrayOfAllGroupsInSource(addressBookToGetAddressBookSources, aSource);

            // The app displays a source if and only if it contains groups
            if (CFArrayGetCount(result) > 0)
            {
                NSMutableArray *groups = [[NSMutableArray alloc] initWithArray:(__bridge NSArray *)result];

                // Fetch the source name
                NSString *sourceName = [self nameForSource:aSource];

                //fetch source record ID
                int sourceRecordID = [self recordIDForSource:aSource];

                //Create a MySource object that contains the source name and all its groups
                MySource *sourceFound = [[MySource alloc] initWithAllGroups:groups name:sourceName recordID:sourceRecordID];

                // Save the source object into the array
                [list addObject:sourceFound];

                if (result)
                {
                    CFRelease(result);
                }
            }
            else
            {
                if (result)
                {
                    CFRelease(result);
                }
            }
        }

        if (allSources)
        {
            CFRelease(allSources);
        }

        if (addressBookToGetAddressBookSources)
        {
            CFRelease(addressBookToGetAddressBookSources);
        }
    }

    return list;
}


- (NSNumber *) defaultABSourceInSourceArray:(NSArray *)sourceArray
{
    BOOL iCloudEnabled = (BOOL)[[NSUserDefaults standardUserDefaults] valueForKey : @"icloud_preference"];

    NSNumber *sourceIndex = [NSNumber numberWithInt:-1];

    if (sourceArray.count == 1)
    {
        sourceIndex = [NSNumber numberWithInt:0];
        return sourceIndex;
    }

    int recordID = (int)[(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookSourceIdentifier]
                         intValue];

    if (recordID != -1)
    {
        for (MySource *sourceInArray in sourceArray)
        {
            if (sourceInArray.sourceRecordID == recordID)
            {
                sourceIndex = (NSNumber *)[NSNumber numberWithInt:[sourceArray indexOfObject:sourceInArray]];

                //
                return sourceIndex;
                break;
            }
        }
    }

    if (sourceArray.count && iCloudEnabled)
    {
//

        for (MySource *sourceInArray in sourceArray)
        {
            if ([sourceInArray.name isEqualToString:@"iCloud"])
            {
                sourceIndex = (NSNumber *)[NSNumber numberWithInt:[sourceArray indexOfObject:sourceInArray]];

                //

                return sourceIndex;
                break;
            }
        }
    }

    if (sourceArray.count > 1)
    {
        return [NSNumber numberWithInt:0];
    }

    return sourceIndex;
}


// Return the name associated with the given identifier
- (NSString *) nameForSourceWithIdentifier:(int)identifier
{
    switch (identifier)
    {
        case kABSourceTypeLocal:
            return @"On My Device";
            break;
        case kABSourceTypeExchange:
            return @"Exchange server";
            break;
        case kABSourceTypeExchangeGAL:
            return @"Exchange Global Address List";
            break;
        case kABSourceTypeMobileMe:
            return @"Moblile Me";
            break;
        case kABSourceTypeLDAP:
            return @"LDAP server";
            break;
        case kABSourceTypeCardDAV:
            return @"CardDAV server";
            break;
        case kABSourceTypeCardDAVSearch:
            return @"Searchable CardDAV server";
            break;
        default:
            break;
    } /* switch */

    return nil;
}


// Return the name of a given source
- (NSString *) nameForSource:(ABRecordRef)desiredSource
{
    // Fetch the source type
    CFNumberRef sourceType = ABRecordCopyValue(desiredSource, kABSourceTypeProperty);

    // Fetch the name associated with the source type
    NSString *sourceName = [self nameForSourceWithIdentifier:[(__bridge NSNumber *)sourceType intValue]];
    CFStringRef sourceNameProperty = ABRecordCopyValue(desiredSource, kABSourceNameProperty);
    if ( sourceNameProperty && CFStringGetLength(sourceNameProperty) )
    {
        sourceName = [sourceName stringByAppendingFormat:@"(%@)",(__bridge NSString *)sourceNameProperty];
    }

    if (sourceNameProperty)
    {
        CFRelease(sourceNameProperty);
    }

    CFRelease(sourceType);
    return sourceName;
}


// Return the name of a given source
- (int) recordIDForSource:(ABRecordRef)sourceToCheck
{
    // Fetch the source type
    int sourceRecordID = ABRecordGetRecordID(sourceToCheck);

    // Fetch the name associated with the source type

    return sourceRecordID;
}


#pragma mark -
#pragma mark configuring cells and sections

- (void) tableViewModel:(SCTableViewModel *)tableViewModel didLayoutSubviewsForCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[SCSwitchCell class]])
    {
//        CGRect frame = cell.textLabel.frame;
        [cell.textLabel sizeToFit];
//        cell.textLabel.frame = frame;
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];

    if (section.headerTitle != nil)
    {
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];

        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.tag = 60;
        headerLabel.text = section.headerTitle;
        [containerView addSubview:headerLabel];

        section.headerView = containerView;
    }

    if (section.footerTitle != nil)
    {
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 100)];
        footerLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        footerLabel.numberOfLines = 6;
        footerLabel.lineBreakMode = NSLineBreakByWordWrapping;
        footerLabel.backgroundColor = [UIColor clearColor];
        footerLabel.textColor = [UIColor whiteColor];
        footerLabel.tag = 60;
        footerLabel.text = section.footerTitle;
        footerLabel.textAlignment = NSTextAlignmentCenter;
        section.footerHeight = (CGFloat)100;
        [containerView addSubview:footerLabel];
//        [footerLabel sizeToFit];
        section.footerView = containerView;
    }
}


#pragma mark -
#pragma mark SCTableViewModelDelegate methods

- (void) tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    if (tableViewModel.tag == 0)
    {
        SCTableViewCell *cell = (SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];

        if (cell.tag == 3 && [cell isKindOfClass:[SCObjectSelectionCell class]])
        {
            UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(abSourcesDoneButtonTapped:)];

            detailTableViewModel.viewController.navigationItem.rightBarButtonItem = doneButton;
            detailTableViewModel.tag = 429;

            currentDetailTableViewModel_ = detailTableViewModel;
        }
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
    {
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        UIColor *backgroundColor = nil;

        if (indexPath.row == NSNotFound || tableModel.tag > 0)
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
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel customButtonTapped:(UIButton *)button forRowWithIndexPath:(NSIndexPath *)indexPath
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    if ([SCUtilities systemVersion] < 6)
    {
        switch (button.tag)
        {
            case 301:
            {
                SCTableViewSection *section = [tableViewModel sectionAtIndex:indexPath.section];
                NSString *groupNameTo = nil;
                NSString *groupNameFrom = nil;

                if ([section isKindOfClass:[SCObjectSection class]])
                {
                    SCObjectSection *objectSection = (SCObjectSection *)section;

                    NSManagedObject *sectionManagedObject = (NSManagedObject *)section.boundObject;

                    if (sectionManagedObject && [sectionManagedObject respondsToSelector:@selector(entity)] && [sectionManagedObject.entity.name isEqualToString:@"ClinicianGroupEntity"])
                    {
                        ClientGroupEntity *clientGroup = (ClientGroupEntity *)sectionManagedObject;
                        if (clientGroup.groupName && clientGroup.groupName.length)
                        {
                            groupNameFrom = [NSString stringWithString:clientGroup.groupName];
                        }

                        [objectSection commitCellChanges];

                        groupNameTo = clientGroup.groupName;
                    }
                }

                if (groupNameTo && groupNameTo.length)
                {
                    if ( [[[UIDevice currentDevice] systemVersion] intValue] < 6  )
                    {
                        ABAddressBookRef addressBookToGetGroup = ABAddressBookCreate();

                        int sourceID = [self defaultABSourceID];

                        source = ABAddressBookGetSourceWithRecordID(addressBookToGetGroup, sourceID);

                        NSArray *ptABGroupsArray = [NSArray arrayWithArray:(NSArray *)[self addressBookGroupsArray]];
                        BOOL groupNameToAlreadyExistsInAB = NO;
                        if (groupNameTo && groupNameTo.length)
                        {
                            for (PTABGroup *group in ptABGroupsArray)
                            {
                                if ([group.groupName isEqualToString:groupNameTo])
                                {
                                    groupNameToAlreadyExistsInAB = YES;

                                    break;
                                }
                            }
                        }

                        BOOL groupNameFromAlreadyExistsInAB = NO;
                        if (groupNameFrom && groupNameFrom.length)
                        {
                            for (PTABGroup *group in ptABGroupsArray)
                            {
                                if ([group.groupName isEqualToString:groupNameFrom])
                                {
                                    groupNameFromAlreadyExistsInAB = YES;

                                    break;
                                }
                            }
                        }

                        if (groupNameToAlreadyExistsInAB && [groupNameTo isEqualToString:groupNameFrom])
                        {
                            [appDelegate displayNotification:@"Group name has not changed." forDuration:3.0 location:kPTTScreenLocationTop inView:tableViewModel.viewController.view.superview];

                            if (addressBookToGetGroup)
                            {
                                CFRelease(addressBookToGetGroup);
                            }

                            return;
                        }

                        NSPredicate *groupNamePredicate = [NSPredicate predicateWithFormat:@"groupName MATCHES %@", groupNameTo];

                        NSArray *filteredPTABGroupsArray = [ptABGroupsArray filteredArrayUsingPredicate:groupNamePredicate];

                        if (filteredPTABGroupsArray.count)
                        {
                            NSString *displayMessag = nil;
                            if (filteredPTABGroupsArray.count > 1)
                            {
                                displayMessag = [NSString stringWithFormat:@"%i groups exist with that name already. The first one found with this name will be used.",ptABGroupsArray.count];
                            }
                            else
                            {
                                displayMessag = @"A group with this name already exists.  It will be used.";
                            }

                            [appDelegate displayNotification:displayMessag forDuration:3.0 location:kPTTScreenLocationTop inView:tableViewModel.viewController.view.superview];
                            if (addressBookToGetGroup)
                            {
                                CFRelease(addressBookToGetGroup);
                            }

                            return;
                        }

                        BOOL successAtChangingName = NO;
                        if (addressBookToGetGroup)
                        {
                            successAtChangingName = [self changeABGroupNameFrom:(NSString *)groupNameFrom To:(NSString *)groupNameTo addNew:(BOOL)NO checkExisting:(BOOL)YES ];
                        }

                        NSString *displayMessage = nil;
                        if (successAtChangingName)
                        {
                            if (!groupNameFromAlreadyExistsInAB)
                            {
                                displayMessage = @"Successfully added group name in the Address Book.";
                            }
                            else
                            {
                                displayMessage = @"Successfully changed group name in the Address Book.";
                            }
                        }
                        else
                        {
                            displayMessage = @"Address Book group name change not successful.";
                        }

                        [appDelegate displayNotification:displayMessage forDuration:3.0 location:kPTTScreenLocationTop inView:tableViewModel.viewController.view.superview];

                        if (addressBookToGetGroup)
                        {
                            CFRelease(addressBookToGetGroup);
                        }

                        if (source)
                        {
                            CFRelease(source);
                        }
                    }
                }
            }
            break;
            case 302:
            {
                SCTableViewSection *section = [tableViewModel sectionAtIndex:indexPath.section];
                NSString *groupName = nil;
                PTABGroup *group = nil;

                if ([section isKindOfClass:[SCObjectSection class]])
                {
                    SCObjectSection *objectSection = (SCObjectSection *)section;

                    NSManagedObject *sectionManagedObject = (NSManagedObject *)section.boundObject;

                    if ([objectSection valuesAreValid] && sectionManagedObject && [sectionManagedObject respondsToSelector:@selector(entity)] && [sectionManagedObject.entity.name isEqualToString:@"ClinicianGroupEntity"])
                    {
                        ClientGroupEntity *clientGroup = (ClientGroupEntity *)sectionManagedObject;

                        [objectSection commitCellChanges];

                        groupName = clientGroup.groupName;
                    }
                    else
                    {
                        [appDelegate displayNotification:@"Enter a group name to delete." forDuration:3.0 location:kPTTScreenLocationTop inView:tableViewModel.viewController.view.superview];
                        return;
                    }
                }

                BOOL groupNameAlreadyExistsInAB = NO;

                if (groupName && groupName.length)
                {
                    if ( [[[UIDevice currentDevice] systemVersion] intValue] < 6  )
                    {
                        ABAddressBookRef addressBookToGetGroups = ABAddressBookCreate();

                        int sourceID = [self defaultABSourceID];

                        source = ABAddressBookGetSourceWithRecordID(addressBookToGetGroups, sourceID);

                        NSArray *ptABGroupsArray = [NSArray arrayWithArray:(NSArray *)[self addressBookGroupsArray]];

                        for (PTABGroup *groupInArray in ptABGroupsArray)
                        {
                            if ([groupInArray.groupName isEqualToString:groupName])
                            {
                                groupNameAlreadyExistsInAB = YES;

                                group = groupInArray;
                                break;
                            }
                        }

                        if (groupNameAlreadyExistsInAB)
                        {
                            NSString *alertMessage = [NSString stringWithFormat:@"Do you wish to delete the %@ group from the address book?", groupName];
                            UIAlertView *deleteConfirmAlert = [[UIAlertView alloc]initWithTitle:@"Remove Group From Address Book" message:alertMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes, Delete it", nil];
                            deleteConfirmAlert.tag = 1;
                            groupRecordIDToDeleteOrImport = group.recordID;
                            detailViewSuperview = tableViewModel.viewController.view.superview;

                            [deleteConfirmAlert show];
                            //
                        }
                        else
                        {
                            [appDelegate displayNotification:@"This group was not found in the Address Book" forDuration:3.0 location:kPTTScreenLocationTop inView:tableViewModel.viewController.view.superview];
                        }

                        if (source)
                        {
                            CFRelease(source);
                        }

                        if (addressBookToGetGroups)
                        {
                            CFRelease(addressBookToGetGroups);
                        }
                    }
                }
            }

            break;
            case 303:
            {
                SCTableViewSection *section = [tableViewModel sectionAtIndex:indexPath.section];
                NSString *groupName = nil;
                PTABGroup *group = nil;

                if ([section isKindOfClass:[SCObjectSection class]])
                {
                    SCObjectSection *objectSection = (SCObjectSection *)section;

                    NSManagedObject *sectionManagedObject = (NSManagedObject *)section.boundObject;

                    if ([objectSection valuesAreValid] && sectionManagedObject && [sectionManagedObject respondsToSelector:@selector(entity)] && [sectionManagedObject.entity.name isEqualToString:@"ClinicianGroupEntity"])
                    {
                        ClientGroupEntity *clientGroup = (ClientGroupEntity *)sectionManagedObject;

                        [objectSection commitCellChanges];

                        groupName = clientGroup.groupName;
                    }
                    else
                    {
                        [appDelegate displayNotification:@"Enter a group name to import." forDuration:3.0 location:kPTTScreenLocationTop inView:tableViewModel.viewController.view.superview];
                        return;
                    }
                }

                BOOL groupNameAlreadyExistsInAB = NO;

                if ( [[[UIDevice currentDevice] systemVersion] intValue] < 6  )
                {
                    ABAddressBookRef addressBookToGetTheGroup = ABAddressBookCreate();
                    if (groupName && groupName.length)
                    {
                        source = nil;

                        int sourceID = [self defaultABSourceID];

                        if (!source && sourceID > -1)
                        {
                            source = ABAddressBookGetSourceWithRecordID(addressBookToGetTheGroup, sourceID);
                        }

                        NSArray *ptABGroupsArray = [NSArray arrayWithArray:(NSArray *)[self addressBookGroupsArray]];

                        for (PTABGroup *groupInArray in ptABGroupsArray)
                        {
                            if ([groupInArray.groupName isEqualToString:groupName])
                            {
                                groupNameAlreadyExistsInAB = YES;

                                group = groupInArray;
                                break;
                            }
                        }
                    }

                    if (!groupNameAlreadyExistsInAB)
                    {
                        [appDelegate displayNotification:@"Group not found in the Address Book." forDuration:3.0 location:kPTTScreenLocationTop inView:tableViewModel.viewController.view.superview];

                        if (addressBookToGetTheGroup)
                        {
                            CFRelease(addressBookToGetTheGroup);
                        }

                        return;
                    }

                    CFArrayRef allGroupsInSource = ABAddressBookCopyArrayOfAllGroupsInSource(addressBookToGetTheGroup, source);

                    int groupCount = 0;
                    if (allGroupsInSource)
                    {
                        groupCount = CFArrayGetCount(allGroupsInSource);

                        CFRelease(allGroupsInSource);
                    }

                    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

                    if (groupCount > 0)
                    {
                        ABRecordRef abGroup = (ABRecordRef)ABAddressBookGetGroupWithRecordID(addressBookToGetTheGroup, group.recordID);
                        CFArrayRef groupMembers;
                        groupMembers = nil;

                        if (abGroup)
                        {
                            groupMembers = (CFArrayRef)ABGroupCopyArrayOfAllMembers(abGroup);
                        }

                        int groupMembersCount = 0;

                        if (groupMembers)
                        {
                            groupMembersCount = CFArrayGetCount(groupMembers);

                            CFRelease(groupMembers);
                        }

                        if (groupMembersCount > 0)
                        {
                            NSString *alertMessage;
                            if (groupMembersCount == 1)
                            {
                                alertMessage = [NSString stringWithFormat:@"Do you wish to import %i contact from the Address Book %@ group?",groupMembersCount, (NSString *)groupName];
                            }
                            else
                            {
                                alertMessage = [NSString stringWithFormat:@"Do you wish to import %i contacts from the Address Book %@ group?",groupMembersCount, groupName];
                            }

                            UIAlertView *importConfirmAlert = [[UIAlertView alloc]initWithTitle:@"Import Contacts" message:alertMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
                            importConfirmAlert.tag = 2;
                            detailViewSuperview = tableViewModel.viewController.view.superview;
                            groupRecordIDToDeleteOrImport = group.recordID;
                            [importConfirmAlert show];

                            //
                        }
                        else
                        {
                            [appDelegate displayNotification:@"This group does not have any members to import." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
                        }
                    }
                    else
                    {
                        [appDelegate displayNotification:@"Unable to find Group. Must specify an existing Address Book group with members to import." forDuration:4.0 location:kPTTScreenLocationTop inView:nil];
                    }

                    if (addressBookToGetTheGroup)
                    {
                        CFRelease(addressBookToGetTheGroup);
                    }

                    if (source)
                    {
                        CFRelease(source);
                    }
                }
            }
            break;

            case 304:
            {
            }

            break;
            case 305:
            {
                if ([SCUtilities systemVersion] < 6)
                {
                    ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc]init];

                    peoplePicker.peoplePickerDelegate = self;
                    // Display only a person's phone, email, and birthdate
                    NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                                               [NSNumber numberWithInt:kABPersonEmailProperty],
                                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];

                    peoplePicker.displayedProperties = displayedItems;
                    // Show the picker

                    if ([SCUtilities systemVersion]<6) {
                          [peoplePicker shouldAutorotateToInterfaceOrientation:YES];
                    }
                  
                    [peoplePicker setEditing:YES];

                    [peoplePicker setPeoplePickerDelegate:self];

                    [tableViewModel.viewController.navigationController presentViewController:peoplePicker animated:YES completion:nil];
                }

                break;
            }
        } /* switch */
    }
}


- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag)
    {
        case 1:

            if (buttonIndex == 1)
            {
                if ([SCUtilities systemVersion] < 6)
                {
                    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

                    if (groupRecordIDToDeleteOrImport > -1)
                    {
                        if ( [[[UIDevice currentDevice] systemVersion] intValue] < 6  )
                        {
                            ABAddressBookRef addressBookAfterAlert = ABAddressBookCreate();

                            if (addressBookAfterAlert)
                            {
                                int CFGroupCount = ABAddressBookGetGroupCount( (ABAddressBookRef)addressBookAfterAlert );

                                if ( CFGroupCount > 0)
                                {
                                    ABRecordRef group = nil;
                                    group = (ABRecordRef)ABAddressBookGetGroupWithRecordID(addressBookAfterAlert, groupRecordIDToDeleteOrImport);
                                    bool didRemove = NO;
                                    if (group)
                                    {
                                        didRemove = (bool)ABAddressBookRemoveRecord( (ABAddressBookRef)addressBookAfterAlert, (ABRecordRef)group, nil );

                                        BOOL wantToSaveChanges = TRUE;
                                        bool didSave = FALSE;
                                        if ( ABAddressBookHasUnsavedChanges(addressBookAfterAlert) )
                                        {
                                            if (wantToSaveChanges)
                                            {
                                                didSave = ABAddressBookSave(addressBookAfterAlert, nil);
                                            }
                                            else
                                            {
                                                ABAddressBookRevert(addressBookAfterAlert);
                                            }
                                        }

                                        if (!didRemove || !didSave)
                                        {
                                            [appDelegate displayNotification:@"Not able to remove the group" forDuration:3.0 location:kPTTScreenLocationTop inView:detailViewSuperview];
                                        }
                                        else
                                        {
                                            [appDelegate displayNotification:@"Group Successfully Removed" forDuration:3.0 location:kPTTScreenLocationTop inView:detailViewSuperview];
                                        }

                                        group = nil;
                                    }
                                    else
                                    {
                                        [appDelegate displayNotification:@"Group not found." forDuration:3.0 location:kPTTScreenLocationTop inView:detailViewSuperview];
                                    }
                                }

                                if (addressBookAfterAlert)
                                {
                                    CFRelease(addressBookAfterAlert);
                                }

                                detailViewSuperview = nil;
                                groupRecordIDToDeleteOrImport = -1;
                            }
                        }
                    }
                }
            }

            break;
        case 2:
        {
            if (buttonIndex == 1)
            {
                if ( [[[UIDevice currentDevice] systemVersion] intValue] < 6  )
                {
                    [self importAllContactsInGroup];
                }
            }
        }
        break;
    } /* switch */
}


#pragma mark -
#pragma mark PeoplePicker delegate methods
- (void) peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return YES;
}


- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}


- (NSArray *) addressBookGroupsArray
{
    NSMutableArray *allGroups = [NSMutableArray array];

    //check to see if the group name exists already
    if ( [[[UIDevice currentDevice] systemVersion] intValue] < 6  )
    {
        ABAddressBookRef addressBookToBuildAddressBookGroupArray = ABAddressBookCreate();
        CFArrayRef allGroupsInSource = nil;
        allGroupsInSource = ABAddressBookCopyArrayOfAllGroupsInSource(addressBookToBuildAddressBookGroupArray, source);
        int groupCount = CFArrayGetCount(allGroupsInSource);

        if (allGroupsInSource && groupCount)
        {
            allGroups = [[NSMutableArray alloc] init];

            //            CFStringRef CFGroupName ;
            for (CFIndex i = 0; i < groupCount; i++)
            {
                ABRecordRef groupInCFArray = CFArrayGetValueAtIndex(allGroupsInSource, i);

                CFStringRef cfGroupName = nil;

                cfGroupName = ABRecordCopyValue(groupInCFArray, kABGroupNameProperty);
                int CFGroupID = ABRecordGetRecordID( (ABRecordRef)groupInCFArray );

                PTABGroup *ptGroup = [[PTABGroup alloc]initWithName:(__bridge NSString *)cfGroupName recordID:CFGroupID];

                [allGroups addObject:ptGroup];

                CFRelease(cfGroupName);
            }
        }

        if (addressBookToBuildAddressBookGroupArray)
        {
            CFRelease(addressBookToBuildAddressBookGroupArray);
        }

        if (allGroupsInSource)
        {
            CFRelease(allGroupsInSource);
        }
    }

    return allGroups;
}


- (BOOL) changeABGroupNameFrom:(NSString *)groupNameFrom To:(NSString *)groupNameTo addNew:(BOOL)addNew checkExisting:(BOOL)checkExisting
{
    BOOL successAtSettingName = NO;

    if ( [[[UIDevice currentDevice] systemVersion] intValue] < 6  )
    {
        ABRecordRef group = nil;
        ABAddressBookRef addressBookToChangeABGroupName = ABAddressBookCreate();
        CFArrayRef allGroupsInSource = ABAddressBookCopyArrayOfAllGroupsInSource(addressBookToChangeABGroupName, source);
        int groupCount = CFArrayGetCount(allGroupsInSource);

        ABRecordRef groupInCheckNameArray = nil;
        if (groupNameFrom && groupNameFrom.length && groupCount && checkExisting)
        {
            for (CFIndex i = 0; i < groupCount; i++)
            {
                groupInCheckNameArray = CFArrayGetValueAtIndex(allGroupsInSource, i);
                CFStringRef cfGroupNameCheck = nil;
                cfGroupNameCheck = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);

//            CFComparisonResult result=  (CFComparisonResult) CFStringCompare (
//                                                                              (__bridge CFStringRef)groupName,
//                                                                              (CFStringRef) CFGroupNameCheck,
//                                                                              1
//                                                                              );

                NSString *checkNameStr = [NSString stringWithFormat:@"%@",(__bridge NSString *)cfGroupNameCheck];

                if (cfGroupNameCheck)
                {
                    CFRelease(cfGroupNameCheck);
                }

                if ([checkNameStr isEqualToString:groupNameTo])
                {
                    successAtSettingName = YES;

                    break;
                }
                else if ([checkNameStr isEqualToString:groupNameFrom])
                {
                    group = groupInCheckNameArray;
                    break;
                }
            }
        }

        if (allGroupsInSource)
        {
            CFRelease(allGroupsInSource);
        }

        if (successAtSettingName)
        {
            if (group)
            {
                CFRelease(group);
            }

            if (addressBookToChangeABGroupName)
            {
                CFRelease(addressBookToChangeABGroupName);
            }

            return successAtSettingName;
        }

        if (!group || addNew)
        {
            if (!addressBookToChangeABGroupName)
            {
                return successAtSettingName;
            }

            ABRecordRef groupTroCreate = ABGroupCreateInSource(source);

            bool didSetGroupName = FALSE;
            didSetGroupName = (bool)ABRecordSetValue(
                groupTroCreate,
                (ABPropertyID)kABGroupNameProperty,
                (__bridge CFStringRef)groupNameTo,
                nil
                );

            if (!didSetGroupName)
            {
                successAtSettingName = NO;
            }

            ABAddressBookAddRecord( (ABAddressBookRef)addressBookToChangeABGroupName, (ABRecordRef)groupTroCreate, nil );

            BOOL wantToSaveChanges = TRUE;
            if ( ABAddressBookHasUnsavedChanges(addressBookToChangeABGroupName) )
            {
                if (wantToSaveChanges)
                {
                    bool didSave = FALSE;
                    didSave = ABAddressBookSave(addressBookToChangeABGroupName, nil);

                    if (didSave)
                    {
                        successAtSettingName = YES;
                    }
                }
                else
                {
                    ABAddressBookRevert(addressBookToChangeABGroupName);
                }
            }

            if (groupTroCreate)
            {
                CFRelease(groupTroCreate);
            }
        }
        else
        {
            BOOL wantToSaveChanges = TRUE;

            CFErrorRef error = nil;
            ABRecordSetValue(group, kABGroupNameProperty,(__bridge CFStringRef)groupNameTo, &error);

            if ( error == noErr && ABAddressBookHasUnsavedChanges(addressBookToChangeABGroupName) )
            {
                if (wantToSaveChanges)
                {
                    bool didSave = FALSE;
                    didSave = ABAddressBookSave(addressBookToChangeABGroupName, nil);
                    if (didSave)
                    {
                        successAtSettingName = YES;
                    }
                }
                else
                {
                    ABAddressBookRevert(addressBookToChangeABGroupName);
                }
            }

            if (error  )
            {
                CFRelease(error);
            }
        }

        if (group != NULL)
        {
            group = nil;
        }

        if (addressBookToChangeABGroupName)
        {
            CFRelease(addressBookToChangeABGroupName);
        }
    }

    return successAtSettingName;
}


- (void) importAllContactsInGroup
{
    if ( [[[UIDevice currentDevice] systemVersion] intValue] < 6  )
    {
        ABAddressBookRef addressBookToImportContactsInGroup = ABAddressBookCreate();

//    int groupIdentifier=groupRecordIDToDeleteOrImport;

        ABRecordRef group = nil;
        if (groupRecordIDToDeleteOrImport > -1)
        {
            group = (ABRecordRef)ABAddressBookGetGroupWithRecordID(addressBookToImportContactsInGroup, groupRecordIDToDeleteOrImport);
        }

        if (addressBookToImportContactsInGroup && group)
        {
            CFArrayRef allPeopleInGroup = (CFArrayRef)ABGroupCopyArrayOfAllMembers(group);

            int peopleInGroupCount = CFArrayGetCount(allPeopleInGroup);
            NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];

            NSError *error = nil;
            NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
            if (fetchedObjects == nil)
            {
                //error handler
            }

            if (peopleInGroupCount > 0)
            {
                ABRecordRef recordRef;

                CFStringRef recordRefFirstName;

                CFStringRef recordRefLastName;

                CFStringRef recordRefPrefix;

                CFStringRef recordRefSuffix;

                CFStringRef recordRefMiddleName;

                CFStringRef recordRefNotes;

                int personID;
                NSPredicate *checkIfRecordIDExists;
                NSArray *filteredArray;
                int numberImported = 0;
                for (int i = 0; i < peopleInGroupCount; i++)
                {
                    recordRef = nil;

                    recordRefFirstName = nil;

                    recordRefLastName = nil;

                    recordRefPrefix = nil;

                    recordRefSuffix = nil;

                    recordRefMiddleName = nil;

                    recordRefNotes = nil;

                    checkIfRecordIDExists = nil;
                    filteredArray = nil;
                    recordRef = CFArrayGetValueAtIndex(allPeopleInGroup, i);

                    recordRefFirstName = ABRecordCopyValue( (ABRecordRef)recordRef,(ABPropertyID)kABPersonFirstNameProperty );

                    recordRefLastName = ABRecordCopyValue( (ABRecordRef)recordRef,(ABPropertyID)kABPersonLastNameProperty );

                    recordRefPrefix = ABRecordCopyValue( (ABRecordRef)recordRef,(ABPropertyID)kABPersonPrefixProperty );

                    recordRefSuffix = ABRecordCopyValue( (ABRecordRef)recordRef,(ABPropertyID)kABPersonSuffixProperty );

                    recordRefMiddleName = ABRecordCopyValue( (ABRecordRef)recordRef,(ABPropertyID)kABPersonMiddleNameProperty );

                    recordRefNotes = ABRecordCopyValue( (ABRecordRef)recordRef,(ABPropertyID)kABPersonNoteProperty );

                    personID = (int)ABRecordGetRecordID(recordRef);
                    checkIfRecordIDExists = [NSPredicate predicateWithFormat:@"aBRecordIdentifier == %@",[NSNumber numberWithInt:personID]];

                    filteredArray = [fetchedObjects filteredArrayUsingPredicate:checkIfRecordIDExists];

                    if (filteredArray.count == 0 && recordRefFirstName && CFStringGetLength(recordRefFirstName) > 0 && recordRefLastName && CFStringGetLength(recordRefLastName) > 0)
                    {
                        ClinicianEntity *clinician = [[ClinicianEntity alloc]initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];

                        if (recordRefPrefix && CFStringGetLength(recordRefPrefix) > 0)
                        {
                            [clinician setValue:(__bridge NSString *)recordRefPrefix forKey:@"prefix"];
                        }

                        if (recordRefFirstName && CFStringGetLength(recordRefFirstName) > 0)
                        {
                            [clinician setValue:(__bridge NSString *)recordRefFirstName forKey:@"firstName"];
                        }

                        if (recordRefMiddleName && CFStringGetLength(recordRefMiddleName) > 0)
                        {
                            [ clinician setValue:(__bridge NSString *)recordRefMiddleName forKey:@"middleName"];
                        }

                        if (recordRefLastName && CFStringGetLength(recordRefLastName) > 0)
                        {
                            [clinician setValue:(__bridge NSString *)recordRefLastName forKey:@"lastName"];
                        }

                        if (recordRefSuffix && CFStringGetLength(recordRefSuffix) > 0)
                        {
                            [clinician setValue:(__bridge NSString *)recordRefSuffix forKey:@"suffix"];
                        }

                        if (recordRefNotes && CFStringGetLength(recordRefNotes) > 0)
                        {
                            [clinician setValue:(__bridge NSString *)recordRefNotes forKey:@"notes"];
                        }

                        if (personID )
                        {
                            [clinician setValue:[NSNumber numberWithInt:personID] forKey:@"aBRecordIdentifier"];
                        }

                        numberImported++;
                    }

                    if (recordRefNotes)
                    {
                        CFRelease(recordRefNotes);
                    }

                    if (recordRefPrefix)
                    {
                        CFRelease(recordRefPrefix);
                    }

                    if (recordRefFirstName)
                    {
                        CFRelease(recordRefFirstName);
                    }

                    if (recordRefMiddleName)
                    {
                        CFRelease(recordRefMiddleName);
                    }

                    if (recordRefLastName)
                    {
                        CFRelease(recordRefLastName);
                    }

                    if (recordRefSuffix)
                    {
                        CFRelease(recordRefSuffix);
                    }
                }

                PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

                if ([managedObjectContext hasChanges])
                {
                    [appDelegate saveContext];
                }

                int numberIgnored = peopleInGroupCount - numberImported;
                NSString *messageStr;

                if (peopleInGroupCount == numberIgnored)
                {
                    if (peopleInGroupCount == 1)
                    {
                        messageStr = [NSString stringWithFormat:@"The contact was not imported because it already exists in the database."];
                    }
                    else
                    {
                        messageStr = [NSString stringWithFormat:@"The contacts were not imported because they already exist in the database."];
                    }
                }
                else
                {
                    if (numberImported == 1)
                    {
                        messageStr = [NSString stringWithFormat:@"Imported %i contact.",numberImported];
                    }
                    else
                    {
                        messageStr = [NSString stringWithFormat:@"Imported %i contacts.",numberImported];
                    }

                    if (numberIgnored > 0)
                    {
                        if (numberIgnored == 1)
                        {
                            messageStr = [messageStr stringByAppendingString:[NSString stringWithFormat:@" The contact was not imported because it already exists in the database"]];
                        }
                        else
                        {
                            messageStr = [messageStr stringByAppendingString:[NSString stringWithFormat:@" %i contacts were not imported because they already exist in the database",numberIgnored]];
                        }
                    }
                }

                [appDelegate displayNotification:messageStr forDuration:6.0 location:kPTTScreenLocationTop inView:nil];
            }

            fetchRequest = nil;

            if (allPeopleInGroup)
            {
                CFRelease(allPeopleInGroup);
            }
        }

        if (addressBookToImportContactsInGroup)
        {
            CFRelease(addressBookToImportContactsInGroup);
        }
    }
}


- (IBAction) abSourcesDoneButtonTapped:(id)sender
{
    if (rootNavController)
    {
        // check if self is the rootViewController

        [objectsModel.viewController.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [sourcesObjSelectionCell_.ownerTableViewModel.viewController dismissViewControllerAnimated:YES completion:nil];
    }
}


- (int) defaultABSourceID
{
    BOOL iCloudEnabled = (BOOL)[[NSUserDefaults standardUserDefaults] valueForKey : @"icloud_preference"];

    int returnID = -1;
    int sourceID = -1;
    BOOL continueChecking = YES;

    if ( [[[UIDevice currentDevice] systemVersion] intValue] < 6  )
    {
        ABAddressBookRef addressBookToGetSource = ABAddressBookCreate();
        CFArrayRef allSourcesArray = ABAddressBookCopyArrayOfAllSources(addressBookToGetSource);
        source = nil;
        int sourcesCount = 0;

        if (allSourcesArray )
        {
            sourcesCount = CFArrayGetCount(allSourcesArray);
        }

        if (sourcesCount == 0)
        {
            continueChecking = NO;
            returnID = -1;
        }

        if (continueChecking && allSourcesArray && sourcesCount == 1)
        {
            source = CFArrayGetValueAtIndex(allSourcesArray, 0);
            ABRecordID sourceID = ABRecordGetRecordID(source);

            continueChecking = NO;
            returnID = sourceID;
        }

        int recordID = (int)[(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookSourceIdentifier]
                             intValue];

        if (continueChecking && recordID != -1)
        {
            source = ABAddressBookGetSourceWithRecordID(addressBookToGetSource, recordID);

            if (source)
            {
                continueChecking = NO;
                returnID = recordID;
            }

//        }
        }

        if (continueChecking && allSourcesArray && CFArrayGetCount(allSourcesArray) > 1 && iCloudEnabled)
        {
            for (int i = 0; i < sourcesCount; i++)
            {
                // Fetch the source type

                source = CFArrayGetValueAtIndex(allSourcesArray, i);
                CFNumberRef sourceType = ABRecordCopyValue(source, kABSourceTypeProperty);

                // Fetch the name associated with the source type
                NSString *sourceName = [self nameForSourceWithIdentifier:[(__bridge NSNumber *)sourceType intValue]];
                if (sourceType)
                {
                    CFRelease(sourceType);
                }

                if ([sourceName isEqualToString:@"CardDAV server"])
                {
                    sourceID = ABRecordGetRecordID(source);

                    //

                    returnID = sourceID;
                    continueChecking = NO;
                    break;
                }
            }
        }

        if (continueChecking && sourcesCount > 1)
        {
            source = CFArrayGetValueAtIndex(allSourcesArray, 0);
            sourceID = ABRecordGetRecordID(source);
            returnID = sourceID;
        }

        if (allSourcesArray)
        {
            CFRelease(allSourcesArray);
        }

        if (addressBookToGetSource)
        {
            CFRelease(addressBookToGetSource);
        }
    }

    return returnID;
}


@end
