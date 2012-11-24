//
//  ExistingHoursViewController.m
//  PsyTrack
//
//  Created by Daniel Boice on 3/29/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ExistingHoursViewController.h"
#import "PTTAppDelegate.h"
#import "ClinicianSelectionCell.h"
#import "EncryptedSCTextViewCell.h"
#import "TotalHoursAndMinutesCell.h"
#import "ExistingHoursEntity.h"
#import "TrainingProgramEntity.h"
#import "SiteEntity.h"
@interface ExistingHoursViewController ()

@end

@implementation ExistingHoursViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    
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
//    
   
    
	// Get managedObjectContext from application delegate
   NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
	
    
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Existing Hours";
    

    SCEntityDefinition *existingHoursDef =[SCEntityDefinition definitionWithEntityName:@"ExistingHoursEntity"
                                                            managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"site",@"programCourse",@"startDate", @"endDate", @"assessments", @"directInterventions", @"supervisionReceived", @"supervisionGiven",@"supportActivities"     , @"notes",   nil]];        
    

                                          
                                          
    
    //create the dictionary with the data bindings
    NSDictionary *supervisorDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObjects:@"supervisor",@"Supervisor",[NSNumber numberWithBool:NO],@"supervisor",[NSNumber numberWithBool:NO],nil] 
                                           forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
    
    //create the custom property definition
    SCCustomPropertyDefinition *supervisorDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SupervisorData"
                                                                                        uiElementClass:[ClinicianSelectionCell class] objectBindings:supervisorDataBindings];
    
    
    
      supervisorDataProperty.autoValidate=NO;
    //insert the custom property definition into the clientData class at index 
    
    [existingHoursDef insertPropertyDefinition:supervisorDataProperty atIndex:0];
    
    
    
    SCEntityDefinition *siteDef=[SCEntityDefinition definitionWithEntityName:@"SiteEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"siteName", @"location",@"settingType", @"started",@"ended",@"notes",@"defaultSite", nil]];
    
    
    
    
    SCEntityDefinition *settingTypeDef=[SCEntityDefinition definitionWithEntityName:@"SiteSettingTypeEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects: @"settingTypeName", @"notes",nil]];
    
    
    
    
    siteDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *sitePropertyDef=[existingHoursDef propertyDefinitionWithName:@"site"];
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
    
    
    //define and initialize a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    
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
    

    //Training Type  start
    SCEntityDefinition *trainingProgramDef=[SCEntityDefinition definitionWithEntityName:@"TrainingProgramEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"school",@"trainingProgram",@"doctorateLevel",@"course",@"startDate",@"endDate",@"selectedByDefault", @"notes", nil]];
    
    
    
    
    
    
    
    
    trainingProgramDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *sessionTrainingProgramPropertyDef=[existingHoursDef propertyDefinitionWithName:@"programCourse"];
    sessionTrainingProgramPropertyDef.type =SCPropertyTypeObjectSelection;
    
    
    sessionTrainingProgramPropertyDef.autoValidate=NO;
    sessionTrainingProgramPropertyDef.title=@"Program - Course*";
    trainingProgramDef.titlePropertyName=@"trainingProgram;course";
    trainingProgramDef.titlePropertyNameDelimiter=@" - ";
    
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
    trainingProgramSchoolSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Schools)"];
    trainingProgramSchoolSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New School"];
    trainingProgramSchoolPropertyDef.attributes = trainingProgramSchoolSelectionAttribs;
    
    SCPropertyDefinition *trainingProgramSchoolNamePropertyDef=[schoolDef propertyDefinitionWithName:@"schoolName"];
    trainingProgramSchoolNamePropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *trainingPrograSchoolmNotesPropertyDef=[schoolDef propertyDefinitionWithName:@"notes"];
    trainingPrograSchoolmNotesPropertyDef.type=SCPropertyTypeTextView;
    

    
    //training type end
    

    
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
  
    
    //Create the property definition for the start date property in the existing Hours class  definition
    SCPropertyDefinition *existingHoursStartDatePropertyDef = [existingHoursDef propertyDefinitionWithName:@"startDate"];
    
    //format the the date using a date formatter
   
    //Set the date attributes in the existinghoursstartdate property definition and make it so the date picker appears in the same view.
    existingHoursStartDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                   datePickerMode:UIDatePickerModeDate
                                                    displayDatePickerInDetailView:NO];
    
    existingHoursStartDatePropertyDef.autoValidate=NO;
    //Create the property definition for the endDate property in the existingHours class
    SCPropertyDefinition *existingHoursEndDatePropertyDef = [existingHoursDef propertyDefinitionWithName:@"endDate"];
    
    
    //Set the date attributes in the existinghours end date property definition and make it so the date picker appears in the same view.
    existingHoursEndDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                                  datePickerMode:UIDatePickerModeDate
                                                                   displayDatePickerInDetailView:NO];
    
    existingHoursEndDatePropertyDef.autoValidate=NO;
    //Create the property definition for the notes property in the existing hours class
    SCPropertyDefinition *existingHoursNotesPropertyDef = [existingHoursDef propertyDefinitionWithName:@"notes"];
    existingHoursNotesPropertyDef.type=SCPropertyTypeTextView;
//    existingHoursNotesPropertyDef.type=SCPropertyTypeCustom;
//    existingHoursNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
//    
//    NSDictionary *encryProfileNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyString",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
//    
//    
//    existingHoursNotesPropertyDef.objectBindings=encryProfileNotesTVCellKeyBindingsDic;
    existingHoursNotesPropertyDef.title=@"Notes";
