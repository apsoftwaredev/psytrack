//
//  ServicesViewController_Shared.m
//  PsyTrack
//
//  Created by Daniel Boice on 4/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "TimeTrackViewController.h"
#import "PTTAppDelegate.h"
#import "Time_Shared.h"
#import "ButtonCell.h"
#import "ClientPresentations_Shared.h"
#import "ClientsViewController_iPhone.h"
#import "ClientsRootViewController_iPad.h"
#import "TimeEntity.h"
#import "BreakTimeEntity.h"
#import "TimePickerCell.h"

#import "ClinicianSelectionCell.h"


@interface TimeTrackViewController ()

@end

@implementation TimeTrackViewController



@synthesize tableView=_tableView;
@synthesize searchBar=_searchBar;
@synthesize totalAdministrationsLabel;
@synthesize stopwatchTextField;
@synthesize clientPresentations_Shared;
@synthesize eventsList,eventStore,eventViewController,psyTrackCalendar;

@synthesize  totalTimeHeaderLabel=totalTimeHeaderLabel;
@synthesize  footerLabel=footerLabel;
@synthesize totalTimeDate=totalTimeDate;
@synthesize timeDef;
//@synthesize managedObject;


#pragma mark -
#pragma mark View lifecycle

-(id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle trackSetup:(PTrackControllerSetup )setupType{
    
    self=[super initWithNibName:nibName bundle:bundle];
    currentControllerSetup=setupType;
    return self;
    
} 

- (void) didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    [appDelegate displayMemoryWarning];
    

}


