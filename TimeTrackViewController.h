//
//  TimeTrackViewController.h
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
#import "InterventionTypeEntity.h"
#import "SupervisionTypeEntity.h"
@class Time_Shared;

typedef enum {
    kTrackAssessmentSetup,
    kTrackInterventionSetup,
    kTrackSupportSetup,
    kTrackSupervisionReceivedSetup,
    kTrackSupervisionGivenSetup,
} PTrackControllerSetup;

static NSString * const kTrackAssessmentEntityName=@"AssessmentEntity";
static NSString * const kTrackInterventionEntityName=@"InterventionDeliveredEntity";
static NSString * const kTrackSupportEntityName=@"SupportActivityDeliveredEntity";
static NSString * const kTrackSupervisionGivenEntityName=@"SupervisionGivenEntity";
static NSString * const kTrackSupervisionReceivedEntityName=@"SupervisionReceivedEntity";


@interface TimeTrackViewController : SCViewController <SCTableViewModelDataSource, SCTableViewModelDelegate, EKEventEditViewDelegate , UINavigationControllerDelegate>
{
    Time_Shared *time_Shared;
    ClientPresentations_Shared *clientPresentations_Shared;
    UISearchBar *searchBar;
//    UITableView *tableView;
    NSManagedObjectContext *managedObjectContext;
    __weak UILabel *totalAdministrationsLabel;
    
//    SCArrayOfObjectsModel *tableModel;
    
    PTrackControllerSetup currentControllerSetup;
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
    
    NSTimer *timer;
    
    
    __weak UITextField *stopwatchTextField;
    StopwatchCell *stopwatchCell;
    SCTableViewSection *timeSection;
    UILabel *footerLabel;
    UILabel *totalTimeHeaderLabel;
    
    
    NSDate *startTime;
    NSDate *endTime;
    NSDate *additionalTime;
    NSDate *timeToSubtract;
   
    SCTableViewSection *breakTimeSection;
    InterventionTypeEntity *selectedInterventionType;
    SupervisionTypeEntity *selectedSupervisionType;
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
@property (strong, nonatomic) IBOutlet  UILabel *totalTimeHeaderLabel;
@property (strong, nonatomic) IBOutlet  UILabel *footerLabel;
@property (strong, nonatomic)   NSDate *totalTimeDate;
@property (strong, nonatomic) IBOutlet SCEntityDefinition *timeDef;

-(void)calculateTime;
-(NSString *)tableViewModel:(SCTableViewModel *)tableViewModel calculateBreakTimeForRowAtIndexPath:(NSIndexPath *)indexPath withBoundValues:(BOOL)useBoundValues;
-(IBAction)stopwatchStop:(id)sender;
-(IBAction)stopwatchReset:(id)sender;

-(NSTimeInterval ) totalBreakTimeInterval;
-(id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle trackSetup:(PTrackControllerSetup )setupType;
@end
