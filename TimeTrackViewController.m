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
#import "InterventionTypeSubtypeEntity.h"
#import "TrainingProgramEntity.h"
#import "SiteEntity.h"
#import "RateEntity.h"
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
        timePickerCellNibName=@"TimePickerCell_iPad";
    else
        timePickerCellNibName=@"TimePickerCell";
    
    
    
    //create the dictionary with the data bindings
    NSDictionary *additionalTimeDataBindings = [NSDictionary 
                                                dictionaryWithObjects:[NSArray arrayWithObjects:@"additionalTime",@"additionalTime", @"Additional Time", nil ] 
                                                forKeys:[NSArray arrayWithObjects:@"40" , @"41",@"42",   nil]]; // 40, 41,42 are the control tags
	
    //create the custom property definition for addtional time
    SCCustomPropertyDefinition *additionalTimePropertyDef = [SCCustomPropertyDefinition definitionWithName:@"AdditionalTime" uiElementNibName:timePickerCellNibName  objectBindings:additionalTimeDataBindings];	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    additionalTimePropertyDef.autoValidate=NO;
    
	
    
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
	
    
    
    
    
    //insert the custom property definition into the Assessment class at index 1
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
    
    
    
    
 
    
	  
    UIViewController *navtitle=self.navigationController.topViewController;
    
        
   
    
    NSString *detailsHeaderStr=nil;
    
    
    switch (currentControllerSetup) {
        case kTrackAssessmentSetup:
            detailsHeaderStr=@"Administration Details";
            break;
        case kTrackInterventionSetup:
            detailsHeaderStr=@"Intervention Details";
            break;
        case kTrackSupportSetup:
            detailsHeaderStr=@"Support Activity Details";
            break;
        case kTrackSupervisionGivenSetup:
            detailsHeaderStr=@"Supervision Given Details";
            break;
        case kTrackSupervisionReceivedSetup:
            detailsHeaderStr=@"Supervision Received Details";
            break;
        
        default:
            break;
    }
     SCPropertyGroup *detailsGroup =[SCPropertyGroup groupWithHeaderTitle:detailsHeaderStr footerTitle:@"*Required" propertyNames:[NSArray arrayWithObjects:@"trainingProgram",@"site", nil]];
  
    //define a property group
    SCPropertyGroup *eventGroup = [SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"dateOfService",@"time", @"EventButtonCell",nil]];
    
  
    
    SCPropertyGroup *peopleGroup =[SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"SupervisorData",  @"notes",nil]];
    
    

    
    NSMutableArray *timeTrackPropertyNamesArray=[NSMutableArray arrayWithObjects:@"dateOfService",  @"time",  @"notes", @"paperwork",  @"supervisor",    @"trainingProgram", @"site",  @"paid",@"hourlyRate",@"eventIdentifier",@"monthlyLogNotes", nil];
    
    if (currentControllerSetup==kTrackAssessmentSetup||currentControllerSetup==kTrackInterventionSetup||currentControllerSetup==kTrackSupportSetup) {
        
        if (currentControllerSetup!=kTrackSupportSetup) {
            [timeTrackPropertyNamesArray addObject:@"clientPresentations"];
            [eventGroup insertPropertyName:@"clientPresentations" atIndex:2];
        }
        else {
            [eventGroup insertPropertyName:@"supportActivityClients" atIndex:2];
        }
        
        
        [timeTrackPropertyNamesArray addObject:@"serviceCode"]; 
        
        
        [peopleGroup addPropertyName:@"paperwork"];
        [detailsGroup addPropertyName:@"serviceCode"];
        
        
        
        
        
    }
    else {
        
        
        
        
        
        [timeTrackPropertyNamesArray addObject:@"studentsPresent"];
        [timeTrackPropertyNamesArray addObject:@"supervisionFeedback"];
        [timeTrackPropertyNamesArray addObject:@"supervisionType"];
        
        [detailsGroup insertPropertyName:@"supervisionType" atIndex:0];
        [eventGroup insertPropertyName:@"supervisionFeedback" atIndex:2];
        [detailsGroup insertPropertyName:@"StudentsPresentData" atIndex:2];

        [detailsGroup insertPropertyName:@"modelsUsed" atIndex:3];

        
        
    }
    NSString *trackEntityName=nil;
    switch (currentControllerSetup) {
        case kTrackAssessmentSetup:
        {
            navtitle.title=@"Assessments";
            
           
            [timeTrackPropertyNamesArray addObject:@"assessmentType"];
            
            trackEntityName= kTrackAssessmentEntityName;
                                                                
            
            [detailsGroup insertPropertyName:@"assessmentType" atIndex:0];
           
        }
            break;
        case kTrackInterventionSetup:
           
            navtitle.title=@"Interventions";
            
            
            
            [timeTrackPropertyNamesArray addObject:@"interventionType"];
            [timeTrackPropertyNamesArray addObject:@"subtype"];
            [timeTrackPropertyNamesArray addObject:@"modelsUsed"];
            
            trackEntityName=kTrackInterventionEntityName;
                                                     
            
             [detailsGroup insertPropertyName:@"interventionType" atIndex:2];
            [detailsGroup insertPropertyName:@"subtype" atIndex:3];
            [detailsGroup insertPropertyName:@"modelsUsed" atIndex:1];
            
            break;
            
        case kTrackSupportSetup:
            
            navtitle.title=@"Indirect Support";
            
            trackEntityName= kTrackSupportEntityName;
            
            [timeTrackPropertyNamesArray addObject:@"supportActivityType"];
            [timeTrackPropertyNamesArray addObject:@"supportActivityClients"];
            
            [detailsGroup insertPropertyName:@"supportActivityType" atIndex:0];
            
           
            break;
            
        case kTrackSupervisionGivenSetup:
            
            navtitle.title=@"Supervision Given";
            
           trackEntityName= kTrackSupervisionGivenEntityName;
                                                     
            
            [timeTrackPropertyNamesArray addObject:@"modelsUsed"];
            [timeTrackPropertyNamesArray addObject:@"subType"];
             [detailsGroup insertPropertyName:@"subType" atIndex:1];
            
                        
            break;
            
        case kTrackSupervisionReceivedSetup:
            navtitle.title=@"Supervision Received";
            
            
            trackEntityName= kTrackSupervisionReceivedEntityName;
            
            [timeTrackPropertyNamesArray addObject:@"modelsUsed"];
            [timeTrackPropertyNamesArray addObject:@"subType"];
             [detailsGroup insertPropertyName:@"subType" atIndex:1];
            break;
            
            
            
        default:
            break;
    }
    
    
    SCEntityDefinition *timeTrackEntityDef=[SCEntityDefinition definitionWithEntityName:trackEntityName managedObjectContext:managedObjectContext propertyNames:timeTrackPropertyNamesArray];
    
    
    // add the event Group property group to the behavioralObservationsDef class. 
    [timeTrackEntityDef.propertyGroups addGroup:eventGroup];
    
    
    
    
    SCPropertyDefinition *monthlyLogNotes=[timeTrackEntityDef propertyDefinitionWithName:@"monthlyLogNotes"];
    monthlyLogNotes.type=SCPropertyTypeTextView;
    

    
    
    
    
    
    
    
    
    NSInteger eventIdentifierPropertyIndex = [timeTrackEntityDef indexOfPropertyDefinitionWithName:@"eventIdentifier"];
    [timeTrackEntityDef removePropertyDefinitionAtIndex:eventIdentifierPropertyIndex];
    
    SCPropertyDefinition *dateOfServicePropertyDef = [timeTrackEntityDef propertyDefinitionWithName:@"dateOfService"];
	dateOfServicePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                         datePickerMode:UIDatePickerModeDate 
                                                          displayDatePickerInDetailView:YES];
    
   
    SCPropertyDefinition *notesPropertyDef = [timeTrackEntityDef propertyDefinitionWithName:@"notes"];
    notesPropertyDef.type=SCPropertyTypeTextView;
    
    timeTrackEntityDef.titlePropertyName=@"dateOfService";
    timeTrackEntityDef.keyPropertyName=@"dateOfService";
    
    
    //add a button to add an event to the calandar
    
    //create a custom property definition for the Button Cell
    
    NSDictionary *buttonCellObjectBinding=[NSDictionary dictionaryWithObject:@"eventIdentifier" forKey:@"event_identifier"];
    SCCustomPropertyDefinition *eventButtonProperty = [SCCustomPropertyDefinition definitionWithName:@"EventButtonCell" uiElementClass:[ButtonCell class] objectBindings:buttonCellObjectBinding];
    
    //add the property definition to the test administration detail view  
    [timeTrackEntityDef addPropertyDefinition:eventButtonProperty];
       
    [timeTrackEntityDef.propertyGroups addGroup:peopleGroup];
    
    
   
    [detailsGroup addPropertyName:@"monthlyLogNotes"];
       
    [timeTrackEntityDef.propertyGroups addGroup:detailsGroup]; 
    
    
    
    SCPropertyDefinition *licenseNumbersCreditedPropertyDef = [timeTrackEntityDef propertyDefinitionWithName:@"licenseNumbersCredited"];
    licenseNumbersCreditedPropertyDef.title=@"Licenses Credited";
    
    SCPropertyGroup *creditsGroup =[SCPropertyGroup groupWithHeaderTitle:@"Credits" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"degreesCredited",@"certificationsCredited",@"licenseNumbersCredited",nil]];
    
    
    [timeTrackEntityDef.propertyGroups addGroup:creditsGroup];
    
    
    
    [timeTrackEntityDef removePropertyDefinitionWithName:@"supervisor"];
    
    //create the dictionary with the data bindings
    NSDictionary *clinicianDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObjects:@"supervisor",@"Supervisor",[NSNumber numberWithBool:NO],@"supervisor",[NSNumber numberWithBool:NO],nil] 
                                           forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *clinicianDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SupervisorData"
                                                                                        uiElementClass:[ClinicianSelectionCell class] objectBindings:clinicianDataBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    clinicianDataProperty.autoValidate=FALSE;
    
    
    [timeTrackEntityDef insertPropertyDefinition:clinicianDataProperty atIndex:1];
    
    
    /****************************************************************************************/
    /*	END of Class Definition and attributes for the Client Entity */
    /****************************************************************************************/
    
    
    SCPropertyDefinition *clientsPropertyDef = [timeTrackEntityDef propertyDefinitionWithName:@"clients"];
    
   	clientsPropertyDef.type = SCPropertyTypeObjectSelection;
    
    
    
    
    
    
    
      
    //Training Type  start
    SCEntityDefinition *trainingProgramDef=[SCEntityDefinition definitionWithEntityName:@"TrainingProgramEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"school",@"trainingProgram",@"course",@"doctorateLevel",@"startDate",@"endDate",@"selectedByDefault", @"notes", nil]];
    
    
    
   
    
    
    
    
    trainingProgramDef.orderAttributeName=@"order";

    
    
    SCPropertyDefinition *sessionTrainingProgramPropertyDef=[timeTrackEntityDef propertyDefinitionWithName:@"trainingProgram"];
    
    sessionTrainingProgramPropertyDef.autoValidate=NO;
    sessionTrainingProgramPropertyDef.title=@"Program - Course*";
    trainingProgramDef.titlePropertyName=@"trainingProgram;course";
    trainingProgramDef.titlePropertyNameDelimiter=@" - ";
    
    sessionTrainingProgramPropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *trainingProgramSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:trainingProgramDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    trainingProgramSelectionAttribs.allowAddingItems = YES;
    trainingProgramSelectionAttribs.allowDeletingItems = YES;
    trainingProgramSelectionAttribs.allowMovingItems = YES;
    trainingProgramSelectionAttribs.allowEditingItems = YES;
    trainingProgramSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Training Types)"];
    trainingProgramSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Training Type"];
    sessionTrainingProgramPropertyDef.attributes = trainingProgramSelectionAttribs;
    
    SCPropertyDefinition *trainingProgramPropertyDef=[trainingProgramDef propertyDefinitionWithName:@"trainingProgram"];
    trainingProgramPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *trainingProgramNotesPropertyDef=[trainingProgramDef propertyDefinitionWithName:@"notes"];
    trainingProgramNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    
    //create the dictionary with the data bindings
    NSDictionary *instructorDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObjects:@"seminarInstructor",@"Seminar Instructor",[NSNumber numberWithBool:NO],@"seminarInstructor",[NSNumber numberWithBool:NO],nil] 
                                           forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *instructorDataProperty = [SCCustomPropertyDefinition definitionWithName:@"InstructorData"
                                                                                        uiElementClass:[ClinicianSelectionCell class] objectBindings:instructorDataBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    instructorDataProperty.autoValidate=FALSE;
    
    
    [trainingProgramDef insertPropertyDefinition:instructorDataProperty atIndex:1];
    
    SCPropertyDefinition *trainingProgramStartDatePropertyDef = [trainingProgramDef propertyDefinitionWithName:@"startDate"];
	trainingProgramStartDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                         datePickerMode:UIDatePickerModeDate 
                                                          displayDatePickerInDetailView:NO];
    
    
    SCPropertyDefinition *trainingProgramEndDatePropertyDef = [trainingProgramDef propertyDefinitionWithName:@"endDate"];
	trainingProgramEndDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                                    datePickerMode:UIDatePickerModeDate 
                                                                     displayDatePickerInDetailView:NO];
    

    SCEntityDefinition *schoolDef=[SCEntityDefinition definitionWithEntityName:@"SchoolEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"schoolName",@"notes", nil]];
    
    
    schoolDef.orderAttributeName=@"order";
    SCPropertyDefinition *trainingProgramSchoolPropertyDef=[trainingProgramDef propertyDefinitionWithName:@"school"];
    trainingProgramSchoolPropertyDef.type =SCPropertyTypeObjectSelection;
    
    
    
    
    SCObjectSelectionAttributes *trainingProgramSchoolSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:schoolDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    trainingProgramSchoolSelectionAttribs.allowAddingItems = YES;
    trainingProgramSchoolSelectionAttribs.allowDeletingItems = YES;
    trainingProgramSchoolSelectionAttribs.allowMovingItems = YES;
    trainingProgramSchoolSelectionAttribs.allowEditingItems = YES;
    trainingProgramSchoolSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to add schools)"];
    trainingProgramSchoolSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New School"];
    trainingProgramSchoolPropertyDef.attributes = trainingProgramSchoolSelectionAttribs;
    
    SCPropertyDefinition *trainingProgramSchoolNamePropertyDef=[schoolDef propertyDefinitionWithName:@"schoolName"];
    trainingProgramSchoolNamePropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *trainingPrograSchoolmNotesPropertyDef=[schoolDef propertyDefinitionWithName:@"notes"];
    trainingPrograSchoolmNotesPropertyDef.type=SCPropertyTypeTextView;
    

    
    //training type end
    
    
    
    
    
    
    SCPropertyDefinition *timePropertyDef = [timeTrackEntityDef propertyDefinitionWithName:@"time"];
    timePropertyDef.attributes = [SCObjectAttributes attributesWithObjectDefinition:self.timeDef];
    
    
    
    
    
    
    //create an array of objects definition for the clientPresentation to-many relationship that with show up in a different view  without a place holder element>.
    SCPropertyDefinition *clientPresentationsPropertyDef =nil;
    SCPropertyDefinition *supervisionFeedbackPropertyDef=nil;
    NSPredicate *modelPredicate=nil;
    //Create the property definition for the clientPresentations property
    if (currentControllerSetup==kTrackAssessmentSetup||currentControllerSetup==kTrackInterventionSetup||currentControllerSetup==kTrackSupportSetup) {
        
         [self.searchBar setSelectedScopeButtonIndex:2];
         modelPredicate = [NSPredicate predicateWithFormat:@"paperwork == %@",[NSNumber numberWithInteger: 0]];
        
        
        
        NSString *clientsPropertyNameStr=nil;
        SCEntityDefinition *clientsEntityDefinition=nil;
        if (currentControllerSetup== kTrackSupportSetup) {
            
            clientsEntityDefinition=[SCEntityDefinition definitionWithEntityName:@"SupportActivityClientEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"notes", nil]];
            clientsPropertyNameStr=@"supportActivityClients";
            clientsEntityDefinition.titlePropertyName=@"client.clientIDCode";
 
                [clientsEntityDefinition removePropertyDefinitionWithName:@"supportActivityDelivered"];
            /****************************************************************************************/
            /*	BEGIN Class Definition and attributes for the Client Entity */
            /****************************************************************************************/ 
            
            //get the client setup from the clients View Controller Shared
            // Add a custom property that represents a custom cells for the description defined TextFieldAndLableCell.xib
            
            //create the dictionary with the data bindings
            NSDictionary *clientDataBindings = [NSDictionary 
                                                dictionaryWithObjects:[NSArray arrayWithObjects:@"client",@"Client",@"client",[NSNumber numberWithBool:NO],nil] 
                                                forKeys:[NSArray arrayWithObjects:@"1",@"90",@"92",@"93",nil ]]; // 1 are the control tags
            
            //create the custom property definition
            SCCustomPropertyDefinition *clientDataProperty = [SCCustomPropertyDefinition definitionWithName:@"CLientData"
                                                                                             uiElementClass:[ClientsSelectionCell class] objectBindings:clientDataBindings];
            
            
            //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
            clientDataProperty.autoValidate=FALSE;
            
            
            //insert the custom property definition into the clientData class at index 
            [clientsEntityDefinition insertPropertyDefinition:clientDataProperty atIndex:0];
            
            
            
            
            /****************************************************************************************/
            /*	END of Class Definition and attributes for the Client Entity */
            /****************************************************************************************/
            /*the client def will be used in the joined clientPresentations table */
            
            
            //Create the property definition for the notes property in the clientPresentation class
            SCPropertyDefinition *supportActivityClientNotesPropertyDef = [clientsEntityDefinition propertyDefinitionWithName:@"notes"];
            
            //set the clientPresentationNotesPropertyDef property definition type to a Text View Cell
            supportActivityClientNotesPropertyDef.type = SCPropertyTypeTextView;
            
            
           
            
            //define a property group
            SCPropertyGroup *supportActivityNotesGroup = [SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"notes", nil]];
            
            // add the main property group to the clientPresentations class. 
            [clientsEntityDefinition.propertyGroups addGroup:supportActivityNotesGroup];
            

            
            
        }
        else {
            clientPresentations_Shared=[[ClientPresentations_Shared alloc]init];
            
            [clientPresentations_Shared setupUsingSTV];
            
            clientsEntityDefinition=clientPresentations_Shared.clientPresentationDef;
            clientsPropertyNameStr=@"clientPresentations";
    
        }
               

        
           clientPresentationsPropertyDef = [timeTrackEntityDef propertyDefinitionWithName:clientsPropertyNameStr];
            clientPresentationsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:clientsEntityDefinition
                                                                                                  allowAddingItems:YES
                                                                                                allowDeletingItems:YES
                                                                                                  allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"tap + to add clients"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:NO];	
        
        
        SCEntityDefinition *serviceCodeDef=[SCEntityDefinition definitionWithEntityName:@"ServiceCodeEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"code",@"name", @"notes", nil]];
        
        
        
        
        serviceCodeDef.orderAttributeName=@"order";
        
        
        serviceCodeDef.titlePropertyName=@"code;name";
        SCPropertyDefinition *serviceCodePropertyDef=[timeTrackEntityDef propertyDefinitionWithName:@"serviceCode"];
        serviceCodePropertyDef.type =SCPropertyTypeObjectSelection;
        
        SCObjectSelectionAttributes *serviceCodeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:serviceCodeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
        serviceCodeSelectionAttribs.allowAddingItems = YES;
        serviceCodeSelectionAttribs.allowDeletingItems = YES;
        serviceCodeSelectionAttribs.allowMovingItems = YES;
        serviceCodeSelectionAttribs.allowEditingItems = YES;
        serviceCodeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap edit to add service code)"];
        serviceCodeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText: @"Add new service code"];
        serviceCodePropertyDef.attributes = serviceCodeSelectionAttribs;
        
        SCPropertyDefinition *serviceCodeNamePropertyDef=[serviceCodeDef propertyDefinitionWithName:@"name"];
        serviceCodeNamePropertyDef.type=SCPropertyTypeTextView;
        SCPropertyDefinition *serviceCodeNotesPropertyDef=[serviceCodeDef propertyDefinitionWithName:@"notes"];
        serviceCodeNotesPropertyDef.type=SCPropertyTypeTextView;
        

        
        
        
        }
    else {
        
         [self.searchBar setSelectedScopeButtonIndex:0];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit ) fromDate:[NSDate date]];
        //create a date with these components
        NSDate *startDate = [calendar dateFromComponents:components];
        [components setMonth:1];
        [components setDay:0]; //reset the other components
        [components setYear:0]; //reset the other components
        NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
        modelPredicate = [NSPredicate predicateWithFormat:@"((dateOfService > %@) AND (dateOfService <= %@)) || (dateOfService = nil)",startDate,endDate];
        
        SCEntityDefinition *supervisionFeedbackDef=[SCEntityDefinition definitionWithEntityName:@"SupervisionFeedbackEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects: @"topic",@"clients", @"feedback",  nil]];
        
        SCEntityDefinition *feedbackTopicDef=[SCEntityDefinition definitionWithEntityName:@"FeedbackTopicEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"topic", nil]];                                                   
                                            
             feedbackTopicDef.orderAttributeName=@"order";                                      
        
        supervisionFeedbackPropertyDef=[timeTrackEntityDef propertyDefinitionWithName:@"supervisionFeedback"];
        supervisionFeedbackPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:supervisionFeedbackDef
                                                                                              allowAddingItems:YES
                                                                                            allowDeletingItems:YES
                                                                                              allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"tap + to add feedback"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:NO];
        
        
       SCPropertyDefinition *feedbackStrPropertyDef=[supervisionFeedbackDef propertyDefinitionWithName:@"feedback"];
        feedbackStrPropertyDef.type=SCPropertyTypeTextView;
        
        //create the dictionary with the data bindings
        NSDictionary *studentsPresentDataBindings = [NSDictionary 
                                               dictionaryWithObjects:[NSArray arrayWithObjects:@"studentsPresent",@"Students Present",[NSNumber numberWithBool:NO],@"studentsPresent",[NSNumber numberWithBool:YES],nil] 
                                               forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
        
        //create the custom property definition
        SCCustomPropertyDefinition *studentsPresentDataProperty = [SCCustomPropertyDefinition definitionWithName:@"StudentsPresentData"
                                                                                            uiElementClass:[ClinicianSelectionCell class] objectBindings:studentsPresentDataBindings];
        
        
        //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
        studentsPresentDataProperty.autoValidate=YES;
        
        [timeTrackEntityDef removePropertyDefinitionWithName:@"studentsPresent"];
        
        [timeTrackEntityDef addPropertyDefinition:(SCPropertyDefinition *)studentsPresentDataProperty];
        
        
        //create the dictionary with the data bindings
        NSDictionary *clientsDataBindings = [NSDictionary 
                                            dictionaryWithObjects:[NSArray arrayWithObjects:@"clients",@"Clients",@"clients",[NSNumber numberWithBool:YES],nil] 
                                            forKeys:[NSArray arrayWithObjects:@"1",@"90",@"92",@"93",nil ]]; // 1 are the control tags
        
        //create the custom property definition
        SCCustomPropertyDefinition *clientsDataProperty = [SCCustomPropertyDefinition definitionWithName:@"CLientsData"
                                                                                         uiElementClass:[ClientsSelectionCell class] objectBindings:clientsDataBindings];
        
        
        //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
        clientsDataProperty.autoValidate=FALSE;
        
        
        //insert the custom property definition into the clientData class at index 
        [supervisionFeedbackDef removePropertyDefinitionWithName:@"clients"];
        [supervisionFeedbackDef insertPropertyDefinition:clientsDataProperty atIndex:0];

        
                
        
        SCPropertyDefinition *feedbackTopicPropertyDef=[supervisionFeedbackDef propertyDefinitionWithName:@"topic"];
        feedbackTopicPropertyDef.type =SCPropertyTypeObjectSelection;
        
        SCObjectSelectionAttributes *feedbackTopicSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:feedbackTopicDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
        feedbackTopicSelectionAttribs.allowAddingItems = YES;
        feedbackTopicSelectionAttribs.allowDeletingItems = YES;
        feedbackTopicSelectionAttribs.allowMovingItems = YES;
        feedbackTopicSelectionAttribs.allowEditingItems = YES;
        feedbackTopicSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap edit to add feedback topic)"];
        feedbackTopicSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText: @"Add new feedback topic"];
        feedbackTopicPropertyDef.attributes = feedbackTopicSelectionAttribs;
        
        SCPropertyDefinition *feedbackTopicNamePropertyDef=[feedbackTopicDef propertyDefinitionWithName:@"topic"];
        feedbackTopicNamePropertyDef.type=SCPropertyTypeTextView;
        SCPropertyDefinition *feedbackTopicNotesPropertyDef=[feedbackTopicDef propertyDefinitionWithName:@"notes"];
        feedbackTopicNotesPropertyDef.type=SCPropertyTypeTextView;
        feedbackTopicDef.keyPropertyName=@"topic";
        feedbackTopicDef.titlePropertyName=@"topic";
        supervisionFeedbackDef.titlePropertyName=@"topic.topic";
        
    }
    
    if (currentControllerSetup!=kTrackAssessmentSetup&&currentControllerSetup!=kTrackSupportSetup) {
   
        NSString *modelEntityName=nil;
        NSArray *modelAttributeNames=[NSArray arrayWithObjects:@"modelName" ,@"acronym", @"evidenceBased", @"notes",nil];
        
        if (currentControllerSetup==kTrackInterventionSetup) {
        
            modelEntityName=@"InterventionModelEntity";
        
        }else if (currentControllerSetup==kTrackSupervisionReceivedSetup||currentControllerSetup==kTrackSupervisionGivenSetup){
             modelEntityName=@"SupervisionModelEntity";
        }
       SCEntityDefinition *modelDef=[SCEntityDefinition definitionWithEntityName:modelEntityName managedObjectContext:managedObjectContext propertyNames:modelAttributeNames];
        
        //Do some property definition customization for the Demographic Profile Entity disabilities relationship
        SCPropertyDefinition *modelUsedPropertyDef = [timeTrackEntityDef propertyDefinitionWithName:@"modelsUsed"];
        
        modelUsedPropertyDef.type = SCPropertyTypeObjectSelection;
        
        SCObjectSelectionAttributes *modelUsedSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:modelDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:NO]; 
        modelUsedSelectionAttribs.allowAddingItems = YES;
        modelUsedSelectionAttribs.allowDeletingItems = YES;
        modelUsedSelectionAttribs.allowMovingItems = YES;
        modelUsedSelectionAttribs.allowEditingItems = YES;
        modelUsedSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Model Definitions)"];
        modelUsedSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Model Definition"];
        modelUsedPropertyDef.attributes = modelUsedSelectionAttribs;
        SCPropertyDefinition *modelUsedNotesPropertyDef = [modelDef propertyDefinitionWithName:@"notes"];
        modelUsedNotesPropertyDef.type=SCPropertyTypeTextView;
        SCPropertyDefinition *modelNamePropertyDef = [modelDef propertyDefinitionWithName:@"modelName"];
        modelNamePropertyDef.type=SCPropertyTypeTextView;
        
        
        
        
    }
    //Create the property definition for the papwerwork property in the testsessiondelivered class
    SCPropertyDefinition *paperworkPropertyDef = [timeTrackEntityDef propertyDefinitionWithName:@"paperwork"];
    
    //set the property definition type to segmented
    paperworkPropertyDef.type = SCPropertyTypeSegmented;
    
    //set the segmented attributes for the paperwork property definition 
    paperworkPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Incomplete", @"Complete",  nil]];
    
    
    
  
  
    //     tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self
    //										withEntityClassDefinition:timeTrackEntity usingPredicate:paperworkIncompletePredicate];
    SCArrayOfObjectsModel *objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:timeTrackEntityDef filterPredicate:modelPredicate];
    
    //    self.tableViewModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView 
    //										entityDefinition:timeTrackEntity];
   
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
    

    SCEntityDefinition *siteDef=[SCEntityDefinition definitionWithEntityName:@"SiteEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"siteName", @"location",@"settingType", @"started",@"ended",@"notes",@"defaultSite", nil]];
    
    
    
    
    SCEntityDefinition *settingTypeDef=[SCEntityDefinition definitionWithEntityName:@"SiteSettingTypeEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects: @"settingTypeName", @"notes",nil]];
    
    
    
    
    siteDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *sitePropertyDef=[timeTrackEntityDef propertyDefinitionWithName:@"site"];
    sitePropertyDef.title=@"Site*";
    sitePropertyDef.autoValidate=NO;
    
    sitePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *siteSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:siteDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    siteSelectionAttribs.allowAddingItems = YES;
    siteSelectionAttribs.allowDeletingItems = YES;
    siteSelectionAttribs.allowMovingItems = YES;
    siteSelectionAttribs.allowEditingItems = YES;
    siteSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Sites)"];
    siteSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Site"];
    sitePropertyDef.attributes = siteSelectionAttribs;
    
    SCPropertyDefinition *siteNamePropertyDef=[siteDef propertyDefinitionWithName:@"siteName"];
    siteNamePropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *siteNotesPropertyDef=[siteDef propertyDefinitionWithName:@"notes"];
    siteNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *siteStartedPropertyDef = [siteDef propertyDefinitionWithName:@"started"];
	siteStartedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                         datePickerMode:UIDatePickerModeDate 
                                                          displayDatePickerInDetailView:YES];
    
    SCPropertyDefinition *siteEndedPropertyDef = [siteDef propertyDefinitionWithName:@"ended"];
	siteEndedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                       datePickerMode:UIDatePickerModeDate 
                                                        displayDatePickerInDetailView:YES];
    
    settingTypeDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *settingTypePropertyDef=[siteDef propertyDefinitionWithName:@"settingType"];
    settingTypePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *settingTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:settingTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    settingTypeSelectionAttribs.allowAddingItems = YES;
    settingTypeSelectionAttribs.allowDeletingItems = YES;
    settingTypeSelectionAttribs.allowMovingItems = YES;
    settingTypeSelectionAttribs.allowEditingItems = YES;
    settingTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap edit to add setting type)"];
    settingTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText: @"Add new setting type"];
    settingTypePropertyDef.attributes = settingTypeSelectionAttribs;
    
    SCPropertyDefinition *settingTypeNamePropertyDef=[settingTypeDef propertyDefinitionWithName:@"settingTypeName"];
    settingTypeNamePropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *settingTypeNotesPropertyDef=[settingTypeDef propertyDefinitionWithName:@"notes"];
    settingTypeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    

    
    
    NSString *typePropertyNameString=nil;
    NSString *typeEntityNameString=nil;
    NSString *typeDescriptionString=nil;
    NSString *typeTitleString=nil;
    switch (currentControllerSetup) {
        case kTrackAssessmentSetup:
        {
            dateOfServicePropertyDef.title=@"Test Date";
            timePropertyDef.title=@"Testing Time";
            clientPresentationsPropertyDef.title=@"Clients Tested";
            
           
            
          
            
            
            typeEntityNameString =@"AssessmentTypeEntity";
            typePropertyNameString=@"assessmentType";
            typeDescriptionString=@"assessment type";
            typeTitleString=@"Assessment Type*";
            
            
        } 

            break;
        case kTrackInterventionSetup:
        {
            dateOfServicePropertyDef.title=@"Service Date";
            
            timePropertyDef.title=@"Direct Time";
            clientPresentationsPropertyDef.title=@"Clients Served";
            
            self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"Current Month",@"All Items",@"Incomplete",nil];
            
            typeEntityNameString =@"InterventionTypeEntity";
            typePropertyNameString=@"interventionType";
              typeDescriptionString=@"intervention type";
            typeTitleString=@"Intervention Type*";
           
        } 
            
            break;
        case kTrackSupportSetup:
        {
            dateOfServicePropertyDef.title=@"Service Date";
            
            timePropertyDef.title=@"Indirect Time";
            clientPresentationsPropertyDef.title=@"Clients Served";
            
             self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"Current Month",@"All Items",@"Incomplete",nil];
            
            
            typeEntityNameString =@"SupportActivityTypeEntity";
            typePropertyNameString=@"supportActivityType";
              typeDescriptionString=@"support activity type";
            typeTitleString=@"Support Activity Type*";
            

        } 
            
            break;
      
        default:
        {
            dateOfServicePropertyDef.title=@"Supervision Date";
            
            timePropertyDef.title=@"Supervision Time";
            supervisionFeedbackPropertyDef.title=@"Feedback Topics";
            
            self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"Current Month",@"All Items",nil];
            
            
            typeEntityNameString =@"SupervisionTypeEntity";
            typePropertyNameString=@"supervisionType";
              typeDescriptionString=@"supervision type";

        
        typeTitleString=@"Supervision Type*";
        
        
        
        }
            break;
    }
    SCEntityDefinition *trackTypeDef=[SCEntityDefinition definitionWithEntityName:typeEntityNameString managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:typePropertyNameString, @"notes", nil]];
    
    
    
    
    trackTypeDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *trackTypePropertyDef=[timeTrackEntityDef propertyDefinitionWithName:typePropertyNameString];
    trackTypePropertyDef.autoValidate=NO;
    trackTypePropertyDef.type =SCPropertyTypeObjectSelection;
    trackTypePropertyDef.title=typeTitleString;
    SCObjectSelectionAttributes *trackTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:trackTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    trackTypeSelectionAttribs.allowAddingItems = YES;
    trackTypeSelectionAttribs.allowDeletingItems = YES;
    trackTypeSelectionAttribs.allowMovingItems = YES;
    trackTypeSelectionAttribs.allowEditingItems = YES;
    trackTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:[NSString stringWithFormat:@"(Tap edit to add %@)",typeDescriptionString]];
    trackTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:[NSString stringWithFormat: @"Add new %@",typeDescriptionString]];
    trackTypePropertyDef.attributes = trackTypeSelectionAttribs;
    
    SCPropertyDefinition *trackTypeStrPropertyDef=[trackTypeDef propertyDefinitionWithName:typePropertyNameString];
   trackTypeStrPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *trackTypeNotesPropertyDef=[trackTypeDef propertyDefinitionWithName:@"notes"];
    trackTypeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    
    
    if (currentControllerSetup==kTrackInterventionSetup) {
        
     
        NSString * subTypePropertyNameString=@"interventionSubType";
        NSString * subTypeEntityNameString=@"InterventionTypeSubtypeEntity";
        NSString * subTypeTitleString=@"Subtype*";
        SCEntityDefinition *trackSubTypeDef=[SCEntityDefinition definitionWithEntityName:subTypeEntityNameString managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:subTypePropertyNameString, @"notes", nil]];
        
        
        
        
        trackSubTypeDef.orderAttributeName=@"order";
        
        
        
        SCPropertyDefinition *trackSubTypePropertyDef=[timeTrackEntityDef propertyDefinitionWithName:@"subtype"];
        trackSubTypePropertyDef.type =SCPropertyTypeObjectSelection;
        trackSubTypePropertyDef.title=subTypeTitleString;
         trackSubTypePropertyDef.autoValidate=NO;
        SCObjectSelectionAttributes *trackSubTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:trackSubTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
        trackSubTypeSelectionAttribs.allowAddingItems = NO;
        trackSubTypeSelectionAttribs.allowDeletingItems = NO;
        trackSubTypeSelectionAttribs.allowMovingItems = YES;
        trackSubTypeSelectionAttribs.allowEditingItems = YES;
        trackSubTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add subtypes under intervention type)"];
        
        trackSubTypePropertyDef.attributes = trackSubTypeSelectionAttribs;
        
        SCPropertyDefinition *trackSubTypeStrPropertyDef=[trackSubTypeDef propertyDefinitionWithName:subTypePropertyNameString];
        trackSubTypeStrPropertyDef.type=SCPropertyTypeTextView;
        SCPropertyDefinition *trackSubTypeNotesPropertyDef=[trackSubTypeDef propertyDefinitionWithName:@"notes"];
        trackSubTypeNotesPropertyDef.type=SCPropertyTypeTextView;
        
        
        
        SCPropertyDefinition *trackTypeSubtypePropertyDef=[SCPropertyDefinition definitionWithName:@"subTypes" title:@"Subtypes" type:SCPropertyTypeArrayOfObjects];
        
        [trackTypeDef addPropertyDefinition:trackTypeSubtypePropertyDef];
        
        trackTypeSubtypePropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:trackSubTypeDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add new intervention subtype"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
        
       
       
        
        

    }
   
    if (currentControllerSetup==kTrackSupervisionReceivedSetup||currentControllerSetup==kTrackSupervisionGivenSetup) {
        
        
        NSString * subTypePropertyNameString=@"subType";
        NSString * subTypeEntityNameString=@"SupervisionTypeSubtypeEntity";
        NSString * subTypeTitleString=@"Subtype*";
        SCEntityDefinition *trackSubTypeDef=[SCEntityDefinition definitionWithEntityName:subTypeEntityNameString managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:subTypePropertyNameString, @"notes", nil]];
        
        
        
        
        trackSubTypeDef.orderAttributeName=@"order";
        
        
        
        SCPropertyDefinition *trackSubTypePropertyDef=[timeTrackEntityDef propertyDefinitionWithName:@"subType"];
        trackSubTypePropertyDef.type =SCPropertyTypeObjectSelection;
        trackSubTypePropertyDef.title=subTypeTitleString;
        trackSubTypePropertyDef.autoValidate=NO;
        SCObjectSelectionAttributes *trackSubTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:trackSubTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
        trackSubTypeSelectionAttribs.allowAddingItems = NO;
        trackSubTypeSelectionAttribs.allowDeletingItems = NO;
        trackSubTypeSelectionAttribs.allowMovingItems = YES;
        trackSubTypeSelectionAttribs.allowEditingItems = YES;
        
        trackSubTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add subtypes under intervention type)"];
        
        trackSubTypePropertyDef.attributes = trackSubTypeSelectionAttribs;
        
        SCPropertyDefinition *trackSubTypeStrPropertyDef=[trackSubTypeDef propertyDefinitionWithName:subTypePropertyNameString];
        trackSubTypeStrPropertyDef.type=SCPropertyTypeTextView;
        SCPropertyDefinition *trackSubTypeNotesPropertyDef=[trackSubTypeDef propertyDefinitionWithName:@"notes"];
        trackSubTypeNotesPropertyDef.type=SCPropertyTypeTextView;
        
        SCPropertyDefinition *trackTypeSubtypePropertyDef=[SCPropertyDefinition definitionWithName:@"subTypes" title:@"Subtypes" type:SCPropertyTypeArrayOfObjects];
        
        [trackTypeDef addPropertyDefinition:trackTypeSubtypePropertyDef];
        
        trackTypeSubtypePropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:trackSubTypeDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add new supervision subtype"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
        
    }

    
    //begin rate paste
    
    
    //end
    
    
    
    NSString * ratePropertyNameString=@"hourlyRate";
    NSString * rateEntityNameString=@"RateEntity";
    
    SCEntityDefinition *trackRateDef=[SCEntityDefinition definitionWithEntityName:rateEntityNameString managedObjectContext:managedObjectContext propertyNamesString:@"rateName;dateStarted;dateEnded;hourlyRate;notes"];
    
    
    
    
    trackRateDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *trackRatePropertyDef=[timeTrackEntityDef propertyDefinitionWithName:ratePropertyNameString];
    trackRatePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *trackRateSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:trackRateDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    trackRateSelectionAttribs.allowAddingItems = YES;
    trackRateSelectionAttribs.allowDeletingItems = YES;
    trackRateSelectionAttribs.allowMovingItems = YES;
    trackRateSelectionAttribs.allowEditingItems = YES;
    trackRateSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"(Add Rates)"];
    
    trackRatePropertyDef.attributes = trackRateSelectionAttribs;
    
    SCPropertyDefinition *trackRateStrPropertyDef=[trackRateDef propertyDefinitionWithName:ratePropertyNameString];
    trackRateStrPropertyDef.type=SCPropertyTypeNumericTextField;
    SCPropertyDefinition *trackRateNotesPropertyDef=[trackRateDef propertyDefinitionWithName:@"notes"];
    trackRateNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *rateDateStartedPropertyDef = [trackRateDef propertyDefinitionWithName:@"dateStarted"];
	rateDateStartedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                           datePickerMode:UIDatePickerModeDate
                                                            displayDatePickerInDetailView:NO];
    
    
    SCPropertyDefinition *rateDateEndedPropertyDef = [trackRateDef propertyDefinitionWithName:@"dateEnded"];
	rateDateEndedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                         datePickerMode:UIDatePickerModeDate
                                                          displayDatePickerInDetailView:NO];
    
    
    
    
    
    SCPropertyGroup *paymentGroup=[SCPropertyGroup groupWithHeaderTitle:@"Payment Information" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"hourlyRate",@"paid", nil]];
    
    [timeTrackEntityDef.propertyGroups addGroup:paymentGroup];
    
    
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    
    
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    objectsModel.autoSortSections = TRUE;  
    objectsModel.searchBar = self.searchBar;
	objectsModel.searchPropertyName = @"dateOfService";
    
    objectsModel.allowMovingItems=TRUE;
    
    objectsModel.autoAssignDelegateForDetailModels=TRUE;
    objectsModel.autoAssignDataSourceForDetailModels=TRUE;
    
    
    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    
    
    
    if(![SCUtilities is_iPad]){
        
        objectsModel.theme=[SCTheme themeWithPath:@"mapper-iPhone.ptt"];
       
        UIImage *menueBarImage=[UIImage imageNamed:@"menubar-full.png"];
        [self.searchBar setBackgroundImage:menueBarImage];
        [self.searchBar setScopeBarBackgroundImage:menueBarImage];
        
        
        
    }else {
        objectsModel.theme=[SCTheme themeWithPath:@"mapper-ipad-full.ptt"];
      
        UIImage *menueBarImage=[UIImage imageNamed:@"ipad-menubar-right.png"];
        [self.searchBar setBackgroundImage:menueBarImage];
        [self.searchBar setScopeBarBackgroundImage:menueBarImage];
        
        
    }
   
    objectsModel.modelActions.didRefresh = ^(SCTableViewModel *tableModel)
    {
        [self updateAdministrationTotalLabel:tableModel];
    };
    
    self.tableViewModel=objectsModel;
     [self updateAdministrationTotalLabel:self.tableViewModel];
    
   
     // Initialize tableModel
