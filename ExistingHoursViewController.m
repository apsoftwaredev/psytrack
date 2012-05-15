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
@interface ExistingHoursViewController ()

@end

@implementation ExistingHoursViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    
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
    
   
    
	// Get managedObjectContext from application delegate
   NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
	
    
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Existing Hours";
    

    SCEntityDefinition *existingHoursDef =[SCEntityDefinition definitionWithEntityName:@"ExistingHoursEntity"
                                                            managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"startDate", @"endDate", @"assessments", @"directInterventions", @"supervision",  @"supportActivities"     , @"notes",   nil]];        
    

                                          
                                          
    
    
    //Create the property definition for the start date property in the existing Hours class  definition
    SCPropertyDefinition *existingHoursStartDatePropertyDef = [existingHoursDef propertyDefinitionWithName:@"startDate"];
    
    //format the the date using a date formatter
    //define and initialize a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    //Set the date attributes in the existinghoursstartdate property definition and make it so the date picker appears in the same view.
    existingHoursStartDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                   datePickerMode:UIDatePickerModeDate
                                                    displayDatePickerInDetailView:NO];
    

    //Create the property definition for the endDate property in the existingHours class
    SCPropertyDefinition *existingHoursEndDatePropertyDef = [existingHoursDef propertyDefinitionWithName:@"endDate"];
    
    
    //Set the date attributes in the existinghours end date property definition and make it so the date picker appears in the same view.
    existingHoursEndDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                                  datePickerMode:UIDatePickerModeDate
                                                                   displayDatePickerInDetailView:NO];
    
    //Create the property definition for the notes property in the existing hours class
    SCPropertyDefinition *existingHoursNotesPropertyDef = [existingHoursDef propertyDefinitionWithName:@"notes"];
    existingHoursNotesPropertyDef.type=SCPropertyTypeCustom;
    existingHoursNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryProfileNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyString",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    existingHoursNotesPropertyDef.objectBindings=encryProfileNotesTVCellKeyBindingsDic;
    existingHoursNotesPropertyDef.title=@"Notes";
    existingHoursNotesPropertyDef.autoValidate=NO;
    
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
    
    
     

    
    //Create a class definition for the existingAssessmentEntity
    SCEntityDefinition *supervisionDef = [SCEntityDefinition definitionWithEntityName:@"ExistingSupervisionEntity" 
                                                                   managedObjectContext:managedObjectContext
                                                                          propertyNames:[NSArray arrayWithObjects:@"supervisionType",@"groupHours", @"individualHours",  @"notes",nil]];
    

    
    SCPropertyDefinition *supervisionGroupNumberPropertyDef = [supervisionDef propertyDefinitionWithName:@"groupHours"];
    
    
    supervisionGroupNumberPropertyDef.autoValidate=NO;
    
    SCPropertyDefinition *supervisionIndividualNumberPropertyDef = [supervisionDef propertyDefinitionWithName:@"individualHours"];
    
    
    supervisionIndividualNumberPropertyDef.autoValidate=NO;
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    //create an array of objects definition for the supervision to-many relationship that with show up in the same view without a place holder element>.
    
    //Create the property definition for the <#propertyName#> property
    SCPropertyDefinition *supervisionPropertyDef = [existingHoursDef propertyDefinitionWithName:@"supervision"];
    