-(void)viewDidUnload{
    
    [super viewDidUnload];
    
    
    self.view=nil;

   
 
    managedObjectContext=nil;
   
  
    
  
   eventTitleString=nil;
    
  tableModelClassDefEntity=nil;
    

    self.clientPresentations_Shared=nil;
    self.psyTrackCalendar=nil;
    self.eventStore=nil;
    
    self.eventsList=nil;
    self.eventViewController=nil;
    
    time_Shared=nil;
    
    searchBar=nil;
//    tableView=nil;
    
    
    
  
    
    
    
    
    counterDateFormatter=nil;
    referenceDate=nil;
    totalTimeDate=nil;
    addStopwatch=nil;
    serviceDateCell=nil;
    
    
    breakTimeTotalHeaderLabel=nil;
    
    
    
    currentDetailTableViewModel=nil;
    
    
    eventButtonBoundObject=nil;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
   
//    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
//    
//    
//    
//    
//    
//    // create a spacer
//    UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
//                                   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
//    [buttons addObject:editButton];
//    
//    
//    
//    
//    // create a standard "add" button
//    UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
//                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:NULL];
//    addButton.style = UIBarButtonItemStyleBordered;
//    [buttons addObject:addButton];
//    
//    // stick the buttons in the toolbar
//    self.navigationItem.rightBarButtonItems=buttons;
    
 
       

   
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE, M/d/yyyy"];
    
    
    
    
    
	
	// Get managedObjectContext from application delegate
    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
	
    
    
    
    //set up the date time formatters
    NSDateFormatter *shortTimeFormatter = [[NSDateFormatter alloc] init];
	[shortTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDateFormatter *additionalTimeFormatter = [[NSDateFormatter alloc] init];
	[additionalTimeFormatter setDateFormat:@"H:mm"];
    [additionalTimeFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    //Create a class definition for the TimeEntity
    self.timeDef = [SCEntityDefinition definitionWithEntityName:@"TimeEntity" 
                                           managedObjectContext:managedObjectContext
                                                  propertyNames:[NSArray arrayWithObjects:@"startTime", @"endTime", @"breaks", @"notes"    , nil]];
    
    //Do some property definition customization for the Time Entity defined in timeDef
    //Create the property definition for the startTime property in the timeDef class  definition
    
    SCPropertyDefinition *startTimePropertyDef = [self.timeDef propertyDefinitionWithName:@"startTime"];
	startTimePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:shortTimeFormatter 
                                                                     datePickerMode:UIDatePickerModeTime 
                                                      displayDatePickerInDetailView:YES];
    SCPropertyDefinition *endTimePropertyDef = [self.timeDef propertyDefinitionWithName:@"endTime"];
	endTimePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:shortTimeFormatter 
                                                                   datePickerMode:UIDatePickerModeTime 
                                                    displayDatePickerInDetailView:YES];
    
    NSString *timePickerCellNibName;
    
    if([SCUtilities is_iPad])
        timePickerCellNibName=[NSString stringWithString:@"TimePickerCell_iPad"];
    else
        timePickerCellNibName=[NSString stringWithString:@"TimePickerCell"];
    
    
    
    //create the dictionary with the data bindings
    NSDictionary *additionalTimeDataBindings = [NSDictionary 
                                                dictionaryWithObjects:[NSArray arrayWithObjects:@"additionalTime",@"additionalTime", @"Additional Time", nil ] 
                                                forKeys:[NSArray arrayWithObjects:@"40" , @"41",@"42",   nil]]; // 40, 41,42 are the control tags
	
    //create the custom property definition for addtional time
    SCCustomPropertyDefinition *additionalTimePropertyDef = [SCCustomPropertyDefinition definitionWithName:@"AdditionalTime" uiElementNibName:timePickerCellNibName  objectBindings:additionalTimeDataBindings];	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    additionalTimePropertyDef.autoValidate=FALSE;
    
	
    
    [self.timeDef insertPropertyDefinition:additionalTimePropertyDef atIndex:2];
    //create the dictionary with the data bindings
    NSDictionary *subtractTimeDataBindings = [NSDictionary 
                                              dictionaryWithObjects:[NSArray arrayWithObjects:@"timeToSubtract",@"timeToSubtract", @"Time To Subtract", nil ] 
                                              forKeys:[NSArray arrayWithObjects:@"40" , @"41",@"42",   nil]]; // 40, 41,42 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *subtractTimePropertyDef = [SCCustomPropertyDefinition definitionWithName:@"SubtractTime" uiElementNibName:timePickerCellNibName  objectBindings:subtractTimeDataBindings];	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    subtractTimePropertyDef.autoValidate=NO;
    
	
    
    [self.timeDef insertPropertyDefinition:subtractTimePropertyDef atIndex:3];
    
    
    
    //Create a property definition for the notes property.
    SCPropertyDefinition *timeNoesPropertyDef = [timeDef propertyDefinitionWithName:@"notes"];
    
    //set the notes property definition type to a Text View Cell
    timeNoesPropertyDef.type = SCPropertyTypeTextView;
    
    //create the dictionary with the data bindings
    NSDictionary *stopwatchDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObjects: @"addStopwatch",@"stopwatchRunning", @"pauseInterval", @"pauseTime", @"stopwatchStartTime",   @"stopwatchRestartAfterStop" ,@"totalTime", nil] 
                                           forKeys:[NSArray arrayWithObjects: @"addStopwatch",@"stopwatchRunning", @"pauseInterval",  @"pauseTime",  @"stopwatchStartTime",  @"stopwatchRestartAfterStop", @"totalTime", nil ]]; // 63 is the control tag for the textField
    
    
    
    //create a custom property definition for the Button Cell
    SCCustomPropertyDefinition *buttonProperty = [SCCustomPropertyDefinition definitionWithName:@"buttonCell" uiElementClass:[ButtonCell class] objectBindings:nil];
    
    //add the property definition to the timeDef class 
    [self.timeDef insertPropertyDefinition:buttonProperty atIndex:4];
    
    
    //create the custom property definition
    SCCustomPropertyDefinition *stopwatchDataProperty = [SCCustomPropertyDefinition definitionWithName:@"StopwatchData"
                                                                                      uiElementNibName:@"StopwatchCell" 
                                                                                        objectBindings:stopwatchDataBindings];
	
    
    
    
    
    //insert the custom property definition into the testingSessionDelivered class at index 1
    [self.timeDef insertPropertyDefinition:stopwatchDataProperty atIndex:5];
    
    
    
    //Create a class definition for the BreakTimeEntity
    SCEntityDefinition *breakTimeDef = [SCEntityDefinition definitionWithEntityName:@"BreakTimeEntity" 
                                                               managedObjectContext:managedObjectContext
                                                                      propertyNames:[NSArray arrayWithObjects:@"reason", @"startTime", @"endTime", @"breakNotes",       nil]];
    
    
    //     timeDef.requireEditingModeToEditPropertyValues = TRUE; // lock all property values until put in editing mode
    
    breakTimeDef.orderAttributeName=@"order";
    //Create a class definition for the BreakTimeReasonEntity
    SCEntityDefinition *breakTimeReasonDef = [SCEntityDefinition definitionWithEntityName:@"BreakTimeReasonEntity" 
                                                                     managedObjectContext:managedObjectContext
                                                                            propertyNames:[NSArray arrayWithObjects:@"breakName",nil]];
    
    
    breakTimeReasonDef.orderAttributeName=@"order";
    //Do some property definition customization for the BreakTime Entity defined in breakTimeDef
    
    
    //create a property definition for the reason property in the breakDef class
    SCPropertyDefinition *breaksPropertyDef = [timeDef propertyDefinitionWithName:@"breaks"];
    
    
    
    breaksPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    breaksPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:breakTimeDef
                                                                             allowAddingItems:YES
                                                                           allowDeletingItems:YES
                                                                             allowMovingItems:YES
                                                                   expandContentInCurrentView:YES 
                                                                         placeholderuiElement:nil 
                                                                        addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap Here To Add Break"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    breakTimeDef.requireEditingModeToEditPropertyValues=TRUE;
    
    //create a property definition
    SCPropertyDefinition *breakTimeReasonPropertyDef = [breakTimeDef propertyDefinitionWithName:@"reason"];
    
    //set a custom title
    breakTimeReasonPropertyDef.title =@"Break Reason";
    
    //set the title property name
    breakTimeDef.titlePropertyName=@"reason.breakName";
    
    
    
    breakTimeReasonPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *breakTimeReasonSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:breakTimeReasonDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    breakTimeReasonSelectionAttribs.allowAddingItems = YES;
    breakTimeReasonSelectionAttribs.allowDeletingItems = YES;
    breakTimeReasonSelectionAttribs.allowMovingItems = YES;
    breakTimeReasonSelectionAttribs.allowEditingItems = YES;
    breakTimeReasonSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Break Reasons)"];
    breakTimeReasonSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add Break Definition"];
    breakTimeReasonPropertyDef.attributes = breakTimeReasonSelectionAttribs;
    SCPropertyDefinition *breakTimeNotesPropertyDef = [breakTimeDef propertyDefinitionWithName:@"breakNotes"];
    breakTimeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    breakTimeReasonDef.titlePropertyName=@"breakName";
    
    
    
    
    //Create the property definition for the startTime property in the breakTime class  definition
    SCPropertyDefinition *startTimeBreakPropertyDef = [breakTimeDef propertyDefinitionWithName:@"startTime"];
    
    
    //Set the date attributes in the startTime property definition and make it so the date picker appears in a separate view.
    startTimeBreakPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:shortTimeFormatter
                                                                          datePickerMode:UIDatePickerModeTime
                                                           displayDatePickerInDetailView:YES];
    
    
    //Create the property definition for the Break endTime property in the breakTime class  definition
    SCPropertyDefinition *endTimeBreakPropertyDef = [breakTimeDef propertyDefinitionWithName:@"endTime"];
    
    //format the the date using a date formatter
    
    //Set the date attributes in the endTime for break property definition and make it so the date picker appears in a separate view.
    endTimeBreakPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:shortTimeFormatter
                                                                        datePickerMode:UIDatePickerModeTime
                                                         displayDatePickerInDetailView:YES];
    
    
    
    
    
	
    //create the dictionary with the data bindings
    NSDictionary *breakUndefinedTimeDataBindings = [NSDictionary 
                                                    dictionaryWithObjects:[NSArray arrayWithObjects:@"undefinedTime",@"undefinedTime", @"Undefined Time", nil ] 
                                                    forKeys:[NSArray arrayWithObjects:@"40" , @"41",@"42",   nil]]; // 40, 41,42 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *breakUndefinedTimePropertyDef = [SCCustomPropertyDefinition definitionWithName:@"BreakAdditionalTime" uiElementNibName:timePickerCellNibName  objectBindings:breakUndefinedTimeDataBindings];	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    breakUndefinedTimePropertyDef.autoValidate=YES;
    
	
    
    [breakTimeDef insertPropertyDefinition:breakUndefinedTimePropertyDef atIndex:3];
    
    //create a custom property definition for the Button Cell
    SCCustomPropertyDefinition *buttonBreakTimeClearPropertyDef = [SCCustomPropertyDefinition definitionWithName:@"buttonBreakTimeClearCell" uiElementClass:[ButtonCell class] objectBindings:nil];
    
    [breakTimeDef insertPropertyDefinition:buttonBreakTimeClearPropertyDef atIndex:4];
    
    
    
    
    SCPropertyGroup *timeGroup=[SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"startTime", @"endTime" ,@"AdditionalTime", @"SubtractTime", @"buttonCell",   @"StopwatchData",     nil]];
    
    SCPropertyGroup *breaksGroup=[SCPropertyGroup groupWithHeaderTitle:@"Breaks" footerTitle:nil propertyNames:[NSArray arrayWithObject:@"breaks"]];
    
    SCPropertyGroup *notesGroup=[SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObject:@"notes"]];
    
    SCPropertyGroup *breakNotesGroup=[SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObject:@"breakNotes"]];
    
    [timeDef.propertyGroups addGroup:timeGroup];
    [timeDef.propertyGroups addGroup:breaksGroup];
    [timeDef.propertyGroups addGroup:notesGroup];
    [breakTimeDef.propertyGroups addGroup:breakNotesGroup];
    
    
    
    
 
    // Set the view controller's theme
    self.tableViewModel.theme = [SCTheme themeWithPath:@"ClearBackgroundTheme.sct"];
   
    
   

    clientPresentations_Shared=[[ClientPresentations_Shared alloc]init];
    
    [clientPresentations_Shared setupUsingSTV];
    
  
  
    
    
	
	// Get managedObjectContext from application delegate
    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
	
    
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Assessments";
    
    
    SCEntityDefinition *testSessionDeliveredDef =[SCEntityDefinition definitionWithEntityName:@"TestingSessionDeliveredEntity"
                                                                         managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"dateOfService",  @"time",@"clientPresentations",  @"notes", @"paperwork", @"assessmentType",     @"supervisor",    @"trainingType", @"site",  @"eventIdentifier",     nil]];        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    NSInteger eventIdentifierPropertyIndex = [testSessionDeliveredDef indexOfPropertyDefinitionWithName:@"eventIdentifier"];
    [testSessionDeliveredDef removePropertyDefinitionAtIndex:eventIdentifierPropertyIndex];
    
    SCPropertyDefinition *dateOfServicePropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"dateOfService"];
	dateOfServicePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                         datePickerMode:UIDatePickerModeDate 
                                                          displayDatePickerInDetailView:YES];
    
    dateOfServicePropertyDef.title=@"Testing Date";
    SCPropertyDefinition *notesPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"notes"];
    notesPropertyDef.type=SCPropertyTypeTextView;
    
    testSessionDeliveredDef.titlePropertyName=@"dateOfService";
    testSessionDeliveredDef.keyPropertyName=@"dateOfService";
    
    
    //add a button to add an event to the calandar
    
    //create a custom property definition for the Button Cell
    
    NSDictionary *buttonCellObjectBinding=[NSDictionary dictionaryWithObject:@"eventIdentifier" forKey:@"event_identifier"];
    SCCustomPropertyDefinition *eventButtonProperty = [SCCustomPropertyDefinition definitionWithName:@"EventButtonCell" uiElementClass:[ButtonCell class] objectBindings:buttonCellObjectBinding];
    
    //add the property definition to the test administration detail view  
    [testSessionDeliveredDef addPropertyDefinition:eventButtonProperty];
    //define a property group
    SCPropertyGroup *eventGroup = [SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"dateOfService",@"time",@"clientPresentations", @"EventButtonCell",nil]];
    
    // add the event Group property group to the behavioralObservationsDef class. 
    [testSessionDeliveredDef.propertyGroups addGroup:eventGroup];
    
    
    SCPropertyGroup *peopleGroup =[SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"SupervisorData",@"paperwork",   @"notes",nil]];
    
    
    
    [testSessionDeliveredDef.propertyGroups addGroup:peopleGroup];
    
    
    SCPropertyGroup *detailsGroup =[SCPropertyGroup groupWithHeaderTitle:@"Administration Details" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"testsAdministered",@"assessmentType",@"treatmentSetting",@"trainingType", @"relatedSupportTime", nil]];
    
    
    
    [testSessionDeliveredDef.propertyGroups addGroup:detailsGroup]; 
    
    
    
    SCPropertyDefinition *licenseNumbersCreditedPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"licenseNumbersCredited"];
    licenseNumbersCreditedPropertyDef.title=@"Licenses Credited";
    
    SCPropertyGroup *creditsGroup =[SCPropertyGroup groupWithHeaderTitle:@"Credits" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"degreesCredited",@"certificationsCredited",@"licenseNumbersCredited",nil]];
    
    
    [testSessionDeliveredDef.propertyGroups addGroup:creditsGroup];
    
    
    
    [testSessionDeliveredDef removePropertyDefinitionWithName:@"supervisor"];
    
    //create the dictionary with the data bindings
    NSDictionary *clinicianDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObjects:@"supervisor",@"Supervisor",[NSNumber numberWithBool:NO],@"supervisor",[NSNumber numberWithBool:NO],nil] 
                                           forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *clinicianDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SupervisorData"
                                                                                        uiElementClass:[ClinicianSelectionCell class] objectBindings:clinicianDataBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    clinicianDataProperty.autoValidate=FALSE;
    
    
    [testSessionDeliveredDef insertPropertyDefinition:clinicianDataProperty atIndex:1];
    
    
    /****************************************************************************************/
    /*	END of Class Definition and attributes for the Client Entity */
    /****************************************************************************************/
    
    
    SCPropertyDefinition *clientsPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"clients"];
    
   	clientsPropertyDef.type = SCPropertyTypeObjectSelection;
    
    
    
    
    
    
    
    
    
    SCEntityDefinition *testSessionTypeDef=[SCEntityDefinition definitionWithEntityName:@"TestingSessionTypeEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"assessmentType", @"notes", nil]];
    
    
    
    
    testSessionTypeDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *testingSessionTypePropertyDef=[testSessionDeliveredDef propertyDefinitionWithName:@"assessmentType"];
    testingSessionTypePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *testSessionTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:testSessionTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    testSessionTypeSelectionAttribs.allowAddingItems = YES;
    testSessionTypeSelectionAttribs.allowDeletingItems = YES;
    testSessionTypeSelectionAttribs.allowMovingItems = YES;
    testSessionTypeSelectionAttribs.allowEditingItems = YES;
    testSessionTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Administration Types)"];
    testSessionTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Administration Type"];
    testingSessionTypePropertyDef.attributes = testSessionTypeSelectionAttribs;
    
    SCPropertyDefinition *testSessionTypePropertyDef=[testSessionTypeDef propertyDefinitionWithName:@"assessmentType"];
    testSessionTypePropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *testSessionTypeNotesPropertyDef=[testSessionTypeDef propertyDefinitionWithName:@"notes"];
    testSessionTypeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    //Training Type  start
    SCEntityDefinition *trainingTypeDef=[SCEntityDefinition definitionWithEntityName:@"TrainingTypeEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"trainingType",@"selectedByDefault", @"notes", nil]];
    
    
    
    
    
    
    
    trainingTypeDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *sessionTrainingTypePropertyDef=[testSessionDeliveredDef propertyDefinitionWithName:@"trainingType"];
    sessionTrainingTypePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *trainingTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:trainingTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    trainingTypeSelectionAttribs.allowAddingItems = YES;
    trainingTypeSelectionAttribs.allowDeletingItems = YES;
    trainingTypeSelectionAttribs.allowMovingItems = YES;
    trainingTypeSelectionAttribs.allowEditingItems = YES;
    trainingTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Training Types)"];
    trainingTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Training Type"];
    sessionTrainingTypePropertyDef.attributes = trainingTypeSelectionAttribs;
    
    SCPropertyDefinition *trainingTypePropertyDef=[trainingTypeDef propertyDefinitionWithName:@"trainingType"];
    trainingTypePropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *trainingTypeNotesPropertyDef=[trainingTypeDef propertyDefinitionWithName:@"notes"];
    trainingTypeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    //training type end
    
    
    
    
    
    
    SCPropertyDefinition *timePropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"time"];
    timePropertyDef.attributes = [SCObjectAttributes attributesWithObjectDefinition:self.timeDef];
    
    timePropertyDef.title=@"Testing Time";
    
    
    
    
    
    
    //create an array of objects definition for the clientPresentation to-many relationship that with show up in a different view  without a place holder element>.
    
    //Create the property definition for the clientPresentations property
    
    SCPropertyDefinition *clientPresentationsPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"clientPresentations"];
    clientPresentationsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:clientPresentations_Shared.clientPresentationDef
                                                                                          allowAddingItems:YES
                                                                                        allowDeletingItems:YES
                                                                                          allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"tap + to add clients"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:NO];	
    
    clientPresentationsPropertyDef.title=@"Clients Tested";
    
    //Create the property definition for the papwerwork property in the testsessiondelivered class
    SCPropertyDefinition *paperworkPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"paperwork"];
    
    //set the property definition type to segmented
    paperworkPropertyDef.type = SCPropertyTypeSegmented;
    
    //set the segmented attributes for the paperwork property definition 
    paperworkPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Incomplete", @"Complete",  nil]];
    
    
    
    
    NSPredicate *paperworkIncompletePredicate = [NSPredicate predicateWithFormat:@"paperwork == %@",[NSNumber numberWithInteger: 0]];
    //     tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self
    //										withEntityClassDefinition:testSessionDeliveredDef usingPredicate:paperworkIncompletePredicate];
    SCArrayOfObjectsModel *objectModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:testSessionDeliveredDef filterPredicate:paperworkIncompletePredicate];
    
    //    self.tableViewModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView 
    //										entityDefinition:testSessionDeliveredDef];
    [self.searchBar setSelectedScopeButtonIndex:2];
    // Initialize tableModel
    //    if (self.navigationItem.rightBarButtonItems.count>1) {
    //        
    //        objectModel.addButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:1];
    //    }
    //
    //   
    //    
    //    if (self.navigationItem.rightBarButtonItems.count >0)
    //    {
    //        self.tableViewModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:0];
    //    }
    
    
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    NSLog(@"self.navigationItem.rightBarButtonItems are %@",self.buttonsToolbar.items);
    
    objectModel.editButtonItem = self.editButton;;
    
    objectModel.addButtonItem = self.addButton;
    
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    objectModel.autoSortSections = TRUE;  
    objectModel.searchBar = self.searchBar;
	objectModel.searchPropertyName = @"dateOfService";
    
    objectModel.allowMovingItems=TRUE;
    
    objectModel.autoAssignDelegateForDetailModels=TRUE;
    objectModel.autoAssignDataSourceForDetailModels=TRUE;
    
    
    objectModel.enablePullToRefresh = TRUE;
    objectModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    
    self.tableViewModel=objectModel;
    [self updateAdministrationTotalLabel:self.tableViewModel];
    

  
    [self.searchBar setSelectedScopeButtonIndex:2];
    // Initialize tableModel

    if ([SCUtilities is_iPad]) {
        
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
    }
        [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    
  
    
    self.view.backgroundColor=[UIColor clearColor];
    
 
    counterDateFormatter=[[NSDateFormatter alloc]init];
    [counterDateFormatter setDateFormat:@"HH:mm:ss"];
    
    [counterDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];  
    
    
    referenceDate=[counterDateFormatter dateFromString:@"00:00:00"];
    
    // Initialize an event store object with the init method. Initilize the array for events.
	self.eventStore = [[EKEventStore alloc] init];
    
	self.eventsList = [[NSMutableArray alloc] initWithArray:0];
    // find local source
    //    EKSource *localSource = nil;
    //    for (EKSource *source in eventStore.sources){
    //        if (source.sourceType == EKSourceTypeLocal)
    //        {
    //            localSource = source;
    //            
    //            break;
    //        }
    //    }
    
    self.psyTrackCalendar=[ self eventEditViewControllerDefaultCalendarForNewEvents:nil];
    
    
    
    //                 NSSet *calendars=(NSSet *)[localSource calendars];
    //                    for(id obj in calendars) { 
    //                    if([obj isKindOfClass:[EKCalendar class]]){
    //                        EKCalendar *calendar=(EKCalendar *)obj;
    //                        if ([calendar.calendarIdentifier isEqualToString:self.psyTrackCalendar.calendarIdentifier]) {
    //                            self.psyTrackCalendar=(EKCalendar *)calendar;
    //                          
    //                            break;
    // 
    // Get the default calendar from store.
	
    
    //	    
    
    
    
}