//    existingHoursNotesPropertyDef.autoValidate=NO;
    
    existingHoursDef.keyPropertyName=@"startDate";

    //Create a class definition for the demographicsEntity
    SCEntityDefinition *demographicsDef = [SCEntityDefinition definitionWithEntityName:@"ExistingDemographicsEntity" 
                                                            managedObjectContext:managedObjectContext
                                                                   propertyNames:[NSArray arrayWithObjects:@"ageGroups", @"ethnicities", @"genders", @"individualsWithDisabilities",  @"races",  @"sexualOrientations",  nil]];
    
    
    //create an array of objects definition for the ageGroups to-many relationship that with show up in a different view with  a place holder element>.
    
    
    //Create a class definition for the ageGroupsEntity
    SCEntityDefinition *existingAgeGroupDef = [SCEntityDefinition definitionWithEntityName:@"ExistingAgeGroupEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"ageGroup",@"numberOfIndividuals",   nil]];
    //Create the property definition for the numberofindividuals property in the existing age group class
    SCPropertyDefinition *existingAgeGroupNumberPropertyDef = [existingAgeGroupDef propertyDefinitionWithName:@"numberOfIndividuals"];
    
    existingAgeGroupNumberPropertyDef.title=@"Number of Individuals";
    existingAgeGroupNumberPropertyDef.autoValidate=NO;
    //Do some property definition customization for the existingAgeGroupDef Entity defined in demographics
    //Create the property definition for the ageGroups property
    SCPropertyDefinition *ageGroupPropertyDef = [demographicsDef propertyDefinitionWithName:@"ageGroups"];
    ageGroupPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:existingAgeGroupDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add age groups"]  addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add age group"]  addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //Create a class definition for the ageGroupEntity
    SCEntityDefinition *ageGroupDef = [SCEntityDefinition definitionWithEntityName:@"AgeGroupEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"ageGroup", nil]];
    
    
    ageGroupDef.orderAttributeName=@"order";
    //create an object selection for the ageGroup relationship in the existingAgeGroup Entity 
    
    //create a property definition
    SCPropertyDefinition *ageGroupInExistingAgeGroupPropertyDef = [existingAgeGroupDef propertyDefinitionWithName:@"ageGroup"];
   
    
    //set the title property name
    ageGroupDef.titlePropertyName=@"ageGroup";
    
    existingAgeGroupDef.titlePropertyName=@"ageGroup.ageGroup;numberOfIndividuals";
    existingAgeGroupDef.titlePropertyNameDelimiter =@" - ";
    //set the property definition type to objects selection
	
    ageGroupInExistingAgeGroupPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *ageGroupSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:ageGroupDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    ageGroupSelectionAttribs.allowAddingItems = YES;
    ageGroupSelectionAttribs.allowDeletingItems = YES;
    ageGroupSelectionAttribs.allowMovingItems = YES;
    ageGroupSelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    ageGroupSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap Edit to define age group"];
    
    
    //add an "Add New" element to appear when user clicks edit
    ageGroupSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Tap here to add new age group"];
    
    //add the selection attributes to the property definition
    ageGroupInExistingAgeGroupPropertyDef.attributes = ageGroupSelectionAttribs;    
    
   
    
    
    
    //Create a class definition for the ageGroupsEntity
    SCEntityDefinition *existingGenderDef = [SCEntityDefinition definitionWithEntityName:@"ExistingGenderEntity" 
                                                                managedObjectContext:managedObjectContext
                                                                       propertyNames:[NSArray arrayWithObjects:@"gender",@"numberOfIndividuals",   nil]];
    
    
    SCPropertyDefinition *existingGenderNumberPropertyDef = [existingGenderDef propertyDefinitionWithName:@"numberOfIndividuals"];
    
       existingGenderNumberPropertyDef.title=@"Number of Individuals";
    existingGenderNumberPropertyDef.autoValidate=NO;
    //Do some property definition customization for the existingAgeGroupDef Entity defined in demographics
    //Create the property definition for the ageGroups property
    SCPropertyDefinition *genderPropertyDef = [demographicsDef propertyDefinitionWithName:@"genders"];
    genderPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:existingGenderDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add genders"]   addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add gender"]  addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //Create a class definition for the ageGroupEntity
    SCEntityDefinition *genderpDef = [SCEntityDefinition definitionWithEntityName:@"GenderEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"genderName",@"notes", nil]];
    
    
    genderpDef.orderAttributeName=@"order";
    //create an object selection for the ageGroup relationship in the existingAgeGroup Entity 
    
    //create a property definition
    SCPropertyDefinition *genderInExistingGendersPropertyDef = [existingGenderDef   propertyDefinitionWithName:@"gender"];
    
    
    existingGenderDef.titlePropertyName=@"gender.genderName;numberOfIndividuals";
    existingGenderDef.titlePropertyNameDelimiter =@" - ";

    
    //set the title property name
    genderpDef.titlePropertyName=@"genderName";
    
    //set the property definition type to objects selection
	
    genderInExistingGendersPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *genderSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:genderpDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    genderSelectionAttribs.allowAddingItems = YES;
    genderSelectionAttribs.allowDeletingItems = YES;
    genderSelectionAttribs.allowMovingItems = YES;
    genderSelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    genderSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap Edit to define gender"];
    
    
    //add an "Add New" element to appear when user clicks edit
    genderSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Tap here to add gender"];
    
    //add the selection attributes to the property definition
    genderInExistingGendersPropertyDef.attributes = genderSelectionAttribs;    
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *genderNotesPropertyDef = [genderpDef propertyDefinitionWithName:@"notes"];
    genderNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    
    
    //Create a class definition for the ageGroupsEntity
    SCEntityDefinition *existingEthnicitiesDef = [SCEntityDefinition definitionWithEntityName:@"ExistingEthnicityEntity" 
                                                              managedObjectContext:managedObjectContext
                                                                     propertyNames:[NSArray arrayWithObjects:@"ethnicity",@"numberOfIndividuals",   nil]];
    
    
    SCPropertyDefinition *existingEthnicitiesNumberPropertyDef = [existingEthnicitiesDef propertyDefinitionWithName:@"numberOfIndividuals"];
    
    
    existingEthnicitiesNumberPropertyDef.autoValidate=NO;
    
     existingEthnicitiesNumberPropertyDef.title=@"Number of Individuals";
    //Do some property definition customization for the existingAgeGroupDef Entity defined in demographics
    //Create the property definition for the ageGroups property
    SCPropertyDefinition *ethnicityPropertyDef = [demographicsDef propertyDefinitionWithName:@"ethnicities"];
    ethnicityPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:existingEthnicitiesDef
                                                                                  allowAddingItems:YES
                                                                                allowDeletingItems:YES
                                                                                  allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add ethnicities"] addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add ethnicity"]  addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //Create a class definition for the ageGroupEntity
    SCEntityDefinition *ethnicitypDef = [SCEntityDefinition definitionWithEntityName:@"EthnicityEntity" 
                                                       managedObjectContext:managedObjectContext
                                                              propertyNames:[NSArray arrayWithObjects:@"ethnicityName",@"notes", nil]];
    
    
    ethnicitypDef.orderAttributeName=@"order";
    //create an object selection for the ageGroup relationship in the existingAgeGroup Entity 
    
    //create a property definition
    SCPropertyDefinition *ethnicityInExistingEthnicityPropertyDef = [existingEthnicitiesDef   propertyDefinitionWithName:@"ethnicity"];
    
    existingEthnicitiesDef.titlePropertyName=@"ethnicity.ethnicityName;numberOfIndividuals";
    existingEthnicitiesDef.titlePropertyNameDelimiter =@" - ";
    
    //set the title property name
    ethnicitypDef.titlePropertyName=@"ethnicityName";
    
    //set the property definition type to objects selection
	
    ethnicityInExistingEthnicityPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *ethnicitySelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:ethnicitypDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    ethnicitySelectionAttribs.allowAddingItems = YES;
    ethnicitySelectionAttribs.allowDeletingItems = YES;
    ethnicitySelectionAttribs.allowMovingItems = YES;
    ethnicitySelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    ethnicitySelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap Edit to define ethnicity"];
    
    
    //add an "Add New" element to appear when user clicks edit
    ethnicitySelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Tap here to add ethnicity"];
    
    //add the selection attributes to the property definition
    ethnicityInExistingEthnicityPropertyDef.attributes = ethnicitySelectionAttribs;    
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *ethnicityNotesPropertyDef = [ethnicitypDef propertyDefinitionWithName:@"notes"];
    ethnicityNotesPropertyDef.type=SCPropertyTypeTextView;

    
    //Create a class definition for the ageGroupsEntity
    SCEntityDefinition *existingRaceDef = [SCEntityDefinition definitionWithEntityName:@"ExistingRaceEntity" 
                                                                   managedObjectContext:managedObjectContext
                                                                          propertyNames:[NSArray arrayWithObjects:@"race",@"numberOfIndividuals",   nil]];
    
    
    SCPropertyDefinition *existingRaceNumberPropertyDef = [existingRaceDef propertyDefinitionWithName:@"numberOfIndividuals"];
    
     existingRaceNumberPropertyDef.title=@"Number of Individuals";
    existingRaceNumberPropertyDef.autoValidate=NO;
    //Do some property definition customization for the existingAgeGroupDef Entity defined in demographics
    //Create the property definition for the ageGroups property
    SCPropertyDefinition *racePropertyDef = [demographicsDef propertyDefinitionWithName:@"races"];
    racePropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:existingRaceDef
                                                                                     allowAddingItems:YES
                                                                                   allowDeletingItems:YES
                                                                                     allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add ethnicities"] addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add race"]  addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //Create a class definition for the ageGroupEntity
    SCEntityDefinition *raceDef = [SCEntityDefinition definitionWithEntityName:@"RaceEntity" 
                                                          managedObjectContext:managedObjectContext
                                                                 propertyNames:[NSArray arrayWithObjects:@"raceName",@"notes", nil]];
    
    
    raceDef.orderAttributeName=@"order";
    //create an object selection for the ageGroup relationship in the existingAgeGroup Entity 
    
    //create a property definition
    SCPropertyDefinition *raceInExistingRacePropertyDef = [existingRaceDef   propertyDefinitionWithName:@"race"];
    
    existingRaceDef.titlePropertyName=@"race.raceName;numberOfIndividuals";
    existingRaceDef.titlePropertyNameDelimiter =@" - ";
    
    //set the title property name
    raceDef.titlePropertyName=@"raceName";
    
    //set the property definition type to objects selection
	
    raceInExistingRacePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *raceSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:raceDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    raceSelectionAttribs.allowAddingItems = YES;
    raceSelectionAttribs.allowDeletingItems = YES;
    raceSelectionAttribs.allowMovingItems = YES;
    raceSelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    raceSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap Edit to define race"];
    
    
    //add an "Add New" element to appear when user clicks edit
    raceSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Tap here to add race"];
    
    //add the selection attributes to the property definition
    raceInExistingRacePropertyDef.attributes = raceSelectionAttribs;    
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *raceNotesPropertyDef = [raceDef propertyDefinitionWithName:@"notes"];
    raceNotesPropertyDef.type=SCPropertyTypeTextView;
    

    //Create a class definition for the ageGroupsEntity
    SCEntityDefinition *existingDisabilityDef = [SCEntityDefinition definitionWithEntityName:@"ExistingDisabilityEntity" 
                                                            managedObjectContext:managedObjectContext
                                                                   propertyNames:[NSArray arrayWithObjects:@"disability",@"numberOfIndividuals",   nil]];
    
    
    SCPropertyDefinition *existingDisabilityNumberPropertyDef = [existingDisabilityDef propertyDefinitionWithName:@"numberOfIndividuals"];
    
    
    existingDisabilityNumberPropertyDef.autoValidate=NO;
   existingDisabilityNumberPropertyDef.title=@"Number of Individuals";
    
    //Do some property definition customization for the existingAgeGroupDef Entity defined in demographics
    //Create the property definition for the ageGroups property
    SCPropertyDefinition *disabilityPropertyDef = [demographicsDef propertyDefinitionWithName:@"individualsWithDisabilities"];
    disabilityPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:existingDisabilityDef
                                                                                allowAddingItems:YES
                                                                              allowDeletingItems:YES
                                                                                allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add disabilities"]  addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add disability"]  addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //Create a class definition for the ageGroupEntity
    SCEntityDefinition *disabilityDef = [SCEntityDefinition definitionWithEntityName:@"DisabilityEntity" 
                                                     managedObjectContext:managedObjectContext
                                                            propertyNames:[NSArray arrayWithObjects:@"disabilityName",@"notes", nil]];
    
    
    disabilityDef.orderAttributeName=@"order";
    //create an object selection for the ageGroup relationship in the existingAgeGroup Entity 
    
    //create a property definition
    SCPropertyDefinition *disabilityInExistingDisabilityPropertyDef = [existingDisabilityDef   propertyDefinitionWithName:@"disability"];
    
    existingDisabilityDef.titlePropertyName=@"disability.disabilityName;numberOfIndividuals";
    existingDisabilityDef.titlePropertyNameDelimiter =@" - ";
    
    //set the title property name
    disabilityDef.titlePropertyName=@"disabilityName";
    disabilityDef.titlePropertyNameDelimiter =@" - ";
    
    //set the property definition type to objects selection
	
    disabilityInExistingDisabilityPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *disabilitySelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:disabilityDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    disabilitySelectionAttribs.allowAddingItems = YES;
    disabilitySelectionAttribs.allowDeletingItems = YES;
    disabilitySelectionAttribs.allowMovingItems = YES;
    disabilitySelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    disabilitySelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap Edit to define disability"];
    
    
    //add an "Add New" element to appear when user clicks edit
    disabilitySelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Tap here to add disability"];
    
    //add the selection attributes to the property definition
    disabilityInExistingDisabilityPropertyDef.attributes = disabilitySelectionAttribs;    
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *disabilityNotesPropertyDef = [disabilityDef propertyDefinitionWithName:@"notes"];
    disabilityNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    //Create a class definition for the ageGroupsEntity
    SCEntityDefinition *existingSexualOrientationDef = [SCEntityDefinition definitionWithEntityName:@"ExistingSexualOrientationEntity" 
                                                                  managedObjectContext:managedObjectContext
                                                                         propertyNames:[NSArray arrayWithObjects:@"sexualOrientation",@"numberOfIndividuals",   nil]];
    
    SCPropertyDefinition *existingSONumberPropertyDef = [existingSexualOrientationDef propertyDefinitionWithName:@"numberOfIndividuals"];
    
    
    existingSONumberPropertyDef.autoValidate=NO;
    existingSONumberPropertyDef.title=@"Number of Individuals";
    //Do some property definition customization for the existingAgeGroupDef Entity defined in demographics
    //Create the property definition for the ageGroups property
    SCPropertyDefinition *sexualOrientationPropertyDef = [demographicsDef propertyDefinitionWithName:@"sexualOrientations"];
    sexualOrientationPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:existingSexualOrientationDef
                                                                                      allowAddingItems:YES
                                                                                    allowDeletingItems:YES
                                                                                      allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add sexual orientations"]   addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add sexual orientation"]  addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
   
    
    //create a property definition
    SCPropertyDefinition *sOInExistingSexualOPropertyDef = [existingSexualOrientationDef   propertyDefinitionWithName:@"sexualOrientation"];
    
    
    //set the title property name
    existingSexualOrientationDef.titlePropertyName=@"sexualOrientation;numberOfIndividuals";
    existingSexualOrientationDef.titlePropertyNameDelimiter =@" - ";
    //set the property definition type to objects selection
	
   
	sOInExistingSexualOPropertyDef.title = @"Sexual Orientation";
    sOInExistingSexualOPropertyDef.type = SCPropertyTypeSelection;
	sOInExistingSexualOPropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Asexual", @"Bisexual", @"Heterosexual",@"Gay", @"Lesbian",@"Uncertain/Questioning",@"Undisclosed", nil] 
                                                                     allowMultipleSelection:NO
                                                                           allowNoSelection:NO autoDismissDetailView:YES hideDetailViewNavigationBar:NO];
    
    
    //create the dictionary with the data bindings
    NSDictionary *hoursDataBindings = [NSDictionary 
                                       dictionaryWithObjects:[NSArray arrayWithObjects:@"hours",nil] 
                                       forKeys:[NSArray arrayWithObjects:@"1",nil ]];
    

     for (NSInteger i=0; i<2; i++) {
         NSString *supervisionEntityName=nil;
         NSString *existingSupervisionPropertyName=nil;
         if (i==0) {
             supervisionEntityName=@"ExistingSupervisionReceivedEntity";
            existingSupervisionPropertyName=@"supervisionReceived";
             
         }
         else {
             supervisionEntityName=@"ExistingSupervisionGivenEntity";
            existingSupervisionPropertyName=@"supervisionGiven";
         }
         
        //Create a class definition for the existingAssessmentEntity
        SCEntityDefinition *supervisionDef = [SCEntityDefinition definitionWithEntityName:supervisionEntityName 
                                                                       managedObjectContext:managedObjectContext
                                                                              propertyNames:[NSArray arrayWithObjects:@"supervisionType",@"subType", @"notes",@"monthlyLogNotes",nil]];
        

            //create the custom property definition
         SCCustomPropertyDefinition *supervisionHoursDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SupervisionHoursData"
                                                                                                 uiElementNibName:@"TotalHoursAndMinutesCell" objectBindings:hoursDataBindings];
         
         
         //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
         supervisionHoursDataProperty.autoValidate=FALSE;
         
         
         [supervisionDef insertPropertyDefinition:supervisionHoursDataProperty atIndex:2];
         

         SCPropertyDefinition *supervisionMonthlyLogNotes=[supervisionDef propertyDefinitionWithName:@"monthlyLogNotes"];
         supervisionMonthlyLogNotes.type=SCPropertyTypeTextView;
         
         
         //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
        
        
        //create an array of objects definition for the supervision to-many relationship that with show up in the same view without a place holder element>.
        
        //Create the property definition for the  property
        SCPropertyDefinition *supervisionPropertyDef = [existingHoursDef propertyDefinitionWithName:existingSupervisionPropertyName];
        
        
         
         
    //    supervisionPropertyDef.title=@"Supervision Types";
