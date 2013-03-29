/*
 *  ClinicianGroupsViewController.h
 *  psyTrack Clinician Tools
 *  Version: 1.0.6
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

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface ClinicianGroupsViewController : SCViewController <SCTableViewModelDelegate, EKCalendarChooserDelegate,ABPeoplePickerNavigationControllerDelegate, UIAlertViewDelegate>{
    SCArrayOfObjectsModel *objectsModel;
    EKEventStore *eventStore;
    EKCalendar *psyTrackCalendar;
    NSMutableArray *eventsList;
    EKEventViewController *eventViewController;
    NSMutableDictionary *dictionaryABGroupIdentifierValueForArrayOfStringsIndexKey;
    NSMutableDictionary *dictionaryArrayOfStringsIndexForGroupIdentifierKey;
    NSArray *groupArray;
    NSMutableDictionary *_valuesDictionary;

    SCTableViewModel *currentDetailTableViewModel_;
    SCObjectSelectionCell *sourcesObjSelectionCell_;

    ABRecordRef source;
    int groupRecordIDToDeleteOrImport;
    UIView *detailViewSuperview;
}
@property (nonatomic, strong) UINavigationController *rootNavController;
@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic, strong) EKCalendar *psyTrackCalendar;
@property (nonatomic, strong) NSMutableArray *eventsList;
@property (nonatomic, strong) EKEventViewController *eventViewController;

- (EKCalendar *) defaultCalendarName;
- (NSArray *) addressBookGroupsArray;
- (void) importAllContactsInGroup;

- (NSString *) nameForSourceWithIdentifier:(int)identifier;

- (NSString *) nameForSource:(ABRecordRef)source;
- (NSArray *) fetchArrayOfAddressBookSources;
- (IBAction) abSourcesDoneButtonTapped:(id)sender;
- (NSNumber *) defaultABSourceInSourceArray:(NSArray *)sourceArray;
- (int) defaultABSourceID;
@end