//-(void)didMoveToParentViewController:(UIViewController *)parent{
//
//NSLog(@"will move to parent %@",parent);
//    if (!parent) {
//        [self viewDidUnload];
//    }
//}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.    
    return YES;
}





- (void)tableViewModel:(SCArrayOfItemsModel *)tableViewModel
searchBarSelectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
    //NSLog(@"scope changed");
    
    
    
    
    if([tableViewModel isKindOfClass:[SCArrayOfObjectsModel class]])
    {
        SCArrayOfObjectsModel *objectsModel = (SCArrayOfObjectsModel *)tableViewModel;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit ) fromDate:[NSDate date]];
        //create a date with these components
        NSDate *startDate = [calendar dateFromComponents:components];
        [components setMonth:1];
        [components setDay:0]; //reset the other components
        [components setYear:0]; //reset the other components
        NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
        //NSLog(@"start dtate %@",startDate);
        //NSLog(@"end date is %@", endDate);
        
        NSPredicate *currentMonthPredicate = [NSPredicate predicateWithFormat:@"((dateOfService > %@) AND (dateOfService <= %@)) || (dateOfService = nil)",startDate,endDate];
        NSPredicate *paperworkIncompletePredicate = [NSPredicate predicateWithFormat:@"paperwork == %@",[NSNumber numberWithInteger: 0]];
        
        
        [self.searchBar setSelectedScopeButtonIndex:selectedScope];
        
        switch (selectedScope) {
            case 1: //all
                
                
                [objectsModel.dataFetchOptions setFilterPredicate:nil];
                //             
                break;
                
            case 2: //case paperwork Incomplete
                [objectsModel.dataFetchOptions setFilterPredicate:paperworkIncompletePredicate];
                
                
                
                
                break;                
                
            default://current month
                
                [objectsModel.dataFetchOptions setFilterPredicate:currentMonthPredicate];
                
                
                
                
                break;
        }
        [objectsModel reloadBoundValues];
        [objectsModel.modeledTableView reloadData]; 
    }
}








-(void)tableViewModel:(SCTableViewModel *)tableViewModel didRemoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableViewModel.tag==0) {
        
        [self updateAdministrationTotalLabel:tableViewModel];
        
    }
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel didRemoveSectionAtIndex:(NSUInteger)index{
    
    if (tableViewModel.tag==0) {
        
        [self updateAdministrationTotalLabel:tableViewModel];
        
    }
    
    
}

-(void)updateAdministrationTotalLabel:(SCTableViewModel *)tableModel{
    
    if (tableModel.tag==0) {
        
        int cellCount=0;
        NSLog(@" table view model section count is %i",tableModel.sectionCount);
        if (tableModel.sectionCount >0){
            
            for (int i=0; i<tableModel.sectionCount; i++) {
                SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:i];
                cellCount=cellCount+section.cellCount;
                
            }
            
            
        }
        if (cellCount==0)
        {
            self.totalAdministrationsLabel.text=@"Tap + To Add Administrations";
        }
        else
        {
            self.totalAdministrationsLabel.text=[NSString stringWithFormat:@"Total Administrations: %i", cellCount];
        }
        
        
        
    }
    
    
    
    
}




-(void)tableViewModel:(SCTableViewModel *)tableModel didInsertRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    [self tableViewModel:(SCTableViewModel *)tableViewModel testFetchForRowAtIndexPath:(NSIndexPath *) indexPath];
    
    
    if (tableModel.tag==0) 
    {
        
        [self updateAdministrationTotalLabel:tableModel];
    }
    
    
    
    
}


-(void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    ////NSLog(@"table view tag is %i",tableViewModel.tag);
    //    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
    
    NSLog(@"tab tag %i",tableViewModel.tag);
    NSLog(@"indext path section is %i", indexPath.section);
    if(tableViewModel.tag==1 &&indexPath.section==1){
        //        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        //NSLog(@"cell bound object is %@",cellManagedObject);
        //NSLog(@"cell.tag%i",cell.tag);
        //NSLog(@"section managed object is %@",cellManagedObject.entity.name);
        switch (cell.tag) {
            case 0:
            {
                if ([cell isKindOfClass:[SCDateCell class]]){
                    serviceDateCell=(SCDateCell *)cell;
                }
            }
                break;
            case 1:
            {
                if ([cell isKindOfClass:[SCObjectCell class]]) {
                    
                    
                    if (![cell viewWithTag:28] ) {
                        
                        UILabel *totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-125, 5, 85, 30)];
                        
                        
                        totalTimeLabel.tag=28;
                        totalTimeLabel.text=[NSString stringWithFormat:@"00:00:00"];
                        totalTimeLabel.backgroundColor=[UIColor clearColor];
                        totalTimeLabel.textAlignment=UITextAlignmentRight;
                        totalTimeLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
                        [totalTimeLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:18]];
                        totalTimeLabel.textColor=[UIColor colorWithRed:50.0f/255 green:69.0f/255 blue:133.0f/255 alpha:1.0];
                        [cell addSubview:(UIView *)totalTimeLabel];
                        
                        
                    }
                }
                
            }
                break;  
                
                
            case 3:
            {
                if ([cell isKindOfClass:[ButtonCell class]]) {
                    NSLog(@"eventidentifier bound object %@",cell.boundObject);
                    NSString *eventIdentifier=[cell.boundObject valueForKey:@"eventIdentifier"]; 
                    
                    
                    //NSLog(@"event Identifier %@", cell.boundObject);
                    NSString *buttonText;
                    if (eventIdentifier.length) {
                        buttonText=[NSString stringWithString:@"Edit This Calendar Event"];
                    }
                    else {
                        buttonText=[NSString stringWithString:@"Add Event to Calendar"];
                    }
                    ButtonCell *buttonCell=(ButtonCell *)cell;
                    UIButton *button=buttonCell.button;
                    [button setTitle:buttonText forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(addEvent:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                
            }
                break;
                
                
                
            default:
                break;
        }
    }
     NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
    if (tableViewModel.tag==2) {
        
       
        if (cellManagedObject&& [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) {
       
        
        if (indexPath.section==0) {
            
            if (cell.tag==2||cell.tag==3) 
                
            {
                if ([cell isKindOfClass:[SCDateCell class]]) {
                    SCDateCell *dateCell= (SCDateCell *) cell;
                    //define a gregorian calandar
                    //                    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                    //                    
                    
                    [dateCell.dateFormatter setDefaultDate:referenceDate];
                    
                    [dateCell.dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                    
                    [dateCell.datePicker setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                }
                
            }
            
            
            switch (cell.tag) 
            {
                    
                    
                case 5:
                {
                    
                    if ([cell class]==[StopwatchCell class]) {
                        stopwatchCell=(StopwatchCell *)cell;
                        stopwatchTextField=(UITextField *)stopwatchCell.stopwatchTextField;
                        
                        [[NSNotificationCenter defaultCenter]
                         addObserver:self
                         selector:@selector(stopwatchUpdated:)
                         name:@"addStopwatchChanged"
                         object:nil];
                        
                        [[NSNotificationCenter defaultCenter]
                         addObserver:self
                         selector:@selector(stopwatchReset:)
                         name:@"stopwatchResetButtonTapped"
                         object:nil];  
                        
                        [[NSNotificationCenter defaultCenter]
                         addObserver:self
                         selector:@selector(stopwatchStop:)
                         name:@"stopwatchStopButtonTapped"
                         object:nil];
                        
                        timeSection=[tableViewModel sectionAtIndex:0];
                    }
                    
                    
                }
                    
                    break;
                case 4:
                {
                    
                    if ([cell isKindOfClass:[ButtonCell class]]) {
                        
                        
                        UIButton *button =(UIButton *)[cell viewWithTag:300];
                        [button setTitle:@"Clear Times" forState:UIControlStateNormal];
                        button.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
                        cell.backgroundColor=[UIColor clearColor];
                        
                        
                    }
                }
                    break;
                    
                default:
                    break;
            }
            
        }  
        }
        if (indexPath.section==1) {
            
            
            if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) 
            {
                
                if (![cell viewWithTag:28]) {
                    
                    
                    
                    UILabel *totalBreakTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-125, 5, 85, 30)];
                    totalBreakTimeLabel.tag=28;
                    totalBreakTimeLabel.text=[NSString stringWithFormat:@"00:00:00"];
                    totalBreakTimeLabel.backgroundColor=[UIColor clearColor];
                    totalBreakTimeLabel.textAlignment=UITextAlignmentRight;
                    totalBreakTimeLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
                    [totalBreakTimeLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:18]];
                    totalBreakTimeLabel.textColor=[UIColor colorWithRed:50.0f/255 green:69.0f/255 blue:133.0f/255 alpha:1.0];
                    [cell addSubview:(UIView *)totalBreakTimeLabel];
                    
                    [cell reloadInputViews];
                }
            }
            
        }
        
    }
    
    if (tableViewModel.tag==3) 
    {
        
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
            
            
            
            if (cell.tag==4) {
                if ([cell isKindOfClass:[ButtonCell class]]) 
                {
                    UIButton *button =(UIButton *)[cell viewWithTag:300];
                    [button setTitle:@"Clear Times" forState:UIControlStateNormal];
                    button.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
                    cell.backgroundColor=[UIColor clearColor];
                }
            }
            
            
        }
        
            
        
        
        
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) 
        {
            if (tableViewModel.delegate!=clientPresentations_Shared) 
            {
//                SCArrayOfObjectsModel *arrayOfObjectsModel=(SCArrayOfObjectsModel *)self.tableViewModel;
//                clientPresentations_Shared.tableModel=arrayOfObjectsModel;
                tableViewModel.delegate=clientPresentations_Shared;
                if (serviceDateCell.label.text.length) 
                {
                    clientPresentations_Shared.serviceDatePickerDate=(NSDate *)serviceDateCell.datePicker.date;
                }
                
                
                
                //NSLog(@"delegate switched to client presentation shared");
                
            }
            
        }
        
        
    }

  }