//    supervisionPropertyDef.title=@"Supervision Types";
    supervisionPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:supervisionDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add supervison hours"]  addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add supervison hours"] addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
   
    
    //create an object selection for the supervisionType relationship in the Supervision Entity 
    
    
    //Create a class definition for the supervision TypeEntity
    SCEntityDefinition *supervisionTypeDef = [SCEntityDefinition definitionWithEntityName:@"SupervisionTypeEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"supervisionType", nil]];
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    //create a property definition
   
    SCPropertyDefinition *supervisionTypePropertyDef = [supervisionDef propertyDefinitionWithName:@"supervisionType"];
    
   
    //set the title property name
    supervisionDef.titlePropertyName=@"supervisionType.supervisionType;groupHours;individualHours";
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
    
   
      
    //create the dictionary with the data bindings
    NSDictionary *clinicianDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObjects:@"supervisors",@"Supervisors",[NSNumber numberWithBool:NO],@"supervisors",[NSNumber numberWithBool:YES],nil] 
                                           forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *clinicianDataProperty = [SCCustomPropertyDefinition definitionWithName:@"ClinicianData"
                                                                                    uiElementClass:[ClinicianSelectionCell class] objectBindings:clinicianDataBindings];
	

    
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    clinicianDataProperty.autoValidate=TRUE;
    
    
    //insert the custom property definition into the clientData class at index 
  
    [supervisionDef insertPropertyDefinition:clinicianDataProperty atIndex:1];
                        
    
    //Create a class definition for the existingAssessmentEntity
    SCEntityDefinition *supportActivityDef = [SCEntityDefinition definitionWithEntityName:@"ExistingSupportActivityEntity" 
                                                           managedObjectContext:managedObjectContext
                                                                  propertyNames:[NSArray arrayWithObjects:@"supportActivityType",@"hours",  @"notes",nil]];
    
    
    
    
    SCPropertyDefinition *supportActivityNumberPropertyDef = [supportActivityDef propertyDefinitionWithName:@"hours"];
    
    
    supportActivityNumberPropertyDef.autoValidate=NO;
    

    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    //create an array of objects definition for the supervision to-many relationship that with show up in the same view without a place holder element>.
    
    //Create the property definition for the supportActivity property
    SCPropertyDefinition *supportActivitiesPropertyDef = [existingHoursDef propertyDefinitionWithName:@"supportActivities"];
    supportActivitiesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:supportActivityDef
                                                                                       allowAddingItems:YES
                                                                                     allowDeletingItems:YES
                                                                                       allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add support activity hours"]  addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add support activity hours"] addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //create an object selection for the supervisionType relationship in the Supervision Entity 
    
    
    //Create a class definition for the supervision TypeEntity
    SCEntityDefinition *supportActivityTypeDef = [SCEntityDefinition definitionWithEntityName:@"SupportActivityTypeEntity" 
                                                               managedObjectContext:managedObjectContext
                                                                      propertyNames:[NSArray arrayWithObjects:@"supportActivityType", nil]];
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    //create a property definition
    
    SCPropertyDefinition *supportActivityTypePropertyDef = [supportActivityDef propertyDefinitionWithName:@"supportActivityType"];
    
    
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
    SCEntityDefinition *assessmentDef = [SCEntityDefinition definitionWithEntityName:@"ExisitingAssessmentEntity" 
                                                          managedObjectContext:managedObjectContext
                                                                 propertyNames:[NSArray arrayWithObjects:@"assessmentType",@"hours",@"instruments",@"batteries", @"demographics",@"notes",nil]];
    
    
    SCPropertyDefinition *assessmentNumberPropertyDef = [assessmentDef propertyDefinitionWithName:@"hours"];
    
    
    assessmentNumberPropertyDef.autoValidate=NO;
    
    


    //Create a class definition for the testingSessionTypeEntity
    SCEntityDefinition *testingSessionTypeDef = [SCEntityDefinition definitionWithEntityName:@"TestingSessionTypeEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"assessmentType", @"notes" , nil]];
    
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *assessmentsPropertyDef = [existingHoursDef propertyDefinitionWithName:@"assessments"];
    
//    assessmentsPropertyDef.title=@"Assessment Types";
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
   
    assessmentsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:assessmentDef
                                                                                             allowAddingItems:YES
                                                                                           allowDeletingItems:YES
                                                                                             allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add assessment hours"] addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add assessment hours"] addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //create an object selection for the supervisionType relationship in the Supervision Entity 
    
    
  
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    //create a property definition
    
    SCPropertyDefinition *testingSessionTypePropertyDef = [assessmentDef propertyDefinitionWithName:@"assessmentType"];
    
    
    //set the title property name
    assessmentDef.titlePropertyName=@"assessmentType.assessmentType;hours";
    assessmentDef.titlePropertyNameDelimiter=@" - ";
    
    //set the property definition type to objects selection
	
    testingSessionTypePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *testingSessionTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:testingSessionTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    testingSessionTypeSelectionAttribs.allowAddingItems = YES;
    testingSessionTypeSelectionAttribs.allowDeletingItems = YES;
    testingSessionTypeSelectionAttribs.allowMovingItems = YES;
    testingSessionTypeSelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    testingSessionTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap edit to add new assessment type"];
    
    
    //add an "Add New" element to appear when user clicks edit
    testingSessionTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New assessment type"];
    
    //add the selection attributes to the property definition
    testingSessionTypePropertyDef.attributes = testingSessionTypeSelectionAttribs;
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *assessmentTypeNotesPropertyDef = [testingSessionTypeDef propertyDefinitionWithName:@"notes"];
    assessmentTypeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    

    testingSessionTypeDef.orderAttributeName=@"order";
      

    
       
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
                                                               propertyNames:[NSArray arrayWithObjects:@"instrumentName", @"acronym", @"instrumentType",    @"notes" , nil]];
    
    
    
    
    
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
                                                                 propertyNames:[NSArray arrayWithObjects:@"batteryName", @"acronym", @"publisher",@"instruments", @"notes" , nil]];
    
    

    //Create the property definition for the instruments property
    SCPropertyDefinition *existingBatteriesPropertyDef = [assessmentDef propertyDefinitionWithName:@"batteries"];
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
    SCPropertyDefinition *batteryInstrumentsPropertyDef = [batteryDef propertyDefinitionWithName:@"instruments"];
    
    batteryInstrumentsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:instrumentDef
                                                                                               allowAddingItems:YES
                                                                                             allowDeletingItems:YES
                                                                                               allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add instruments"] addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add instrument"] addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
   
    SCPropertyDefinition *existingBatteryNotesPropertyDef = [existingBatteryDef propertyDefinitionWithName:@"notes"];
    existingBatteryNotesPropertyDef.type=SCPropertyTypeTextView;
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *batteryNotesPropertyDef = [batteryDef propertyDefinitionWithName:@"notes"];
    batteryNotesPropertyDef.type=SCPropertyTypeTextView;
    
    //Create a class definition for the other psychotherapyEntity
    SCEntityDefinition *interventionDef = [SCEntityDefinition definitionWithEntityName:@"ExistingInterventionEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects: @"interventionType"  ,@"hours", @"models",@"demographics",@"notes", nil]];
    
    
    
    
    SCPropertyDefinition *existingInterventionNumberPropertyDef = [interventionDef propertyDefinitionWithName:@"hours"];
    
    
    existingInterventionNumberPropertyDef.autoValidate=NO;
    
    

    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    interventionDef.titlePropertyName=@"interventionType.interventionType;models.acronym;hours";
    
    //create an array of objects definition for the other psychotherapy to-many relationship that with show up in a different view  without a place holder element>.
    
    //Create the property definition for the other property
    SCPropertyDefinition *directInterventionPropertyDef = [existingHoursDef propertyDefinitionWithName:@"directInterventions"];
    
//    directInterventionPropertyDef.title=@"Direct Intervention Types";
    directInterventionPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:interventionDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Tap edit to add direct interventions"] addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add a direct intervention" ]addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
   
    
    
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *interventionDemPropertyDef = [interventionDef propertyDefinitionWithName:@"demographics"];
    
    interventionDemPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:demographicsDef
                                                                                         allowAddingItems:NO
                                                                                       allowDeletingItems:NO
                                                                                         allowMovingItems:NO];
    

    
    //Create a class definition for the ExistingOtherInterventionType Entity
    SCEntityDefinition *interventionTypeDef = [SCEntityDefinition definitionWithEntityName:@"InterventionTypeEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"interventionType",@"notes",   nil]];
    
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    //create an object selection for the intervention Type relationship in the ExistingOtherInterventionTypeEntity Entity 
    
    //create a property definition
    SCPropertyDefinition *interventionTypePropertyDef = [interventionDef propertyDefinitionWithName:@"interventionType"];
    
        
    //set the title property name
    interventionTypeDef.titlePropertyName=@"interventionType";
    
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
    
    tableModel_ = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView  										entityDefinition:existingHoursDef];
    if (self.navigationItem.rightBarButtonItems.count>1) {
        
        tableModel_.addButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:1];
    }
    
    
    
    if (self.navigationItem.rightBarButtonItems.count >0)
    {
        tableModel_.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:0];
    }
    
   
    if ([SCUtilities is_iPad]) {
        
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:[UIColor clearColor]];
    }
    else {
        [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    }
    
    
//    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped)];
//    
//    self.navigationItem.leftBarButtonItem=cancelButton;
    self.view.backgroundColor=[UIColor clearColor];
    
    
    tableModel_.allowMovingItems=TRUE;
    
    tableModel_.autoAssignDelegateForDetailModels=TRUE;
    tableModel_.autoAssignDataSourceForDetailModels=TRUE;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadBoundValues:)
                                                 name:NSPersistentStoreDidImportUbiquitousContentChangesNotification
                                               object:nil];

    
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