//    NSString *detailThemeNameStr=nil;
    if ([SCUtilities is_iPad]) {
//        NSString *mapperThemePath=(NSString *)[(NSString *)(NSBundle *)[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"mapper-ipad-full"];
//        
//        detailThemeNameStr=mapperThemePath;
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
    }
    else {
        
        [self.tableView setBackgroundColor:[UIColor clearColor]];
       
//        NSString *mapperThemePath=[NSBundle pathForResource:@"mapper-phone" ofType:@"ppt" inDirectory:@"MapperTheme"];
//        
//        detailThemeNameStr=mapperThemePath;
    }
//
//    SCTheme *theme=[SCTheme themeWithPath:detailThemeNameStr];
//    objectsModel.theme=theme;
    

  
    
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
//
    self.psyTrackCalendar=[ self eventEditViewControllerDefaultCalendarForNewEvents:nil];
    
    
    
//                 NSSet *calendars=(NSSet *)[localSource calendars];
//                    for(id obj in calendars) { 
//                    if([obj isKindOfClass:[EKCalendar class]]){
//                        EKCalendar *calendar=(EKCalendar *)obj;
//                        if ([calendar.calendarIdentifier isEqualToString:self.psyTrackCalendar.calendarIdentifier]) {
//                            self.psyTrackCalendar=(EKCalendar *)calendar;
//                          
//                            break;
//                        }}}
    
    
    