-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillDismissForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    currentDetailTableViewModel=tableViewModel;
        
    if (tableViewModel.tag==0) {
        serviceDateCell=nil;
        self.eventViewController=nil;
        if (clientPresentations_Shared) {
            clientPresentations_Shared.serviceDatePickerDate=nil;
        }
        
    }
    if (tableViewModel.tag==1){
        [stopwatchCell invalidateTheTimer];
        [[NSNotificationCenter defaultCenter]
         removeObserver:self];
        [[NSNotificationCenter defaultCenter]
         removeObserver:self];
        
        [[NSNotificationCenter defaultCenter]
         removeObserver:self];
        //    [self calculateTime];
        viewControllerOpen=FALSE;

        
        viewControllerOpen=FALSE;
        [tableViewModel.modeledTableView reloadData];
        //           [self timerDestroy];
        
        //           stopwatchRunning=nil;
        //           stopwatchIsRunningBool=NO;
        //           viewControllerOpen=NO;
        //           
        
        
    }
    
    
}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillPresentForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    currentDetailTableViewModel=detailTableViewModel;
    
    if (tableViewModel.tag==2 && tableViewModel.sectionCount ==1) 
    {
        
        
        
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
        
        
        //NSLog(@"tableview model data source %@",tableViewModel.dataSource);
        if (section.cellCount>0) 
        {
            SCTableViewCell *cell=(SCTableViewCell *)[section cellAtIndex:0];
            
            if (section.cellCount>1 || (section.cellCount==1 &&![cell.textLabel.text isEqualToString:@"tap + to add clients"])) 
            {
                
                NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
                //NSLog(@"cell managed object is%@ ",cellManagedObject.entity.name);
                if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&& [cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) {
                    
                    SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)[tableViewModel sectionAtIndex:0];
                    NSMutableSet *mutableSet=[(NSMutableSet *)arrayOfObjectsSection.items mutableSetValueForKey:@"client"];
                    
                    NSLog(@"mutable set is %@",mutableSet);
                    SCArrayOfObjectsSection *mainSection=(SCArrayOfObjectsSection *)[detailTableViewModel sectionAtIndex:0];
                    if (mainSection.cellCount) {
                        SCTableViewCell *cellAtZero=(SCTableViewCell *)[mainSection cellAtIndex:0];
                        
                        if ([cellAtZero isKindOfClass:[ClientsSelectionCell class]]) {
                            ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)[mainSection cellAtIndex:0];
                            clientSelectionCell.alreadySelectedClients=mutableSet;
                            
                            //NSLog(@"client items are12345 %@",mutableSet);
                            clientSelectionCell.hasChangedClients=NO;
                        }
                       

                    }
                                        
                }
                
            }
            
            
            else if ([cell.textLabel.text isEqualToString:@"tap + to add clients"]&&detailTableViewModel.sectionCount) 
            {
               
                SCArrayOfObjectsSection *mainSection=(SCArrayOfObjectsSection *)[detailTableViewModel sectionAtIndex:0];
                if (mainSection.cellCount) {
                    SCTableViewCell *cellAtZero=(SCTableViewCell *)[mainSection cellAtIndex:0];
                    
                    if ([cellAtZero isKindOfClass:[ClientsSelectionCell class]]) {
                        ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)[mainSection cellAtIndex:0];
                        clientSelectionCell.alreadySelectedClients=[NSMutableSet set];
                    }
                  
                }
            
                
            }
            
            
            
        }
    }
    
    
    
    
    
}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewDidAppearForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    self.eventViewController=nil;
    
    
    
}
-(void)tableViewModel:(SCTableViewModel *)tableModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{

    currentDetailTableViewModel=detailTableViewModel;




}

//-(void)tableViewModel:(SCTableViewModel *)tableModel detailModelConfiguredForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
//
//
//
////    if (indexPath.row!=NSNotFound) {
////        SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
////        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
////        if (detailTableViewModel.tag==2 ||tableModel.tag==1) 
////        {
////            
////            
////            //NSLog(@"cell managed object is%@ ",cellManagedObject.entity.name);
////            //NSLog(@"detail model class is %@",[detailTableViewModel class]);
////            if (cellManagedObject &&[cellManagedObject respondsToSelector:@selector(entity)] &&[cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) 
////            {
////                
////                
////                
////                time_Shared.tableViewModel=detailTableViewModel;
////                time_Shared.tableViewModel.delegate=time_Shared;
////                //                tableModel.detailViewController=time_Shared;
////            }
////            
////        }    
////        
////    }
//
//
//}

-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    [self tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForSectionAtIndex:(NSUInteger)indexPath.section withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel];
    
    if (tableModel.tag==0||tableModel.tag==1) {
        currentDetailTableViewModel=detailTableViewModel;
        
    }
    NSLog(@"tableviewmodel tag is %i",tableModel.tag);

    if ([SCUtilities is_iPad]) {
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        

        UIColor *backgroundColor=nil;
        if(indexPath.row==NSNotFound|| tableModel.tag>0)
        {
            backgroundColor=(UIColor *)(UIView *)[(UIWindow *)appDelegate.window viewWithTag:5].backgroundColor;
        }
        else {
            backgroundColor=[UIColor clearColor];
        }
        
        if (detailTableViewModel.modeledTableView.backgroundColor!=backgroundColor) {
            
            [detailTableViewModel.modeledTableView setBackgroundView:nil];
            UIView *view=[[UIView alloc]init];
            [detailTableViewModel.modeledTableView setBackgroundView:view];
            [detailTableViewModel.modeledTableView setBackgroundColor:backgroundColor];
            
            
        }
    }
    
    if (detailTableViewModel.tag==2||detailTableViewModel.tag==3) {
        if (tableModel.sectionCount>1)
        {
            SCTableViewSection *sectionOne=nil;
            if (tableModel.tag==1 &&detailTableViewModel.sectionCount>1) {
                sectionOne=(SCTableViewSection *)[detailTableViewModel sectionAtIndex:0];
            }
            else {
                sectionOne=(SCTableViewSection *)[tableModel sectionAtIndex:0];
            }
            
            if (sectionOne.cellCount) {
                SCTableViewCell *cellOne=(SCTableViewCell *)[sectionOne cellAtIndex:0];
                
                NSManagedObject *cellOneManagedObject=(NSManagedObject *)cellOne.boundObject;
                
                if (cellOneManagedObject && [cellOneManagedObject respondsToSelector:@selector(entity)]&& [cellOneManagedObject.entity.name isEqualToString:(NSString *)@"TimeEntity"]) {
                    [detailTableViewModel.modeledTableView setEditing:YES animated:NO];
                }
                
            }
            
        }
            
    }
    
    if (tableModel.tag==2 && tableModel.sectionCount ==1) {
        
        
        SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:0];
        
        if (section.cellCount>0) 
        {
            
            SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
            NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
            //NSLog(@"cell managed object is%@ ",cellManagedObject.entity.name);
            if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] &&[cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) {
                
                SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)section;
                NSMutableSet *mutableSet=[(NSMutableSet *)arrayOfObjectsSection.items mutableSetValueForKey:@"client"];
                
                NSLog(@"mutable set is %@",mutableSet);
                if (detailTableViewModel.sectionCount) {
               
                SCArrayOfObjectsSection *mainSection=(SCArrayOfObjectsSection *)[detailTableViewModel sectionAtIndex:0];
                if (mainSection.cellCount) {
                    SCTableViewCell *cellAtZero=(SCTableViewCell *)[mainSection cellAtIndex:0];
                    
                    if ([cellAtZero isKindOfClass:[ClientsSelectionCell class]]) {
                        ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)[mainSection cellAtIndex:0];
                        clientSelectionCell.alreadySelectedClients=mutableSet;
                        
                        //NSLog(@"client items are12345 %@",mutableSet);
                        clientSelectionCell.hasChangedClients=NO;
                    }
                    
                    
                }
                    
                }
                
                //NSLog(@"client items are12345 %@",mutableSet);
                
            }
        } 
    }
}


- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
    
    //    NSManagedObject *sectionManagedObject=(NSManagedObject *)section.boundObject;
    
    
    NSManagedObject *sectionManagedObject=(NSManagedObject *)section.boundObject;
    
    if(section.headerTitle !=nil)
    {
        
        //        if (!(tableViewModel.tag ==2 && index==0 &&[sectionManagedObject.entity.name isEqualToString:@"TimeEntity"] )) 
        //        {
       
                
        if (!(tableViewModel.tag ==2 && index==0 &&sectionManagedObject &&[sectionManagedObject respondsToSelector:@selector(entity)] &&[sectionManagedObject.entity.name isEqualToString:@"TimeEntity"]) ) 
        {
            
            
            UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
            UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
            headerLabel.tag=60;
            
            headerLabel.backgroundColor = [UIColor clearColor];
            headerLabel.textColor = [UIColor whiteColor];
            
            if (tableViewModel.tag ==2 && index==1) {
                headerLabel.text= [self  totalBreakTimeString];
                
                [self calculateTime];
            }
            else
            {
                headerLabel.text=section.headerTitle;
                
            }
            
            [containerView addSubview:headerLabel];
            
            section.headerView = containerView;
            
            
            
        }
        else {
            UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
            UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
            
            
            headerLabel.backgroundColor = [UIColor clearColor];
            headerLabel.textColor = [UIColor whiteColor];
            headerLabel.tag=60;
            headerLabel.text=section.headerTitle;
            [containerView addSubview:headerLabel];
            
            section.headerView = containerView;

            
        }

        
        //        }
        
    }
    
    
    
    
  
    if (tableViewModel.tag ==2 && index==1) 
        
    { 
        [section editingModeDidChange];
        
    }
    
    if((tableViewModel.tag==2 && index==0 &&sectionManagedObject && [sectionManagedObject.entity.name isEqualToString:@"TimeEntity"])||(tableViewModel.tag==3 &&index==0 && sectionManagedObject && [sectionManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]))
    {
        
        
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        containerView.autoresizingMask=UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleRightMargin;
        
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        
        headerLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        headerLabel.backgroundColor = [UIColor blackColor];
        headerLabel.alpha=0.5;
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.font=[UIFont fontWithName:@"Arial Rounded MT Bold" size:30];
        
        
        
        
        
        [containerView addSubview:headerLabel];
        headerLabel.textAlignment=UITextAlignmentCenter;
        section.headerView = containerView;
        
        
        switch (tableViewModel.tag) {
            case 2:
                totalTimeHeaderLabel=headerLabel;
                break;
                
            case 3:
                breakTimeTotalHeaderLabel=headerLabel;
                break;
                
                
            default:
                break;
        }
        
        
        //        section.footerView.autoresizingMask=;
        //        
        //       //NSLog(@"section width is is %f",section.footerView.frame.size.width;
        
    }
    

    if (tableViewModel.tag==3 && tableViewModel.sectionCount&&index==0) {
        
        
      
        SCTableViewSection *sectionOne=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
        SCTableViewCell *sectionOneClicianCell=(SCTableViewCell *)[sectionOne cellAtIndex:0];
        NSManagedObject *cellManagedObject=(NSManagedObject *)sectionOneClicianCell.boundObject;        
        
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) 
        
        {
            //if change the cell text then update the method that sets the age with the new cell text
            SCLabelCell *actualAge=[SCLabelCell cellWithText:@"Test Age" boundObject:nil labelTextPropertyName:@"Age"];
            SCLabelCell *wechslerAge=[SCLabelCell cellWithText:@"Wechlsler Test Age" boundObject:nil labelTextPropertyName:@"WechslerAge"];
            actualAge.label.text=[NSString stringWithString: @"0y 0m"];
            wechslerAge.label.text=[NSString stringWithFormat:@"%iy %im",0,0];
            [section addCell:actualAge];
            [section addCell:wechslerAge];
        
        }
}
}