//        supervisionPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:supervisionDef
//                                                                                        allowAddingItems:YES
//                                                                                      allowDeletingItems:YES
//                                                                                      allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:(i==0)?@"Tap edit to add supervison received hours":@"Tap edit to add supervision given hours"]  addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add supervison hours"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
         supervisionPropertyDef.type=SCPropertyTypeArrayOfObjects;
         supervisionPropertyDef.attributes =  [SCArrayOfObjectsAttributes attributesWithObjectDefinition:supervisionDef
                                                   allowAddingItems:YES
                                                 allowDeletingItems:YES
                                                   allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:(i==0)?@"tap + to add supervision received hours":@"tap + to add supervision given hours"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:NO];
        
        //create an object selection for the supervisionType relationship in the Supervision Entity 
        
                 
         
        //Create a class definition for the supervision TypeEntity
        SCEntityDefinition *supervisionTypeDef = [SCEntityDefinition definitionWithEntityName:@"SupervisionTypeEntity" 
                                                            managedObjectContext:managedObjectContext
                                                                   propertyNames:[NSArray arrayWithObjects:@"supervisionType",@"subTypes", nil]];
        
        //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
        //create a property definition
       
        SCPropertyDefinition *supervisionTypePropertyDef = [supervisionDef propertyDefinitionWithName:@"supervisionType"];
         supervisionTypePropertyDef.autoValidate=NO;
       
        //set the title property name
        supervisionDef.titlePropertyName=@"supervisionType.supervisionType;subType.subType";
        supervisionDef.titlePropertyNameDelimiter=@" - ";
        
        
        //set the property definition type to objects selection
        
        supervisionTypePropertyDef.type = SCPropertyTypeObjectSelection;
        SCObjectSelectionAttributes *supervisionTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:supervisionTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
        
        //set some addtional attributes
        supervisionTypeSelectionAttribs.allowAddingItems = YES;
        supervisionTypeSelectionAttribs.allowDeletingItems = YES;
        supervisionTypeSelectionAttribs.allowMovingItems = NO;
        supervisionTypeSelectionAttribs.allowEditingItems = YES;
        
        //add a placeholder element to tell the user what to do     when there are no other cells                                          
        supervisionTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap edit to add new supervision type"];
        
        
        //add an "Add New" element to appear when user clicks edit
        supervisionTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New supervision type"];
        
        //add the selection attributes to the property definition
        supervisionTypePropertyDef.attributes = supervisionTypeSelectionAttribs;
        
        //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
        
        
        //Create the property definition for the notes property in the genderDef class
        SCPropertyDefinition *supervisiondNotesPropertyDef = [supervisionDef propertyDefinitionWithName:@"notes"];
        supervisiondNotesPropertyDef.type=SCPropertyTypeTextView;
        
       
         if (i==1) {
         
        //create the dictionary with the data bindings
        NSDictionary *clinicianDataBindings = [NSDictionary 
                                               dictionaryWithObjects:[NSArray arrayWithObjects:@"supervisors",(i==0)?@"Supervisors":@"Supervisees",[NSNumber numberWithBool:NO],@"supervisors",[NSNumber numberWithBool:YES],nil] 
                                               forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
        
        //create the custom property definition
        SCCustomPropertyDefinition *clinicianDataProperty = [SCCustomPropertyDefinition definitionWithName:@"ClinicianData"
                                                                                        uiElementClass:[ClinicianSelectionCell class] objectBindings:clinicianDataBindings];
        

        
        
        //insert the custom property definition into the clientData class at index 
        
        [supervisionDef insertPropertyDefinition:clinicianDataProperty atIndex:3];
         
        //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
        clinicianDataProperty.autoValidate=TRUE;
         }
        
        NSString * supervisionSubTypePropertyNameString=@"subType";
        NSString * supervisionSubTypeEntityNameString=@"SupervisionTypeSubtypeEntity";
        
        SCEntityDefinition *supervisionSubTypeDef=[SCEntityDefinition definitionWithEntityName:supervisionSubTypeEntityNameString managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:supervisionSubTypePropertyNameString, @"notes", nil]];
        
        
        
        
        supervisionSubTypeDef.orderAttributeName=@"order";
        
        
        
        SCPropertyDefinition *supervisionSubTypePropertyDef=[supervisionDef propertyDefinitionWithName:@"subType"];
         supervisionSubTypePropertyDef.autoValidate=NO;
        supervisionSubTypePropertyDef.type =SCPropertyTypeObjectSelection;
        
        SCObjectSelectionAttributes *supervisionSubTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:supervisionSubTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
        supervisionSubTypeSelectionAttribs.allowAddingItems = NO;
        supervisionSubTypeSelectionAttribs.allowDeletingItems = NO;
        supervisionSubTypeSelectionAttribs.allowMovingItems = YES;
        supervisionSubTypeSelectionAttribs.allowEditingItems = YES;
        supervisionSubTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add supervision subtypes under Supervision Type)"];
        
        supervisionSubTypePropertyDef.attributes = supervisionSubTypeSelectionAttribs;
        
        SCPropertyDefinition *supervisionSubTypeStrPropertyDef=[supervisionSubTypeDef propertyDefinitionWithName:supervisionSubTypePropertyNameString];
        supervisionSubTypeStrPropertyDef.type=SCPropertyTypeTextView;
        SCPropertyDefinition *supervisionSubTypeNotesPropertyDef=[supervisionSubTypeDef propertyDefinitionWithName:@"notes"];
        supervisionSubTypeNotesPropertyDef.type=SCPropertyTypeTextView;
        

//         SCPropertyDefinition *supervisionTypeSubtypePropertyDef=[SCPropertyDefinition definitionWithName:@"subTypes" title:@"Subtypes" type:SCPropertyTypeArrayOfObjects];
//         
//         [supervisionTypeDef addPropertyDefinition:supervisionTypeSubtypePropertyDef];
         SCPropertyDefinition *supervisionTypeSubtypePropertyDef=[supervisionTypeDef propertyDefinitionWithName:@"subTypes"];
         supervisionSubTypePropertyDef.type=SCPropertyTypeArrayOfObjects;
         
         supervisionTypeSubtypePropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:supervisionSubTypeDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add new supervision subtype"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];
    }                   
    
    //Create a class definition for the existingAssessmentEntity
    SCEntityDefinition *supportActivityDef = [SCEntityDefinition definitionWithEntityName:@"ExistingSupportActivityEntity" 
                                                           managedObjectContext:managedObjectContext
                                                                  propertyNames:[NSArray arrayWithObjects:@"supportActivityType",  @"notes",@"monthlyLogNotes",nil]];
    
    
    
    
    SCPropertyDefinition *supportMonthlyLogNotes=[supportActivityDef propertyDefinitionWithName:@"monthlyLogNotes"];
    supportMonthlyLogNotes.type=SCPropertyTypeTextView;
    

    
    //create the custom property definition
    SCCustomPropertyDefinition *supportHoursDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SupportHoursData"
                                                                                            uiElementNibName:@"TotalHoursAndMinutesCell" objectBindings:hoursDataBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    supportHoursDataProperty.autoValidate=FALSE;
    
    
    [supportActivityDef insertPropertyDefinition:supportHoursDataProperty atIndex:1];
    


    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    //create an array of objects definition for the supervision to-many relationship that with show up in the same view without a place holder element>.
    
    //Create the property definition for the supportActivity property
    SCPropertyDefinition *supportActivitiesPropertyDef = [existingHoursDef propertyDefinitionWithName:@"supportActivities"];
    
