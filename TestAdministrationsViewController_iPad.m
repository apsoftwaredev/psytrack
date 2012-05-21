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






@implementation TestAdministrationsViewController_iPad





#pragma mark -
#pragma mark View lifecycle




- (void)viewDidLoad {
    [super viewDidLoad];
    

   
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE, M/d/yyyy"];
    
   
    
    
    
	
	// Get managedObjectContext from application delegate
    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
	
    
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Testing Sessions";
    
    
    SCEntityDefinition *testSessionDeliveredDef =[SCEntityDefinition definitionWithEntityName:@"TestingSessionDeliveredEntity"
                                                                   managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"dateOfService",  @"time",@"clientPresentations",  @"notes", @"paperwork", @"assessmentType", @"certificationsCredited",   @"degreesCredited",  @"licenseNumbersCredited", @"relatedSupportTime", @"supervisor", @"testsAdministered",   @"trainingType", @"treatmentSetting",  @"eventIdentifier",     nil]];        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
   
 
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
       
   
    SCPropertyGroup *peopleGroup =[SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"supervisor",@"paperwork",   @"notes",nil]];
    
    
    
    [testSessionDeliveredDef.propertyGroups addGroup:peopleGroup];
    
    
    SCPropertyGroup *detailsGroup =[SCPropertyGroup groupWithHeaderTitle:@"Administration Details" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"testsAdministered",@"assessmentType",@"treatmentSetting",@"trainingType", @"relatedSupportTime", nil]];
    
   
    
    [testSessionDeliveredDef.propertyGroups addGroup:detailsGroup]; 
    
    
    
    SCPropertyDefinition *licenseNumbersCreditedPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"licenseNumbersCredited"];
    licenseNumbersCreditedPropertyDef.title=@"Licenses Credited";
    
    SCPropertyGroup *creditsGroup =[SCPropertyGroup groupWithHeaderTitle:@"Credits" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"degreesCredited",@"certificationsCredited",@"licenseNumbersCredited",nil]];
    
    
    [testSessionDeliveredDef.propertyGroups addGroup:creditsGroup];
    
    
    SCPropertyDefinition *supervivisorPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"supervisor"];
    
   	supervivisorPropertyDef.type = SCPropertyTypeObjectSelection;
    
    SCEntityDefinition *supervisorDef =[SCEntityDefinition definitionWithEntityName:@"ClinicianEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"prefix",@"firstName",@"middleName", @"lastName",@"suffix", nil]];
    supervisorDef.titlePropertyName=@"prefix;firstName;lastName;suffix";
    supervisorDef.orderAttributeName=@"order";
    
    SCPropertyGroup *supervisorNameGroup =[SCPropertyGroup groupWithHeaderTitle:@"Supervisor Name" footerTitle:@"Select this clinician under the Clicician tab to add or view more details." propertyNames:[NSArray arrayWithObjects:@"prefix",@"firstName",@"middleName", @"lastName",@"suffix", nil]];
    
    
    
    
    [supervisorDef.propertyGroups addGroup:supervisorNameGroup];
    
    SCObjectSelectionAttributes *supervisorSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:supervisorDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
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
    
    
    
    SCEntityDefinition *testAdministeredDef =[SCEntityDefinition definitionWithEntityName:@"TestAdministeredEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"psychTestName" ,@"scores",@"notes", nil]];
    
    
    
    
    testAdministeredDef.orderAttributeName = @"order";
    SCPropertyDefinition *testAdministeredNotesPropertyDef=[testAdministeredDef propertyDefinitionWithName:@"notes"];
    testAdministeredNotesPropertyDef.type=SCPropertyTypeTextView;
    
    testsAdministeredPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:testAdministeredDef
                                                             allowAddingItems:TRUE
                                                           allowDeletingItems:TRUE
                                                             allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Tests Administered)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:TRUE addNewObjectuiElementExistsInEditingMode:FALSE];
    
    
    
    testAdministeredDef.titlePropertyName=@"psychTestName.acronym";
    
    SCEntityDefinition *testNameDef=[SCEntityDefinition definitionWithEntityName:@"InstrumentEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"instrumentName", @"acronym",@"instrumentType", @"notes", nil]];
    
    
    testNameDef.titlePropertyName=@"acronym";
    
    testNameDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *testNamePropertyDef=[testAdministeredDef propertyDefinitionWithName:@"psychTestName"];
    testNamePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *testNameSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:testNameDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
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
    
    SCEntityDefinition *testTypeDef=[SCEntityDefinition definitionWithEntityName:@"InstrumentTypeEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"instrumentType", @"notes", nil]];
    
    
    
    testTypeDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *testTypePropertyDef=[testNameDef propertyDefinitionWithName:@"instrumentType"];
    testTypePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *testTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:testTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    testTypeSelectionAttribs.allowAddingItems = YES;
    testTypeSelectionAttribs.allowDeletingItems = YES;
    testTypeSelectionAttribs.allowMovingItems = YES;
    testTypeSelectionAttribs.allowEditingItems = YES;
    testTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Test Types)"];
    testTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Test Type"];
    testTypePropertyDef.attributes = testTypeSelectionAttribs;
    
   
    SCPropertyDefinition *testTypeNotesPropertyDef=[testTypeDef propertyDefinitionWithName:@"notes"];
    testTypeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    
    SCEntityDefinition *testScoredDef =[SCEntityDefinition definitionWithEntityName:@"TestScoreEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"scoreName" ,@"score",@"notes", nil]];
    
    
    
    
    testScoredDef.orderAttributeName = @"order";
    
    
    SCPropertyDefinition *testScoredNotesPropertyDef=[testScoredDef propertyDefinitionWithName:@"notes"];
    testScoredNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *testScoredNamePropertyDef=[testScoredDef propertyDefinitionWithName:@"scoreName"];
    testScoredNamePropertyDef.type=SCPropertyTypeTextView;
    testScoredNamePropertyDef.title=@"Score Name/Index";
    testScoredDef.titlePropertyName=@"scoreName;score";
    
    
    SCPropertyDefinition *testAdministeredScoresPropertyDef=[testAdministeredDef propertyDefinitionWithName:@"scores"];
    testAdministeredScoresPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:testScoredDef
                                                       allowAddingItems:TRUE
                                                     allowDeletingItems:TRUE
                                                       allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Test Scores)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:TRUE addNewObjectuiElementExistsInEditingMode:FALSE];
    
    
    
    testAdministeredDef.titlePropertyName=@"psychTestName.acronym";
    
    
    
    
    
    
    
    
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
    
    //treatment setting start
    SCEntityDefinition *psychTreatmentSettingDef=[SCEntityDefinition definitionWithEntityName:@"TreatmentSettingEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"settingType", @"notes", nil]];
    
    
    
    
    
    psychTreatmentSettingDef.orderAttributeName=@"order";
    
    
    //treatment setting is a place or setting where the treatment takes place (e.g., hospital, community mental health clinic, day program
    
    SCPropertyDefinition *sessionTreatmentSettingPropertyDef=[testSessionDeliveredDef propertyDefinitionWithName:@"treatmentSetting"];
    sessionTreatmentSettingPropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *treatmentSettingSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:psychTreatmentSettingDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
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






@end
