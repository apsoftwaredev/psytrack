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

@interface ExistingHoursViewController ()

@end

@implementation ExistingHoursViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // Gracefully handle reloading the view controller after a memory warning
    tableModel_ = (SCArrayOfObjectsModel *)[[SCModelCenter sharedModelCenter] modelForViewController:self];
    if(tableModel_)
    {
        [tableModel_ replaceModeledTableViewWith:self.tableView];
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
    
    
	// Get managedObjectContext from application delegate
   NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
	
    
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Existing Hours";
    

    SCClassDefinition *existingHoursDef =[SCClassDefinition definitionWithEntityName:@"ExistingHoursEntity"
                                                            withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];        
    


    
    
    
    //Create a class definition for the demographicsEntity
    SCClassDefinition *demographicsDef = [SCClassDefinition definitionWithEntityName:@"ExistingDemographicsEntity" 
                                                            withManagedObjectContext:managedObjectContext
                                                                   withPropertyNames:[NSArray arrayWithObjects:@"ageGroups", @"ethnicities", @"genders", @"individualsWithDisabilities",  @"races",  @"sexualOrientations",  nil]];
    
    
    //create an array of objects definition for the ageGroups to-many relationship that with show up in a different view with  a place holder element>.
    
    
    //Create a class definition for the ageGroupsEntity
    SCClassDefinition *existingAgeGroupDef = [SCClassDefinition definitionWithEntityName:@"ExistingAgeGroupEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"ageGroup",@"numberOfIndividuals",   nil]];
    //Create the property definition for the numberofindividuals property in the existing age group class
    SCPropertyDefinition *existingAgeGroupNumberPropertyDef = [existingAgeGroupDef propertyDefinitionWithName:@"numberOfIndividuals"];
    
    existingAgeGroupNumberPropertyDef.title=@"Number of Individuals";
    existingAgeGroupNumberPropertyDef.autoValidate=NO;
    //Do some property definition customization for the existingAgeGroupDef Entity defined in demographics
    //Create the property definition for the ageGroups property
    SCPropertyDefinition *ageGroupPropertyDef = [demographicsDef propertyDefinitionWithName:@"ageGroups"];
    ageGroupPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:existingAgeGroupDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add age group"]  addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //Create a class definition for the ageGroupEntity
    SCClassDefinition *ageGroupDef = [SCClassDefinition definitionWithEntityName:@"AgeGroupEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"ageGroup", nil]];
    
    
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
    SCObjectSelectionAttributes *ageGroupSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:ageGroupDef allowMultipleSelection:NO allowNoSelection:NO];
    
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
    SCClassDefinition *existingGenderDef = [SCClassDefinition definitionWithEntityName:@"ExistingGenderEntity" 
                                                                withManagedObjectContext:managedObjectContext
                                                                       withPropertyNames:[NSArray arrayWithObjects:@"gender",@"numberOfIndividuals",   nil]];
    
    
    SCPropertyDefinition *existingGenderNumberPropertyDef = [existingGenderDef propertyDefinitionWithName:@"numberOfIndividuals"];
    
       existingGenderNumberPropertyDef.title=@"Number of Individuals";
    existingGenderNumberPropertyDef.autoValidate=NO;
    //Do some property definition customization for the existingAgeGroupDef Entity defined in demographics
    //Create the property definition for the ageGroups property
    SCPropertyDefinition *genderPropertyDef = [demographicsDef propertyDefinitionWithName:@"genders"];
    genderPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:existingGenderDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add gender"]  addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //Create a class definition for the ageGroupEntity
    SCClassDefinition *genderpDef = [SCClassDefinition definitionWithEntityName:@"GenderEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"genderName",@"notes", nil]];
    
    
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
    SCObjectSelectionAttributes *genderSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:genderpDef allowMultipleSelection:NO allowNoSelection:NO];
    
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
    SCClassDefinition *existingEthnicitiesDef = [SCClassDefinition definitionWithEntityName:@"ExistingEthnicityEntity" 
                                                              withManagedObjectContext:managedObjectContext
                                                                     withPropertyNames:[NSArray arrayWithObjects:@"ethnicity",@"numberOfIndividuals",   nil]];
    
    
    SCPropertyDefinition *existingEthnicitiesNumberPropertyDef = [existingEthnicitiesDef propertyDefinitionWithName:@"numberOfIndividuals"];
    
    
    existingEthnicitiesNumberPropertyDef.autoValidate=NO;
    
     existingEthnicitiesNumberPropertyDef.title=@"Number of Individuals";
    //Do some property definition customization for the existingAgeGroupDef Entity defined in demographics
    //Create the property definition for the ageGroups property
    SCPropertyDefinition *ethnicityPropertyDef = [demographicsDef propertyDefinitionWithName:@"ethnicities"];
    ethnicityPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:existingEthnicitiesDef
                                                                                  allowAddingItems:YES
                                                                                allowDeletingItems:YES
                                                                                  allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add ethnicity"]  addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //Create a class definition for the ageGroupEntity
    SCClassDefinition *ethnicitypDef = [SCClassDefinition definitionWithEntityName:@"EthnicityEntity" 
                                                       withManagedObjectContext:managedObjectContext
                                                              withPropertyNames:[NSArray arrayWithObjects:@"ethnicityName",@"notes", nil]];
    
    
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
    SCObjectSelectionAttributes *ethnicitySelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:ethnicitypDef allowMultipleSelection:NO allowNoSelection:NO];
    
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
    SCClassDefinition *existingRaceDef = [SCClassDefinition definitionWithEntityName:@"ExistingRaceEntity" 
                                                                   withManagedObjectContext:managedObjectContext
                                                                          withPropertyNames:[NSArray arrayWithObjects:@"race",@"numberOfIndividuals",   nil]];
    
    
    SCPropertyDefinition *existingRaceNumberPropertyDef = [existingRaceDef propertyDefinitionWithName:@"numberOfIndividuals"];
    
     existingRaceNumberPropertyDef.title=@"Number of Individuals";
    existingRaceNumberPropertyDef.autoValidate=NO;
    //Do some property definition customization for the existingAgeGroupDef Entity defined in demographics
    //Create the property definition for the ageGroups property
    SCPropertyDefinition *racePropertyDef = [demographicsDef propertyDefinitionWithName:@"races"];
    racePropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:existingRaceDef
                                                                                     allowAddingItems:YES
                                                                                   allowDeletingItems:YES
                                                                                     allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add race"]  addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //Create a class definition for the ageGroupEntity
    SCClassDefinition *raceDef = [SCClassDefinition definitionWithEntityName:@"RaceEntity" 
                                                          withManagedObjectContext:managedObjectContext
                                                                 withPropertyNames:[NSArray arrayWithObjects:@"raceName",@"notes", nil]];
    
    
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
    SCObjectSelectionAttributes *raceSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:raceDef allowMultipleSelection:NO allowNoSelection:NO];
    
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
    SCClassDefinition *existingDisabilityDef = [SCClassDefinition definitionWithEntityName:@"ExistingDisabilityEntity" 
                                                            withManagedObjectContext:managedObjectContext
                                                                   withPropertyNames:[NSArray arrayWithObjects:@"disability",@"numberOfIndividuals",   nil]];
    
    
    SCPropertyDefinition *existingDisabilityNumberPropertyDef = [existingDisabilityDef propertyDefinitionWithName:@"numberOfIndividuals"];
    
    
    existingDisabilityNumberPropertyDef.autoValidate=NO;
   existingDisabilityNumberPropertyDef.title=@"Number of Individuals";
    
    //Do some property definition customization for the existingAgeGroupDef Entity defined in demographics
    //Create the property definition for the ageGroups property
    SCPropertyDefinition *disabilityPropertyDef = [demographicsDef propertyDefinitionWithName:@"individualsWithDisabilities"];
    disabilityPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:existingDisabilityDef
                                                                                allowAddingItems:YES
                                                                              allowDeletingItems:YES
                                                                                allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add disability"]  addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //Create a class definition for the ageGroupEntity
    SCClassDefinition *disabilityDef = [SCClassDefinition definitionWithEntityName:@"DisabilityEntity" 
                                                     withManagedObjectContext:managedObjectContext
                                                            withPropertyNames:[NSArray arrayWithObjects:@"disabilityName",@"notes", nil]];
    
    
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
    SCObjectSelectionAttributes *disabilitySelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:disabilityDef allowMultipleSelection:NO allowNoSelection:NO];
    
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
    SCClassDefinition *existingSexualOrientationDef = [SCClassDefinition definitionWithEntityName:@"ExistingSexualOrientationEntity" 
                                                                  withManagedObjectContext:managedObjectContext
                                                                         withPropertyNames:[NSArray arrayWithObjects:@"sexualOrientation",@"numberOfIndividuals",   nil]];
    
    SCPropertyDefinition *existingSONumberPropertyDef = [existingSexualOrientationDef propertyDefinitionWithName:@"numberOfIndividuals"];
    
    
    existingSONumberPropertyDef.autoValidate=NO;
    existingSONumberPropertyDef.title=@"Number of Individuals";
    //Do some property definition customization for the existingAgeGroupDef Entity defined in demographics
    //Create the property definition for the ageGroups property
    SCPropertyDefinition *sexualOrientationPropertyDef = [demographicsDef propertyDefinitionWithName:@"sexualOrientations"];
    sexualOrientationPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:existingSexualOrientationDef
                                                                                      allowAddingItems:YES
                                                                                    allowDeletingItems:YES
                                                                                      allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add sexual orientation"]  addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
   
    
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
    SCClassDefinition *supervisionDef = [SCClassDefinition definitionWithEntityName:@"ExistingSupervisionEntity" 
                                                                   withManagedObjectContext:managedObjectContext
                                                                          withPropertyNames:[NSArray arrayWithObjects:@"supervisionType",@"groupHours", @"individualHours",  @"notes",nil]];
    

    
    SCPropertyDefinition *supervisionGroupNumberPropertyDef = [supervisionDef propertyDefinitionWithName:@"groupHours"];
    
    
    supervisionGroupNumberPropertyDef.autoValidate=NO;
    
    SCPropertyDefinition *supervisionIndividualNumberPropertyDef = [supervisionDef propertyDefinitionWithName:@"individualHours"];
    
    
    supervisionIndividualNumberPropertyDef.autoValidate=NO;
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    //create an array of objects definition for the supervision to-many relationship that with show up in the same view without a place holder element>.
    
    //Create the property definition for the <#propertyName#> property
    SCPropertyDefinition *supervisionPropertyDef = [existingHoursDef propertyDefinitionWithName:@"supervision"];
    
    supervisionPropertyDef.title=@"Supervision Types";
    supervisionPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:supervisionDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add supervison hours"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
   
    
    //create an object selection for the supervisionType relationship in the Supervision Entity 
    
    
    //Create a class definition for the supervision TypeEntity
    SCClassDefinition *supervisionTypeDef = [SCClassDefinition definitionWithEntityName:@"SupervisionTypeEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"supervisionType", nil]];
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    //create a property definition
   
    SCPropertyDefinition *supervisionTypePropertyDef = [supervisionDef propertyDefinitionWithName:@"supervisionType"];
    
   
    //set the title property name
    supervisionDef.titlePropertyName=@"supervisionType.supervisionType;groupHours;individualHours";
    supervisionDef.titlePropertyNameDelimiter=@" - ";
    
    
    //set the property definition type to objects selection
	
    supervisionTypePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *supervisionTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:supervisionTypeDef allowMultipleSelection:NO allowNoSelection:NO];
    
    //set some addtional attributes
    supervisionTypeSelectionAttribs.allowAddingItems = YES;
    supervisionTypeSelectionAttribs.allowDeletingItems = YES;
    supervisionTypeSelectionAttribs.allowMovingItems = YES;
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
                                                                                    withuiElementClass:[ClinicianSelectionCell class] withObjectBindings:clinicianDataBindings];
	

    
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    clinicianDataProperty.autoValidate=TRUE;
    
    
    //insert the custom property definition into the clientData class at index 
  
    [supervisionDef insertPropertyDefinition:clinicianDataProperty atIndex:1];
                        
    
    //Create a class definition for the existingAssessmentEntity
    SCClassDefinition *supportActivityDef = [SCClassDefinition definitionWithEntityName:@"ExistingSupportActivityEntity" 
                                                           withManagedObjectContext:managedObjectContext
                                                                  withPropertyNames:[NSArray arrayWithObjects:@"supportActivityType",@"hours",  @"notes",nil]];
    
    
    
    
    SCPropertyDefinition *supportActivityNumberPropertyDef = [supportActivityDef propertyDefinitionWithName:@"hours"];
    
    
    supportActivityNumberPropertyDef.autoValidate=NO;
    

    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    //create an array of objects definition for the supervision to-many relationship that with show up in the same view without a place holder element>.
    
    //Create the property definition for the supportActivity property
    SCPropertyDefinition *supportActivitiesPropertyDef = [existingHoursDef propertyDefinitionWithName:@"supportActivities"];
    supportActivitiesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:supportActivityDef
                                                                                       allowAddingItems:YES
                                                                                     allowDeletingItems:YES
                                                                                       allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add support activity hours"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //create an object selection for the supervisionType relationship in the Supervision Entity 
    
    
    //Create a class definition for the supervision TypeEntity
    SCClassDefinition *supportActivityTypeDef = [SCClassDefinition definitionWithEntityName:@"SupportActivityTypeEntity" 
                                                               withManagedObjectContext:managedObjectContext
                                                                      withPropertyNames:[NSArray arrayWithObjects:@"supportActivityType", nil]];
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    //create a property definition
    
    SCPropertyDefinition *supportActivityTypePropertyDef = [supportActivityDef propertyDefinitionWithName:@"supportActivityType"];
    
    
    //set the title property name
    supportActivityDef.titlePropertyName=@"supportActivityType.supportActivityType;hours";
    
    //set the property definition type to objects selection
	
    supportActivityTypePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *supportActivityTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:supportActivityTypeDef allowMultipleSelection:NO allowNoSelection:NO];
    
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
    SCClassDefinition *assessmentDef = [SCClassDefinition definitionWithEntityName:@"ExisitingAssessmentEntity" 
                                                          withManagedObjectContext:managedObjectContext
                                                                 withPropertyNames:[NSArray arrayWithObjects:@"assessmentType",@"hours",@"instruments",@"batteries", @"demographics",@"notes",nil]];
    
    
    SCPropertyDefinition *assessmentNumberPropertyDef = [assessmentDef propertyDefinitionWithName:@"hours"];
    
    
    assessmentNumberPropertyDef.autoValidate=NO;
    
    


    //Create a class definition for the testingSessionTypeEntity
    SCClassDefinition *testingSessionTypeDef = [SCClassDefinition definitionWithEntityName:@"TestingSessionTypeEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"assessmentType", @"notes" , nil]];
    
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *assessmentsPropertyDef = [existingHoursDef propertyDefinitionWithName:@"assessments"];
    
    assessmentsPropertyDef.title=@"Assessment Types";
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
   
    assessmentsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:assessmentDef
                                                                                             allowAddingItems:YES
                                                                                           allowDeletingItems:YES
                                                                                             allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add assessment hours"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //create an object selection for the supervisionType relationship in the Supervision Entity 
    
    
  
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    //create a property definition
    
    SCPropertyDefinition *testingSessionTypePropertyDef = [assessmentDef propertyDefinitionWithName:@"assessmentType"];
    
    
    //set the title property name
    assessmentDef.titlePropertyName=@"assessmentType.assessmentType;hours";
    assessmentDef.titlePropertyNameDelimiter=@" - ";
    
    //set the property definition type to objects selection
	
    testingSessionTypePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *testingSessionTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:testingSessionTypeDef allowMultipleSelection:NO allowNoSelection:NO];
    
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
    
    assessmentDemPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:demographicsDef
                                                                                               allowAddingItems:NO
                                                                                             allowDeletingItems:NO
                                                                                               allowMovingItems:NO];
    

    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *assessmentNotesPropertyDef = [assessmentDef propertyDefinitionWithName:@"notes"];
    assessmentNotesPropertyDef.type=SCPropertyTypeTextView;
    

    //Create a class definition for the existing InstrumentsEntity
    SCClassDefinition *existingInstrumentDef = [SCClassDefinition definitionWithEntityName:@"ExistingInstrumentEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                                         withPropertyNames:[NSArray arrayWithObjects:@"instrument",@"numberAdminstered",@"numberOfReportsWritten",@"notes",  nil]];
    
    
    
    
    
    SCPropertyDefinition *existingIAdministeredNumberPropertyDef = [existingInstrumentDef propertyDefinitionWithName:@"numberAdminstered"];
    
    
    existingIAdministeredNumberPropertyDef.autoValidate=NO;
    
    
    SCPropertyDefinition *existingIReportsNumberPropertyDef = [existingInstrumentDef propertyDefinitionWithName:@"numberOfReportsWritten"];
    
    
    existingIReportsNumberPropertyDef.autoValidate=NO;
    
    existingIReportsNumberPropertyDef.title=@"Number of Reports Written";

    
    //Create a class definition for the instrument type Entity
    SCClassDefinition *instrumentTypeDef = [SCClassDefinition definitionWithEntityName:@"InstrumentTypeEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"instrumentType", @"notes" , nil]];
    
    
    
    
    //Create a class definition for the Instrument Entity
    SCClassDefinition *instrumentDef = [SCClassDefinition definitionWithEntityName:@"InstrumentEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"instrumentName", @"acronym", @"instrumentType",    @"notes" , nil]];
    
    
    
    
    
    //create an array of objects definition for the existing instruments to-many relationship that with show up in a different view  without a place holder element>.
    
    //Create the property definition for the instruments property
    SCPropertyDefinition *existingInstrumentsPropertyDef = [assessmentDef propertyDefinitionWithName:@"instruments"];
    existingInstrumentsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:existingInstrumentDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add instrument"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    existingInstrumentDef.titlePropertyName=@"instrument.instrumentName;numberOfTimesUsed";
   
    //create an object selection for the instrument relationship in the existing Instruments Entity 
    
    //create a property definition
    SCPropertyDefinition *instrumentPropertyDef = [existingInstrumentDef propertyDefinitionWithName:@"instrument"];
    
 
    
    //set the title property name
    instrumentDef.titlePropertyName=@"instrumentName";
    
    //set the property definition type to objects selection
	
    instrumentPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *instrumentSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:instrumentDef allowMultipleSelection:NO allowNoSelection:NO];
    
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
    SCObjectSelectionAttributes *instrumentTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:instrumentTypeDef allowMultipleSelection:NO allowNoSelection:NO];
    
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
    SCClassDefinition *existingBatteryDef = [SCClassDefinition definitionWithEntityName:@"ExistingBatteryEntity" 
                                                                  withManagedObjectContext:managedObjectContext
                                                                         withPropertyNames:[NSArray arrayWithObjects:@"battery",@"numberAdminstered",@"numberOfReportsWritten",@"notes",  nil]];
    
    
    
    SCPropertyDefinition *existingBAdministeredNumberPropertyDef = [existingBatteryDef propertyDefinitionWithName:@"numberAdminstered"];
    
    
    existingBAdministeredNumberPropertyDef.autoValidate=NO;
    
    
    SCPropertyDefinition *existingBReportsNumberPropertyDef = [existingBatteryDef propertyDefinitionWithName:@"numberOfReportsWritten"];
    
    
    existingBReportsNumberPropertyDef.autoValidate=NO;
    
    


    
    //Create a class definition for the Instrument Entity
    SCClassDefinition *batteryDef = [SCClassDefinition definitionWithEntityName:@"BatteryEntity" 
                                                          withManagedObjectContext:managedObjectContext
                                                                 withPropertyNames:[NSArray arrayWithObjects:@"batteryName", @"acronym", @"publisher",@"instruments", @"notes" , nil]];
    
    

    //Create the property definition for the instruments property
    SCPropertyDefinition *existingBatteriesPropertyDef = [assessmentDef propertyDefinitionWithName:@"batteries"];
    existingBatteriesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:existingBatteryDef
                                                                                               allowAddingItems:YES
                                                                                             allowDeletingItems:YES
                                                                                               allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add battery"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
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
    SCObjectSelectionAttributes *batterySelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:batteryDef allowMultipleSelection:NO allowNoSelection:NO];
    
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
    
    batteryInstrumentsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:instrumentDef
                                                                                               allowAddingItems:YES
                                                                                             allowDeletingItems:YES
                                                                                               allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add instrument"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
   
    SCPropertyDefinition *existingBatteryNotesPropertyDef = [existingBatteryDef propertyDefinitionWithName:@"notes"];
    existingBatteryNotesPropertyDef.type=SCPropertyTypeTextView;
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *batteryNotesPropertyDef = [batteryDef propertyDefinitionWithName:@"notes"];
    batteryNotesPropertyDef.type=SCPropertyTypeTextView;
    
    //Create a class definition for the other psychotherapyEntity
    SCClassDefinition *interventionDef = [SCClassDefinition definitionWithEntityName:@"ExistingInterventionEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects: @"interventionType"  ,@"hours", @"models",@"demographics",@"notes", nil]];
    
    
    
    
    SCPropertyDefinition *existingInterventionNumberPropertyDef = [interventionDef propertyDefinitionWithName:@"hours"];
    
    
    existingInterventionNumberPropertyDef.autoValidate=NO;
    
    

    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    interventionDef.titlePropertyName=@"interventionType.interventionType;models.acronym;hours";
    
    //create an array of objects definition for the other psychotherapy to-many relationship that with show up in a different view  without a place holder element>.
    
    //Create the property definition for the other property
    SCPropertyDefinition *directInterventionPropertyDef = [existingHoursDef propertyDefinitionWithName:@"directInterventions"];
    
    directInterventionPropertyDef.title=@"Direct Intervention Types";
    directInterventionPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:interventionDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add a direct intervention" ]addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
   
    
    
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *interventionDemPropertyDef = [interventionDef propertyDefinitionWithName:@"demographics"];
    
    interventionDemPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:demographicsDef
                                                                                         allowAddingItems:NO
                                                                                       allowDeletingItems:NO
                                                                                         allowMovingItems:NO];
    

    
    //Create a class definition for the ExistingOtherInterventionType Entity
    SCClassDefinition *interventionTypeDef = [SCClassDefinition definitionWithEntityName:@"InterventionTypeEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"interventionType",@"notes",   nil]];
    
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    //create an object selection for the intervention Type relationship in the ExistingOtherInterventionTypeEntity Entity 
    
    //create a property definition
    SCPropertyDefinition *interventionTypePropertyDef = [interventionDef propertyDefinitionWithName:@"interventionType"];
    
        
    //set the title property name
    interventionTypeDef.titlePropertyName=@"interventionType";
    
    //set the property definition type to objects selection
	
    interventionTypePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *interventionTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:interventionTypeDef allowMultipleSelection:NO allowNoSelection:NO];
    
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
    SCClassDefinition *interventionModelDef = [SCClassDefinition definitionWithEntityName:@"InterventionModelEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects: @"modelName",@"acronym",  @"evidenceBased",@"notes" , nil]];
    
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    //create an object selection for the models relationship in the Intervention Model Entity 
    
    //create a property definition
    SCPropertyDefinition *interventionModelsPropertyDef = [interventionDef propertyDefinitionWithName:@"models"];
    
        //set the title property name
    interventionModelDef.titlePropertyName=@"modelName;acronym";
    interventionModelDef.titlePropertyNameDelimiter=@" - ";
    //set the property definition type to objects selection
	
    interventionModelsPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *interventionModelsSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:interventionModelDef allowMultipleSelection:YES allowNoSelection:YES];
    
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
    
    tableModel_ = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self
										withEntityClassDefinition:existingHoursDef];
    if (self.navigationItem.rightBarButtonItems.count>1) {
        
        tableModel_.addButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:1];
    }
    
    
    
    if (self.navigationItem.rightBarButtonItems.count >0)
    {
        tableModel_.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:0];
    }
    
    if ([SCHelper is_iPad]) {
        
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:[UIColor clearColor]];
    }
    [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    
    tableModel_.allowMovingItems=TRUE;
    
    tableModel_.autoAssignDelegateForDetailModels=TRUE;
    tableModel_.autoAssignDataSourceForDetailModels=TRUE;
    
    
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


-(BOOL)tableViewModel:(SCTableViewModel *)tableViewModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath{
BOOL valid=NO;
    SCTableViewCell *cell=[tableViewModel cellAtIndexPath:indexPath];
    NSLog(@"cell class is %@",cell.class);
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




-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)index detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    
    
    
    detailTableViewModel.delegate = self;
    detailTableViewModel.tag = tableViewModel.tag+1;
    
    if([SCHelper is_iPad]&&detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
        
        
        [detailTableViewModel.modeledTableView setBackgroundView:nil];
        [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
        [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    }
    
    
    
}

@end