//    supportActivitiesPropertyDef.type=SCPropertyTypeArrayOfObjects;
//    supportActivitiesPropertyDef.attributes =  [SCArrayOfObjectsAttributes attributesWithObjectDefinition:supportActivityDef
//                                                                                   allowAddingItems:YES
//                                                                                 allowDeletingItems:YES
//                                                                                   allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap + to add support activity hours"] addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add support activity hours"] addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:NO];
    supportActivitiesPropertyDef.type=SCPropertyTypeArrayOfObjects;
    supportActivitiesPropertyDef.attributes =  [SCArrayOfObjectsAttributes attributesWithObjectDefinition:supportActivityDef
                                                                                   allowAddingItems:YES
                                                                                 allowDeletingItems:YES
                                                                                   allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"tap + to add support activity hours"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:NO];

    
    //create an object selection for the supervisionType relationship in the Supervision Entity 
    
    
    //Create a class definition for the supervision TypeEntity
    SCEntityDefinition *supportActivityTypeDef = [SCEntityDefinition definitionWithEntityName:@"SupportActivityTypeEntity" 
                                                               managedObjectContext:managedObjectContext
                                                                      propertyNames:[NSArray arrayWithObjects:@"supportActivityType", nil]];
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    //create a property definition
    
    SCPropertyDefinition *supportActivityTypePropertyDef = [supportActivityDef propertyDefinitionWithName:@"supportActivityType"];
    
    supportActivityTypePropertyDef.autoValidate=NO;
    //set the title property name
    supportActivityDef.titlePropertyName=@"supportActivityType.supportActivityType;hours";
    
    //set the property definition type to objects selection
	
    supportActivityTypePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *supportActivityTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:supportActivityTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    supportActivityTypeSelectionAttribs.allowAddingItems = YES;
    supportActivityTypeSelectionAttribs.allowDeletingItems = YES;
    supportActivityTypeSelectionAttribs.allowMovingItems = YES;
    supportActivityTypeSelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    supportActivityTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap edit to add new support activity type"];
    
    
    //add an "Add New" element to appear when user clicks edit
    supportActivityTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New support activity type"];
    
    //add the selection attributes to the property definition
    supportActivityTypePropertyDef.attributes = supportActivityTypeSelectionAttribs;
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *supportActivitydNotesPropertyDef = [supportActivityDef propertyDefinitionWithName:@"notes"];
    supportActivitydNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    //Create a class definition for the existingAssessmentEntity
    SCEntityDefinition *assessmentDef = [SCEntityDefinition definitionWithEntityName:@"ExistingAssessmentEntity" 
                                                          managedObjectContext:managedObjectContext
                                                                 propertyNames:[NSArray arrayWithObjects:@"assessmentType",@"instruments",@"batteries", @"demographics",@"notes",@"monthlyLogNotes",nil]];
    
    
   
    SCPropertyDefinition *assessmentnMonthlyLogNotes=[assessmentDef propertyDefinitionWithName:@"monthlyLogNotes"];
    assessmentnMonthlyLogNotes.type=SCPropertyTypeTextView;
    

    //create the custom property definition
    SCCustomPropertyDefinition *assessmentHoursDataProperty = [SCCustomPropertyDefinition definitionWithName:@"AssessmentHoursData"
                                                                                    uiElementNibName:@"TotalHoursAndMinutesCell" objectBindings:hoursDataBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    assessmentHoursDataProperty.autoValidate=FALSE;
    
   
    [assessmentDef insertPropertyDefinition:assessmentHoursDataProperty atIndex:1];


    //Create a class definition for the assessmentTypeEntity
    SCEntityDefinition *assessmentTypeDef = [SCEntityDefinition definitionWithEntityName:@"AssessmentTypeEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"assessmentType", @"notes" , nil]];
    
    
    
    
      

    
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *assessmentsPropertyDef = [existingHoursDef propertyDefinitionWithName:@"assessments"];
    
//    assessmentsPropertyDef.title=@"Assessment Types";
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    assessmentsPropertyDef.type=SCPropertyTypeArrayOfObjects;
    assessmentsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:assessmentDef
                                                                                             allowAddingItems:YES
                                                                                           allowDeletingItems:YES
                                                                                             allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap + to add assessment hours"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //create an object selection for the supervisionType relationship in the Supervision Entity 
    
    
  
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    //create a property definition
    
    SCPropertyDefinition *assessmentTypePropertyDef = [assessmentDef propertyDefinitionWithName:@"assessmentType"];
    
    assessmentTypePropertyDef.autoValidate=NO;
    //set the title property name
    assessmentDef.titlePropertyName=@"assessmentType.assessmentType;hours";
    assessmentDef.titlePropertyNameDelimiter=@" - ";
    
    //set the property definition type to objects selection
	
    assessmentTypePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *assessmentTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:assessmentTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    assessmentTypeSelectionAttribs.allowAddingItems = YES;
    assessmentTypeSelectionAttribs.allowDeletingItems = YES;
    assessmentTypeSelectionAttribs.allowMovingItems = YES;
    assessmentTypeSelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    assessmentTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap edit to add new assessment type"];
    
    
    //add an "Add New" element to appear when user clicks edit
    assessmentTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New assessment type"];
    
    //add the selection attributes to the property definition
    assessmentTypePropertyDef.attributes = assessmentTypeSelectionAttribs;
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *assessmentTypeNotesPropertyDef = [assessmentTypeDef propertyDefinitionWithName:@"notes"];
    assessmentTypeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    

    assessmentTypeDef.orderAttributeName=@"order";
      

    
       
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *assessmentDemPropertyDef = [assessmentDef propertyDefinitionWithName:@"demographics"];
    
    assessmentDemPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:demographicsDef
                                                                                               allowAddingItems:NO
                                                                                             allowDeletingItems:NO
                                                                                               allowMovingItems:NO];
    

    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *assessmentNotesPropertyDef = [assessmentDef propertyDefinitionWithName:@"notes"];
    assessmentNotesPropertyDef.type=SCPropertyTypeTextView;
    

    //Create a class definition for the existing InstrumentsEntity
    SCEntityDefinition *existingInstrumentDef = [SCEntityDefinition definitionWithEntityName:@"ExistingInstrumentEntity" 
                                                        managedObjectContext:managedObjectContext
                                                                         propertyNames:[NSArray arrayWithObjects:@"instrument",@"numberAdminstered",@"numberOfReportsWritten",@"notes",  nil]];
    
    
    
    
    
    SCPropertyDefinition *existingIAdministeredNumberPropertyDef = [existingInstrumentDef propertyDefinitionWithName:@"numberAdminstered"];
    
    
    existingIAdministeredNumberPropertyDef.autoValidate=NO;
    
    
    SCPropertyDefinition *existingIReportsNumberPropertyDef = [existingInstrumentDef propertyDefinitionWithName:@"numberOfReportsWritten"];
    
    
    existingIReportsNumberPropertyDef.autoValidate=NO;
    
    existingIReportsNumberPropertyDef.title=@"Number of Reports Written";

    
    //Create a class definition for the instrument type Entity
    SCEntityDefinition *instrumentTypeDef = [SCEntityDefinition definitionWithEntityName:@"InstrumentTypeEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"instrumentType", @"notes" , nil]];
    
    
    
    
    //Create a class definition for the Instrument Entity
    SCEntityDefinition *instrumentDef = [SCEntityDefinition definitionWithEntityName:@"InstrumentEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"acronym",@"instrumentName",  @"publisher",@"ages",@"sampleSize",@"instrumentType",  @"scoreNames",  @"notes" , nil]];
    
    
    
    
    
    //create an array of objects definition for the existing instruments to-many relationship that with show up in a different view  without a place holder element>.
    
    //Create the property definition for the instruments property
    SCPropertyDefinition *existingInstrumentsPropertyDef = [assessmentDef propertyDefinitionWithName:@"instruments"];
    existingInstrumentsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:existingInstrumentDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add instruments"]  addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add instrument"] addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    existingInstrumentDef.titlePropertyName=@"instrument.instrumentName;numberOfTimesUsed";
   
    //create an object selection for the instrument relationship in the existing Instruments Entity 
    
    //create a property definition
    SCPropertyDefinition *instrumentPropertyDef = [existingInstrumentDef propertyDefinitionWithName:@"instrument"];
    
 
    
    //set the title property name
    instrumentDef.titlePropertyName=@"instrumentName";
    
    //set the property definition type to objects selection
	
    instrumentPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *instrumentSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:instrumentDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    
    //set some addtional attributes
    instrumentSelectionAttribs.allowAddingItems = YES;
    instrumentSelectionAttribs.allowDeletingItems = YES;
    instrumentSelectionAttribs.allowMovingItems = NO;
    instrumentSelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    instrumentSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap edit to add instruments"];
    
    
    //add an "Add New" element to appear when user clicks edit
    instrumentSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Tap here to add new instrument"];
    
    //add the selection attributes to the property definition
    instrumentPropertyDef.attributes = instrumentSelectionAttribs;
   
    //Create a class definition for the instrument publisher Entity
    SCEntityDefinition *instrumentPublisherDef = [SCEntityDefinition definitionWithEntityName:@"InstrumentPublisherEntity" 
                                                                         managedObjectContext:managedObjectContext
                                                                                propertyNames:[NSArray arrayWithObjects:@"publisherName", @"notes" , nil]];
    
    
    
    //create a property definition
    SCPropertyDefinition *instrumentPublisherPropertyDef = [instrumentDef propertyDefinitionWithName:@"publisher"];
    
    
    
    //set the title property name
    instrumentPublisherDef.titlePropertyName=@"publisherName";
    instrumentPublisherDef.orderAttributeName=@"order";
    //set the property definition Publisher to objects selection
	
    instrumentPublisherPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *instrumentPublisherSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:instrumentPublisherDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    instrumentPublisherSelectionAttribs.allowAddingItems = YES;
    instrumentPublisherSelectionAttribs.allowDeletingItems = YES;
    instrumentPublisherSelectionAttribs.allowMovingItems = YES;
    instrumentPublisherSelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    instrumentPublisherSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap edit to add instrument publishers"];
    
    
    //add an "Add New" element to appear when user clicks edit
    instrumentPublisherSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Tap here to add new instrument Publisher"];
    
    //add the selection attributes to the property definition
    instrumentPublisherPropertyDef.attributes = instrumentPublisherSelectionAttribs;
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *instrumentPublisherNotesPropertyDef = [instrumentPublisherDef propertyDefinitionWithName:@"notes"];
    instrumentPublisherNotesPropertyDef.type=SCPropertyTypeTextView;
    
    

    
    //create a property definition
    SCPropertyDefinition *instrumentTypePropertyDef = [instrumentDef propertyDefinitionWithName:@"instrumentType"];
    
    
    
    //set the title property name
    instrumentTypeDef.titlePropertyName=@"instrumentType";
    
    //set the property definition type to objects selection
	
    instrumentTypePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *instrumentTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:instrumentTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    instrumentTypeSelectionAttribs.allowAddingItems = YES;
    instrumentTypeSelectionAttribs.allowDeletingItems = YES;
    instrumentTypeSelectionAttribs.allowMovingItems = NO;
    instrumentTypeSelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    instrumentTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap edit to add instrument types"];
    
    
    //add an "Add New" element to appear when user clicks edit
    instrumentTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Tap here to add new instrument type"];
    
    //add the selection attributes to the property definition
    instrumentTypePropertyDef.attributes = instrumentTypeSelectionAttribs;
    
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *existingInstrumentNotesPropertyDef = [existingInstrumentDef propertyDefinitionWithName:@"notes"];
    existingInstrumentNotesPropertyDef.type=SCPropertyTypeTextView;
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *instrumentNotesPropertyDef = [instrumentDef propertyDefinitionWithName:@"notes"];
    instrumentNotesPropertyDef.type=SCPropertyTypeTextView;
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *instrumentTypeNotesPropertyDef = [instrumentTypeDef propertyDefinitionWithName:@"notes"];
    instrumentTypeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCEntityDefinition *instrumentScoreNameDef=[SCEntityDefinition definitionWithEntityName:@"InstrumentScoreNameEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"scoreName", @"abbreviatedName", @"notes"   , nil]];
    
    SCPropertyDefinition *instrumentScoreNameNotesPropertyDef = [instrumentScoreNameDef propertyDefinitionWithName:@"notes"];    
    
    
    instrumentScoreNameNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *scoreNameInInstrumentPropertyDef=[instrumentDef propertyDefinitionWithName:@"scoreNames"];
    
    
    
    
    
    scoreNameInInstrumentPropertyDef.type=SCPropertyTypeArrayOfObjects;
    scoreNameInInstrumentPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:instrumentScoreNameDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"(Define score names)"] addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to define score name"] addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	    
    
    

    
    
    //Create a class definition for the existing InstrumentsEntity
    SCEntityDefinition *existingBatteryDef = [SCEntityDefinition definitionWithEntityName:@"ExistingBatteryEntity" 
                                                                  managedObjectContext:managedObjectContext
                                                                         propertyNames:[NSArray arrayWithObjects:@"battery",@"numberAdminstered",@"numberOfReportsWritten",@"notes",  nil]];
    
    
    
    SCPropertyDefinition *existingBAdministeredNumberPropertyDef = [existingBatteryDef propertyDefinitionWithName:@"numberAdminstered"];
    
    
    existingBAdministeredNumberPropertyDef.autoValidate=NO;
    
    
    SCPropertyDefinition *existingBReportsNumberPropertyDef = [existingBatteryDef propertyDefinitionWithName:@"numberOfReportsWritten"];
    
    
    existingBReportsNumberPropertyDef.autoValidate=NO;
    
    


    
    //Create a class definition for the Instrument Entity
    SCEntityDefinition *batteryDef = [SCEntityDefinition definitionWithEntityName:@"BatteryEntity" 
                                                          managedObjectContext:managedObjectContext
                                                                 propertyNames:[NSArray arrayWithObjects:@"batteryName", @"acronym", @"publisher",@"instruments",@"sampleSize", @"ages",   @"notes" , nil]];
    
    
    
    //Create the property definition for the instruments property
    SCPropertyDefinition *existingBatteriesPropertyDef = [assessmentDef propertyDefinitionWithName:@"batteries"];
    existingBatteriesPropertyDef.type=SCPropertyTypeArrayOfObjects;
    existingBatteriesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:existingBatteryDef
                                                                                               allowAddingItems:YES
                                                                                             allowDeletingItems:YES
                                                                                               allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add batteries"]  addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add battery"] addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    existingBatteryDef.titlePropertyName=@"battery.batteryName;numberAdminstered;numberOfReportsWritten";
    existingRaceDef.titlePropertyNameDelimiter=@" - ";
    //create an object selection for the instrument relationship in the existing Instruments Entity 
    

    
    //create a property definition
    SCPropertyDefinition *batteryPropertyDef = [existingBatteryDef propertyDefinitionWithName:@"battery"];
    
    
    
    //set the title property name
    batteryDef.titlePropertyName=@"batteryName;acronym;numberAdminstered";
    batteryDef.titlePropertyNameDelimiter=@" - ";
    //set the property definition type to objects selection
	
    batteryPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *batterySelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:batteryDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    
    //set some addtional attributes
    batterySelectionAttribs.allowAddingItems = YES;
    batterySelectionAttribs.allowDeletingItems = YES;
    batterySelectionAttribs.allowMovingItems = NO;
    batterySelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    batterySelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap edit to add batteries"];
    
    
    //add an "Add New" element to appear when user clicks edit
    batterySelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Tap here to add new battery"];
    
    //add the selection attributes to the property definition
    batteryPropertyDef.attributes = batterySelectionAttribs;
    

    //create a property definition
    SCPropertyDefinition *batteryPublisherPropertyDef = [batteryDef propertyDefinitionWithName:@"publisher"];
    
    
    
   //set the property definition Publisher to objects selection
	
    batteryPublisherPropertyDef.type = SCPropertyTypeObjectSelection;
    //add the selection attributes to the property definition
    batteryPublisherPropertyDef.attributes = instrumentPublisherSelectionAttribs;
        
    
    //create a property definition
    SCPropertyDefinition *batteryInstrumentsPropertyDef = [batteryDef propertyDefinitionWithName:@"instruments"];
    
    batteryInstrumentsPropertyDef.type=SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *batteryInstrumentsSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:instrumentDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:YES];
    batteryInstrumentsSelectionAttribs.allowAddingItems = YES;
    batteryInstrumentsSelectionAttribs.allowDeletingItems = YES;
    batteryInstrumentsSelectionAttribs.allowMovingItems = YES;
    batteryInstrumentsSelectionAttribs.allowEditingItems = YES;
    batteryInstrumentsSelectionAttribs.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add New Instrument"];
    batteryInstrumentsSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Instruments)"];
    batteryInstrumentsPropertyDef.attributes=batteryInstrumentsSelectionAttribs;
    
    SCPropertyDefinition *existingBatteryNotesPropertyDef = [existingBatteryDef propertyDefinitionWithName:@"notes"];
    existingBatteryNotesPropertyDef.type=SCPropertyTypeTextView;
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *batteryNotesPropertyDef = [batteryDef propertyDefinitionWithName:@"notes"];
    batteryNotesPropertyDef.type=SCPropertyTypeTextView;
    
    //Create a class definition for the other psychotherapyEntity
    SCEntityDefinition *interventionDef = [SCEntityDefinition definitionWithEntityName:@"ExistingInterventionEntity"
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects: @"interventionType"  ,@"interventionSubType", @"models",@"demographics",@"notes",@"monthlyLogNotes", nil]];
    
    
    
    SCPropertyDefinition *interventionMonthlyLogNotes=[interventionDef propertyDefinitionWithName:@"monthlyLogNotes"];
   interventionMonthlyLogNotes.type=SCPropertyTypeTextView;
    

    //create the custom property definition
    SCCustomPropertyDefinition *interventionHoursDataProperty = [SCCustomPropertyDefinition definitionWithName:@"interventionHoursData"
                                                                                            uiElementNibName:@"TotalHoursAndMinutesCell" objectBindings:hoursDataBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    interventionHoursDataProperty.autoValidate=FALSE;
    
    
    [interventionDef insertPropertyDefinition:interventionHoursDataProperty atIndex:2];


    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    interventionDef.titlePropertyName=@"interventionType.interventionType;interventionSubType.interventionSubType;hours";
    interventionDef.titlePropertyNameDelimiter=@" - ";
    
    //create an array of objects definition for the other psychotherapy to-many relationship that with show up in a different view  without a place holder element>.
    
    //Create the property definition for the other property
    SCPropertyDefinition *directInterventionPropertyDef = [existingHoursDef propertyDefinitionWithName:@"directInterventions"];
    
//    directInterventionPropertyDef.title=@"Direct Intervention Types";
    directInterventionPropertyDef.type=SCPropertyTypeArrayOfObjects;
    directInterventionPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:interventionDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap + to add direct interventions"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
   
    
    
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *interventionDemPropertyDef = [interventionDef propertyDefinitionWithName:@"demographics"];
    
    interventionDemPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:demographicsDef
                                                                                         allowAddingItems:NO
                                                                                       allowDeletingItems:NO
                                                                                         allowMovingItems:NO];
    

    
    //Create a class definition for the ExistingOtherInterventionType Entity
    SCEntityDefinition *interventionTypeDef = [SCEntityDefinition definitionWithEntityName:@"InterventionTypeEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"interventionType",@"subTypes",@"notes",   nil]];
    
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    //create an object selection for the intervention Type relationship in the ExistingOtherInterventionTypeEntity Entity 
    
    //create a property definition
    SCPropertyDefinition *interventionTypePropertyDef = [interventionDef propertyDefinitionWithName:@"interventionType"];
    
        
    //set the title property name
    interventionTypeDef.titlePropertyName=@"interventionType";
    interventionTypePropertyDef.autoValidate=NO;
    //set the property definition type to objects selection
	
    interventionTypePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *interventionTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:interventionTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    interventionTypeSelectionAttribs.allowAddingItems = YES;
    interventionTypeSelectionAttribs.allowDeletingItems = YES;
    interventionTypeSelectionAttribs.allowMovingItems = YES;
    interventionTypeSelectionAttribs.allowEditingItems = YES;
    

    //add an "Add New" element to appear when user clicks edit
    interventionTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new interveniton type"];
    
    //add an "Add New" element to appear when user clicks edit
    interventionTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap edit to add a new interveniton type"];
    
    //add the selection attributes to the property definition
    interventionTypePropertyDef.attributes = interventionTypeSelectionAttribs;
    
    interventionTypeDef.orderAttributeName=@"order";
    
    SCPropertyDefinition *interventionNotesPropertyDef = [interventionDef propertyDefinitionWithName:@"notes"];
    interventionNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *interventionTypeNotesPropertyDef = [interventionTypeDef propertyDefinitionWithName:@"notes"];
    interventionTypeNotesPropertyDef.type=SCPropertyTypeTextView;

    
  
        
        
        NSString * interventionSubTypePropertyNameString=@"interventionSubType";
        NSString * interventionSubTypeEntityNameString=@"InterventionTypeSubtypeEntity";
        
        SCEntityDefinition *interventionSubTypeDef=[SCEntityDefinition definitionWithEntityName:interventionSubTypeEntityNameString managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:interventionSubTypePropertyNameString, @"notes", nil]];
        
        
        
        
        interventionSubTypeDef.orderAttributeName=@"order";
        
        
        
        SCPropertyDefinition *interventionSubTypePropertyDef=[interventionDef propertyDefinitionWithName:@"interventionSubType"];
    
    interventionSubTypePropertyDef.autoValidate=NO;
        interventionSubTypePropertyDef.type =SCPropertyTypeObjectSelection;
        
        SCObjectSelectionAttributes *interventionSubTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:interventionSubTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
        interventionSubTypeSelectionAttribs.allowAddingItems = NO;
        interventionSubTypeSelectionAttribs.allowDeletingItems = NO;
        interventionSubTypeSelectionAttribs.allowMovingItems = YES;
        interventionSubTypeSelectionAttribs.allowEditingItems = YES;
        interventionSubTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add subtypes under intervention type)"];
        
        interventionSubTypePropertyDef.attributes = interventionSubTypeSelectionAttribs;
        
        SCPropertyDefinition *interventionSubTypeStrPropertyDef=[interventionSubTypeDef propertyDefinitionWithName:interventionSubTypePropertyNameString];
        interventionSubTypeStrPropertyDef.type=SCPropertyTypeTextView;
        SCPropertyDefinition *interventionSubTypeNotesPropertyDef=[interventionSubTypeDef propertyDefinitionWithName:@"notes"];
        interventionSubTypeNotesPropertyDef.type=SCPropertyTypeTextView;
        
        
        
