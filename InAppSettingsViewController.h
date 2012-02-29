//
//  InAppSettingsViewController.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 2/1/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "SCTableViewModel.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface InAppSettingsViewController : UITableViewController <SCTableViewModelDelegate, EKCalendarChooserDelegate,ABPeoplePickerNavigationControllerDelegate>{

    SCArrayOfObjectsModel *tableModel;
    EKEventStore *eventStore;
	EKCalendar *psyTrainTrackCalendar;
	NSMutableArray *eventsList;
    EKEventViewController *eventViewController;
    NSMutableDictionary *dictionaryABGroupIdentifierValueForArrayOfStringsIndexKey;
    NSMutableDictionary *dictionaryArrayOfStringsIndexForGroupIdentifierKey;
    NSArray *groupArray;
    ABAddressBookRef addressBook;
    
 
}

@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic, strong) EKCalendar *psyTrainTrackCalendar;
@property (nonatomic, strong) NSMutableArray *eventsList;
@property (nonatomic, strong) EKEventViewController *eventViewController;




- (EKCalendar *)defaultCalendarName;
-(NSArray *)addressBookGroupsArray;
-(void)changeABGroupNameTo:(NSString *)groupName  addNew:(BOOL)addNew;

@end
