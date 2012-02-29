//
//  TestAdministrationViewController_iPad.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 10/5/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//



#import "SCTableViewModel.h"
#import "StopwatchCell.h"
#import "ClientPresentations_Shared.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>


@class Time_Shared;


@interface TestAdministrationsViewController_iPad : UIViewController < /*UINavigationControllerDelegate SCViewControllerDelegate,*/ SCTableViewModelDataSource, SCTableViewModelDelegate,/*UIGestureRecognizerDelegate,*/SCTableViewCellDelegate, EKEventEditViewDelegate , UINavigationControllerDelegate> {
    
    Time_Shared *time_Shared;
    ClientPresentations_Shared *clientPresentations_Shared;
    UISearchBar *searchBar;
    UITableView *tableView;
    NSManagedObjectContext *managedObjectContext;
    __weak UILabel *totalAdministrationsLabel;
    
    SCArrayOfObjectsModel *tableModel;
    

    BOOL viewControllerOpen;
   
    NSDateFormatter *counterDateFormatter;
    NSDate *referenceDate;
    NSDate *totalTimeDate;
    NSDate *addStopwatch;
    SCDateCell *serviceDateCell;
    
    
    UILabel *breakTimeTotalHeaderLabel;
    
 
	EKEventStore *eventStore;
	EKCalendar *psyTrainTrackCalendar;
	NSMutableArray *eventsList;
    EKEventEditViewController *eventViewController;

    SCTableViewModel *currentDetailTableViewModel;
//    NSString *calendarIdentifier;
  
    NSManagedObject *eventButtonBoundObject;
}




@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *totalAdministrationsLabel;
//@property (nonatomic, strong) IBOutlet NSManagedObject *managedObject;
@property (nonatomic, weak) IBOutlet UITextField *stopwatchTextField;
@property (nonatomic,strong)  ClientPresentations_Shared *clientPresentations_Shared;

@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic, strong) EKCalendar *psyTrainTrackCalendar;
@property (nonatomic, strong) NSMutableArray *eventsList;
@property (nonatomic, strong) EKEventEditViewController *eventViewController;

//- (NSArray *) fetchEventsForToday;
- (IBAction) addEvent:(id)sender;



-(void)updateAdministrationTotalLabel;

- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller;


@end