//    for (EKCalendar *calander in self.eventStore.calendars){
//    
//       
//    
//        if ([calander.title isEqualToString:@"Client Appointments"]) {
//    
//               NSError *err;
//            [self.eventStore removeCalendar:calander commit:YES error:&err ];
//        }
    
//     
    
//    }
// Get the default calendar from store.
	
    
    //	    
    
    
    
}


//-(void)didMoveToParentViewController:(UIViewController *)parent{
//

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
    
    
    
    
    
    
    if([tableViewModel isKindOfClass:[SCArrayOfObjectsModel class]])
    {
        SCArrayOfObjectsModel *objectsModel = (SCArrayOfObjectsModel *)tableViewModel;
        
       
        
        
        
       
               
        [self.searchBar setSelectedScopeButtonIndex:selectedScope];
        
        switch (selectedScope) {
            case 1: //all
                
                
                [objectsModel.dataFetchOptions setFilterPredicate:nil];
                //             
                break;
                
            case 2: //case paperwork Incomplete
               
            {
                NSPredicate *paperworkIncompletePredicate = [NSPredicate predicateWithFormat:@"paperwork == %@",[NSNumber numberWithInteger: 0]];
                

                [objectsModel.dataFetchOptions setFilterPredicate:paperworkIncompletePredicate];
            }   
                
                
                
                break;                
                
            default://current month
            {
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit ) fromDate:[NSDate date]];
                //create a date with these components
                NSDate *startDate = [calendar dateFromComponents:components];
                [components setMonth:1];
                [components setDay:0]; //reset the other components
                [components setYear:0]; //reset the other components
                NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
                NSPredicate *currentMonthPredicate = [NSPredicate predicateWithFormat:@"((dateOfService > %@) AND (dateOfService <= %@)) || (dateOfService = nil)",startDate,endDate];
                [objectsModel.dataFetchOptions setFilterPredicate:currentMonthPredicate];
                
            }   
                
                
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
        
        NSString *emptyLabelTextStr=nil;
        NSString *totalLabelTextStr=nil;
        switch (currentControllerSetup) {
            case kTrackAssessmentSetup:
                emptyLabelTextStr=@"Tap + To Add Administrations";
                totalLabelTextStr=@"Total Administrations: ";
                break;
            case kTrackInterventionSetup:
                emptyLabelTextStr=@"Tap + To Add Interventions";
                totalLabelTextStr=@"Total Interventions: ";
                break;
            case kTrackSupportSetup:
                emptyLabelTextStr=@"Tap + To Add Indirect Support Activties";
                 totalLabelTextStr=@"Total Indirect Support Activities: ";
                break;
            case kTrackSupervisionGivenSetup:
                emptyLabelTextStr=@"Tap + To Add Supervision Given";
                 totalLabelTextStr=@"Total Supervision Sessions Given: ";
                break;
            
            case kTrackSupervisionReceivedSetup:
                emptyLabelTextStr=@"Tap + To Add Supervision Received";
                 totalLabelTextStr=@"Total Supervision Sessions Received: ";
                break;
            
            default:
                break;
        }
        
        
        int cellCount=0;
        
        if (tableModel.sectionCount >0){
            
            for (int i=0; i<tableModel.sectionCount; i++) {
                SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:i];
                cellCount=cellCount+section.cellCount;
                
            }
            
            
        }
        if (cellCount==0)
        {
            self.totalAdministrationsLabel.text=emptyLabelTextStr;
        }
        else
        {
            self.totalAdministrationsLabel.text=[NSString stringWithFormat:@"%@%i", totalLabelTextStr, cellCount];
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
    //
    //    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
    
    
    
    if(tableViewModel.tag==1 &&(indexPath.section==0||indexPath.section==1)){
        //        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        
        
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
                    
                    NSString *eventIdentifier=[cell.boundObject valueForKey:@"eventIdentifier"]; 
                    
                    
                    
                    NSString *buttonText;
                    if (eventIdentifier.length) {
                        buttonText=@"Edit This Calendar Event";
                    }
                    else {
                        buttonText=@"Add Event to Calendar";
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
                
                
                
                
                
            }
            
        }
        
        
    }

  }