//        SCPropertyDefinition *interventionTypeSubtypePropertyDef=[SCPropertyDefinition definitionWithName:@"subTypes" title:@"Subtypes" type:SCPropertyTypeArrayOfObjects];
    
        
    SCPropertyDefinition *interventionTypeSubtypePropertyDef=[interventionTypeDef propertyDefinitionWithName:@"subTypes"];
    interventionTypeSubtypePropertyDef.type=SCPropertyTypeArrayOfObjects;
    interventionSubTypeStrPropertyDef.title=@"Selectable SubTypes";
        interventionTypeSubtypePropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:interventionSubTypeDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add new intervention subtype"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];
        
        
        [interventionTypeDef insertPropertyDefinition:interventionTypeSubtypePropertyDef atIndex:1];
        
        
        
   

    
    
    
    
    
    
    
    
    
    
    //Create a class definition for the intervention ModelEntity
    SCEntityDefinition *interventionModelDef = [SCEntityDefinition definitionWithEntityName:@"InterventionModelEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects: @"modelName",@"acronym",  @"evidenceBased",@"notes" , nil]];
    
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    //create an object selection for the models relationship in the Intervention Model Entity 
    
    //create a property definition
    SCPropertyDefinition *interventionModelsPropertyDef = [interventionDef propertyDefinitionWithName:@"models"];
    
        //set the title property name
    interventionModelDef.titlePropertyName=@"modelName;acronym";
    interventionModelDef.titlePropertyNameDelimiter=@" - ";
    //set the property definition type to objects selection
	
    interventionModelsPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *interventionModelsSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:interventionModelDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:YES];
    
    //set some addtional attributes
    interventionModelsSelectionAttribs.allowAddingItems = YES;
    interventionModelsSelectionAttribs.allowDeletingItems = YES;
    interventionModelsSelectionAttribs.allowMovingItems = YES;
    interventionModelsSelectionAttribs.allowEditingItems = YES;
    
      
    //add an "Add New" element to appear when user clicks edit
    interventionModelsSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap Edit to add new intervention model"];
    
    //add an "Add New" element to appear when user clicks edit
    interventionModelsSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Tap here to add new intervention model"];
    
    //add the selection attributes to the property definition
    interventionModelsPropertyDef.attributes = interventionModelsSelectionAttribs;
    SCPropertyDefinition *interventionModelNotesPropertyDef = [interventionModelDef propertyDefinitionWithName:@"notes"];
    interventionModelNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    objectsModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView entityDefinition:existingHoursDef];
    
    

   
    if(![SCUtilities is_iPad]){
        
        objectsModel.theme=[SCTheme themeWithPath:@"mapper-iPhone.ptt"];
       
       
        
        
    }else {
        objectsModel.theme=[SCTheme themeWithPath:@"mapper-ipad-full.ptt"];
      
       
        
    }
    
    
    
    if([SCUtilities is_iPad]||[SCUtilities systemVersion]>=6){
        
        self.tableView.backgroundView=nil;
        UIView *newView=[[UIView alloc]init];
        [self.tableView setBackgroundView:newView];
        
        
    }
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
   
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;

    self.view.backgroundColor=[UIColor clearColor];
    
    
    objectsModel.allowMovingItems=TRUE;
    
    objectsModel.autoAssignDelegateForDetailModels=TRUE;
    objectsModel.autoAssignDataSourceForDetailModels=TRUE;
    

    
    objectsModel.enablePullToRefresh = YES;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    
    
    
    
    self.tableViewModel=objectsModel;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


