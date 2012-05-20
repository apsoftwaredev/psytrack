//
//  ServicesViewController_Shared.h
//  PsyTrack
//
//  Created by Daniel Boice on 4/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StopwatchCell.h"
#import "ClientPresentations_Shared.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@class Time_Shared;

@interface ServicesViewController_Shared : SCViewController <SCTableViewModelDataSource, SCTableViewModelDelegate, EKEventEditViewDelegate , UINavigationControllerDelegate>
{
    Time_Shared *time_Shared;
    ClientPresentations_Shared *clientPresentations_Shared;
    UISearchBar *searchBar;
//    UITableView *tableView;
    NSManagedObjectContext *managedObjectContext;
    __weak UILabel *totalAdministrationsLabel;
    
//    SCArrayOfObjectsModel *tableModel;
    
    
    BOOL viewControllerOpen;
    
    NSDateFormatter *counterDateFormatter;
    NSDate *referenceDate;
    NSDate *totalTimeDate;
    NSDate *addStopwatch;
    SCDateCell *serviceDateCell;
    
    
    UILabel *breakTimeTotalHeaderLabel;
    
    
	EKEventStore *eventStore;
	EKCalendar *psyTrackCalendar;
	NSMutableArray *eventsList;
    EKEventEditViewController *eventViewController;
    
    SCTableViewModel *currentDetailTableViewModel;
    //    NSString *calendarIdentifier;
    
    NSManagedObject *eventButtonBoundObject;


    NSString *eventTitleString;

    NSString *tableModelClassDefEntity;


}







@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
//@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *totalAdministrationsLabel;
//@property (nonatomic, strong) IBOutlet NSManagedObject *managedObject;
@property (nonatomic, weak) IBOutlet UITextField *stopwatchTextField;
@property (nonatomic,strong)  ClientPresentations_Shared *clientPresentations_Shared;

@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic, strong) EKCalendar *psyTrackCalendar;
@property (nonatomic, strong) NSMutableArray *eventsList;
@property (nonatomic, strong) EKEventEditViewController *eventViewController;

//- (NSArray *) fetchEventsForToday;
- (IBAction) addEvent:(id)sender;



@end