-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillDismissForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    currentDetailTableViewModel=tableViewModel;
        
    if (tableViewModel.tag==0) {
        selectedInterventionType=nil;
        selectedSupervisionType=nil;
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
        
        
        
        if (section.cellCount>0) 
        {
            SCTableViewCell *cell=(SCTableViewCell *)[section cellAtIndex:0];
            
            if (section.cellCount>1 || (section.cellCount==1 &&![cell.textLabel.text isEqualToString:@"tap + to add clients"])) 
            {
                
                NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
                
                if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&& [cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) {
                    
                    SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)[tableViewModel sectionAtIndex:0];
                    NSMutableSet *mutableSet=[(NSMutableSet *)arrayOfObjectsSection.items mutableSetValueForKey:@"client"];
                    
                    
                    SCArrayOfObjectsSection *mainSection=(SCArrayOfObjectsSection *)[detailTableViewModel sectionAtIndex:0];
                    if (mainSection.cellCount) {
                        SCTableViewCell *cellAtZero=(SCTableViewCell *)[mainSection cellAtIndex:0];
                        
                        if ([cellAtZero isKindOfClass:[ClientsSelectionCell class]]) {
                            ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)[mainSection cellAtIndex:0];
                            clientSelectionCell.alreadySelectedClients=mutableSet;
                            
                            
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
////            
////            
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
    
    if ([SCUtilities is_iPad]) {
                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        UIColor *backgroundColor=nil;
     
        if(indexPath.row==NSNotFound|| tableModel.tag>0)
        {
          
            backgroundColor=(UIColor *)appDelegate.window.backgroundColor;
            
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
    //start
    
    
    
    if (currentControllerSetup==kTrackInterventionSetup&& detailTableViewModel.tag==1&& detailTableViewModel.sectionCount>2) {
        
        SCTableViewSection *section=(SCTableViewSection *)[detailTableViewModel sectionAtIndex:2];
        
        
        
        if ([section isKindOfClass:[SCObjectSection class]]){
            
            SCObjectSection *objectSection=(SCObjectSection *)section;
            
            
            NSManagedObject *sectionManagedObject=(NSManagedObject *)objectSection.boundObject;
            
            
            
            
            if (sectionManagedObject&&[sectionManagedObject respondsToSelector:@selector(entity)]&&[sectionManagedObject.entity.name isEqualToString:@"InterventionDeliveredEntity"]&&objectSection.cellCount>4) {
                
                SCTableViewCell *cellAtFour=(SCTableViewCell *)[objectSection cellAtIndex:4];
                if ([cellAtFour isKindOfClass:[SCObjectSelectionCell class]]) {
                    SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cellAtFour;
                    
                    
                    
                    NSObject *interventionTypeObject=[sectionManagedObject valueForKeyPath:@"interventionType"];
                    
                    if (indexPath.row!=NSNotFound &&( selectedInterventionType||(interventionTypeObject&&[interventionTypeObject isKindOfClass:[InterventionTypeEntity class]]))) {
                        if (!selectedInterventionType) {
                            selectedInterventionType=(InterventionTypeEntity *)interventionTypeObject;
                        }
                        
                        
                        if (selectedInterventionType.interventionType.length) {
                            
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                      @"interventionType.interventionType like %@",[NSString stringWithString:(NSString *) selectedInterventionType.interventionType]]; 
                            
                            SCDataFetchOptions *dataFetchOptions=[SCDataFetchOptions optionsWithSortKey:@"interventionSubType" sortAscending:YES filterPredicate:predicate];
                            
                            objectSelectionCell.selectionItemsFetchOptions=dataFetchOptions;
                            
                            [objectSelectionCell reloadBoundValue];
                            
                            
                        }
                        
                    }
                    else {
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                  @"interventionType.interventionType = nil"]; 
                        
                        SCDataFetchOptions *dataFetchOptions=[SCDataFetchOptions optionsWithSortKey:@"interventionSubType" sortAscending:YES filterPredicate:predicate];
                        
                        objectSelectionCell.selectionItemsFetchOptions=dataFetchOptions;
                    }
                    
                    
                }
                
                
                
            }
            
            if (sectionManagedObject&&[sectionManagedObject respondsToSelector:@selector(entity)]&&([sectionManagedObject.entity.name isEqualToString:@"SupervisionReceivedEntity"]||[sectionManagedObject.entity.name isEqualToString:@"SupervisionGivenEntity"])&&objectSection.cellCount>1) {
                
                SCTableViewCell *cellAtFour=(SCTableViewCell *)[objectSection cellAtIndex:0];
                if ([cellAtFour isKindOfClass:[SCObjectSelectionCell class]]) {
                    SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cellAtFour;
                    
                    
                    
                    NSObject *supervisionTypeObject=[sectionManagedObject valueForKeyPath:@"supervisionType"];
                    
                    if (indexPath.row!=NSNotFound &&( selectedSupervisionType||(supervisionTypeObject&&[supervisionTypeObject isKindOfClass:[SupervisionTypeEntity class]]))) {
                        if (!selectedSupervisionType) {
                            selectedSupervisionType=(SupervisionTypeEntity *)supervisionTypeObject;
                        }
                        
                        
                        if (selectedSupervisionType.supervisionType.length) {
                            
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                      @"supervisionType.supervisionType like %@",[NSString stringWithString:(NSString *) selectedSupervisionType.supervisionType]]; 
                            
                            SCDataFetchOptions *dataFetchOptions=[SCDataFetchOptions optionsWithSortKey:@"supervisionSubType" sortAscending:YES filterPredicate:predicate];
                            
                            objectSelectionCell.selectionItemsFetchOptions=dataFetchOptions;
                            
                            [objectSelectionCell reloadBoundValue];
                            
                            
                        }
                        
                    }
                    else {
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                  @"supervisionType.supervisionType = nil"]; 
                        
                        SCDataFetchOptions *dataFetchOptions=[SCDataFetchOptions optionsWithSortKey:@"subType" sortAscending:YES filterPredicate:predicate];
                        
                        objectSelectionCell.selectionItemsFetchOptions=dataFetchOptions;
                    }
                    
                    
                }
                
                
                
            }
        }}
    
    
    
    
    ///end

    
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
            
            if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] &&[cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) {
                
                SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)section;
                NSMutableSet *mutableSet=[(NSMutableSet *)arrayOfObjectsSection.items mutableSetValueForKey:@"client"];
                
                
                if (detailTableViewModel.sectionCount) {
               
                SCArrayOfObjectsSection *mainSection=(SCArrayOfObjectsSection *)[detailTableViewModel sectionAtIndex:0];
                if (mainSection.cellCount) {
                    SCTableViewCell *cellAtZero=(SCTableViewCell *)[mainSection cellAtIndex:0];
                    
                    if ([cellAtZero isKindOfClass:[ClientsSelectionCell class]]) {
                        ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)[mainSection cellAtIndex:0];
                        clientSelectionCell.alreadySelectedClients=mutableSet;
                        
                        
                        clientSelectionCell.hasChangedClients=NO;
                    }
                    
                    
                }
                    
                }
                
                
                
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
    
    
    if (section.footerTitle&&section.footerTitle.length) {
        UIView *footerContainerView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 300, 20)];
        UILabel *sectionFooterLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 300, 20)];
        
        
        sectionFooterLabel.backgroundColor = [UIColor clearColor];
        sectionFooterLabel.textColor = [UIColor yellowColor];
        sectionFooterLabel.tag=60;
        sectionFooterLabel.text=section.footerTitle;
        [footerContainerView addSubview:sectionFooterLabel];
        
        section.footerView = footerContainerView;   
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
        
        
               
    }
  

    if (tableViewModel.tag==3 && tableViewModel.sectionCount&&index==1) {
        
        
      
        SCTableViewSection *sectionOne=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
        
        if ([section isKindOfClass:[SCObjectSection class]]) {
            SCObjectSection *objectSection=(SCObjectSection *)section;
            
            NSManagedObject *objectSectionManagedObject=(NSManagedObject *)objectSection.boundObject;
            
            if (objectSectionManagedObject&&[objectSectionManagedObject respondsToSelector:@selector(entity)] &&([objectSectionManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]||[objectSectionManagedObject.entity.name isEqualToString:@"SupportActivityClientEntity"])) {
              
                
                //if change the cell text then update the method that sets the age with the new cell text
                SCLabelCell *actualAge=[SCLabelCell cellWithText:@"Test Age" boundObject:nil labelTextPropertyName:@"Age"];
                SCLabelCell *wechslerAge=[SCLabelCell cellWithText:@"Age (30-Day Months)" boundObject:nil labelTextPropertyName:@"WechslerAge"];
                actualAge.label.text=@"0y 0m";
                wechslerAge.label.text=@"0y 0m";
                [sectionOne addCell:actualAge];
                [sectionOne addCell:wechslerAge];
            } 
        
        
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
        
        NSDate *totalTime=[cellManagedObject valueForKeyPath:@"time.totalTime"];
        NSDateFormatter *timeFormatter=[[NSDateFormatter alloc]init];
        
        [timeFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        
        [timeFormatter setDateFormat:@"HH:mm"];
        
        cell.textLabel.text= [NSString stringWithFormat:@"%@; (%@)",[dateFormatter stringFromDate:[cellManagedObject valueForKey:@"dateOfService"]], [timeFormatter stringFromDate:totalTime]];
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]) {
            
            
            
            //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
            if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
                
            
                //identify the Languages Spoken table
                NSString *mainEntityString=[NSString string];
                switch (currentControllerSetup) {
                    case kTrackAssessmentSetup:
                        mainEntityString=kTrackAssessmentEntityName;
                        break;
                    case kTrackInterventionSetup:
                        mainEntityString=kTrackInterventionEntityName;
                        break;
                    case kTrackSupportSetup:
                        mainEntityString=kTrackSupportEntityName;
                        break;
                    default:
                        break;
                }
                NSString *cellTextString=[cell.textLabel text];
                if ([cellManagedObject.entity.name isEqualToString:mainEntityString]) {
                    
                    
                    
                    
                    
                    
                    //get the value of the primaryLangugage attribute
                    NSNumber *paperworkNumber=(NSNumber *)[cellManagedObject valueForKey:@"paperwork"];
                    
                    
                    
                    //if the paperwork selection is Yes
                    if (paperworkNumber==[NSNumber numberWithInteger:0]) {
                        //set the text color to red
                        cell.textLabel.textColor=[UIColor redColor];
                    }
                    NSString *pathStr=nil;
                    if (currentControllerSetup== kTrackSupportSetup) {
                        pathStr=@"supportActivityClients.client.clientIDCode";
                    }
                    else {
                        pathStr=@"clientPresentations.client.clientIDCode";
                    }
                    
                    NSMutableSet *clientSet=[cellManagedObject mutableSetValueForKeyPath:pathStr];
                    
                    
                    
                    NSString *clientsString=[NSString string];
                    if ([clientSet count]) {
                        for (id obj in clientSet){
                            clientsString=[clientsString stringByAppendingFormat:@" %@,",obj];
                            
                            
                        }
                        
                    }
                    
                    
                    if ( [clientsString length] > 1){
                        clientsString = [clientsString substringToIndex:[clientsString length] - 1];
                        clientsString =[clientsString substringFromIndex:1]; 
                        if (cellTextString.length) {
                            cellTextString=[cellTextString stringByAppendingFormat:@": %@ ",clientsString];
                            
                        }
                    }
                    
                }
                else 
                {
                    
                    switch (currentControllerSetup) {
                        case kTrackSupervisionReceivedSetup:
                        {
                            ClinicianEntity *supervisor=(ClinicianEntity *)[cellManagedObject valueForKey:@"supervisor"];
                            
                            if (supervisor) {
                                cellTextString=[cellTextString stringByAppendingFormat:@": %@",supervisor.combinedName];
                                
                                
                            }
                        }
                            break;
                        case kTrackSupervisionGivenSetup:
                        {
                            NSMutableSet *studentsSet=[cellManagedObject mutableSetValueForKey:@"studentsPresent"];
                            NSString *superviseesString=[NSString string];
                            if ([studentsSet count]) {
                                for (id obj in studentsSet)
                                {
                                    if ([obj isKindOfClass:[ClinicianEntity class]])
                                    {
                                        
                                        ClinicianEntity *student=(ClinicianEntity *)obj;
                                        
                                        superviseesString=[superviseesString stringByAppendingFormat:@" %@,",student.combinedName];
                                        

                                    }
                                                                        
                                }
                                if ( [superviseesString length] > 1){
                                    
                                    if (cellTextString.length) {
                                        cellTextString=[cellTextString stringByAppendingFormat:@":%@ ",superviseesString];
                                        
                                    }
                                } 
                            }
                        
                        
                        }
                            break;    
                        default:
                            break;
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
                    
                    
                    
                
            }
            
        }
        
        
        
    }
    
    
    if (tableViewModel.tag==1) 
    {
        
        
        if (cell.tag==1)
        {
            
            if ([cell isKindOfClass:[SCObjectCell class]]) 
            {
               
                NSDate *totalTimeDateBoundValue=(NSDate *)[cell.boundObject valueForKey:@"totalTime"];
                
                NSString *totalTimeString=[counterDateFormatter stringFromDate:totalTimeDateBoundValue];
                
                
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
       else if ([cell isKindOfClass:[ClinicianSelectionCell class]]) {
            ClinicianSelectionCell *clinicianSelectionCell=(ClinicianSelectionCell *)cell;
            
            if (clinicianSelectionCell.clinicianObject ) {
                ClinicianEntity *supervisorSelected=(ClinicianEntity *)clinicianSelectionCell.clinicianObject;
                if ([supervisorSelected.myInformation isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                    clinicianSelectionCell.label.text=@"Self";
                }
            }
            
        }

        //        UIView *view=(UIView *)[timeCell viewWithTag:5];
        //        UILabel*lable =(UILabel*)view;
        //        lable.text=@"test";
        //        timeCell.label.text=(NSString *)[counterDateFormatter stringFromDate:totalTimeDate];
        
        
       else if ([cell.textLabel.text isEqualToString:@"Hourly Rate"]&&[cell isKindOfClass:[SCObjectSelectionCell class]]){
           
           SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cell;
           
           if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]]) {
            
               RateEntity *rateSelected=(RateEntity *)[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex intValue]];
               
               NSLocale *locale = [NSLocale currentLocale];
               NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc]init];
               [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
               [currencyFormatter setLocale:locale];
               objectSelectionCell.label.text=[rateSelected.rateName stringByAppendingFormat:@" %@",[currencyFormatter stringFromNumber:rateSelected.hourlyRate]];
               
           }
           
       
       
       }
        
        
    }
    
    
    
    if (tableViewModel.tag==2) {
        
        
        
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]) {
        
            if ([cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) {
                
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
                
                
               else if (cell.tag==5)
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
            else if ([cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"])
            
            {
                
                
                
                    
                    
                    
                    UILabel *totalTimeLabel=(UILabel *)[cell viewWithTag:28];
                    totalTimeLabel.text=[self tableViewModel:tableViewModel calculateBreakTimeForRowAtIndexPath:indexPath withBoundValues:YES];
                    SCTableViewSection *section=[tableViewModel sectionAtIndex:1];
                    
                    NSString *totalBreakTimeString=(NSString *)[self totalBreakTimeString];
                    UILabel *headerLabel=(UILabel *)[section.headerView viewWithTag:60];
                    headerLabel.text=totalBreakTimeString;
                    
                
                
            }
           
            else if ([cellManagedObject.entity.name isEqualToString:@"RateEntity"])
                
            {
                
                
                
                
                
                RateEntity *rateSelected=(RateEntity *)cellManagedObject;
                NSLocale *locale = [NSLocale currentLocale];
                NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc]init];
                [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                [currencyFormatter setLocale:locale];
                cell.textLabel.text=[rateSelected.rateName stringByAppendingFormat:@" %@",[currencyFormatter stringFromNumber:rateSelected.hourlyRate]];
                
                
                
                
            }
            
            
            
        }
    }
    if (tableViewModel.tag==3) 
    {
        
        
        
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        if (cellManagedObject &&[cellManagedObject respondsToSelector:@selector(entity)]) {
       
            if ( [cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
            
                
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
          
            
            if ( [cellManagedObject.entity.name isEqualToString:@"SupportActivityClientEntity"]) 
            {
                SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
                
                [self displayAgeInAgeCells:section];
            
            
            }
            
        }
        
        
        
               
        
        
    }
    
    
    
    

    
    
}


-(BOOL)tableViewModel:(SCTableViewModel *)tableModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath{

    BOOL valid=NO;

    SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
    
    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
    
    if (tableModel.tag==1 &&cellManagedObject) {
        ClinicianEntity *supervisor=(ClinicianEntity *)[cellManagedObject valueForKey:@"supervisor"];
        if (supervisor &&[supervisor isKindOfClass:[ClinicianEntity class]]) {
            valid=YES;
        }
        
        
        NSString *cellTitleLastCharacter=[cell.textLabel.text substringFromIndex:cell.textLabel.text.length-1 ];
    
        
     
        if ([cell isKindOfClass:[SCObjectSelectionCell class]]&&[cellTitleLastCharacter isEqualToString:@"*" ]) {
            SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cell;
            
            
            if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]]) {
                valid=YES;
            }else {
                valid=NO;
            }
            
        }

    
    

    }
    else 
    {
        valid=YES;
    }


    return  valid;
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        
    if (tableViewModel.tag==1) 
    {
        SCSelectionCell *cell=(SCSelectionCell *)[tableViewModel.modeledTableView cellForRowAtIndexPath:indexPath];
        
        if (cell.tag==0) {
            if ([cell isKindOfClass:[SCDateCell class]]){
                serviceDateCell=(SCDateCell *)cell;
            }
        }
        
        if (cell.tag==1) //time cell
        {
            
            
            
            
            
            
            
            if ([cell isKindOfClass:[SCObjectCell class]]) 
            {
            
                [cell.boundObject setValue:totalTimeDate forKey:@"totalTime"];
                [self tableViewModel:(SCTableViewModel *)tableViewModel 
                     willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath];
                
                currentDetailTableViewModel=tableViewModel;

                
                
            }
        }
        
        
        
        
        //begin
        
       
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        if (currentControllerSetup==kTrackInterventionSetup&& cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"InterventionDeliveredEntity"] && [cell isKindOfClass:[SCObjectSelectionCell class]]&& cell.tag==3) {
            
            SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cell;
            
            
            if ([objectSelectionCell.selectedItemIndex intValue]>-1) {
              NSManagedObject *selectedInterventionTypeManagedObject =[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];
                if ([selectedInterventionTypeManagedObject isKindOfClass:[InterventionTypeEntity class]]) {
                    selectedInterventionType=(InterventionTypeEntity *) selectedInterventionTypeManagedObject;
                
                
                
                    SCTableViewCell *subtypeCell=(SCTableViewCell *)[tableViewModel cellAfterCell:objectSelectionCell rewind:NO];
                    
                    if ([subtypeCell isKindOfClass:[SCObjectSelectionCell class]]) {
                   
                    
                        SCObjectSelectionCell *subytypeObjectSelectionCell=(SCObjectSelectionCell *)subtypeCell;
                    
                        if (selectedInterventionType.interventionType.length) {
                            
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                      @"interventionType.interventionType like %@",[NSString stringWithString:(NSString *) selectedInterventionType.interventionType]]; 
                            
                            SCDataFetchOptions *dataFetchOptions=[SCDataFetchOptions optionsWithSortKey:@"interventionSubType" sortAscending:YES filterPredicate:predicate];
                            
                            subytypeObjectSelectionCell.selectionItemsFetchOptions=dataFetchOptions;
                            
                            [subytypeObjectSelectionCell reloadBoundValue];
                            
                            
                        }

                    }
                
                
                }
               
                
                                    
               

                
                
                
            }}
               
            if ((currentControllerSetup==kTrackSupervisionReceivedSetup||currentControllerSetup==kTrackSupervisionGivenSetup)&& cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&([cellManagedObject.entity.name isEqualToString:@"SupervisionReceivedEntity"]||[cellManagedObject.entity.name isEqualToString:@"SupervisionGivenEntity"] )&& [cell isKindOfClass:[SCObjectSelectionCell class]]&& cell.tag==0) {
                
                SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cell;
                
                
                if ([objectSelectionCell.selectedItemIndex intValue]>-1) {
                    NSManagedObject *selectedSupervisionTypeManagedObject =[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];
                    if ([selectedSupervisionTypeManagedObject isKindOfClass:[SupervisionTypeEntity class]]) {
                        selectedSupervisionType=(SupervisionTypeEntity *) selectedSupervisionTypeManagedObject;
                        
                        
                        
                        SCTableViewCell *subtypeCell=(SCTableViewCell *)[tableViewModel cellAfterCell:objectSelectionCell rewind:NO];
                        
                        if ([subtypeCell isKindOfClass:[SCObjectSelectionCell class]]) {
                            
                            
                            SCObjectSelectionCell *subytypeObjectSelectionCell=(SCObjectSelectionCell *)subtypeCell;
                            
                            if (selectedSupervisionType.supervisionType.length) {
                                
                                NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                          @"supervisionType.supervisionType like %@",[NSString stringWithString:(NSString *) selectedSupervisionType.supervisionType]]; 
                                
                                SCDataFetchOptions *dataFetchOptions=[SCDataFetchOptions optionsWithSortKey:@"subType" sortAscending:YES filterPredicate:predicate];
                                
                                subytypeObjectSelectionCell.selectionItemsFetchOptions=dataFetchOptions;
                                
                                [subytypeObjectSelectionCell reloadBoundValue];
                                
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                }  
                    
                    
                    
                } 
           
            
        

        
        
        
        //end
        
        
        
            }
    
    
    if (tableViewModel.tag==2) {
        
        currentDetailTableViewModel=tableViewModel;

        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
     
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) {
            
            
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
         PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        if (cellManagedObject &&[cellManagedObject respondsToSelector:@selector(entity)]) { 
            if ( [cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
                
                
                
                if (cell.tag==1||cell.tag==2||cell.tag==3)
                    breakTimeTotalHeaderLabel.text=[self tableViewModel:tableViewModel calculateBreakTimeForRowAtIndexPath:indexPath withBoundValues:NO];
                }
            
            if ( [cellManagedObject.entity.name isEqualToString:@"SupportActivityClientEntity"]) 
            {
                SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
                
                [self displayAgeInAgeCells:section];
                
                
            }
        }   
        currentDetailTableViewModel=tableViewModel;

       
        if ([cellManagedObject.entity.name isEqualToString:@"TrainingProgramEntity"]) {
            if (cell.tag==7) {
                       PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
            
            
            NSFetchRequest *trainingProgramFetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *trainingProgramEntity = [NSEntityDescription entityForName:@"TrainingProgramEntity" inManagedObjectContext:appDelegate.managedObjectContext];
            [trainingProgramFetchRequest setEntity:trainingProgramEntity];
            
            NSPredicate *defaultTrainingPredicate = [NSPredicate predicateWithFormat:@"selectedByDefault == %@ ", [NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES]];
            [trainingProgramFetchRequest setPredicate:defaultTrainingPredicate];
            
            NSError *trainingProgramError = nil;
            NSArray *trainingProgramFetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:trainingProgramFetchRequest error:&trainingProgramError];
            
            
            if (trainingProgramFetchedObjects&&trainingProgramFetchedObjects.count) {
                
                for (TrainingProgramEntity *trainingProgram in trainingProgramFetchedObjects) {
                    [trainingProgram willChangeValueForKey:@"selectedByDefault"];
                    trainingProgram.selectedByDefault=[NSNumber numberWithBool:NO];
                    [trainingProgram didChangeValueForKey:@"selectedByDefault"];
                }
                
                
                
                
                
            }     
            }
        }
        if ([cellManagedObject.entity.name isEqualToString:@"SiteEntity"]) {
            if (cell.tag==6) {
               
                
                
                NSFetchRequest *siteFetchRequest = [[NSFetchRequest alloc] init];
                NSEntityDescription *siteEntity = [NSEntityDescription entityForName:@"SiteEntity" inManagedObjectContext:appDelegate.managedObjectContext];
                [siteFetchRequest setEntity:siteEntity];
                
                NSPredicate *defaultSitePredicate = [NSPredicate predicateWithFormat:@"defaultSite == %@ ", [NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES]];
                [siteFetchRequest setPredicate:defaultSitePredicate];
                
                NSError *siteError = nil;
                NSArray *siteFetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:siteFetchRequest error:&siteError];
                
                
                if (siteFetchedObjects&&siteFetchedObjects.count) {
                                        
                    for (SiteEntity *site  in siteFetchedObjects) {
                        [site willChangeValueForKey:@"defaultSite"];
                        site.defaultSite=[NSNumber numberWithBool:NO];
                        [site didChangeValueForKey:@"defaultSite"];
                    }
                    
                    
                    
                    
                    
                }     
            }
        }

        
    } 
    
    
    
       
    
        
    
    
}