- (void)tableViewModel:(SCTableViewModel *)tableViewModel 
       willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;
    
    
    
    if (tableViewModel.tag==0) 
    {
        
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        //set the date format
        [dateFormatter setDateFormat:@"MMM d, yyyy"];
        //Set the date attributes in the  property definition and make it so the date picker appears 
        cell.textLabel.text= [dateFormatter stringFromDate:[cellManagedObject valueForKey:@"dateOfService"]];
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]) {
            
            
            
            //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
            if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
                
            NSLog(@"entity name is %@",cellManagedObject.entity.name);
                //identify the Languages Spoken table
                
                if ([cellManagedObject.entity.name isEqualToString:@"TestingSessionDeliveredEntity"]) {
                    //NSLog(@"the managed object entity is Languag spoken Entity");
                    //get the value of the primaryLangugage attribute
                    NSNumber *paperworkNumber=(NSNumber *)[cellManagedObject valueForKey:@"paperwork"];
                    
                    
                    //NSLog(@"primary alanguage %@",  paperworkNumber);
                    //if the paperwork selection is Yes
                    if (paperworkNumber==[NSNumber numberWithInteger:0]) {
                        //set the text color to red
                        cell.textLabel.textColor=[UIColor redColor];
                    }
                    
                    NSMutableSet *clientSet=[cellManagedObject mutableSetValueForKeyPath:@"clientPresentations.client.clientIDCode"];
                    
                    //NSLog(@"client set is %@",clientSet);
                    
                    NSString *clientsString=[NSString string];
                    if ([clientSet count]) {
                        for (id obj in clientSet){
                            clientsString=[clientsString stringByAppendingFormat:@" %@,",obj];
                            
                            
                        }
                        
                    }
                    
                    NSString *cellTextString=[cell.textLabel text];
                    if ( [clientsString length] > 1){
                        clientsString = [clientsString substringToIndex:[clientsString length] - 1];
                        clientsString =[clientsString substringFromIndex:1]; 
                        if (cellTextString.length) {
                            cellTextString=[cellTextString stringByAppendingFormat:@": %@ ",clientsString];
                            
                        }
                    }
                    
                    
                    
                    NSString *notesString=[cellManagedObject valueForKey:@"notes"];
                    
                    if (notesString.length &&cellTextString.length) {
                        cellTextString=[cellTextString stringByAppendingFormat:@"; %@",notesString];
                    }
                    else if(notesString.length &&!cellTextString.length){
                        cellTextString=notesString;
                    }
                    
                    [cell.textLabel setText:cellTextString];
                    
                    //NSLog(@"cell text label text is %@",cell.textLabel.text);
                    
                }
            }
            
        }
        
        
        
    }
    
    
    if (tableViewModel.tag==1) 
    {
        
        
        if (cell.tag==1)
        {
            //NSLog(@"cell is kind of class %@",[cell class]);
            if ([cell isKindOfClass:[SCObjectCell class]]) 
            {
               
                NSDate *totalTimeDateBoundValue=(NSDate *)[cell.boundObject valueForKey:@"totalTime"];
                //NSLog(@"total time date in will display cell objects %@", totalTimeDate);
                NSString *totalTimeString=[counterDateFormatter stringFromDate:totalTimeDateBoundValue];
                
                NSLog(@"total time date is %@",[counterDateFormatter stringFromDate:totalTimeDateBoundValue]);
                UILabel *totalTimeLabel=(UILabel *)[cell viewWithTag:28];
                totalTimeLabel.text=totalTimeString;
                
                BOOL stopwatchIsRunning =(BOOL)[[cell.boundObject valueForKey:@"stopwatchRunning"]boolValue];
                
                if (stopwatchIsRunning)
                {
                    
                    totalTimeLabel.textColor=[UIColor redColor];
                    
                }
                else
                {
                    
                    totalTimeLabel.textColor=[UIColor colorWithRed:50.0f/255 green:69.0f/255 blue:133.0f/255 alpha:1.0];
                    
                }
            }
        }
        //        UIView *view=(UIView *)[timeCell viewWithTag:5];
        //        UILabel*lable =(UILabel*)view;
        //        lable.text=@"test";
        //        timeCell.label.text=(NSString *)[counterDateFormatter stringFromDate:totalTimeDate];
        
    }
    
    
    
    if (tableViewModel.tag==2) {
        
        
        
        
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) {
            
            if (cell.tag>=0 && cell.tag<4) {
                if ([cell isKindOfClass:[SCDateCell class]]){
                    SCDateCell *dateCell=(SCDateCell *)cell;
                    
                    switch (cell.tag) {
                        case 0:
                            startTime=[cellManagedObject valueForKey:@"startTime"];
                            break;
                        case 1:
                            endTime=[cellManagedObject valueForKey:@"endTime"];
                            break;
                        case 2:
                            additionalTime=dateCell.datePicker.date;
                            [dateCell.dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                            break;
                            
                        case 3:
                            timeToSubtract=dateCell.datePicker.date;
                            [dateCell.dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                            break;
                            
                            
                    }
                    
                }
            }
            
            
            if (cell.tag==5) 
            {
                
                if ([cell isKindOfClass:[StopwatchCell class]]) 
                {
                    
                    addStopwatch=(NSDate *)[cell.boundObject valueForKey:@"addStopwatch"];
                    
                    
                    
                    //set the date format
                    
                    //                n  
                    //                   
                    //                
                    stopwatchTextField.text=[stopwatchCell.stopwatchFormat stringFromDate:addStopwatch];
                    
                    
                    BOOL stopwatchIsRunningBool;
                    stopwatchIsRunningBool=(BOOL )[[cellManagedObject valueForKey:@"stopwatchRunning"] boolValue];
                    
                    
                    if (stopwatchIsRunningBool &&!viewControllerOpen) 
                    {
                        [stopwatchCell startButtonTapped:self];
                    }
                    if (!viewControllerOpen) {
                        [self calculateTime];
                    }
                    viewControllerOpen=YES;
                    
                }
            }
            
            
        }
        else
        {
            
            
            if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) 
            {
                
                
                
                UILabel *totalTimeLabel=(UILabel *)[cell viewWithTag:28];
                totalTimeLabel.text=[self tableViewModel:tableViewModel calculateBreakTimeForRowAtIndexPath:indexPath withBoundValues:YES];
                SCTableViewSection *section=[tableViewModel sectionAtIndex:1];
                
                NSString *totalBreakTimeString=(NSString *)[self totalBreakTimeString];
                UILabel *headerLabel=(UILabel *)[section.headerView viewWithTag:60];
                headerLabel.text=totalBreakTimeString;
                
            }
            
        }
    }
    if (tableViewModel.tag==3) 
    {
        
        
        
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
            
            
            //                    SCTableViewSection *section =(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
            //                   
//            if (!tableViewModel.modeledTableView.editing) {
//                [tableViewModel didTapEditButtonItem];
//                [tableViewModel.modeledTableView setEditing:TRUE]; 
//                
//            }
            
            
            
            
            
            
            if(cell.tag>0 && cell.tag<4 && indexPath.section==0) 
            {
                breakTimeTotalHeaderLabel.text=[self tableViewModel:tableViewModel calculateBreakTimeForRowAtIndexPath:indexPath withBoundValues:YES];
                
            }
        }
        
    }
    
    
    
    

    
    
}




-(void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        
    if (tableViewModel.tag==1) 
    {
        SCSelectionCell *cell=(SCSelectionCell *)[tableViewModel.modeledTableView cellForRowAtIndexPath:indexPath];
        //NSLog(@"cell.tag %i",cell.tag);
        if (cell.tag==0) {
            if ([cell isKindOfClass:[SCDateCell class]]){
                serviceDateCell=(SCDateCell *)cell;
            }
        }
        
        if (cell.tag==1) //time cell
        {
            
            
            
            
            
            
            //NSLog(@"cell is kind of class %@",[cell class]);
            if ([cell isKindOfClass:[SCObjectCell class]]) 
            {
            
                [cell.boundObject setValue:totalTimeDate forKey:@"totalTime"];
                [self tableViewModel:(SCTableViewModel *)tableViewModel 
                     willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath];
                
                currentDetailTableViewModel=tableViewModel;

                
                
            }
        }
            }
    
    
    if (tableViewModel.tag==2) {
        //NSLog(@"value changed for row at index path");
        currentDetailTableViewModel=tableViewModel;

        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) {
            
            
            switch (cell.tag) {
                case 0:
                {
                    
                    SCDateCell *startTimeCell =(SCDateCell *)cell;
                    
                    
                    startTime=(NSDate*)startTimeCell.datePicker.date;
                    
                    
                }
                    break;
                case 1:
                {
                    SCDateCell *endTimeCell =(SCDateCell *)cell;
                    
                    endTime=(NSDate*)endTimeCell.datePicker.date;
                    
                }
                    break;
                case 2:
                {
                    TimePickerCell *additionalTimeCell =(TimePickerCell *)cell;
                    
                    if ([additionalTimeCell respondsToSelector:@selector(timeValue)]) {
                        additionalTime=(NSDate*)additionalTimeCell.timeValue;
                    }
                    
                    
                }
                    break;
                    
                case 3:
                {
                    TimePickerCell *timeToSubtractCell =(TimePickerCell *)cell;
                    if ([timeToSubtractCell respondsToSelector:@selector(timeValue)]) {
                        timeToSubtract=(NSDate*)timeToSubtractCell.timeValue;

                    }
                                       
                }
                    break;
                    
                    
                default:
                    break;
            }
            
            [self calculateTime];
        }
        
    } 
    
    
    if (tableViewModel.tag==3) {
        
        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
            
            
            
            if (cell.tag==1||cell.tag==2||cell.tag==3)
                breakTimeTotalHeaderLabel.text=[self tableViewModel:tableViewModel calculateBreakTimeForRowAtIndexPath:indexPath withBoundValues:NO];
        }
        currentDetailTableViewModel=tableViewModel;

    } 
    
    
    
    
    
    
        
    
    
}








#pragma mark -
#pragma mark Add a new event