-(SCCustomCell *)tableViewModel:(SCTableViewModel *)tableModel cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCCustomCell *actionOverviewCell=nil; 
    if (tableModel.tag==0) {
    
        actionOverviewCell  = [SCCustomCell cellWithText:nil objectBindings:nil nibName:@"ExistingHoursOverviewCell"];
    
    }
    
    
    return actionOverviewCell;

}
//-(void)cancelButtonTapped{
//    
//    
//    
//    
//    
//    if(self.navigationController)
//	{
//		// check if self is the rootViewController
//		if([self.navigationController.viewControllers objectAtIndex:0] == self)
//		{
//			[self dismissModalViewControllerAnimated:YES];
//		}
//		else
//			[self.navigationController popViewControllerAnimated:YES];
//	}
//	else
//		[self dismissModalViewControllerAnimated:YES];
//    
//    
//}

-(BOOL)tableViewModel:(SCTableViewModel *)tableViewModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath{
BOOL valid=NO;
    SCTableViewCell *cell=[tableViewModel cellAtIndexPath:indexPath];
    
    
    if (tableViewModel.tag==1) {
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        
        
        if ([cell isKindOfClass:[ClinicianSelectionCell class]]) {
            ClinicianSelectionCell *clinicianSelectionCell=(ClinicianSelectionCell *)cell;
            
            if (!clinicianSelectionCell.clinicianObject) {
                return valid;
            }
            else {
                valid=YES;
                return valid;
            }
            
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
            
            
            
            
       
        

        
        
        
        
        
        
        if ([cell isKindOfClass:[SCDateCell class]]) {
            SCDateCell *dateCell=(SCDateCell *)cell;
            
            SCTableViewCell *otherCell=nil;
            SCDateCell *otherDateCell=nil;
            NSDate *startDate=nil;
            NSDate *endDate=nil;
            SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
            
            
            ClinicianSelectionCell *clinicianSelectionCell=(ClinicianSelectionCell *)[section cellAtIndex:0];
            ClinicianEntity *clinician=nil;
            
            
                        
            if (clinicianSelectionCell.clinicianObject) {
                
                clinician=clinicianSelectionCell.clinicianObject;
            }
            
            if ( cell.tag==3) {
                
            
                otherCell=(SCTableViewCell *)[tableViewModel cellAfterCell:dateCell rewind:NO];
            
                
            }
            else if (cell.tag==4){
                SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
                otherCell=(SCTableViewCell *)[section cellAtIndex:3];
            
                
            }
            
            if ([otherCell isKindOfClass:[SCDateCell class]]) {
                otherDateCell=(SCDateCell *) otherCell;
            }
           
            if (cell.tag==3) {
                startDate=dateCell.datePicker.date;
                endDate=otherDateCell.datePicker.date;
            } else if (cell.tag==4) {
                startDate=otherDateCell.datePicker.date;
                endDate=dateCell.datePicker.date;
            }
            
            
            if (startDate && endDate) {
            
            if ( ([startDate compare:endDate]) == NSOrderedDescending ) {
                [appDelegate displayNotification:@"Invalid: The start date is after the end date" forDuration:kPTTScreenLocationTop location:kPTTScreenLocationTop inView:appDelegate.window];
                return NO;
            }else if ([startDate isEqualToDate:endDate]) {
                [appDelegate displayNotification:@"Invalid: Start date is the same as the end date" forDuration:kPTTScreenLocationTop location:kPTTScreenLocationTop inView:appDelegate.window];
                return NO;
            }
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"ExistingHoursEntity" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
                NSPredicate *predicate=nil;
//                if (clinician) {
//                    predicate = [NSPredicate predicateWithFormat:@"(self.supervisor != nil AND self.supervisor.objectID== %@ AND (startDate >= %@) AND (endDate <= %@)) OR ((startDate < %@) AND ((endDate < %@ )AND (endDate > %@) )) OR ((startDate < %@) AND (endDate > %@)   )", clinician.objectID, startDate, endDate, startDate, endDate,startDate, startDate,endDate];
//                }
//                else {
                ExistingHoursEntity *existingHoursObject=nil;
                if ([cell.boundObject isKindOfClass:[ExistingHoursEntity class]]) {
                 existingHoursObject=(ExistingHoursEntity *)cell.boundObject;
                    
                    //                }
                }
                    
                predicate = [NSPredicate predicateWithFormat:@"((startDate >= %@) AND (endDate <= %@)) OR ((startDate < %@) AND ((endDate < %@ )AND (endDate > %@) )) OR ((startDate < %@) AND (endDate > %@)   )",  startDate, endDate, startDate, endDate,startDate, startDate,endDate];
                [fetchRequest setPredicate:predicate];
                
                
            
            NSError *error = nil;
            NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
            
                
                if (clinician &&fetchedObjects.count) {
                    NSPredicate *clinicianFilter=[NSPredicate predicateWithFormat:@"self.supervisor.objectID == %@ and self.objectID != %@",clinician.objectID, existingHoursObject.objectID];
                    
                    fetchedObjects=[fetchedObjects filteredArrayUsingPredicate:clinicianFilter];
                    
                }
                if (!fetchedObjects.count) {
                
                valid=YES;
            }
            else {
               
                if (clinician) {
                    [appDelegate displayNotification:@"Existing hours already defined for this date range and supervisor." forDuration:kPTTScreenLocationTop location:kPTTScreenLocationTop inView:appDelegate.window];

                }else {
                     [appDelegate displayNotification:@"Existing hours already defined for this date range" forDuration:kPTTScreenLocationTop location:kPTTScreenLocationTop inView:appDelegate.window];
                }
                   
              
                
            }

                fetchRequest=nil;
            }   
    
            
        }
        
        
        if ([cell isKindOfClass:[SCTextViewCell class]]) {
            valid=YES;
            
            
        }


        
        
        
        
    }
    
    if ([cell isKindOfClass:[SCNumericTextFieldCell class]]) {
        SCNumericTextFieldCell *numericCell=(SCNumericTextFieldCell *)cell;
        
        
        
        NSNumberFormatter *numberFormatter =[[NSNumberFormatter alloc] init];
        NSString *numberStr=[numericCell.textField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
        NSNumber *number=[numberFormatter numberFromString:numberStr];
        if (numberStr.length && [numberStr floatValue]<1000000 &&number) {
            valid=YES;
            
            if ([numericCell.textLabel.text rangeOfString:@"Number"].location != NSNotFound) {
                NSScanner* scan = [NSScanner scannerWithString:numberStr]; 
                int val;         
                
                valid=[scan scanInt:&val] && [scan isAtEnd];
                
                
            }
            
            
        } 
        
        
        
        numberFormatter=nil;
        
       
        
       
    }
    
    
    if (tableViewModel.tag==3&&(cell.tag==0||cell.tag==1)) {
    
        
        if([cell isKindOfClass:[SCObjectSelectionCell class]]){
        
            SCObjectSelectionCell *selectionCell=(SCObjectSelectionCell *)cell;
            if (![selectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]] ) {
                valid=YES;
            }
            
        
        
        
        }
        if([cell isKindOfClass:[TotalHoursAndMinutesCell class]]){
        
            TotalHoursAndMinutesCell *totalHoursAndMinutesCell=(TotalHoursAndMinutesCell *)cell;
//            UIBarButtonItem *doneButton=(UIBarButtonItem *)objectsModel.commitButton;
            
            valid=[totalHoursAndMinutesCell valueIsValid];
        }
    }
    
    
       
    return valid;



}

- (void)tableViewModel:(SCTableViewModel *)tableViewModel didLayoutSubviewsForCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[SCNumericTextFieldCell class]])
    {
        SCNumericTextFieldCell *numericCell=(SCNumericTextFieldCell *)cell;
        
        
        [numericCell.textLabel sizeToFit];
        numericCell.textField.textAlignment=UITextAlignmentRight;
        numericCell.textField.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin ;
//       CGRect textFieldFrame=numericCell.textField.textInputView.frame;
//        textFieldFrame.size.width=50;
     
    
    }
}


//-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
//
//    [self tableViewModel:tableViewModel detailModelCreatedForSectionAtIndex:indexPath.section detailTableViewModel:detailTableViewModel];
//
//}
-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillDismissForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableModel.tag==2) {
        selectedInterventionType=nil;
        selectedSupervisionType=nil;
    }





}