#pragma mark -
#pragma mark Add a new event

// If event is nil, a new event is created and added to the specified event store. New events are 
// added to the default calendar. An exception is raised if set to an event that is not in the 
// specified event store.
- (void)addEvent:(id)sender {
	
    EKEvent *thisEvent;
    
    
    
    if ([[sender class] isSubclassOfClass:[UIButton class]]) 
    {
        UIButton *button=(UIButton *)sender;
        UIView *buttonView=(UIView *)button.superview;
        
        
        if ([buttonView.superview isKindOfClass:[ButtonCell class]]) 
        {
            ButtonCell *buttonCell=(ButtonCell *)buttonView.superview;
            
            
            NSManagedObject *buttonManagedObject=(NSManagedObject *)buttonCell.boundObject;
            NSString *eventIdentifier=(NSString *)[buttonManagedObject valueForKey:@"eventIdentifier"];
            
            if (eventIdentifier.length  &&[self.eventStore eventWithIdentifier:eventIdentifier]) {
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
                
                
                [buttonCell commitDetailModelChanges:currentDetailTableViewModel];
                
                [currentDetailTableViewModel.modeledTableView reloadData];
                
                NSManagedObject *buttonCellManagedObject=(NSManagedObject *)buttonCell.boundObject;
                
                
                
                TimeEntity *timeEntity=(TimeEntity *)[buttonCellManagedObject valueForKey:@"time"];
                
                NSDate *testDate=(NSDate *)[buttonCellManagedObject valueForKey:@"dateOfService"];
                
                NSDate *calanderStartTime=(NSDate *)[timeEntity valueForKey:@"startTime"];
                
                
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
                    
                    
                    
                    startTime=[dateFormatterCombined dateFromString:startDateString];
                    
                }
                
                if (calanderEndTime && testDate) {
                    NSString *endDateString=[NSString stringWithFormat:@"%@ %@",[dateFormatterTime stringFromDate:endTime],[dateFormatterDate stringFromDate:testDate]];
                    
                    
                    
                    endTime=[dateFormatterCombined dateFromString:endDateString];
                    
                    
                }
                
                if (calanderStartTime&&calanderEndTime) {
                    thisEvent.startDate=calanderStartTime;
                    thisEvent.endDate=calanderEndTime;

                }else {
                    thisEvent.startDate=[NSDate date];
                    thisEvent.endDate=[NSDate dateWithTimeIntervalSinceNow:60*60];
                }
                
                 
                switch (currentControllerSetup) {
                    case kTrackAssessmentSetup:
                        eventTitleString=@"Test Administration:";
                        break;
                    case kTrackInterventionSetup:
                        eventTitleString=@"Intervention:";
                        break;
                    case kTrackSupportSetup:
                        eventTitleString=@"Indirect Support:";
                        break;
                    case kTrackSupervisionGivenSetup:
                        eventTitleString=@"Supervision Given to";
                        break;
                    case kTrackSupervisionReceivedSetup:
                        eventTitleString=@"Supervision from";
                        break;
    
                    default:
                        break;
                }
                
                
                 
                if (currentControllerSetup==kTrackAssessmentSetup||currentControllerSetup==kTrackInterventionSetup||currentControllerSetup==kTrackSupportSetup) {
                    
                   
                    NSMutableSet *clientSet=[buttonCellManagedObject mutableSetValueForKeyPath:@"clientPresentations.client.clientIDCode"];
                    for (NSString * idCode in clientSet){
                        
                        
                        eventTitleString=[eventTitleString stringByAppendingFormat:@" %@,",idCode];
                        
                        
                        
                        
                    }
                    eventTitleString = [eventTitleString substringToIndex:[eventTitleString length] - 1];


                }
                else {
                    SCTableViewModel *tableModel=buttonCell.ownerTableViewModel;
                    
                                        
                    switch (currentControllerSetup) {
                        case kTrackSupervisionReceivedSetup:
                        {
                            
                            SCTableViewSection *section=[tableModel sectionAtIndex:1]; 
                            
                            
                            if ([section isKindOfClass:[SCObjectSection class]]) {
                                SCObjectSection *objectSection=(SCObjectSection *)section;
                                
                                [objectSection commitCellChanges];
                                
                            }

                            ClinicianEntity *supervisor=(ClinicianEntity *)[buttonCellManagedObject valueForKey:@"supervisor"];
                            
                            if (supervisor) {
                                eventTitleString=[eventTitleString stringByAppendingFormat:@" %@",supervisor.combinedName];
                                
                                
                            }
                        }
                            break;
                        case kTrackSupervisionGivenSetup:
                        {
                            SCTableViewSection *section=[tableModel sectionAtIndex:2]; 
                            
                            
                            if ([section isKindOfClass:[SCObjectSection class]]) {
                                SCObjectSection *objectSection=(SCObjectSection *)section;
                                
                                [objectSection commitCellChanges];
                                
                            }
                            NSMutableSet *studentsSet=[buttonCellManagedObject mutableSetValueForKey:@"studentsPresent"];
                            NSString *superviseesString=[NSString string];
                            if ([studentsSet count]) {
                                for (id obj in studentsSet)
                                {
                                    if ([obj isKindOfClass:[ClinicianEntity class]])
                                    {
                                        
                                        ClinicianEntity *student=(ClinicianEntity *)obj;
                                        
                                        superviseesString=[superviseesString stringByAppendingFormat:@" %@,",student.combinedName];
                                        
                                        
                                    }
                                    
                                }
                                 superviseesString = [superviseesString substringToIndex:[superviseesString length] - 1];
                                if ( [superviseesString length] > 1){
                                    
                                    if (eventTitleString.length) {
                                        eventTitleString=[eventTitleString stringByAppendingFormat:@":%@ ",superviseesString];
                                        
                                    }
                                    
                                    thisEvent.notes=[NSString stringWithFormat:@"Supervision given to: %@", superviseesString];
                                    
                                } 
                            }
                            
                            
                        }
                            break;    
                        default:
                            break;
                    }

                    
                                                         
                }
                               
                
                
               
                               
                
                if ( [eventTitleString length] > 0)
                   
                
                thisEvent.title=(NSString *) eventTitleString;
                
                UIViewController *currentTableModelViewController=(UIViewController *)currentDetailTableViewModel.viewController;
                
                NSString *calenderLocation=[[NSUserDefaults standardUserDefaults] valueForKey:@"calander_location"];
                
                [thisEvent setLocation:calenderLocation];
                
                addController.editViewDelegate = self;
                addController.view.tag=837;
//                addController.modalViewController.navigationController.delegate=self;
                //                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                //                
                //                UITabBarController *tabBarController=[appDelegate tabBarController];
                
                
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
	SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel sectionAtIndex:0];
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
			
            
            
            
            if (self.psyTrackCalendar ==  thisEvent.calendar) {
				[self.eventsList addObject:thisEvent];
			}
			[controller.eventStore saveEvent:controller.event span:EKSpanThisEvent error:&error];
			
            
            
            
            
            [cell.boundObject setValue:[controller.event eventIdentifier] forKey:@"eventIdentifier"];
            
            [cell commitChanges];
            [cell reloadBoundValue];
            
            
            if ([cell isKindOfClass:[ButtonCell class]]) {
                ButtonCell *buttonCell=(ButtonCell *)cell;
                UIButton *button=(UIButton *)buttonCell.button;
                
                [button setTitle:@"Edit Calendar Event" forState:UIControlStateNormal];
                
            }
            
            
            
            
        }
            
            break;
			
		case EKEventEditViewActionDeleted:
			// When deleting an event, remove the event from the event store, 
			// and reload table view.
			// If deleting an event from the currenly default calendar, then update its 
			// eventsList.
			
            
            
            
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
                //                
                
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
    
    
    
    
    
    NSError *error;
    
    if (![self.eventStore saveCalendar:self.psyTrackCalendar commit:YES error:&error ]) {
        
    }
    else
    {
        
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
    
    
    
    return totalBreakTimeInterval;
    
}  
    
    

-(NSString *)totalBreakTimeString{
    
    
    
    
    NSTimeInterval totalBreakTimeInterval=[self totalBreakTimeInterval];
   
    NSDate *timeFromReferenceTime=[referenceDate dateByAddingTimeInterval:totalBreakTimeInterval];
    
    
    
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
    
    if(tableModel.tag==2 &&indexPath.section)
    {
        [self calculateTime];
        SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel sectionAtIndex:1];
        UILabel *breakSectionHeaderLabel=(UILabel *)[section.headerView viewWithTag:60];
       
        
        breakSectionHeaderLabel.text=[self totalBreakTimeString];
        
    }
    

}