// If event is nil, a new event is created and added to the specified event store. New events are 
// added to the default calendar. An exception is raised if set to an event that is not in the 
// specified event store.
- (void)addEvent:(id)sender {
	
    EKEvent *thisEvent;
    
    
    //NSLog(@"add event sender is %@",[sender superclass]);
    if ([[sender class] isSubclassOfClass:[UIButton class]]) 
    {
        UIButton *button=(UIButton *)sender;
        UIView *buttonView=(UIView *)button.superview;
        //NSLog(@"button superview is %@",buttonView.superview);
        
        if ([buttonView.superview isKindOfClass:[ButtonCell class]]) 
        {
            ButtonCell *buttonCell=(ButtonCell *)buttonView.superview;
            
            
            NSManagedObject *buttonManagedObject=(NSManagedObject *)buttonCell.boundObject;
            NSString *eventIdentifier=(NSString *)[buttonManagedObject valueForKey:@"eventIdentifier"];
            //NSLog(@"event identifier in add event %@",eventIdentifier);
            if (eventIdentifier.length) {
                if (!eventViewController) {
                    
                    thisEvent= (EKEvent *)[self.eventStore eventWithIdentifier:eventIdentifier];
                    
                    self.eventViewController=[[EKEventEditViewController alloc]initWithNibName:nil bundle:nil];
                    [eventViewController setEvent:thisEvent];
                    
                    //                  
                }
            
                [currentDetailTableViewModel.viewController.navigationController presentModalViewController:eventViewController animated:YES];
                eventViewController.editViewDelegate=self;
            
                
            }
            
            else 
            {
                
                // When add button is pushed, create an EKEventEditViewController to display the event.
                EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:@"MyEKEventEditViewController" bundle:nil];
                //                UIView *addControllerView=(UIView *) addController.view;
                
                //                
                // set the addController's event store to the current event store.
                addController.eventStore = self.eventStore;
                thisEvent = (EKEvent *) addController.event;
                
                if (!self.psyTrackCalendar) {
                    [thisEvent setCalendar:[self eventEditViewControllerDefaultCalendarForNewEvents:addController]];
                }
                else {
                    [thisEvent setCalendar:self.psyTrackCalendar];
                }
                //NSLog(@"add new event calander %@",self.psyTrackCalendar);
                
                [buttonCell commitDetailModelChanges:currentDetailTableViewModel];
                
                [currentDetailTableViewModel.modeledTableView reloadData];
                
                NSManagedObject *buttonCellManagedObject=(NSManagedObject *)buttonCell.boundObject;
                
                //NSLog(@"button cell managed object is %@",buttonCellManagedObject);
                
                TimeEntity *timeEntity=(TimeEntity *)[buttonCellManagedObject valueForKey:@"time"];
                
                NSDate *testDate=(NSDate *)[buttonCellManagedObject valueForKey:@"dateOfService"];
                
                NSDate *calanderStartTime=(NSDate *)[timeEntity valueForKey:@"startTime"];
                //NSLog(@"time entity is %@",timeEntity);
                
                NSDate *calanderEndTime=(NSDate *)[timeEntity valueForKey:@"endTime"];
                
                
                NSDateFormatter *dateFormatterTime=[[NSDateFormatter alloc]init];
                
                [dateFormatterTime setTimeZone:[NSTimeZone defaultTimeZone]];
                
                
                
                NSDateFormatter *dateFormatterDate=[[NSDateFormatter alloc]init];
                
                [dateFormatterDate setTimeZone:[NSTimeZone defaultTimeZone]];
                
                [dateFormatterDate setDateFormat:@"MM/d/yyyy"];
                
                [dateFormatterTime setDateFormat:@"H:m"];
                
                NSDateFormatter *dateFormatterCombined=[[NSDateFormatter alloc]init];
                
                [dateFormatterCombined setTimeZone:[NSTimeZone defaultTimeZone]];
                
                [dateFormatterCombined setDateFormat:@"H:m MM/d/yyyy"];
                
                if (calanderStartTime && testDate) {
                    NSString *startDateString=[NSString stringWithFormat:@"%@ %@",[dateFormatterTime stringFromDate:startTime],[dateFormatterDate stringFromDate:testDate]];
                    
                    //NSLog(@"startDateString is %@",startDateString);
                    
                    startTime=[dateFormatterCombined dateFromString:startDateString];
                    //NSLog(@"startTime is %@",startTime);
                }
                
                if (calanderEndTime && testDate) {
                    NSString *endDateString=[NSString stringWithFormat:@"%@ %@",[dateFormatterTime stringFromDate:endTime],[dateFormatterDate stringFromDate:testDate]];
                    
                    //NSLog(@"startDateString is %@",endDateString);
                    
                    endTime=[dateFormatterCombined dateFromString:endDateString];
                    
                    //NSLog(@"end time is %@", endTime);
                }
                
                if (calanderStartTime&&calanderEndTime) {
                    thisEvent.startDate=calanderStartTime;
                    thisEvent.endDate=calanderEndTime;

                }else {
                    thisEvent.startDate=[NSDate date];
                    thisEvent.endDate=[NSDate dateWithTimeIntervalSinceNow:60*60];
                }
                                
                NSMutableSet *clientSet=[buttonCellManagedObject mutableSetValueForKeyPath:@"clientPresentations.client.clientIDCode"];
                
                NSLog(@"client set is %@",clientSet);
                
               eventTitleString=@"Test Administration:";
                for (NSString * idCode in clientSet){
                    
                       
                        eventTitleString=[eventTitleString stringByAppendingFormat:@" %@,",idCode];
                 
                    
                    
                    
                }
                
                NSLog(@"event title string is %@",eventTitleString);
                if ( [eventTitleString length] > 0)
                    eventTitleString = [eventTitleString substringToIndex:[eventTitleString length] - 1];
                
                thisEvent.title=(NSString *) eventTitleString;
                
                UIViewController *currentTableModelViewController=(UIViewController *)currentDetailTableViewModel.viewController;
                
                NSString *calenderLocation=[[NSUserDefaults standardUserDefaults] valueForKey:@"calander_location"];
                //NSLog(@"calander location is %@",calenderLocation);
                [thisEvent setLocation:calenderLocation];
                
                addController.editViewDelegate = self;
                addController.view.tag=837;
//                addController.modalViewController.navigationController.delegate=self;
                //                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                //                
                //                UITabBarController *tabBarController=[appDelegate tabBarController];
                
                NSLog(@"curretnt tableviewmodel tag is %i",currentDetailTableViewModel.tag);
//                currentTableModelViewController.navigationController.delegate=self;
            
                [currentTableModelViewController.navigationController presentModalViewController:addController animated:YES];
                
                
                
            }
        }
        
    }
    
    
  }


#pragma mark -
#pragma mark EKEventEditViewDelegate

// Overriding EKEventEditViewDelegate method to update event store according to user actions.
- (void)eventEditViewController:(EKEventEditViewController *)controller 
          didCompleteWithAction:(EKEventEditViewAction)action {
	
	NSError *error = nil;
	EKEvent *thisEvent = controller.event;
	SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel sectionAtIndex:1];
    SCTableViewCell *cell=(SCTableViewCell *)[section cellAtIndex:3];
    
	switch (action) {
		case EKEventEditViewActionCanceled:
			// Edit action canceled, do nothing.
        {
            
            
        }
			break;
			
		case EKEventEditViewActionSaved:
        {
			// When user hit "Done" button, save the newly created event to the event store, 
			// and reload table view.
			// If the new event is being added to the default calendar, then update its 
			// eventsList.
			
            //NSLog(@"self psyTrack calendar %@",self.psyTrackCalendar);
            //NSLog(@"even calander is %@",thisEvent.calendar);
            
            if (self.psyTrackCalendar ==  thisEvent.calendar) {
				[self.eventsList addObject:thisEvent];
			}
			[controller.eventStore saveEvent:controller.event span:EKSpanThisEvent error:&error];
			
            //NSLog(@"section count is %i",currentDetailTableViewModel.sectionCount);
            
            //NSLog(@"cell bound object in save event is %@",cell.boundObject);
            
            [cell.boundObject setValue:[controller.event eventIdentifier] forKey:@"eventIdentifier"];
            NSLog(@"cell bound object is %@",cell.boundObject);
            [cell commitChanges];
            [cell reloadBoundValue];
            if ([cell isKindOfClass:[ButtonCell class]]) {
                ButtonCell *buttonCell=(ButtonCell *)cell;
                UIButton *button=(UIButton *)buttonCell.button;
                
                [button setTitle:@"Edit Calendar Event" forState:UIControlStateNormal];
                //NSLog(@"cell identifier after reset button is %@",[cell.boundObject valueForKey:@"eventIdentifier"]);
            }
            
            //NSLog(@"event identifier controller .event.event identi %@", [cell.boundObject valueForKey:@"eventIdentifier"]);
            
            
        }
            
            break;
			
		case EKEventEditViewActionDeleted:
			// When deleting an event, remove the event from the event store, 
			// and reload table view.
			// If deleting an event from the currenly default calendar, then update its 
			// eventsList.
			
            //NSLog(@"self psyTrack calendar %@",self.psyTrackCalendar);
            //NSLog(@"even calander is %@",thisEvent.calendar);
            
            if (self.psyTrackCalendar ==  thisEvent.calendar) {
				[self.eventsList removeObject:thisEvent];
			}
			[controller.eventStore removeEvent:thisEvent span:EKSpanThisEvent error:&error];
			[cell.boundObject setNilValueForKey:@"eventIdentifier"];
            
            
            [cell commitChanges];
            [cell reloadBoundValue];
            if ([cell isKindOfClass:[ButtonCell class]]) {
                ButtonCell *buttonCell=(ButtonCell *)cell;
                UIButton *button=(UIButton *)buttonCell.button;
                
                [button setTitle:@"Add Event To Calendar" forState:UIControlStateNormal];
                //NSLog(@"cell identifier after reset button is %@",[cell.boundObject valueForKey:@"eventIdentifier"]);
            }
			break;
			
		default:
			break;
	}
	
    
    [controller dismissModalViewControllerAnimated:YES];
    
    
	
}



