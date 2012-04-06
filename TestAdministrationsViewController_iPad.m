/*
 *  TestAdministrationViewController_iPad.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 10/5/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "TestAdministrationsViewController_iPad.h"
#import "PTTAppDelegate.h"
#import "Time_Shared.h"
#import "ButtonCell.h"
#import "ClientPresentations_Shared.h"
#import "ClientsViewController_iPhone.h"
#import "ClientsRootViewController_iPad.h"
#import "TimeEntity.h"


@implementation TestAdministrationsViewController_iPad




@synthesize tableView=_tableView;
@synthesize searchBar=_searchBar;
@synthesize totalAdministrationsLabel;
@synthesize stopwatchTextField;
@synthesize clientPresentations_Shared;
@synthesize eventsList,eventStore,eventViewController,psyTrackCalendar;
//@synthesize managedObject;


#pragma mark -
#pragma mark View lifecycle


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

    self.clientPresentations_Shared=nil;
    self.psyTrackCalendar=nil;
    self.eventStore=nil;

    self.eventsList=nil;
    self.eventViewController=nil;

    time_Shared=nil;
  
   searchBar=nil;
   tableView=nil;
  
 
    
   tableModel=nil;
    
    

    
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
    
   
    // Gracefully handle reloading the view controller after a memory warning
    tableModel = (SCArrayOfObjectsModel *)[[SCModelCenter sharedModelCenter] modelForViewController:self];
    if(tableModel)
    {
        [tableModel replaceModeledTableViewWith:self.tableView];
        return;
    }
    

    
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
    
 
    
    
    
    // create a spacer
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
    [buttons addObject:editButton];
    
   

    
    // create a standard "add" button
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:NULL];
    addButton.style = UIBarButtonItemStyleBordered;
    [buttons addObject:addButton];
 
    // stick the buttons in the toolbar
    self.navigationItem.rightBarButtonItems=buttons;
    

    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE, M/d/yyyy"];
    
   
    
    
    
	
	// Get managedObjectContext from application delegate
    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
	
    
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Testing Sessions";
    
    
    SCClassDefinition *testSessionDeliveredDef =[SCClassDefinition definitionWithEntityName:@"TestingSessionDeliveredEntity"
                                                                   withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"dateOfTesting",  @"time",@"clientPresentations",  @"notes", @"paperwork", @"assessmentType", @"certificationsCredited",   @"degreesCredited",  @"licenseNumbersCredited", @"relatedSupportTime", @"supervisor", @"testsAdministered",   @"trainingType", @"treatmentSetting",  @"eventIdentifier",     nil]];        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
   
 
    NSInteger eventIdentifierPropertyIndex = [testSessionDeliveredDef indexOfPropertyDefinitionWithName:@"eventIdentifier"];
    [testSessionDeliveredDef removePropertyDefinitionAtIndex:eventIdentifierPropertyIndex];

    SCPropertyDefinition *dateOfTestingPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"dateOfTesting"];
	dateOfTestingPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                              datePickerMode:UIDatePickerModeDate 
                                                               displayDatePickerInDetailView:YES];
    
    dateOfTestingPropertyDef.title=@"Testing Date";
    SCPropertyDefinition *notesPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"notes"];
    notesPropertyDef.type=SCPropertyTypeTextView;
    
    testSessionDeliveredDef.titlePropertyName=@"dateOfTesting";
    testSessionDeliveredDef.keyPropertyName=@"dateOfTesting";
    
    
    //add a button to add an event to the calandar
    
    //create a custom property definition for the Button Cell
    
    NSDictionary *buttonCellObjectBinding=[NSDictionary dictionaryWithObject:@"eventIdentifier" forKey:@"event_identifier"];
    SCCustomPropertyDefinition *eventButtonProperty = [SCCustomPropertyDefinition definitionWithName:@"EventButtonCell" withuiElementClass:[ButtonCell class] withObjectBindings:buttonCellObjectBinding];
    
    //add the property definition to the test administration detail view  
    [testSessionDeliveredDef addPropertyDefinition:eventButtonProperty];
    //define a property group
    SCPropertyGroup *eventGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"dateOfTesting",@"time",@"clientPresentations", @"EventButtonCell",nil]];
    
    // add the event Group property group to the behavioralObservationsDef class. 
    [testSessionDeliveredDef.propertyGroups addGroup:eventGroup];
       
   
    SCPropertyGroup *peopleGroup =[SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"supervisor",@"paperwork",   @"notes",nil]];
    
    
    
    [testSessionDeliveredDef.propertyGroups addGroup:peopleGroup];
    
    
    SCPropertyGroup *detailsGroup =[SCPropertyGroup groupWithHeaderTitle:@"Administration Details" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"testsAdministered",@"assessmentType",@"treatmentSetting",@"trainingType", @"relatedSupportTime", nil]];
    
    
    [testSessionDeliveredDef.propertyGroups addGroup:detailsGroup]; 
    
    
    
    SCPropertyDefinition *licenseNumbersCreditedPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"licenseNumbersCredited"];
    licenseNumbersCreditedPropertyDef.title=@"Licenses Credited";
    
    SCPropertyGroup *creditsGroup =[SCPropertyGroup groupWithHeaderTitle:@"Credits" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"degreesCredited",@"certificationsCredited",@"licenseNumbersCredited",nil]];
    
    
    [testSessionDeliveredDef.propertyGroups addGroup:creditsGroup];
    
    
    SCPropertyDefinition *supervivisorPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"supervisor"];
    
   	supervivisorPropertyDef.type = SCPropertyTypeObjectSelection;
    
    SCClassDefinition *supervisorDef =[SCClassDefinition definitionWithEntityName:@"ClinicianEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"prefix",@"firstName",@"middleName", @"lastName",@"suffix",@"credentialInitials", nil]];
    supervisorDef.titlePropertyName=@"prefix;firstName;lastName;suffix;credentialInitials";
    supervisorDef.orderAttributeName=@"order";
    
    SCPropertyGroup *supervisorNameGroup =[SCPropertyGroup groupWithHeaderTitle:@"Supervisor Name" withFooterTitle:@"Select this clinician under the Clicician tab to add or view more details." withPropertyNames:[NSArray arrayWithObjects:@"prefix",@"firstName",@"middleName", @"lastName",@"suffix",@"credentialInitials", nil]];
    
    
    
    
    [supervisorDef.propertyGroups addGroup:supervisorNameGroup];
    
    SCObjectSelectionAttributes *supervisorSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:supervisorDef allowMultipleSelection:NO allowNoSelection:NO];
    supervisorSelectionAttribs.allowAddingItems = YES;
    supervisorSelectionAttribs.allowDeletingItems = YES;
    supervisorSelectionAttribs.allowMovingItems = YES;
    supervisorSelectionAttribs.allowEditingItems = YES;
    supervisorSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Supervisors)"];
    supervisorSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Supervisor"];
    supervivisorPropertyDef.attributes = supervisorSelectionAttribs;
    
    SCPropertyDefinition *clientsPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"clients"];
    
   	clientsPropertyDef.type = SCPropertyTypeObjectSelection;
    
    
    
    //During a testing session (PsyTestingSessionDeliveredEntity), the examiner may administer many different tests (PsyTestAdministeredEntity). The testing session may be a group administration or individual administration, and may be considered neuropsych testing or other types of testing (testingSessionTypeEntity).  The tests administered may break down into several score indexes (PsyTestScoreEntity).  The individual tests may be any differnt type of test, including personality test, intelligence test, neuropsych batteries, etc(PsyTestTypeEntity).  For example, a neuropsch testing session on a particular day may include personality tests, memory tests, achievement tests, intelligence tests, and neuropsych battery of tests.  The session includes the overall time of the testing session and includes the other details such as the client and supervisor where the credits are applied.//
    
    
    SCPropertyDefinition *testsAdministeredPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"testsAdministered"];
    
    
    
    SCClassDefinition *testAdministeredDef =[SCClassDefinition definitionWithEntityName:@"TestAdministeredEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"psychTestName" ,@"scores",@"notes", nil]];
    
    
    
    
    testAdministeredDef.orderAttributeName = @"order";
    SCPropertyDefinition *testAdministeredNotesPropertyDef=[testAdministeredDef propertyDefinitionWithName:@"notes"];
    testAdministeredNotesPropertyDef.type=SCPropertyTypeTextView;
    
    testsAdministeredPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:testAdministeredDef
                                                             allowAddingItems:TRUE
                                                           allowDeletingItems:TRUE
                                                             allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Tests Administered)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:TRUE addNewObjectuiElementExistsInEditingMode:FALSE];
    
    
    
    testAdministeredDef.titlePropertyName=@"psychTestName.acronym";
    
    SCClassDefinition *testNameDef=[SCClassDefinition definitionWithEntityName:@"InstrumentEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"instrumentName", @"acronym",@"instrumentType", @"notes", nil]];
    
    
    testNameDef.titlePropertyName=@"acronym";
    
    testNameDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *testNamePropertyDef=[testAdministeredDef propertyDefinitionWithName:@"psychTestName"];
    testNamePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *testNameSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:testNameDef allowMultipleSelection:NO allowNoSelection:NO];
    testNameSelectionAttribs.allowAddingItems = YES;
    testNameSelectionAttribs.allowDeletingItems = YES;
    testNameSelectionAttribs.allowMovingItems = YES;
    testNameSelectionAttribs.allowEditingItems = YES;
    testNameSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Test Names)"];
    testNameSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Test Name"];
    testNamePropertyDef.attributes = testNameSelectionAttribs;
    
        SCPropertyDefinition *testNameNotesPropertyDef=[testNameDef propertyDefinitionWithName:@"notes"];
    testNameNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    //testTypeEntity is in a one to many relationship with testNameEntity.
    
    SCClassDefinition *testTypeDef=[SCClassDefinition definitionWithEntityName:@"InstrumentTypeEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"instrumentType", @"notes", nil]];
    
    
    
    testTypeDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *testTypePropertyDef=[testNameDef propertyDefinitionWithName:@"instrumentType"];
    testTypePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *testTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:testTypeDef allowMultipleSelection:NO allowNoSelection:NO];
    testTypeSelectionAttribs.allowAddingItems = YES;
    testTypeSelectionAttribs.allowDeletingItems = YES;
    testTypeSelectionAttribs.allowMovingItems = YES;
    testTypeSelectionAttribs.allowEditingItems = YES;
    testTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Test Types)"];
    testTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Test Type"];
    testTypePropertyDef.attributes = testTypeSelectionAttribs;
    
   
    SCPropertyDefinition *testTypeNotesPropertyDef=[testTypeDef propertyDefinitionWithName:@"notes"];
    testTypeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    
    SCClassDefinition *testScoredDef =[SCClassDefinition definitionWithEntityName:@"TestScoreEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"scoreName" ,@"score",@"notes", nil]];
    
    
    
    
    testScoredDef.orderAttributeName = @"order";
    
    
    SCPropertyDefinition *testScoredNotesPropertyDef=[testScoredDef propertyDefinitionWithName:@"notes"];
    testScoredNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *testScoredNamePropertyDef=[testScoredDef propertyDefinitionWithName:@"scoreName"];
    testScoredNamePropertyDef.type=SCPropertyTypeTextView;
    testScoredNamePropertyDef.title=@"Score Name/Index";
    testScoredDef.titlePropertyName=@"scoreName;score";
    
    
    SCPropertyDefinition *testAdministeredScoresPropertyDef=[testAdministeredDef propertyDefinitionWithName:@"scores"];
    testAdministeredScoresPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:testScoredDef
                                                       allowAddingItems:TRUE
                                                     allowDeletingItems:TRUE
                                                       allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Test Scores)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:TRUE addNewObjectuiElementExistsInEditingMode:FALSE];
    
    
    
    testAdministeredDef.titlePropertyName=@"psychTestName.acronym";
    
    
    
    
    
    
    
    
    SCClassDefinition *testSessionTypeDef=[SCClassDefinition definitionWithEntityName:@"TestingSessionTypeEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"assessmentType", @"notes", nil]];
    
    
    
    
    testSessionTypeDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *testingSessionTypePropertyDef=[testSessionDeliveredDef propertyDefinitionWithName:@"assessmentType"];
    testingSessionTypePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *testSessionTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:testSessionTypeDef allowMultipleSelection:NO allowNoSelection:NO];
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
    
    //treatment setting start
    SCClassDefinition *psychTreatmentSettingDef=[SCClassDefinition definitionWithEntityName:@"TreatmentSettingEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"settingType", @"notes", nil]];
    
    
    
    
    
    psychTreatmentSettingDef.orderAttributeName=@"order";
    
    
    //treatment setting is a place or setting where the treatment takes place (e.g., hospital, community mental health clinic, day program
    
    SCPropertyDefinition *sessionTreatmentSettingPropertyDef=[testSessionDeliveredDef propertyDefinitionWithName:@"treatmentSetting"];
    sessionTreatmentSettingPropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *treatmentSettingSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:psychTreatmentSettingDef allowMultipleSelection:NO allowNoSelection:NO];
    treatmentSettingSelectionAttribs.allowAddingItems = YES;
    treatmentSettingSelectionAttribs.allowDeletingItems = YES;
    treatmentSettingSelectionAttribs.allowMovingItems = YES;
    treatmentSettingSelectionAttribs.allowEditingItems = YES;
    treatmentSettingSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Treatment Settings)"];
    treatmentSettingSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Treatment Setting"];
    sessionTreatmentSettingPropertyDef.attributes = treatmentSettingSelectionAttribs;
    
    SCPropertyDefinition *treatmentSettingTypePropertyDef=[psychTreatmentSettingDef propertyDefinitionWithName:@"settingType"];
    treatmentSettingTypePropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *treatmentSettingNotesPropertyDef=[psychTreatmentSettingDef propertyDefinitionWithName:@"notes"];
    treatmentSettingNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    
    //treatment setting end    
    
    //Training Type  start
    SCClassDefinition *trainingTypeDef=[SCClassDefinition definitionWithEntityName:@"TrainingTypeEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"trainingType",@"selectedByDefault", @"notes", nil]];
    
    
    
    
    
    
    
    trainingTypeDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *sessionTrainingTypePropertyDef=[testSessionDeliveredDef propertyDefinitionWithName:@"trainingType"];
    sessionTrainingTypePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *trainingTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:trainingTypeDef allowMultipleSelection:NO allowNoSelection:NO];
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
    
    
    time_Shared=[[Time_Shared alloc]init];

    [time_Shared setupTheTimeViewUsingSTV];
   
   

    
    SCPropertyDefinition *timePropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"time"];
timePropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:time_Shared.timeDef
                                                                                              allowAddingItems:TRUE
                                                                                            allowDeletingItems:TRUE
                                                                                              allowMovingItems:FALSE];
    
    timePropertyDef.title=@"Testing Time";
    
    
    clientPresentations_Shared=[[ClientPresentations_Shared alloc]init];
    
    [clientPresentations_Shared setupUsingSTV];
    
    
    


    //create an array of objects definition for the clientPresentation to-many relationship that with show up in a different view  without a place holder element>.
    
    //Create the property definition for the clientPresentations property
    
    SCPropertyDefinition *clientPresentationsPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"clientPresentations"];
    clientPresentationsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:clientPresentations_Shared.clientPresentationDef
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
     tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self
										withEntityClassDefinition:testSessionDeliveredDef usingPredicate:paperworkIncompletePredicate];
    
    [self.searchBar setSelectedScopeButtonIndex:2];
    // Initialize tableModel
    if (self.navigationItem.rightBarButtonItems.count>1) {
        
        tableModel.addButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:1];
    }

   
    
    if (self.navigationItem.rightBarButtonItems.count >0)
    {
        tableModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:0];
    }
    
    if ([SCHelper is_iPad]) {
   
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:[UIColor clearColor]];
    }
        [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    

    self.view.backgroundColor=[UIColor clearColor];
    
    tableModel.autoSortSections = TRUE;  
    tableModel.searchBar = self.searchBar;
	tableModel.searchPropertyName = @"dateOfTesting";
    
    tableModel.allowMovingItems=TRUE;
    
    tableModel.autoAssignDelegateForDetailModels=TRUE;
    tableModel.autoAssignDataSourceForDetailModels=TRUE;
    
    [self updateAdministrationTotalLabel];

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
        
        NSPredicate *currentMonthPredicate = [NSPredicate predicateWithFormat:@"((dateOfTesting > %@) AND (dateOfTesting <= %@)) || (dateOfTesting = nil)",startDate,endDate];
        NSPredicate *paperworkIncompletePredicate = [NSPredicate predicateWithFormat:@"paperwork == %@",[NSNumber numberWithInteger: 0]];
        
        
        [self.searchBar setSelectedScopeButtonIndex:selectedScope];
        
        switch (selectedScope) {
            case 1: //Male
                objectsModel.itemsPredicate = nil;
                //NSLog(@"case default");
                 break;
               
            case 2: //Male
                objectsModel.itemsPredicate = paperworkIncompletePredicate;
                //NSLog(@"case paperwork Incomplete");
                break;                
                
            default:
                objectsModel.itemsPredicate = currentMonthPredicate;
                //NSLog(@"case 1");
               
                
                break;
        }
        [objectsModel reloadBoundValues];
        [objectsModel.modeledTableView reloadData]; 
        [self updateAdministrationTotalLabel ];
    }
}

-(void)tableViewModelSearchBarResultsListButtonClicked:(SCArrayOfItemsModel *)tableViewModel{


//NSLog(@"search list button clicked");


}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
 
    [self tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger )indexPath.section detailTableViewModel:(SCTableViewModel *)detailTableViewModel];
    SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
    if (detailTableViewModel.tag==2 ||tableViewModel.tag==2) 
    {
                    
           
            //NSLog(@"cell managed object is%@ ",cellManagedObject.entity.name);
        //NSLog(@"detail model class is %@",[detailTableViewModel class]);
            if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) 
            {
                
                time_Shared.tableModel=tableModel;
                detailTableViewModel.delegate=time_Shared;
                time_Shared.tableModel=detailTableViewModel;
                
                
            }
                       
    }    
        

      
        
   

        
    
    
}





-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)index detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    if([SCHelper is_iPad]&&detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
        

    [detailTableViewModel.modeledTableView setBackgroundView:nil];
    [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
    [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
   //NSLog(@"tableviewmodel is %@",detailTableViewModel.debugDescription);
            
    }   

}


-(void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
////NSLog(@"table view tag is %i",tableViewModel.tag);
//    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        

    if(tableViewModel.tag==1 &&indexPath.section==0){
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
    
    
    if (tableViewModel.tag==3) {
 
        
        //NSLog(@"index path section is %i",indexPath.section);
        //                if (indexPath.section==0) {
        //                    <#statements#>
        //                }
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        //NSLog(@"cell bound object is %@",cellManagedObject);
        //NSLog(@"cell.tag%i",cell.tag);
        //NSLog(@"section managed object is %@",cellManagedObject.entity.name);
        //NSLog(@"cell text is %@",cell.textLabel.text);
        //NSLog(@"cell class is %@",[cell class]);
        
        
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) 
        {
            if (tableViewModel.delegate!=clientPresentations_Shared) 
            {
                clientPresentations_Shared.tableModel=tableModel;
                tableViewModel.delegate=clientPresentations_Shared;
                if (serviceDateCell.label.text.length) 
                {
                    clientPresentations_Shared.serviceDatePickerDate=(NSDate *)serviceDateCell.datePicker.date;
                }
                
                
                
                //NSLog(@"delegate switched to client presentation shared");
                
            }
            
        }
        
        
    }
    
  

        
//        if (cell.tag==0) {
//            if ([cell isKindOfClass:[SCDateCell class]]){
//            serviceDateCell=(SCDateCell *)cell;
//            }
//        }
//        if (cell.tag==1) {
//            if ([cell isKindOfClass:[SCObjectCell class]]) {
//                
//                
//                if (![cell viewWithTag:28] ) {
//               
//                UILabel *totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-125, 5, 85, 30)];
//             
//               
//                totalTimeLabel.tag=28;
//                totalTimeLabel.text=[NSString stringWithFormat:@"00:00:00"];
//                totalTimeLabel.backgroundColor=[UIColor clearColor];
//                totalTimeLabel.textAlignment=UITextAlignmentRight;
//                totalTimeLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
//                [totalTimeLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:18]];
//                totalTimeLabel.textColor=[UIColor colorWithRed:50.0f/255 green:69.0f/255 blue:133.0f/255 alpha:1.0];
//                [cell addSubview:(UIView *)totalTimeLabel];
//            
//                    
//                }
//            }
//            
//            
//            
//        }
//    
//    
//        if ([cell isKindOfClass:[ButtonCell class]]) {
//            ButtonCell *buttonCell=(ButtonCell *)cell;
////            buttonCell.buttonText=@"Add Event to Calendar";
//            UIButton *button=buttonCell.button;
//            [button setTitle:@"Add Event to Calendar" forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(addEvent:) forControlEvents:UIControlEventTouchUpInside];
//            
//        }
//    
//    }
//    
//    if (tableViewModel.tag==3) {
//        //        NSManagedObject *detailViewManagedObject= detailTableViewModel.
//        
//        
//        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
//        
//        //NSLog(@"section managed object is %@",cellManagedObject.entity.name);
//        if ([cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) 
//        {
//            if (tableViewModel.delegate!=clientPresentations_Shared) {
//                clientPresentations_Shared.tableModel=tableModel;
//                tableViewModel.delegate=clientPresentations_Shared;
//                if (serviceDateCell.label.text.length) {
//                    clientPresentations_Shared.serviceDatePickerDate=(NSDate *)serviceDateCell.datePicker.date;
//                }
//                
//                
//                
//                //NSLog(@"delegate switched to client presentation shared");
//                
//            }
//            
//        }
//    }
//    }
    
}


-(void) tableViewModel:(SCTableViewModel *)tableViewModel customButtonTapped:(UIButton *)button forRowWithIndexPath:(NSIndexPath *)indexPath{
    
}



-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillDisappearForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    
    if (tableViewModel.tag==0) {
        serviceDateCell=nil;
          self.eventViewController=nil;
        if (clientPresentations_Shared) {
             clientPresentations_Shared.serviceDatePickerDate=nil;
        }
       
    }
       if (tableViewModel.tag==1){
           [time_Shared willDisappear];
           
           viewControllerOpen=FALSE;
           [tableViewModel.modeledTableView reloadData];
//           [self timerDestroy];
           
//           stopwatchRunning=nil;
//           stopwatchIsRunningBool=NO;
//           viewControllerOpen=NO;
//           
           
           
    }


}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillAppearForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{

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
                    if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) {
                        
                        SCArrayOfObjectsSection *section=(SCArrayOfObjectsSection *)[tableViewModel sectionAtIndex:0];
                        NSMutableSet *mutableSet=[(NSMutableSet *)section.itemsSet mutableSetValueForKey:@"client"];
                        
                        SCArrayOfObjectsSection *mainSection=(SCArrayOfObjectsSection *)[detailTableViewModel sectionAtIndex:0];
                        ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)[mainSection cellAtIndex:0];
                        clientSelectionCell.alreadySelectedClients=mutableSet;
                       
                        //NSLog(@"client items are12345 %@",mutableSet);
                        clientSelectionCell.hasChangedClients=NO;
                        
                    }
    
                }
            
            
            else if ([cell.textLabel.text isEqualToString:@"tap + to add clients"]) 
            {
                    SCArrayOfObjectsSection *mainSection=(SCArrayOfObjectsSection *)[detailTableViewModel sectionAtIndex:0];
                    ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)[mainSection cellAtIndex:0];
                    clientSelectionCell.alreadySelectedClients=[[NSMutableSet alloc]init];;

            }
            

        
        }
    }

    



}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewDidAppearForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
   self.eventViewController=nil;
    


}




-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillAppearForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    if (tableViewModel.tag==0||tableViewModel.tag==1) {
        currentDetailTableViewModel=detailTableViewModel;
        
    }
   
    
    if (detailTableViewModel.tag==2) {
        
        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        //NSLog(@"cell managed object is%@ ",cellManagedObject.entity.name);
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) {
            
        [detailTableViewModel.modeledTableView setEditing:YES animated:NO];
        }
    }
    
    if (tableViewModel.tag==2 && tableViewModel.sectionCount ==1) {
        
        
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
        
        if (section.cellCount>0) 
        {
           
                SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
                NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
                //NSLog(@"cell managed object is%@ ",cellManagedObject.entity.name);
                if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) {
                    
                    SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)section;
                    NSMutableSet *mutableSet=[(NSMutableSet *)arrayOfObjectsSection.itemsSet mutableSetValueForKey:@"client"];
                   
                    SCArrayOfObjectsSection *mainSection=(SCArrayOfObjectsSection *)[detailTableViewModel sectionAtIndex:0];
                    ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)[mainSection cellAtIndex:0];
                    clientSelectionCell.alreadySelectedClients=mutableSet;
                   
                    //NSLog(@"client items are12345 %@",mutableSet);
                    
                }
        } 
    }
}


- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSInteger)index
{
    
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
    
//    NSManagedObject *sectionManagedObject=(NSManagedObject *)section.boundObject;

    
    if(section.headerTitle !=nil)
    {
        
//        if (!(tableViewModel.tag ==2 && index==0 &&[sectionManagedObject.entity.name isEqualToString:@"TimeEntity"] )) 
//        {
            
       
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
        
        
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.tag=60;
        headerLabel.text=section.headerTitle;
        [containerView addSubview:headerLabel];
            
        section.headerView = containerView;
        
//        }
        
    }
  
    if (tableViewModel.tag==3 && index==0) 
    {
                
        
        //if change the cell text then update the method that sets the age with the new cell text
        SCLabelCell *actualAge=[SCLabelCell cellWithText:@"Test Age" withBoundObject:nil withPropertyName:@"Age"];
        SCLabelCell *wechslerAge=[SCLabelCell cellWithText:@"Wechsler Test Age" withBoundObject:nil withPropertyName:@"WechslerAge"];
        actualAge.label.text=[NSString stringWithString: @"0y 0m"];
        wechslerAge.label.text=[NSString stringWithFormat:@"%iy %im",0,0];
        [section addCell:actualAge];
        [section addCell:wechslerAge];
        
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
        cell.textLabel.text= [dateFormatter stringFromDate:[cellManagedObject valueForKey:@"dateOfTesting"]];
        if (cellManagedObject) {
            
            
            
            //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
            if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
                
                //NSLog(@"entity name is %@",cellManagedObject.entity.name);
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
                
                totalTimeDate=(NSDate *)[cell.boundObject valueForKey:@"totalTime"];
                //NSLog(@"total time date in will display cell objects %@", totalTimeDate);
                NSString *totalTimeString=[counterDateFormatter stringFromDate:totalTimeDate];
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

          
           
  
    
}



-(void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath{


//NSLog(@"value changed for row at index path");

   
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
               
                 [cell.boundObject setValue:time_Shared.totalTimeDate forKey:@"totalTime"];
                [self tableViewModel:(SCTableViewModel *)tableViewModel 
                     willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath];
               
                
               
                
            }
        }
//        UIView *view=(UIView *)[timeCell viewWithTag:5];
//        UILabel*lable =(UILabel*)view;
//        lable.text=@"test";
//        timeCell.label.text=(NSString *)[counterDateFormatter stringFromDate:totalTimeDate];

    }
    
    
  
    
    
    
}


-(void)tableViewModel:(SCTableViewModel *)tableViewModel didRemoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableViewModel.tag==0) {
        
        [self totalAdministrationsLabel];
        
    }
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel didRemoveSectionAtIndex:(NSInteger)index{
    
    if (tableViewModel.tag==0) {
        
        [self totalAdministrationsLabel];
        
    }
    
    
}

-(void)updateAdministrationTotalLabel{
    
    
    if (tableModel.tag==0) 
    {
        int cellCount=0;
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




-(void)tableViewModel:(SCTableViewModel *)tableViewModel didInsertRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self tableViewModel:(SCTableViewModel *)tableViewModel testFetchForRowAtIndexPath:(NSIndexPath *) indexPath];
    
       
    if (tableViewModel.tag==0) 
    {
        
        [self totalAdministrationsLabel];
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
               
                 NSDate *testDate=(NSDate *)[buttonCellManagedObject valueForKey:@"dateOfTesting"];
                
                NSDate *startTime=(NSDate *)[timeEntity valueForKey:@"startTime"];
                //NSLog(@"time entity is %@",timeEntity);
              
                NSDate *endTime=(NSDate *)[timeEntity valueForKey:@"endTime"];
                
               
                NSDateFormatter *dateFormatterTime=[[NSDateFormatter alloc]init];
                
                [dateFormatterTime setTimeZone:[NSTimeZone defaultTimeZone]];
                
               
                
                NSDateFormatter *dateFormatterDate=[[NSDateFormatter alloc]init];
                
                [dateFormatterDate setTimeZone:[NSTimeZone defaultTimeZone]];
                
                [dateFormatterDate setDateFormat:@"MM/d/yyyy"];
                
                [dateFormatterTime setDateFormat:@"H:m"];
                
                NSDateFormatter *dateFormatterCombined=[[NSDateFormatter alloc]init];
                
                [dateFormatterCombined setTimeZone:[NSTimeZone defaultTimeZone]];
                
                [dateFormatterCombined setDateFormat:@"H:m MM/d/yyyy"];
                
                if (startTime && testDate) {
                     NSString *startDateString=[NSString stringWithFormat:@"%@ %@",[dateFormatterTime stringFromDate:startTime],[dateFormatterDate stringFromDate:testDate]];
                
                //NSLog(@"startDateString is %@",startDateString);
                    
                    startTime=[dateFormatterCombined dateFromString:startDateString];
                    //NSLog(@"startTime is %@",startTime);
                }
               
                if (endTime && testDate) {
                    NSString *endDateString=[NSString stringWithFormat:@"%@ %@",[dateFormatterTime stringFromDate:endTime],[dateFormatterDate stringFromDate:testDate]];
                    
                    //NSLog(@"startDateString is %@",endDateString);
                    
                    endTime=[dateFormatterCombined dateFromString:endDateString];
                    
                    //NSLog(@"end time is %@", endTime);
                }
                
                thisEvent.startDate=startTime;
                thisEvent.endDate=endTime;
                
                NSMutableSet *clientSet=[buttonCellManagedObject mutableSetValueForKeyPath:@"clientPresentations.client.clientIDCode"];
                
                //NSLog(@"client set is %@",clientSet);
                
                NSString *eventTitleString=[NSString stringWithString:@"Test Administration:"];
                for (id obj in clientSet){
                    eventTitleString=[eventTitleString stringByAppendingFormat:@" %@,",obj];
                    
                    
                }
                if ( [eventTitleString length] > 0)
                    eventTitleString = [eventTitleString substringToIndex:[eventTitleString length] - 1];
                
                thisEvent.title=(NSString *) eventTitleString;
                
                UIViewController *currentTableModelViewController=(UIViewController *)currentDetailTableViewModel.viewController;
               
                NSString *calenderLocation=[[NSUserDefaults standardUserDefaults] valueForKey:@"calander_location"];
                //NSLog(@"calander location is %@",calenderLocation);
                [thisEvent setLocation:calenderLocation];
                
                  addController.editViewDelegate = self;
                addController.view.tag=837;
                addController.modalViewController.navigationController.delegate=self;
//                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//                
//                UITabBarController *tabBarController=[appDelegate tabBarController];
                currentTableModelViewController.navigationController.delegate=self;
                [currentTableModelViewController.navigationController presentModalViewController:addController animated:YES];
              
               
             
            }
        }
            
    }

    
   //    if (self.psyTrackCalendar) {
//        
//        [thisEvent setCalendar:self.psyTrackCalendar];
//    }
//    else {
//        <#statements#>
//    }
//      thisEvent.calendar=[self.eventStore defaultCalendarForNewEvents];
        //NSLog(@"psyTrackcalendar identifier %@",self.psyTrackCalendar.calendarIdentifier);
//      //NSLog(@"event isidentifier %@",thisEvent.eventIdentifier);
    

	// present EventsAddViewController as a modal view controller
	    
//    
//    // When add button is pushed, create an EKEventEditViewController to display the event.
//	EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:nil bundle:nil];
//	
//    // set the addController's event store to the current event store.
//	addController.eventStore = self.eventStore;
//   //NSLog(@"sender button class is %@",[sender class]);
//    
//    if ([sender isKindOfClass:[UIButton class]]) {
//        //NSLog(@"is member of uiButton class");
//        
//        UIButton *button=(UIButton *)sender;
//        
//       
//        UIView *buttonSuperView =button.superview;
//        //NSLog(@"view super view is %@",buttonSuperView.superview);
//        
//        if ([buttonSuperView.superview isKindOfClass:[ButtonCell class]]) {
//            ButtonCell *buttonCell=(ButtonCell *)buttonSuperView.superview;
//            eventButtonBoundObject=(NSManagedObject *) buttonCell.boundObject;
//            
//            //NSLog(@"button Cell bound object %@",buttonCell.boundObject);
//            NSString *eventIdentifier=[eventButtonBoundObject valueForKey:@"eventIdentifier"];
//            
//            if (eventIdentifier.length)
//            {
//                    if ([self.eventStore eventWithIdentifier:eventIdentifier]) 
//                    {
//                
//                        addController.event=[self.eventStore eventWithIdentifier:eventIdentifier];
//                    }
//               
//            }
//            
//        
//            
//        }
//     
//        
//        
//    }
//           
//        
//    
//    
//	
//
//	
//	NSString *location=[settingsDictionary valueForKey:@"calendarLocation"];
//    if (!location.length) {
//        location=@"My Clinic";
//        [settingsDictionary setValue:location forKey:@"calendarLocation"];
//        [settingsDictionary writeToFile:plistPath atomically: YES];
//    }
//    EKEvent *thisEvent = (EKEvent *) addController.event;
//    thisEvent.title=@"Testing Title";
////    thisEvent.calendar=self.psyTrackCalendar;
//    //NSLog(@"psyTrackcalendar identifier %@",self.psyTrackCalendar.calendarIdentifier);
//    //NSLog(@"event isidentifier %@",thisEvent.eventIdentifier);
//   
//    thisEvent.location=location;
//    
//    // present EventsAddViewController as a modal view controller
//	[self presentModalViewController:addController animated:YES];
//	addController.editViewDelegate = self;
//   
//     [thisEvent setCalendar: [self.eventStore defaultCalendarForNewEvents]];

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
			
            //NSLog(@"self psyTrack calendar %@",self.psyTrackCalendar);
            //NSLog(@"even calander is %@",thisEvent.calendar);
            
            if (self.psyTrackCalendar ==  thisEvent.calendar) {
				[self.eventsList addObject:thisEvent];
			}
			[controller.eventStore saveEvent:controller.event span:EKSpanThisEvent error:&error];
			
            //NSLog(@"section count is %i",currentDetailTableViewModel.sectionCount);
                       
            //NSLog(@"cell bound object in save event is %@",cell.boundObject);
           
            [cell.boundObject setValue:[controller.event eventIdentifier] forKey:@"eventIdentifier"];
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




@end
