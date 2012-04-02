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
    
    existingAgeGroupDef.titlePropertyName=@"ageGroup.ageGroup";
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
    
    
    existingGenderDef.titlePropertyName=@"gender.genderName";
    
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
    
    existingEthnicitiesDef.titlePropertyName=@"ethnicity.ethnicityName";
    
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
    
    existingRaceDef.titlePropertyName=@"race.raceName";
    
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
    
    existingDisabilityDef.titlePropertyName=@"disability.disabilityName";
    //set the title property name
    disabilityDef.titlePropertyName=@"disabilityName";
    
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
    existingSexualOrientationDef.titlePropertyName=@"sexualOrientation";
    
    //set the property definition type to objects selection
	
   
	sOInExistingSexualOPropertyDef.title = @"Sexual Orientation";
    sOInExistingSexualOPropertyDef.type = SCPropertyTypeSelection;
	sOInExistingSexualOPropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Asexual", @"Bisexual", @"Heterosexual",@"Gay", @"Lesbian",@"Uncertain/Questioning",@"Undisclosed", nil] 
                                                                     allowMultipleSelection:NO
                                                                           allowNoSelection:NO autoDismissDetailView:YES hideDetailViewNavigationBar:NO];
    
    
     
    
    //Create a class definition for the existingAssessmentEntity
    SCClassDefinition *assessmentDef = [SCClassDefinition definitionWithEntityName:@"ExisitingAssessmentEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"intakeOrStructuredInterview", @"neuropsychologicalTestAdministration",@"otherAssessmentActivities",   @"psychodiagnosticTestAdministration",     @"demographics",@"notes",nil]];
    
    //Create a class definition for the existingAssessmentEntity
    SCClassDefinition *supervisionDef = [SCClassDefinition definitionWithEntityName:@"ExistingSupervisionEntity" 
                                                          withManagedObjectContext:managedObjectContext
                                                                 withPropertyNames:[NSArray arrayWithObjects:@"licensedSupervision", @"otherSupervision",nil]];
                                        
    
    //Create a class definition for the existingAssessmentEntity
    SCClassDefinition *supervisionLicencedDef = [SCClassDefinition definitionWithEntityName:@"ExistingLicensedSupervisionEntity" 
                                                           withManagedObjectContext:managedObjectContext
                                                                  withPropertyNames:[NSArray arrayWithObjects:@"groupHours", @"individualHours",@"licenseType",  @"notes",nil]];
    
    
    
    
    //Create a class definition for the existingAssessmentEntity
    SCClassDefinition *supervisionOtherDef = [SCClassDefinition definitionWithEntityName:@"ExistingOtherSupervisionEntity" 
                                                                   withManagedObjectContext:managedObjectContext
                                                                          withPropertyNames:[NSArray arrayWithObjects:@"groupHours", @"individualHours",@"otherSupervisionType",  @"notes",nil]];
    

    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *supervisionPropertyDef = [existingHoursDef propertyDefinitionWithName:@"supervision"];
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    supervisionPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:supervisionDef
                                                                                         allowAddingItems:NO
                                                                                       allowDeletingItems:NO
                                                                                         allowMovingItems:NO];
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *supervisonLicensedPropertyDef = [supervisionDef propertyDefinitionWithName:@"licensedSupervision"];
    
   
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    supervisonLicensedPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:supervisionLicencedDef
                                                                                            allowAddingItems:NO
                                                                                          allowDeletingItems:NO
                                                                                              allowMovingItems:NO];
    
    
    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *supervisionLicensedNotesPropertyDef = [supervisionLicencedDef propertyDefinitionWithName:@"notes"];
    supervisionLicensedNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *supervisonOtherPropertyDef = [supervisionDef propertyDefinitionWithName:@"otherSupervision"];
    
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    supervisonOtherPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:supervisionOtherDef
                                                                                              allowAddingItems:NO
                                                                                            allowDeletingItems:NO
                                                                                              allowMovingItems:NO];

    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *supervisionOtherNotesPropertyDef = [supervisionOtherDef propertyDefinitionWithName:@"notes"];
    supervisionOtherNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    
    //create the dictionary with the data bindings
    NSDictionary *clinicianDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObjects:@"supervisors",@"Supervisors",[NSNumber numberWithBool:NO],@"supervisors",[NSNumber numberWithBool:YES],nil] 
                                           forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *clinicianDataProperty = [SCCustomPropertyDefinition definitionWithName:@"ClinicianData"
                                                                                    withuiElementClass:[ClinicianSelectionCell class] withObjectBindings:clinicianDataBindings];
	

    
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    clinicianDataProperty.autoValidate=FALSE;
    
    
    //insert the custom property definition into the clientData class at index 
    [supervisionLicencedDef insertPropertyDefinition:clinicianDataProperty atIndex:1];
    [supervisionOtherDef insertPropertyDefinition:clinicianDataProperty atIndex:1];
                                        
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *assessmentsPropertyDef = [existingHoursDef propertyDefinitionWithName:@"assessment"];
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
   
    assessmentsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:assessmentDef
                                                                                    allowAddingItems:NO
                                                                                  allowDeletingItems:NO
                                                                                    allowMovingItems:NO];
    
      

    
       
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *assessmentDemPropertyDef = [assessmentDef propertyDefinitionWithName:@"demographics"];
    
    assessmentDemPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:demographicsDef
                                                                                               allowAddingItems:NO
                                                                                             allowDeletingItems:NO
                                                                                               allowMovingItems:NO];
    

    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *assessmentNotesPropertyDef = [assessmentDef propertyDefinitionWithName:@"notes"];
    assessmentNotesPropertyDef.type=SCPropertyTypeTextView;
    

    
    //Create a class definition for the psychotherapyEntity
    SCClassDefinition *psychotherapyDef = [SCClassDefinition definitionWithEntityName:@"ExistingPsychotherapyEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"familyAndCouples", @"group", @"individual",  @"other"   , nil]];
    
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *psychotherapyPropertyDef = [existingHoursDef propertyDefinitionWithName:@"psychotherapy"];
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    psychotherapyPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:psychotherapyDef
                                                                                       allowAddingItems:NO
                                                                                     allowDeletingItems:NO
                                                                                       allowMovingItems:NO];
    
    
    //Create a class definition for the family and couplesEntity
    SCClassDefinition *familyAndCouplesDef = [SCClassDefinition definitionWithEntityName:@"ExistingFamilyCouplesEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"hours",@"demographics", nil]];
    
    
        
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *familyAndCouplesPropertyDef = [psychotherapyDef propertyDefinitionWithName:@"familyAndCouples"];
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *familyAndCouplesDemPropertyDef = [familyAndCouplesDef propertyDefinitionWithName:@"demographics"];
    
    familyAndCouplesDemPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:demographicsDef
                                                                                            allowAddingItems:NO
                                                                                          allowDeletingItems:NO
                                                                                            allowMovingItems:NO];
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    familyAndCouplesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:familyAndCouplesDef
                                                                                         allowAddingItems:NO
                                                                                       allowDeletingItems:NO
                                                                                         allowMovingItems:NO];
    

   
    //Create a class definition for the family and couplesEntity
    SCClassDefinition *groupDef = [SCClassDefinition definitionWithEntityName:@"ExistingGroupPsychotherapyEntity" 
                                                                withManagedObjectContext:managedObjectContext
                                                                       withPropertyNames:[NSArray arrayWithObjects:@"hours",@"demographics", nil]];
    
    
    //instantiate the table model
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *groupPropertyDef = [psychotherapyDef propertyDefinitionWithName:@"group"];
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    groupPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:groupDef
                                                                                            allowAddingItems:NO
                                                                                          allowDeletingItems:NO
                                                                                            allowMovingItems:NO];
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *groupDemPropertyDef = [groupDef propertyDefinitionWithName:@"demographics"];
    
    groupDemPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:demographicsDef
                                                                                               allowAddingItems:NO
                                                                                             allowDeletingItems:NO
                                                                                               allowMovingItems:NO];
    
    //Create a class definition for the family and couplesEntity
    SCClassDefinition *individualDef = [SCClassDefinition definitionWithEntityName:@"ExistingIndivPsychotherapyEntity" 
                                                     withManagedObjectContext:managedObjectContext
                                                            withPropertyNames:[NSArray arrayWithObjects:@"hours",@"demographics", nil]];
    
    
    //instantiate the table model
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *individualPropertyDef = [psychotherapyDef propertyDefinitionWithName:@"individual"];
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    individualPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:individualDef
                                                                                 allowAddingItems:NO
                                                                               allowDeletingItems:NO
                                                                                 allowMovingItems:NO];
    


    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *individualDemPropertyDef = [individualDef propertyDefinitionWithName:@"demographics"];
    
    individualDemPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:demographicsDef
                                                                                    allowAddingItems:NO
                                                                                  allowDeletingItems:NO
                                                                                    allowMovingItems:NO];
    
    
    //Create a class definition for the other psychotherapyEntity
    SCClassDefinition *otherInterventionDef = [SCClassDefinition definitionWithEntityName:@"ExistingOtherInterventionEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects: @"type"  ,@"hours", @"demographics", nil]];
    
    
    
    
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    
    //create an array of objects definition for the other psychotherapy to-many relationship that with show up in a different view  without a place holder element>.
    
    //Create the property definition for the other property
    SCPropertyDefinition *otherPropertyDef = [psychotherapyDef propertyDefinitionWithName:@"other"];
    otherPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:otherInterventionDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add other direct intervention" ]addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
   
    
    
    
    //Create the property definition for the assessment property in the existingHours class
    SCPropertyDefinition *otherDemPropertyDef = [otherInterventionDef propertyDefinitionWithName:@"demographics"];
    
    otherDemPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:demographicsDef
                                                                                         allowAddingItems:NO
                                                                                       allowDeletingItems:NO
                                                                                         allowMovingItems:NO];
    

    
    //Create a class definition for the ExistingOtherInterventionType Entity
    SCClassDefinition *otherInterventionTypeDef = [SCClassDefinition definitionWithEntityName:@"ExistingOtherInterventionTypeEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"interventionType", nil]];
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
    
    //create an object selection for the intervention Type relationship in the ExistingOtherInterventionTypeEntity Entity 
    
    //create a property definition
    SCPropertyDefinition *otherInterventionTypePropertyDef = [otherInterventionDef propertyDefinitionWithName:@"type"];
    
        
    //set the title property name
    otherInterventionTypeDef.titlePropertyName=@"interventionType";
    
    //set the property definition type to objects selection
	
    otherInterventionTypePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *otherInterventionTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:otherInterventionTypeDef allowMultipleSelection:NO allowNoSelection:NO];
    
    //set some addtional attributes
    otherInterventionTypeSelectionAttribs.allowAddingItems = YES;
    otherInterventionTypeSelectionAttribs.allowDeletingItems = YES;
    otherInterventionTypeSelectionAttribs.allowMovingItems = YES;
    otherInterventionTypeSelectionAttribs.allowEditingItems = YES;
    

    //add an "Add New" element to appear when user clicks edit
    otherInterventionTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new interveniton type"];
    
    //add an "Add New" element to appear when user clicks edit
    otherInterventionTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap edit to add a new interveniton type"];
    
    //add the selection attributes to the property definition
    otherInterventionTypePropertyDef.attributes = otherInterventionTypeSelectionAttribs;
    
    otherInterventionTypeDef.orderAttributeName=@"order";
    
    
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

@end