// Set the calendar edited by EKEventEditViewController to our chosen calendar - the default calendar.
- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller {
	
    
    // Get the default calendar from store.
    //    settingsDictionary=(NSDictionary *)[(PTTAppDelegate *)[UIApplication sharedApplication].delegate settingsPlistDictionary];
    NSString *defaultCalendarIdentifier=[[NSUserDefaults standardUserDefaults] valueForKey:@"defaultCalendarIdentifier"];
	
    
    EKSource *mySource = nil;
    
    
    BOOL iCloudEnabled=(BOOL)[[NSUserDefaults standardUserDefaults] valueForKey:@"icloud_preference"];
    
    if (iCloudEnabled) {
        for (EKSource *source in eventStore.sources){
            
            if ([source.title isEqualToString: @"iCloud"])
            {
                mySource = source;
                //                //NSLog(@"cloud source type is %@",source.sourceType);
                
                break;
            }
        }
        
    }
    
    if (!mySource)
    {
        
        
        for (EKSource *source in eventStore.sources){
            
            if (source.sourceType==EKSourceTypeLocal)
            {
                mySource = source;
                
                break;
            }
        }
        
    }
    
    if (mySource) 
    {
        NSString *defaultCalendarName=[[NSUserDefaults standardUserDefaults] valueForKey:@"calendar_name"];
        //        NSSet *calendars=(NSSet *)[localSource calendars];
        if (defaultCalendarIdentifier.length) 
        {
            
            
            self.psyTrackCalendar =[self.eventStore calendarWithIdentifier:defaultCalendarIdentifier]; 
            mySource =psyTrackCalendar.source;
            
        }
        else 
        {
            
            self.psyTrackCalendar = [EKCalendar calendarWithEventStore:self.eventStore];
            
            [[NSUserDefaults standardUserDefaults] setValue:psyTrackCalendar.calendarIdentifier forKey:@"defaultCalendarIdentifier"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        
        if (defaultCalendarName.length) {
            self.psyTrackCalendar.title =defaultCalendarName;
        }
        
        else 
        {
            
            self.psyTrackCalendar.title=@"Client Appointments";
        }
        self.psyTrackCalendar.source = mySource;
        
        
    }
    
    
    
    //NSLog(@"cal id = %@", self.psyTrackCalendar.calendarIdentifier);
    
    NSError *error;
    
    if (![self.eventStore saveCalendar:self.psyTrackCalendar commit:YES error:&error ]) {
        //NSLog(@"something didn't go right");
    }
    else
    {
        //NSLog(@"saved calendar");
        [[NSUserDefaults standardUserDefaults]setValue:psyTrackCalendar.calendarIdentifier forKey:@"defaultCalendarIdentifier"];
        //                 NSSet *calendars=(NSSet *)[localSource calendars];
        //                    for(id obj in calendars) { 
        //                    if([obj isKindOfClass:[EKCalendar class]]){
        //                        EKCalendar *calendar=(EKCalendar *)obj;
        //                        if ([calendar.calendarIdentifier isEqualToString:self.psyTrackCalendar.calendarIdentifier]) {
        //                            self.psyTrackCalendar=(EKCalendar *)calendar;
        //                          
        //                            break;
        //                        }
        
        
        //                    }
        
    }
    
    
    //            self.psyTrackCalendar =(EKCalendar *)localSource cal
    
    
    
    
    
    
    
    if (self.psyTrackCalendar) {
        //NSLog(@"self %@",self.psyTrackCalendar);
    }
    
    
    
    
    
    EKCalendar *calendarForEdit = self.psyTrackCalendar;
	return calendarForEdit;
}

#pragma mark -
#pragma mark start time delegates




-(IBAction)stopwatchReset:(id)sender{
    
    
    [self calculateTime];
    
}

-(void)calculateTime
{
    
    NSLog(@"current detailtable view model %i",currentDetailTableViewModel.tag);
    if (currentDetailTableViewModel.sectionCount) {
   
    SCTableViewSection *section=[currentDetailTableViewModel sectionAtIndex:0];
    
        if (section.cellCount>3) {
            if ([(SCTableViewCell *)[section cellAtIndex:1] isKindOfClass:[SCDateCell class]]) {
          
    SCDateCell *startTimeCell =(SCDateCell *)[section cellAtIndex:0];
    SCDateCell *endTimeEndTimeCell =(SCDateCell *)[section cellAtIndex:1];
    TimePickerCell *additionalTimeCell =(TimePickerCell *)[section cellAtIndex:2];
    TimePickerCell *subtractTimeCell =(TimePickerCell *)[section cellAtIndex:3];
    if (startTime&&startTimeCell.label.text.length) {
        startTime=startTimeCell.datePicker.date;
        
    }
    else{startTime=referenceDate;}
    
    if (endTime&&endTimeEndTimeCell.label.text.length) {
        endTime=endTimeEndTimeCell.datePicker.date;
    }
    else{endTime=referenceDate;}
    
    if (additionalTimeCell&& [additionalTimeCell respondsToSelector:@selector(timeValue)]&& additionalTimeCell.timeValue) {
        additionalTime=additionalTimeCell.timeValue;
    }
    else{additionalTime=referenceDate;}
    
    if (subtractTimeCell&& [subtractTimeCell respondsToSelector:@selector(timeValue)]&& subtractTimeCell.timeValue) {
        timeToSubtract=subtractTimeCell.timeValue;
    }
    else{timeToSubtract=referenceDate;}
    
    
    
    if (startTime && startTime != referenceDate &&endTime &&endTime!=referenceDate) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc ]init];
        [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [dateFormatter setDateFormat:@"H:mm"];
        NSDateFormatter *dateFormatClearSeconds=[[NSDateFormatter alloc]init];
        [dateFormatClearSeconds setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatClearSeconds setDateFormat:@"H:mm"];
        
        startTime=[dateFormatClearSeconds dateFromString:[dateFormatter stringFromDate:startTime]];
        endTime=[dateFormatClearSeconds dateFromString:[dateFormatter stringFromDate:endTime]];
        //NSLog(@"start time %@ end time %@ additioanl time %@ time to subtract %@",startTime,endTime,additionalTime,timeToSubtract);
        
        
    }
    
    
    
    if (stopwatchCell.addStopwatch) {
        addStopwatch=stopwatchCell.addStopwatch;
    }
    
    NSTimeInterval startAndEndTimeInterval=0.0;
    if (startTime&&startTimeCell&& [startTimeCell respondsToSelector:@selector(label) ]&&startTimeCell.label.text.length>0&&endTimeEndTimeCell&& [endTimeEndTimeCell respondsToSelector:@selector(label)]&& endTimeEndTimeCell.label.text.length>0) {
        if ([endTime timeIntervalSinceDate:startTime]>0.0)
        {
            
            startAndEndTimeInterval=[endTime timeIntervalSinceDate:startTime];
        }
    }
    
    
    if ([additionalTime timeIntervalSinceDate:referenceDate]>0.0) 
    {
        startAndEndTimeInterval=startAndEndTimeInterval+[additionalTime timeIntervalSinceDate:referenceDate];
    }
    
    if ([addStopwatch timeIntervalSinceDate:referenceDate]>0.0) {
        startAndEndTimeInterval=startAndEndTimeInterval+[addStopwatch timeIntervalSinceDate:referenceDate];
    }
    if ([timeToSubtract timeIntervalSinceDate:referenceDate]>0.0) {
        startAndEndTimeInterval=startAndEndTimeInterval-[timeToSubtract timeIntervalSinceDate:referenceDate];
    }
    
    NSString *totalTimeString;
    if (startAndEndTimeInterval>=0.983333) {
        
        //cut off miliseconds
        
        totalTimeString=[NSString stringWithFormat:@"%f",startAndEndTimeInterval];
        
        
        NSRange range;
        range.length=6;
        range.location=totalTimeString.length-6;
        totalTimeString=[totalTimeString stringByReplacingCharactersInRange:range withString:@"000000"];
        
        
        startAndEndTimeInterval=[totalTimeString doubleValue];
    }
    else
    {
        
        startAndEndTimeInterval=0;
    }
    
    NSTimeInterval totalBreakTime=[self totalBreakTimeInterval];
    
    if ( startAndEndTimeInterval>totalBreakTime) {
        startAndEndTimeInterval=startAndEndTimeInterval-totalBreakTime;
    }
    else if(totalBreakTime>0){
        
        startAndEndTimeInterval=0.0;
    }
    
    
    
    
    totalTimeDate=[referenceDate dateByAddingTimeInterval:startAndEndTimeInterval];
    
    
    
    //    
    //    //define a gregorian calandar
    //    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //    
    //    //define the calandar unit flags
    //    NSUInteger unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    //    
    //    //define the date components
    //    NSDateComponents *dateComponents = [gregorianCalendar components:unitFlags
    //                                                            fromDate:startTime
    //                                                              toDate:endTime
    //                                                             options:0];
    //    
    //    
    //    
    //    
    //    float day, hour, minute, second;
    //    day=[dateComponents day];
    //    hour=[dateComponents hour];
    //    minute=[dateComponents minute];
    //    second= [dateComponents second];
    //    
    //  
    
    
    //    }
    
    
    
    
    totalTimeHeaderLabel.text=[NSString stringWithFormat:@"Total Time:%@",[counterDateFormatter stringFromDate:totalTimeDate]];
    
    //     totalTimeString=[NSString stringWithFormat:@"start time is %@, end time is %@, additional time is %@, timeToSubtract is %@",startTime,endTime, additionalTime, timeToSubtract];
    //    return totalTimeDate;
    
            
        } 
    }
    }
}







-(IBAction)stopwatchUpdated:(id)sender {
    
    [self calculateTime];
    
}

-(IBAction)stopwatchStop:(id)sender{
    
    
    [self calculateTime];
    
    
}



-(void) tableViewModel:(SCTableViewModel *)tableViewModel customButtonTapped:(UIButton *)button forRowWithIndexPath:(NSIndexPath *)indexPath{
    
    
    SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
    
    if (tableViewModel.tag==2) 
    {
        
        
        if (section.cellCount>=6) 
        {
            
            if ([[section cellAtIndex:5] class]==[StopwatchCell class]) 
            {
                
                
                
                switch (button.tag)
                {
                    case 300:
                        // clear the times
                    {
                        if (section.cellCount>3) {
                            
                            if ([[section cellAtIndex:0]isKindOfClass:[SCDateCell class]]) {
                                
                                SCDateCell *startTimeCell=(SCDateCell *)[section cellAtIndex:0];
                                SCDateCell *endTimeCell=(SCDateCell *)[section cellAtIndex:1];
                                TimePickerCell *additionalTimeCell=(TimePickerCell *)[section cellAtIndex:2];
                                TimePickerCell *timeToSubtractCell=(TimePickerCell *)[section cellAtIndex:3];
                                
                                [startTimeCell.boundObject setValue:nil forKey:@"startTime"];
                                [endTimeCell.boundObject setValue:nil forKey:@"endTime"];
                                [additionalTimeCell.boundObject setValue:referenceDate forKey:@"additionalTime"];
                                [timeToSubtractCell.boundObject setValue:referenceDate forKey:@"timeToSubtract"];
                                
                                startTime=nil;
                                
                                endTime=nil;
                                
                                additionalTime=nil;
                                
                                
                                
                                timeToSubtract=nil;
                                [section reloadBoundValues];
                                
                                [self calculateTime];
                            }
                        }
                        break;
                    }
                }
            }
        }
        
    }
    if (tableViewModel.tag==3) 
    {
        NSManagedObject *sectionManagedObject=(NSManagedObject *)section.boundObject;
        if (sectionManagedObject && [sectionManagedObject.entity.name  isEqualToString:@"BreakTimeEntity"]) {
            
            switch (button.tag)
            {
                case 300:
                    // clear the times
                {
                    SCDateCell *startTimeCell=(SCDateCell *)[section cellAtIndex:1];
                    SCDateCell *endTimeCell=(SCDateCell *)[section cellAtIndex:2];
                    TimePickerCell *undefinedTimeCell=(TimePickerCell *)[section cellAtIndex:3];
                    
                    
                    [startTimeCell.boundObject setNilValueForKey:@"startTime"];
                    [endTimeCell.boundObject setNilValueForKey:@"endTime"];
                    [undefinedTimeCell.boundObject setValue:referenceDate forKey:@"undefinedTime"];
                    
                    
                    
                    
                    [startTimeCell reloadBoundValue];
                    [endTimeCell reloadBoundValue];
                    [undefinedTimeCell reloadBoundValue];
                    breakTimeTotalHeaderLabel.text=[self tableViewModel:tableViewModel calculateBreakTimeForRowAtIndexPath:indexPath withBoundValues:YES];
                    
                }
            }
        }
    }
}