-(void)tableViewModel:(SCTableViewModel *)tableModel willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableModel.tag==0) {
        NSManagedObject *managedObject=(NSManagedObject *)cell.boundObject;
            if (managedObject) {
                
                
                SCTableViewSection *section=(SCTableViewSection *)[objectsModel sectionAtIndex:indexPath.section];
                //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
                if (managedObject && [managedObject respondsToSelector:@selector(entity)]&&![section isKindOfClass:[SCArrayOfStringsSection class]]) {
        
                    
                    ClinicianEntity *supervisor=(ClinicianEntity *)[managedObject valueForKeyPath:@"supervisor"];
                    
                    
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        //set the date format
        [dateFormatter setDateFormat:@"M/d/yyyy"];
        
        NSDate *startDate=[managedObject valueForKey:@"startDate"];
        NSDate *endDate=[managedObject valueForKey:@"endDate"];
        
        //                NSString *notes=[managedObject valueForKey:@"notes"];
        
        NSMutableSet *assessmentHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"assessments.hours"];
        
        NSArray *assessmentHoursArray=[assessmentHoursSet allObjects];
        
        NSString *assessmentTotalTimeStr=[NSString stringWithFormat:@"%@ Assessment",[self totalTimeStrForHoursArray:assessmentHoursArray]];
        
        
        NSMutableSet *interventionHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"directInterventions.hours"];
        
        NSArray *interventionHoursArray=[interventionHoursSet allObjects];
        NSString *InterventionTotalTimeStr=[NSString stringWithFormat:@"%@ Intervention",[self totalTimeStrForHoursArray:interventionHoursArray]];
        
        
        
        NSMutableSet *supportHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"supportActivities.hours"];
        
        NSArray *supportHoursArray=[supportHoursSet allObjects];
        
        NSString *supportTotalTimeStr=[NSString stringWithFormat:@"%@ Support",[self totalTimeStrForHoursArray:supportHoursArray]];
        
        
        
        
        
        
        
        NSMutableSet *supervisionReceivedHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"supervisionReceived.hours"];
        
        NSArray *supervisionReceivedHoursArray=[supervisionReceivedHoursSet allObjects];
        
        NSString *supervisionReceivedTotalTimeStr=[NSString stringWithFormat:@"%@ Supervision %@",[self totalTimeStrForHoursArray:supervisionReceivedHoursArray],([SCUtilities is_iPad])?@"Received":@"R"];
        
        
        NSMutableSet *supervisionGivenHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"supervisionGiven.hours"];
        
        NSArray *supervisionGivenHoursArray=[supervisionGivenHoursSet allObjects];
        
        NSString *supervisionGivenTotalTimeStr=[NSString stringWithFormat:@"%@ Supervision %@",[self totalTimeStrForHoursArray:supervisionGivenHoursArray],([SCUtilities is_iPad])?@"Given":@"G"];
        
        
        
        
        
        NSString * dateString=[NSString stringWithFormat:@"%@ (%@ - %@) ",supervisor.combinedName,[dateFormatter stringFromDate:startDate],[dateFormatter stringFromDate:endDate]];
        
        UILabel *datesLabel=(UILabel *)[cell viewWithTag:71];
        datesLabel.text=dateString;
        
        UILabel *interventionLabel=(UILabel *)[cell viewWithTag:72];
        interventionLabel.text=InterventionTotalTimeStr;
        
        UILabel *assessmentLabel=(UILabel *)[cell viewWithTag:73];
        assessmentLabel.text=assessmentTotalTimeStr;
        
        UILabel *supportLabel=(UILabel *)[cell viewWithTag:75];
        supportLabel.text=supportTotalTimeStr;
        
        UILabel *supervisionReceivedLabel=(UILabel *)[cell viewWithTag:74];
        supervisionReceivedLabel.text=supervisionReceivedTotalTimeStr;
        
        UILabel *supervisionGivenLabel=(UILabel *)[cell viewWithTag:77];
        supervisionGivenLabel.text=supervisionGivenTotalTimeStr;
        
        //            if (![SCUtilities is_iPad]) {
        //                UIFont *smallerFont=[UIFont systemFontOfSize:15];
        //                supervisionGivenLabel.font=smallerFont;
        //                supervisionReceivedLabel.font=smallerFont;
        //            }
        UILabel *totalLabel=(UILabel *)[cell viewWithTag:76];
        NSTimeInterval directHoursTimeInterval=[self totalTimeTIForHoursArray:interventionHoursArray]+[self totalTimeTIForHoursArray:assessmentHoursArray];
       
                    NSInteger totalDirectMinutes=[self totalMinutes:directHoursTimeInterval];
        NSString *directMinutesStr=[self totalMinutesStrFromMinutesInteger:totalDirectMinutes];
                    
        totalLabel.text=[NSString stringWithFormat:@"%i:%@ Total Direct",[self totalHours:directHoursTimeInterval],directMinutesStr];
        
        
        //                cell.textLabel.text=[NSString stringWithFormat:@"%@ - %@; %@ hrs Assessment; %@ hrs Intervention",[dateFormatter stringFromDate:startDate],[dateFormatter stringFromDate:endDate],assessmentSum, interventionSum];
        
        //don't change this to @"" because it causes a bug with the back button
        cell.textLabel.text=nil;
                    dateFormatter=nil;
                    
    }}
    }
    
    if (tableModel.tag==1) {
        if ([cell isKindOfClass:[ClinicianSelectionCell class]]) {
            ClinicianSelectionCell *clinicianSelectionCell=(ClinicianSelectionCell *)cell;
            
            if (clinicianSelectionCell.clinicianObject ) {
                ClinicianEntity *supervisorSelected=(ClinicianEntity *)clinicianSelectionCell.clinicianObject;
                if ([supervisorSelected.myInformation isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                    clinicianSelectionCell.label.text=@"Self";
                }
            }
            
        }
        
    }
    
    
    if (tableModel.tag==2) {
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        if (cellManagedObject&& [cellManagedObject respondsToSelector:@selector(entity)]) {
            
            if ([cellManagedObject.entity.name isEqualToString:@"ExistingInterventionEntity"]) {
                NSString *interventionType= [cellManagedObject valueForKeyPath:@"interventionType.interventionType"];
                
                NSString *interventionSubType=[cellManagedObject valueForKeyPath:@"interventionSubType.interventionSubType"];
                
                NSDate *hours=[cellManagedObject valueForKey:@"hours"];
                
                NSString *hoursStr=[self totalTimeStrFromHoursDate:hours];
                
                cell.textLabel.text=[NSString stringWithFormat:@"%@ - %@ - %@",interventionType,interventionSubType,hoursStr];
                
                
                
            }
            if ([cellManagedObject.entity.name isEqualToString:@"ExistingAssessmentEntity"]) {
                NSString *assessmentType= [cellManagedObject valueForKeyPath:@"assessmentType.assessmentType"];
                
                
                NSDate *hours=[cellManagedObject valueForKey:@"hours"];
                
                NSString *hoursStr=[self totalTimeStrFromHoursDate:hours];
                
                cell.textLabel.text=[NSString stringWithFormat:@"%@ - %@",assessmentType,hoursStr];
                
                
                
            }
            if ([cellManagedObject.entity.name isEqualToString:@"ExistingSupportActivityEntity"]) {
                NSString *type= [cellManagedObject valueForKeyPath:@"supportActivityType.supportActivityType"];
                
                
                NSDate *hours=[cellManagedObject valueForKey:@"hours"];
                
                NSString *hoursStr=[self totalTimeStrFromHoursDate:hours];
                
                cell.textLabel.text=[NSString stringWithFormat:@"%@ - %@",type,hoursStr];
                
                
                
            }
            if ([cellManagedObject.entity.name isEqualToString:@"ExistingSupervisionGivenEntity"]||[cellManagedObject.entity.name isEqualToString:@"ExistingSupervisionReceivedEntity"]) {
                NSString *type= [cellManagedObject valueForKeyPath:@"supervisionType.supervisionType"];
                
                NSString *subType= [cellManagedObject valueForKeyPath:@"subType.subType"];
                
                NSDate *hours=[cellManagedObject valueForKey:@"hours"];
                
                NSString *hoursStr=[self totalTimeStrFromHoursDate:hours];
                
               
                 cell.textLabel.text=[NSString stringWithFormat:@"%@ - %@ - %@",type,subType,hoursStr];
                
                
            }
            
            
        }
        
        
        
    }






}
-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

   
    if ([SCUtilities is_iPad]||[SCUtilities systemVersion]>=6) {
        //        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        UIColor *backgroundColor=nil;
        
        if(indexPath.row==NSNotFound|| tableModel.tag>0)
        {
//            backgroundImage=[UIImage imageNamed:@"iPad-background-blue.png"];
            backgroundColor=(UIColor *)(UIWindow *)appDelegate.window.backgroundColor;
            
            
            
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
    
    
    
    if ( detailTableViewModel.tag==3&& detailTableViewModel.sectionCount>0) {
        
        SCTableViewSection *section=(SCTableViewSection *)[detailTableViewModel sectionAtIndex:0];
        
        
        
        if ([section isKindOfClass:[SCObjectSection class]]){
            
            SCObjectSection *objectSection=(SCObjectSection *)section;
            
            
            NSManagedObject *sectionManagedObject=(NSManagedObject *)objectSection.boundObject;
            
            
            
            
            if (sectionManagedObject&&[sectionManagedObject respondsToSelector:@selector(entity)]&&[sectionManagedObject.entity.name isEqualToString:@"ExistingInterventionEntity"]&&objectSection.cellCount>1) {
                
                SCTableViewCell *cellAtOne=(SCTableViewCell *)[objectSection cellAtIndex:1];
                if ([cellAtOne isKindOfClass:[SCObjectSelectionCell class]]) {
                    SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cellAtOne;
                    
                    
                    
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
            
            
        
            
           else if (sectionManagedObject&&[sectionManagedObject respondsToSelector:@selector(entity)]&&([sectionManagedObject.entity.name isEqualToString:@"ExistingSupervisionReceivedEntity"]||[sectionManagedObject.entity.name isEqualToString:@"ExistingSupervisionGivenEntity"])&&objectSection.cellCount>1) {
                
                SCTableViewCell *cellAtFour=(SCTableViewCell *)[objectSection cellAtIndex:1];
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
                            
                            SCDataFetchOptions *dataFetchOptions=[SCDataFetchOptions optionsWithSortKey:@"subType" sortAscending:YES filterPredicate:predicate];
                            
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

    
    

}
-(void)tableViewModel:(SCTableViewModel *)tableModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath{

    //begin
    
    
   
    
    if (tableModel.tag==3) {
        
        SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
       NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
    
    
        
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]) {
       
    if ([cellManagedObject.entity.name isEqualToString:@"ExistingInterventionEntity"] && [cell isKindOfClass:[SCObjectSelectionCell class]]&& cell.tag==0) {
        
        SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cell;
        
        
        if ([objectSelectionCell.selectedItemIndex intValue]>-1) {
            NSManagedObject *selectedInterventionTypeManagedObject =[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];
            if ([selectedInterventionTypeManagedObject isKindOfClass:[InterventionTypeEntity class]]) {
                selectedInterventionType=(InterventionTypeEntity *) selectedInterventionTypeManagedObject;
                
                
                
                SCTableViewCell *subtypeCell=(SCTableViewCell *)[tableModel cellAfterCell:objectSelectionCell rewind:NO];
                
                if ([subtypeCell isKindOfClass:[SCObjectSelectionCell class]]) {
                    
                    
                    SCObjectSelectionCell *subytypeObjectSelectionCell=(SCObjectSelectionCell *)subtypeCell;
                    
                    if (selectedInterventionType.interventionType.length) {
                        
                        subytypeObjectSelectionCell.userInteractionEnabled=YES;
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                  @"interventionType.interventionType like %@",[NSString stringWithString:(NSString *) selectedInterventionType.interventionType]]; 
                        
                        SCDataFetchOptions *dataFetchOptions=[SCDataFetchOptions optionsWithSortKey:@"interventionSubType" sortAscending:YES filterPredicate:predicate];
                        
                        subytypeObjectSelectionCell.selectionItemsFetchOptions=dataFetchOptions;
                        
                        [subytypeObjectSelectionCell reloadBoundValue];
                        
                        
                    }
                    else {
                        subytypeObjectSelectionCell.userInteractionEnabled=NO;
                    }
                }
                
                
            }
            
            
            
            
            
            
            
            
        }
            
        

    } 
        
        if (([cellManagedObject.entity.name isEqualToString:@"ExistingSupervisionReceivedEntity"]||[cellManagedObject.entity.name isEqualToString:@"ExistingSupervisionGivenEntity"] )&& [cell isKindOfClass:[SCObjectSelectionCell class]]&& cell.tag==0) {
            
            SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cell;
            
            
            if ([objectSelectionCell.selectedItemIndex intValue]>-1) {
                NSManagedObject *selectedSupervisionTypeManagedObject =[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];
                if ([selectedSupervisionTypeManagedObject isKindOfClass:[SupervisionTypeEntity class]]) {
                    selectedSupervisionType=(SupervisionTypeEntity *) selectedSupervisionTypeManagedObject;
                    
                    
                    
                    SCTableViewCell *subtypeCell=(SCTableViewCell *)[tableModel cellAfterCell:objectSelectionCell rewind:NO];
                    
                    if ([subtypeCell isKindOfClass:[SCObjectSelectionCell class]]) {
                        
                        
                        SCObjectSelectionCell *subytypeObjectSelectionCell=(SCObjectSelectionCell *)subtypeCell;
                        
                        if (selectedSupervisionType.supervisionType.length) {
                           
                            subytypeObjectSelectionCell.userInteractionEnabled=YES;
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                      @"supervisionType.supervisionType like %@",[NSString stringWithString:(NSString *) selectedSupervisionType.supervisionType]]; 
                            
                            SCDataFetchOptions *dataFetchOptions=[SCDataFetchOptions optionsWithSortKey:@"subType" sortAscending:YES filterPredicate:predicate];
                            
                            subytypeObjectSelectionCell.selectionItemsFetchOptions=dataFetchOptions;
                            
                            [subytypeObjectSelectionCell reloadBoundValue];
                            
                            
                        }
                        else {
                            subytypeObjectSelectionCell.userInteractionEnabled=NO;
                        }
                        
                    }
                    
                    
                }
                
                
                
                
            }  
            
            
            
        }  
    }
    
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        if ([cellManagedObject.entity.name isEqualToString:@"TrainingProgramEntity"]) {
            if (cell.tag==7) {
                
                
                
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
                trainingProgramFetchRequest=nil;
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
                siteFetchRequest=nil;
            }
        }

        
        
    }
    
    
    //end



}

//-(void)tableViewModel:(SCTableViewModel *)tableModel willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//   
//    
//    if (tableModel.tag==0) {
//        NSManagedObject *managedObject=(NSManagedObject *)cell.boundObject;
//        if (managedObject) {
//        
//        
//        SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:indexPath.section];
//        //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
//        if (managedObject && [managedObject respondsToSelector:@selector(entity)]&&![section isKindOfClass:[SCArrayOfStringsSection class]]) {
//            
//            
//            //identify the Languages Spoken table
//            if ([managedObject.entity.name isEqualToString:@"ExistingHoursEntity"]) {
//                //define and initialize a date formatter
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                
//                //set the date format
//                [dateFormatter setDateFormat:@"M/d/yyyy"];
//                
//                NSDate *startDate=[managedObject valueForKey:@"startDate"];
//                NSDate *endDate=[managedObject valueForKey:@"endDate"];
//                
////                NSString *notes=[managedObject valueForKey:@"notes"];
//                
//                NSMutableSet *assessmentHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"assessments.hours"];
//                
//                NSArray *assessmentHoursArray=[assessmentHoursSet allObjects];
//                
//                NSString *assessmentTotalTimeStr=[NSString stringWithFormat:@"%@ Assessment",[self totalTimeStrForHoursArray:assessmentHoursArray]];
//                
//                
//                NSMutableSet *interventionHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"directInterventions.hours"];
//                
//                NSArray *interventionHoursArray=[interventionHoursSet allObjects];
//                NSString *InterventionTotalTimeStr=[NSString stringWithFormat:@"%@ Intervention",[self totalTimeStrForHoursArray:interventionHoursArray]];
//            
//               
//
//                NSMutableSet *supportHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"supportActivities.hours"];
//                
//                NSArray *supportHoursArray=[supportHoursSet allObjects];
//                
//                NSString *supportTotalTimeStr=[NSString stringWithFormat:@"%@ Support",[self totalTimeStrForHoursArray:supportHoursArray]];
//                
//                
//                
//                                     
//                
//                
//                
//                  NSMutableSet *supervisionReceivedHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"supervisionReceived.hours"];
//                
//                NSArray *supervisionReceivedHoursArray=[supervisionReceivedHoursSet allObjects];
//                
//                NSString *supervisionReceivedTotalTimeStr=[NSString stringWithFormat:@"%@ Supervision Received",[self totalTimeStrForHoursArray:supervisionReceivedHoursArray]];
//
//               
//                NSMutableSet *supervisionGivenHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"supervisionGiven.hours"];
//                               
//                NSArray *supervisionGivenHoursArray=[supervisionGivenHoursSet allObjects];
//               
//                NSString *supervisionGivenTotalTimeStr=[NSString stringWithFormat:@"%@ Supervision Given",[self totalTimeStrForHoursArray:supervisionGivenHoursArray]];
//                
//
//                
//                
//                
//              NSString * dateString=[[dateFormatter stringFromDate:startDate] stringByAppendingFormat:@" - %@",[dateFormatter stringFromDate:endDate]];
//                
//                UILabel *datesLabel=(UILabel *)[cell viewWithTag:71];
//                datesLabel.text=dateString;
//                
//                UILabel *interventionLabel=(UILabel *)[cell viewWithTag:72];
//                interventionLabel.text=InterventionTotalTimeStr;
//                
//                UILabel *assessmentLabel=(UILabel *)[cell viewWithTag:73];
//                assessmentLabel.text=assessmentTotalTimeStr;
//                
//                 UILabel *supportLabel=(UILabel *)[cell viewWithTag:75];
//                supportLabel.text=supportTotalTimeStr;
//                
//                UILabel *supervisionReceivedLabel=(UILabel *)[cell viewWithTag:74];
//                supervisionReceivedLabel.text=supervisionReceivedTotalTimeStr;
//                
//                UILabel *supervisionGivenLabel=(UILabel *)[cell viewWithTag:77];
//                supervisionGivenLabel.text=supervisionGivenTotalTimeStr;
//                
//                UILabel *totalLabel=(UILabel *)[cell viewWithTag:76];
//                NSTimeInterval directHoursTimeInterval=[self totalTimeTIForHoursArray:interventionHoursArray]+[self totalTimeTIForHoursArray:assessmentHoursArray];
//                totalLabel.text=[NSString stringWithFormat:@"%i:%i Total Direct",[self totalHours:directHoursTimeInterval],[self totalMinutes:directHoursTimeInterval]];
//                               
//                
////                cell.textLabel.text=[NSString stringWithFormat:@"%@ - %@; %@ hrs Assessment; %@ hrs Intervention",[dateFormatter stringFromDate:startDate],[dateFormatter stringFromDate:endDate],assessmentSum, interventionSum];
//                
//                 cell.textLabel.text=@"";
//                
//            }
//
//        }
//    }
//        
//}





//}
-(NSString * )totalTimeStrForHoursArray:(NSArray *)totalTimesArray{
    
    NSTimeInterval totalTime=0;
    if (totalTimesArray.count) {
        
        
        for (NSDate *totalTimeDateObject in totalTimesArray) {
            if (totalTimeDateObject&&[totalTimeDateObject isKindOfClass:[NSDate class]]) {
                
                totalTime=totalTime+[totalTimeDateObject timeIntervalSince1970];
                
                
                
            }
        }
        
        
        
        NSString *totalHoursStr=[NSString stringWithFormat:@"%i",[self totalHours:totalTime]];
        int totalMinutes=[self totalMinutes:totalTime];
        
        NSString *totalMinutesStr=[self totalMinutesStrFromMinutesInteger:totalMinutes];
        return [totalHoursStr stringByAppendingString:totalMinutesStr];

    }
    else {
        return @"0:00";
    }
   
    
}
-(NSString *)totalMinutesStrFromMinutesInteger:(NSInteger)totalMinutes{

    NSString *totalMinutesStr=nil;
    if (totalMinutes<10 && totalMinutes>=0 ) {
        totalMinutesStr=[NSString stringWithFormat:@":0%i",totalMinutes];
    }
    else if (totalMinutes>9){
        totalMinutesStr=[NSString stringWithFormat:@":%i",totalMinutes];
    }
    else {
        totalMinutesStr=@":00";
    }

    return totalMinutesStr;


}
-(NSString *)totalTimeStrFromHoursDate:(NSDate *)hours{


    NSString *totalTimeStr=nil;
    if (hours) {
        
        NSTimeInterval totalTI=[hours timeIntervalSince1970];
        int hoursInt=[self totalHours:totalTI];
        
        int minuteInt=[self totalMinutes:totalTI];
        if (minuteInt>9) {
            totalTimeStr=[NSString stringWithFormat:@"%i:%i",hoursInt,minuteInt];
        }
        else 
        {
            
            totalTimeStr=[NSString stringWithFormat:@"%i:0%i",hoursInt,minuteInt];
        }
        
        
    }
    else {
        totalTimeStr=@"0:00";
    }
    
    return totalTimeStr;



}
-(NSTimeInterval )totalTimeTIForHoursArray:(NSArray *)totalTimesArray{
    
    NSTimeInterval totalTime=0;
    if (totalTimesArray.count) {
        
        
        for (NSDate *totalTimeDateObject in totalTimesArray) {
            if (totalTimeDateObject&&[totalTimeDateObject isKindOfClass:[NSDate class]]) {
                
                totalTime=totalTime+[totalTimeDateObject timeIntervalSince1970];
                
                
                
            }
        }
        
        
        
               
    }
        
     return totalTime;
}


-(NSInteger )totalHours:(NSTimeInterval) totalTime{
    
    
    return totalTime/3600;
    
}

-(NSInteger )totalMinutes:(NSTimeInterval) totalTime{
    
    
    return round(((totalTime/3600) -[self totalHours:totalTime])*60);;
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableViewModel.tag==0) {
        CGRect cellFrame=cell.frame;
        cellFrame.size.height=100;
    }







}


@end