-(void)cancelButtonTapped{
    
    //NSLog(@"cancel button Tapped");
    
    //NSLog(@"parent controller %@",[super parentViewController]);
    
    if(self.navigationController)
	{
		// check if self is the rootViewController
		if([self.navigationController.viewControllers objectAtIndex:0] == self)
		{
			[self dismissModalViewControllerAnimated:YES];
		}
		else
			[self.navigationController popViewControllerAnimated:YES];
	}
	else
		[self dismissModalViewControllerAnimated:YES];
    
    
}

-(BOOL)tableViewModel:(SCTableViewModel *)tableViewModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath{
BOOL valid=NO;
    SCTableViewCell *cell=[tableViewModel cellAtIndexPath:indexPath];
    //NSLog(@"cell class is %@",cell.class);
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
        
        
        
        
        
       
        
       
    }
    
    if ([cell isKindOfClass:[EncryptedSCTextViewCell class]]) {
        valid=YES;
        
    
    }
    
    return valid;



}

- (void)tableViewModel:(SCTableViewModel *)tableViewModel didLayoutSubviewsForCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[SCNumericTextFieldCell class]])
    {
        SCNumericTextFieldCell *numericCell=(SCNumericTextFieldCell *)cell;
        CGRect frame = numericCell.textLabel.frame;
        frame.size.width = frame.size.width+100;
        
        numericCell.textLabel.frame = frame;
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

-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
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


-(void)tableViewModel:(SCTableViewModel *)tableViewModel willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    NSManagedObject *managedObject=(NSManagedObject *)cell.boundObject;
    
    if (tableViewModel.tag==0) {
    
    if (managedObject) {
        
        
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
        //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
        if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
            
            //NSLog(@"entity name is %@",managedObject.entity.name);
            //identify the Languages Spoken table
            if ([managedObject.entity.name isEqualToString:@"ExistingHoursEntity"]) {
                //define and initialize a date formatter
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                
                //set the date format
                [dateFormatter setDateFormat:@"M/d/yyyy"];
                
                NSDate *startDate=[managedObject valueForKey:@"startDate"];
                NSDate *endDate=[managedObject valueForKey:@"endDate"];
                
//                NSString *notes=[managedObject valueForKey:@"notes"];
                
                NSMutableSet *assessmentHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"assessments.hours"];
                
                NSArray *assessmentHoursArray=[assessmentHoursSet allObjects];
                //NSLog(@"direct hours are %@",assessmentHoursArray);
                NSNumber *assessmentSum = nil;
                
                for (NSNumber *assessmentHours in assessmentHoursArray) {
                        //NSLog(@"hours class is %@",[assessmentHours class]);
                    
                    if (!assessmentSum) 
                    {
                        assessmentSum =[NSNumber numberWithFloat:(float)[assessmentHours floatValue]];
                    } else 
                    {
                        assessmentSum =[NSNumber numberWithFloat:[assessmentSum floatValue] + [assessmentHours floatValue]];
                    }
                }
                NSMutableSet *interventionHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"directInterventions.hours"];
                
                NSArray *interventionHoursArray=[interventionHoursSet allObjects];
                //NSLog(@"direct hours are %@",assessmentHoursArray);
                NSNumber *interventionSum = nil;
                
                for (NSNumber *interventionHours in interventionHoursArray) {
                    //NSLog(@"hours class is %@",[interventionHours class]);
                    
                    if (!interventionSum) 
                    {
                        interventionSum =[NSNumber numberWithFloat:(float)[interventionHours floatValue]];
                    } else 
                    {
                        interventionSum =[NSNumber numberWithFloat:[interventionSum floatValue] + [interventionHours floatValue]];
                    }
                }
                
                NSMutableSet *supportHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"supportActivities.hours"];
                
                NSArray *supportHoursArray=[supportHoursSet allObjects];
                //NSLog(@"direct hours are %@",supportHoursArray);
                NSNumber *supportSum = nil;
                
                for (NSNumber *supportHours in supportHoursArray) {
                    //NSLog(@"hours class is %@",[supportHours class]);
                    
                    if (!supportSum) 
                    {
                        supportSum =[NSNumber numberWithFloat:(float)[supportHours floatValue]];
                    } else 
                    {
                        supportSum =[NSNumber numberWithFloat:[supportSum floatValue] + [supportHours floatValue]];
                    }
                }
                NSMutableSet *supervisionGroupHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"supervision.groupHours"];
                
                NSArray *supervisionGroupHoursArray=[supervisionGroupHoursSet allObjects];
                //NSLog(@"direct hours are %@",supervisionGroupHoursArray);
                NSNumber *supervisionGroupSum = nil;
                
                for (NSNumber *supervisionGroupHours in supervisionGroupHoursArray) {
                    //NSLog(@"hours class is %@",[supervisionGroupHours class]);
                    
                    if (!supervisionGroupSum) 
                    {
                        supervisionGroupSum =[NSNumber numberWithFloat:(float)[supervisionGroupHours floatValue]];
                    } else 
                    {
                        supervisionGroupSum =[NSNumber numberWithFloat:[supervisionGroupSum floatValue] + [supervisionGroupHours floatValue]];
                    }
                }
                NSMutableSet *supervisionIndividualHoursSet=[managedObject mutableSetValueForKeyPath:(NSString *)@"supervision.individualHours"];
                
                NSArray *supervisionIndividualHoursArray=[supervisionIndividualHoursSet allObjects];
                //NSLog(@"direct hours are %@",supervisionIndividualHoursArray);
                NSNumber *supervisionIndividualSum = nil;
                
                for (NSNumber *supervisionIndividualHours in supervisionIndividualHoursArray) {
                    //NSLog(@"hours class is %@",[supervisionIndividualHours class]);
                    
                    if (!supervisionIndividualSum) 
                    {
                        supervisionIndividualSum =[NSNumber numberWithFloat:(float)[supervisionIndividualHours floatValue]];
                    } else 
                    {
                        supervisionIndividualSum =[NSNumber numberWithFloat:[supervisionIndividualSum floatValue] + [supervisionIndividualHours floatValue]];
                    }
                }

               
                float totalSum=[supervisionIndividualSum floatValue]+[supervisionGroupSum floatValue]+[supportSum floatValue]+[interventionSum floatValue]+[assessmentSum floatValue];
                
                
              NSString * dateString=[[dateFormatter stringFromDate:startDate] stringByAppendingFormat:@" - %@",[dateFormatter stringFromDate:endDate]];
                
                UILabel *datesLabel=(UILabel *)[cell viewWithTag:71];
                datesLabel.text=dateString;
                
                UILabel *interventionLabel=(UILabel *)[cell viewWithTag:72];
                interventionLabel.text=[NSString stringWithFormat:@"%.2f Intervention",[interventionSum floatValue]];
                
                UILabel *assessmentLabel=(UILabel *)[cell viewWithTag:73];
                assessmentLabel.text=[NSString stringWithFormat:@"%.2f Assessment",[assessmentSum floatValue]];
                
                 UILabel *supportLabel=(UILabel *)[cell viewWithTag:75];
                supportLabel.text=[NSString stringWithFormat:@"%.2f Support",[supportSum floatValue]];
                
                UILabel *supervisionLabel=(UILabel *)[cell viewWithTag:74];
                supervisionLabel.text=[NSString stringWithFormat:@"%.2f Supervision",[supervisionIndividualSum floatValue]+[supervisionGroupSum floatValue]];
                

                UILabel *totalLabel=(UILabel *)[cell viewWithTag:76];
                totalLabel.text=[NSString stringWithFormat:@"%.2f Total",totalSum];
                               
                
//                cell.textLabel.text=[NSString stringWithFormat:@"%@ - %@; %@ hrs Assessment; %@ hrs Intervention",[dateFormatter stringFromDate:startDate],[dateFormatter stringFromDate:endDate],assessmentSum, interventionSum];
                
                 cell.textLabel.text=@"";
                return;
            }

        }}
        
    }





}



-(void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableViewModel.tag==0) {
        CGRect cellFrame=cell.frame;
        cellFrame.size.height=100;
    }







}


- (SCCustomCell *)tableViewModel:(SCTableViewModel *)tableModel cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    
    // Create & return a custom cell based on the cell in ContactOverviewCell.xib
	
    
    SCCustomCell *actionOverviewCell=nil;
    if (tableModel.tag==0) {
        actionOverviewCell= [SCCustomCell cellWithText:nil boundObject:nil objectBindings:nil
                                            nibName:@"ExistingHoursOverviewCell"];
    }
	 
	
	return actionOverviewCell;
}

@end