-(void)tableViewModel:(SCTableViewModel *)tableModel itemEditedForSectionAtIndexPath:(NSIndexPath *)indexPath item:(NSObject *)item{
    
    if (currentDetailTableViewModel.tag==2) {
   
    [self tableViewModel:(SCTableViewModel *)tableModel itemAddedForSectionAtIndexPath:indexPath item:(NSObject *)item];
        
    }
    
    currentDetailTableViewModel=tableModel;
    
    if (tableModel.tag==1) 
    {
        SCSelectionCell *cell=(SCSelectionCell *)[tableModel.modeledTableView cellForRowAtIndexPath:indexPath];
        
        if (cell.tag==0) {
            if ([cell isKindOfClass:[SCDateCell class]]){
                serviceDateCell=(SCDateCell *)cell;
            }
        }
        
        if (cell.tag==1) //time cell
        {
            
            
            
            
            
            
            
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


-(void)displayAgeInAgeCells:(SCTableViewSection *)section {
    
    if (section.cellCount>2) {
        
        
        SCLabelCell *actualAgeCell=(SCLabelCell*)[section cellAtIndex:1];
        SCLabelCell *wechslerAgeCell=(SCLabelCell*)[section cellAtIndex:2];
        
        if (![actualAgeCell isKindOfClass:[SCLabelCell class]]||![wechslerAgeCell isKindOfClass:[SCLabelCell class]]) {
            return;
        }
        
        //    SCTableViewCell *clientCell=(SCTableViewCell *)[section cellAtIndex:0];
        //    SCTableViewCell *testDateCell=(SCTableViewCell*)[section cellAtIndex:3];
        ClientsViewController_Shared *clientsViewController_Shared=[[ClientsViewController_Shared alloc]init];
        
        SCTableViewCell *clientCell=(SCTableViewCell *)[section cellAtIndex:0];
        
        NSDate *clientDateOfBirth=nil;    
        if ([clientCell isKindOfClass:[ClientsSelectionCell class]]) {
            ClientsSelectionCell *clientObjectsSelectionCell=(ClientsSelectionCell *)clientCell;
            if (clientObjectsSelectionCell.clientObject) {
                
                
                
                //        NSArray *array=[[NSArray alloc]init];
                
                //        int itemsCount=clientObjectsSelectionCell.items.count;
                //        if (itemsCount>=0&&clientObjectsSelectionCell.clientObject) {
                ////            clientDateOfBirth=(NSDate *)[(NSArray *)[clientObjectsSelectionCell.items valueForKey:@"dateOfBirth"]lastObject];
                
                
                
                
                NSManagedObject *clientObject=(NSManagedObject *)clientObjectsSelectionCell.clientObject;
                clientDateOfBirth=(NSDate *)[clientObject valueForKey:@"dateOfBirth"];
                
            }else{
                NSString *noClientString=@"choose client";
                wechslerAgeCell.label.text=noClientString; 
                actualAgeCell.label.text=noClientString;
                return;
                
            }
            
            
            
            
            
            
        }
        
        
        
        //    
        //   
        
        
        if (serviceDateCell.datePicker.date && clientDateOfBirth) {
            wechslerAgeCell.label.text=(NSString *)[clientsViewController_Shared calculateWechslerAgeWithBirthdate:(NSDate *)clientDateOfBirth toDate:(NSDate *)serviceDateCell.datePicker.date];
            actualAgeCell.label.text=(NSString *)[clientsViewController_Shared calculateActualAgeWithBirthdate:(NSDate *)clientDateOfBirth toDate:(NSDate *)serviceDateCell.datePicker.date];
        }
        else
        {
            if (!serviceDateCell.datePicker.date) {
                wechslerAgeCell.label.text=@"no test date";
                actualAgeCell.label.text=@"no test date";
            }
            else if (!clientDateOfBirth)
            {
                
                if (wechslerAgeCell&&[wechslerAgeCell respondsToSelector:@selector(label) ]) {
                    
                    wechslerAgeCell.label.text=@"no birthdate";
                    actualAgeCell.label.text=@"no birthdate";
                    
                }
            }
            else
            {
                wechslerAgeCell.label.text=@"0y 0m";
                actualAgeCell.label.text=@"0y 0m";
            }
            
            
        }
        [wechslerAgeCell setNeedsLayout];
        [wechslerAgeCell setNeedsDisplay];
        [actualAgeCell setNeedsLayout];
        [actualAgeCell setNeedsDisplay];
    }
    
    //    actualAgeCell.label.text=[clientsViewController_Shared calculateActualAgeWithBirthdate:birthdateCell.datePicker.date];
    //    
    
}



@end