-(NSTimeInterval ) totalBreakTimeInterval{
    
    
    
    NSTimeInterval totalBreakTimeInterval=0;
    
    
  
    
   
    
    if (currentDetailTableViewModel.tag==2 && currentDetailTableViewModel.sectionCount>1) {
  
        SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel sectionAtIndex:0];
        
       
        if ([section isKindOfClass:[SCObjectSection class]]&&section.cellCount>1) {
  

            SCTableViewCell *cellOne=(SCTableViewCell *)[section cellAtIndex:0];
    
            NSDate *breakStartTime, *breakEndTime,*breakUndefinedTime;
    
   
            TimeEntity *timeEntity=(TimeEntity *)cellOne.boundObject;
            [timeEntity willAccessValueForKey:@"breaks"];
           
        
    
            for (BreakTimeEntity *obj in [timeEntity.breaks allObjects]) {
                
                
                breakStartTime=(NSDate *)obj.startTime;
                breakEndTime=(NSDate *)obj.endTime;
                breakUndefinedTime=obj.undefinedTime;
                
               
            
         
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc ]init];
                [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
                [dateFormatter setDateFormat:@"H:mm"];
                NSDateFormatter *dateFormatClearSeconds=[[NSDateFormatter alloc]init];
                [dateFormatClearSeconds setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                [dateFormatClearSeconds setDateFormat:@"H:mm"];
                

                    
                    
                    
                    
                    if (breakStartTime && breakStartTime != referenceDate &&breakEndTime &&breakEndTime!=referenceDate) {
                        
                        
                        breakStartTime=[dateFormatClearSeconds dateFromString:[dateFormatter stringFromDate:breakStartTime]];
                        breakEndTime=[dateFormatClearSeconds dateFromString:[dateFormatter stringFromDate:breakEndTime]];
                        
                        
                        
                        
                        
                    }
                    
                    NSTimeInterval startAndEndTimeInterval=[breakEndTime timeIntervalSinceDate:breakStartTime]+[breakUndefinedTime timeIntervalSinceDate:referenceDate];
                    totalBreakTimeInterval=totalBreakTimeInterval+startAndEndTimeInterval;
            }
        }
    
    NSString *totalTimeString;
    if (totalBreakTimeInterval>=1) {
        
        //cut off miliseconds
        
        totalTimeString=[NSString stringWithFormat:@"%f",totalBreakTimeInterval];
        //NSLog(@"totoal time string is %@", totalTimeString);
        
        NSRange range;
        range.length=6;
        range.location=totalTimeString.length-6;
        totalTimeString=[totalTimeString stringByReplacingCharactersInRange:range withString:@"000000"];
        
        
        totalBreakTimeInterval=[totalTimeString doubleValue];
    }
    else
    {
        
        totalBreakTimeInterval=0;
    }
    
            
        }
    
    
    NSLog(@"total break time interval is %f",totalBreakTimeInterval);
    return totalBreakTimeInterval;
    
}  
    
    

-(NSString *)totalBreakTimeString{
    
    
    
    
    NSTimeInterval totalBreakTimeInterval=[self totalBreakTimeInterval];
   
    NSDate *timeFromReferenceTime=[referenceDate dateByAddingTimeInterval:totalBreakTimeInterval];
    
    
    NSLog(@"total break time %@",[counterDateFormatter stringFromDate:timeFromReferenceTime]);
    return [NSString stringWithFormat:@"Total Break Time: %@",[counterDateFormatter stringFromDate:timeFromReferenceTime]];
    
    
    
}




-(NSString *)tableViewModel:(SCTableViewModel *)tableViewModel calculateBreakTimeForRowAtIndexPath:(NSIndexPath *)indexPath withBoundValues:(BOOL)useBoundValues{
    
    SCTableViewSection *section=[tableViewModel sectionAtIndex:indexPath.section];
    NSManagedObject *sectionBoundObject=(NSManagedObject *)section.boundObject;
    NSDate *breakStartTime;
    NSDate *breakEndTime;
    
    
    NSDate *breakUndefinedTime;
    
    
    if (tableViewModel.tag==3 && section.cellCount>=4 && [sectionBoundObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
        
        
        
        SCDateCell *breakStartTimeCell =(SCDateCell *)[section cellAtIndex:1];
        SCDateCell *breakEndTimeCell =(SCDateCell *)[section cellAtIndex:2];
        TimePickerCell *breakUndefinedTimeCell =(TimePickerCell *)[section cellAtIndex:3];
        
        if (useBoundValues) {
            breakStartTime=[breakStartTimeCell.boundObject valueForKey:@"startTime"];
            breakEndTime=[breakEndTimeCell.boundObject valueForKey:@"endTime"];
            
            breakUndefinedTime=[breakUndefinedTimeCell.boundObject valueForKey:@"undefinedTime"];
        }
        else
        {
            if (breakStartTimeCell&& breakStartTimeCell.label.text.length>0 && breakEndTimeCell.label.text.length>0) {
                breakStartTime=breakStartTimeCell.datePicker.date;
                breakEndTime=breakEndTimeCell.datePicker.date;
            }
            else
            {
                breakStartTime=referenceDate;
                breakEndTime=referenceDate;
            }
            
            if (breakUndefinedTimeCell&& breakUndefinedTimeCell.timeValue) {
                breakUndefinedTime=breakUndefinedTimeCell.timeValue;
            }
            else{breakUndefinedTime=referenceDate;}
            
        }
    }
    
    
    if (tableViewModel.tag==2 ){//&& [sectionBoundObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
        
        
        if (indexPath.section==1) {
            
            
            SCObjectCell *breakObjectCell=(SCObjectCell *)[section cellAtIndex:indexPath.row];
            
            breakStartTime=(NSDate *)[breakObjectCell.boundObject valueForKey:@"startTime"];
            breakEndTime=(NSDate *)[breakObjectCell.boundObject valueForKey:@"endTime"];
            
            breakUndefinedTime=(NSDate *)[breakObjectCell.boundObject valueForKey:@"undefinedTime"];
        }
    }
    
    if (breakStartTime && breakStartTime != referenceDate &&breakEndTime &&breakEndTime!=referenceDate) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc ]init];
        [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [dateFormatter setDateFormat:@"H:mm"];
        NSDateFormatter *dateFormatClearSeconds=[[NSDateFormatter alloc]init];
        [dateFormatClearSeconds setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatClearSeconds setDateFormat:@"H:mm"];
        
        breakStartTime=[dateFormatClearSeconds dateFromString:[dateFormatter stringFromDate:breakStartTime]];
        breakEndTime=[dateFormatClearSeconds dateFromString:[dateFormatter stringFromDate:breakEndTime]];
        
    }
    NSTimeInterval startAndEndTimeInterval=0.0;
    
    if ([breakEndTime timeIntervalSinceDate:breakStartTime]>0.0)
    {
        
        startAndEndTimeInterval=[breakEndTime timeIntervalSinceDate:breakStartTime];
    }
    
    if ([breakUndefinedTime timeIntervalSinceDate:referenceDate]>0.0) 
    {
        startAndEndTimeInterval=startAndEndTimeInterval+[breakUndefinedTime timeIntervalSinceDate:referenceDate];
    }
    
    NSString *totalTimeString;
    if (startAndEndTimeInterval>=1) {
        
        //cut off miliseconds
        
        totalTimeString=[NSString stringWithFormat:@"%f",startAndEndTimeInterval];
        
        
        NSRange range;
        range.length=6;
        range.location=totalTimeString.length-6;
        totalTimeString=[totalTimeString stringByReplacingCharactersInRange:range withString:@"000000"];
        
        
        startAndEndTimeInterval=[totalTimeString doubleValue];
    }
    else
    {
        
        startAndEndTimeInterval=0;
    }
    
    
    NSDate *timeFromReferenceTime=[referenceDate dateByAddingTimeInterval:startAndEndTimeInterval];
    if (tableViewModel.tag==2) {
        return [NSString stringWithFormat:@"%@",[counterDateFormatter stringFromDate:timeFromReferenceTime]];
    }
    
    
    return [NSString stringWithFormat:@"Time:%@",[counterDateFormatter stringFromDate:timeFromReferenceTime]];
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForSectionAtIndex:(NSUInteger)index{
    
    
    
    
    
}

-(void)tableViewModel:(SCTableViewModel *)tableModel itemAddedForSectionAtIndexPath:(NSIndexPath *)indexPath item:(NSObject *)item{

    currentDetailTableViewModel=tableModel;
    NSLog(@"current table view model tag is %i",currentDetailTableViewModel.tag);
    if(tableModel.tag==2 &&indexPath.section)
    {
        [self calculateTime];
        SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel sectionAtIndex:1];
        UILabel *breakSectionHeaderLabel=(UILabel *)[section.headerView viewWithTag:60];
       
        NSLog(@"break time string is %@",[self totalBreakTimeString]);
        breakSectionHeaderLabel.text=[self totalBreakTimeString];
        
    }
    

}


-(void)tableViewModel:(SCTableViewModel *)tableModel itemEditedForSectionAtIndexPath:(NSIndexPath *)indexPath item:(NSObject *)item{
    
    if (currentDetailTableViewModel.tag==2) {
   
    [self tableViewModel:(SCTableViewModel *)tableModel itemAddedForSectionAtIndexPath:indexPath item:(NSObject *)item];
        
    }
    //NSLog(@"value changed for row at index path");
    currentDetailTableViewModel=tableModel;
    
    if (tableModel.tag==1) 
    {
        SCSelectionCell *cell=(SCSelectionCell *)[tableModel.modeledTableView cellForRowAtIndexPath:indexPath];
        //NSLog(@"cell.tag %i",cell.tag);
        if (cell.tag==0) {
            if ([cell isKindOfClass:[SCDateCell class]]){
                serviceDateCell=(SCDateCell *)cell;
            }
        }
        
        if (cell.tag==1) //time cell
        {
            
            
            
            
            
            
            //NSLog(@"cell is kind of class %@",[cell class]);
            if ([cell isKindOfClass:[SCObjectCell class]]) 
            {
                
                [cell.boundObject setValue:totalTimeDate forKey:@"totalTime"];
                [self tableViewModel:(SCTableViewModel *)tableModel 
                     willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath];
                
                
                
                
            }
        }
    }
    
    
    if (tableModel.tag==2) {
        
        SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) {
            
            
            switch (cell.tag) {
                case 0:
                {
                    
                    SCDateCell *startTimeCell =(SCDateCell *)cell;
                    
                    
                    startTime=(NSDate*)startTimeCell.datePicker.date;
                    
                    
                }
                    break;
                case 1:
                {
                    SCDateCell *endTimeCell =(SCDateCell *)cell;
                    
                    endTime=(NSDate*)endTimeCell.datePicker.date;
                    
                }
                    break;
                case 2:
                {
                    TimePickerCell *additionalTimeCell =(TimePickerCell *)cell;
                    
                    if ([additionalTimeCell respondsToSelector:@selector(timeValue)]) {
                        additionalTime=(NSDate*)additionalTimeCell.timeValue;
                    }
                    
                    
                }
                    break;
                    
                case 3:
                {
                    TimePickerCell *timeToSubtractCell =(TimePickerCell *)cell;
                    if ([timeToSubtractCell respondsToSelector:@selector(timeValue)]) {
                        timeToSubtract=(NSDate*)timeToSubtractCell.timeValue;
                        
                    }
                    
                }
                    break;
                    
                    
                default:
                    break;
            }
            
            [self calculateTime];
        }
        
    } 
    
    
    if (tableModel.tag==3) {
        
        SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
            
            
            
            if (cell.tag==1||cell.tag==2||cell.tag==3)
                breakTimeTotalHeaderLabel.text=[self tableViewModel:tableModel calculateBreakTimeForRowAtIndexPath:indexPath withBoundValues:NO];
        }
        
    } 
    

}





@end
