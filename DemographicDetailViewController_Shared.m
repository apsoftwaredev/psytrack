/*
 *  DemographicDetailViewController_Shared.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/24/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "DemographicDetailViewController_Shared.h"
#import "PTTAppDelegate.h"
#import "TimeOfDayPickerCell.h"
#import "EncryptedSCTextViewCell.h"
#import "EncryptedSCSelectionCell.h"
#import "BOPickersDataSource.h"
@implementation DemographicDetailViewController_Shared
@synthesize demographicProfileDef;

-(id)setupTheDemographicView{
    
    
    NSManagedObjectContext *managedObjectContext=[(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    
//    NSString *shortFieldCellNibName=nil;
//    NSString *textFieldAndLableNibName=nil;
    NSString *scaleDataCellNibName=nil;
    if ([SCUtilities is_iPad]) {
//        textFieldAndLableNibName=@"TextFieldAndLabelCell_iPad";
//        shortFieldCellNibName=@"ShortFieldCell_iPad";
        scaleDataCellNibName=@"ScaleDataCell_iPad";

        
       
        
    } else
    {
//        textFieldAndLableNibName=@"TextFieldAndLabelCell_iPhone";
//        shortFieldCellNibName=@"ShortFieldCell_iPhone";
        scaleDataCellNibName=@"ScaleDataCell_iPhone";       
    }
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMM dd, yyyy"];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
	[timeFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    //start Demographic Profile setup
    //Create a class definition for Demographic Profile entity
//	self.demographicProfileDef = [SCEntityDefinition definitionWithEntityName:@"DemographicProfileEntity" 
//                                                    managedObjectContext:managedObjectContext
//                                                           propertyNames:[NSArray arrayWithObjects:@"profileNotes",@"sex",@"gender", @"sexualOrientation",
//                                                                              @"disabilities",@"educationLevel",@"employmentStatus", @"ethnicities",@"languagesSpoken",
//                                                                              @"cultureGroups",@"migrationHistory", @"interpersonal",  
//                                                                              @"races",@"spiritualBeliefs",@"significantLifeEvents",@"militaryService", @"additionalVariables",nil]];
	
    self.demographicProfileDef = [SCEntityDefinition definitionWithEntityName:@"DemographicProfileEntity" 
                                                         managedObjectContext:managedObjectContext
                                                                propertyNames:[NSArray arrayWithObjects:@"profileNotes",@"sex",@"gender", @"sexualOrientation",
                                                                               @"disabilities",@"ethnicities",@"languagesSpoken",
                                                                               @"cultureGroups",
                                                                                @"races",@"spiritualBeliefs",@"significantLifeEvents",@"militaryService", @"educationLevel",@"employmentStatus", @"migrationHistory", @"interpersonal",  
                                                                              @"hearing",@"vision",@"additionalVariables",nil]];
     
//    [self.demographicProfileDef removePropertyDefinitionWithName:@"order"];
//    [self.demographicProfileDef removePropertyDefinitionWithName:@"keyString"];
//    SCPropertyGroup *sharedPropertyGroup=[SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"profileNotes",@"sex",@"gender", @"sexualOrientation",
//                                                                                                                                                                                                @"disabilities",@"educationLevel",@"employmentStatus", @"ethnicities",@"languagesSpoken",
//                                                                                                                                                                                                @"cultureGroups",@"migrationHistory", @"interpersonal",  
//                                                                                                                                                                                                @"races",@"spiritualBeliefs",@"significantLifeEvents",@"militaryService", @"hearing",@"vision",@"additionalVariables",nil]];
//    
//    [self.demographicProfileDef.propertyGroups addGroup:sharedPropertyGroup];
    //Create a class definition for Demographic Gender entity
    SCEntityDefinition *genderDef = [SCEntityDefinition definitionWithEntityName:@"GenderEntity" 
                                                      managedObjectContext:managedObjectContext
                                                             propertyNames:[NSArray arrayWithObjects:@"genderName",@"notes",nil]];
    
    genderDef.orderAttributeName=@"order";
    //Create a class definition for Demographic Immigration History entity
    SCEntityDefinition *migrationHistoryDef = [SCEntityDefinition definitionWithEntityName:@"MigrationHistoryEntity" 
                                                                 managedObjectContext:managedObjectContext
                                                                        propertyNames:[NSArray arrayWithObjects:@"migratedFrom",@"migratedTo",@"arrivedDate",@"notes",nil]];
    
       
    
    
    //Create a class definition for  Disablity entity
    SCEntityDefinition *disabilityDef = [SCEntityDefinition definitionWithEntityName:@"DisabilityEntity" 
                                                          managedObjectContext:managedObjectContext
                                                                 propertyNames:[NSArray arrayWithObjects:@"disabilityName",@"notes",nil]];
    disabilityDef.orderAttributeName=@"order";
    //Create a class definition for Education Level entity
    SCEntityDefinition *educationLevelDef = [SCEntityDefinition definitionWithEntityName:@"EducationLevelEntity" 
                                                              managedObjectContext:managedObjectContext
                                                                     propertyNames:[NSArray arrayWithObjects:@"educationLevel",@"notes",nil]];
    educationLevelDef.orderAttributeName=@"order";
    //Create a class definition for Employment Status entity
    SCEntityDefinition *employmentStatuslDef = [SCEntityDefinition definitionWithEntityName:@"EmploymentStatusEntity" 
                                                                 managedObjectContext:managedObjectContext
                                                                        propertyNames:[NSArray arrayWithObjects:@"employmentStatus",@"notes",nil]];
    
    employmentStatuslDef.orderAttributeName=@"order";
    //Create a class definition for Ethnicity entity
    SCEntityDefinition *ethnicitylDef = [SCEntityDefinition definitionWithEntityName:@"EthnicityEntity" 
                                                          managedObjectContext:managedObjectContext
                                                                 propertyNames:[NSArray arrayWithObjects:
                                                                                    @"ethnicityName",@"notes",nil]]; 
    ethnicitylDef.orderAttributeName=@"order";
    //Create a class definition for Culture Group entity
    SCEntityDefinition *cultureGroupDef = [SCEntityDefinition definitionWithEntityName:@"CultureGroupEntity" 
                                                            managedObjectContext:managedObjectContext
                                                                   propertyNames:[NSArray arrayWithObjects:@"cultureName",@"notes",nil]];  
    
    //Create a class definition for Languages Spoken entity
    SCEntityDefinition *languageSpokenDef = [SCEntityDefinition definitionWithEntityName:@"LanguageSpokenEntity" 
                                                              managedObjectContext:managedObjectContext
                                                                     propertyNames:[NSArray arrayWithObjects:@"language", @"primaryLanguage", @"nativeSpeaker", @"onlyLanguage", @"startedSpeaking", @"notes", nil]];  
    
    
    
    languageSpokenDef.orderAttributeName=@"order";
    //Create a class definition for Language entity
    SCEntityDefinition *languageDef = [SCEntityDefinition definitionWithEntityName:@"LanguageEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"language",@"notes",nil]];  
    
    
    languageDef.orderAttributeName=@"order";
    
    
    
    //Create a class definition for Race entity
    SCEntityDefinition *raceDef = [SCEntityDefinition definitionWithEntityName:@"RaceEntity" 
                                                    managedObjectContext:managedObjectContext
                                                           propertyNames:[NSArray arrayWithObjects:@"raceName",@"notes",nil]];  
    
    //Create a class definition for Spiritual Belief entity
    SCEntityDefinition *spiritualBeliefDef = [SCEntityDefinition definitionWithEntityName:@"SpiritualBeliefEntity" 
                                                               managedObjectContext:managedObjectContext
                                                                      propertyNames:[NSArray arrayWithObjects:@"beliefName",@"notes",nil]];  
    
    
    spiritualBeliefDef.orderAttributeName=@"order";
    //Create a class definition for Significant Life Event entity
    SCEntityDefinition *significantLifeEventDef = [SCEntityDefinition definitionWithEntityName:@"SignificantLifeEventEntity" 
                                                                    managedObjectContext:managedObjectContext
                                                                           propertyNames:[NSArray arrayWithObjects:@"eventType",@"desc",nil]];  
    
    
    significantLifeEventDef.orderAttributeName=@"order";
    
    
    
    
    
    //Create a class definition for Additional Variables entity 
    SCEntityDefinition *additionalVariableDef = [SCEntityDefinition definitionWithEntityName:@"AdditionalVariableEntity" 
                                                                  managedObjectContext:managedObjectContext
                                                                         propertyNames:[NSArray arrayWithObjects:@"variableName",@"selectedValue",@"stringValue",@"timeValue",@"dateValue",@"timeValueTwo", @"notes",nil]];  
    
    
    
    
    
    
    
    
    
    additionalVariableDef.orderAttributeName=@"order";
    //Create a class definition for Additional Variable Name entity
    SCEntityDefinition *additionalVariableNameDef = [SCEntityDefinition definitionWithEntityName:@"AdditionalVariableNameEntity" 
                                                                      managedObjectContext:managedObjectContext
                                                                             propertyNames:[NSArray arrayWithObjects:@"variableName",@"notes",nil]];
    
    
    
    
    
    additionalVariableNameDef.orderAttributeName=@"order";
    
    SCEntityDefinition *additionalVariableValueDef = [SCEntityDefinition definitionWithEntityName:@"AdditionalVariableValueEntity" 
                                                                       managedObjectContext:managedObjectContext
                                                                              propertyNames:[NSArray arrayWithObjects:@"variableValue",@"notes",nil]]; 
    
    
    additionalVariableValueDef.orderAttributeName=@"order";
    
    
    
    //begin
    
  
    
    
    additionalVariableValueDef.orderAttributeName=@"order";
    
    
    
       
    
    SCPropertyDefinition *variableValuesInVariableNamePropertyDef=[SCPropertyDefinition definitionWithName:@"variableValues" title:@"Values" type:SCPropertyTypeArrayOfObjects];
    
    [additionalVariableNameDef addPropertyDefinition:variableValuesInVariableNamePropertyDef];
    
    variableValuesInVariableNamePropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:additionalVariableValueDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add new variable value"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];
    
    
    //end
    
    
    
    
    
    //Do some property definition customization for the Demographic Profile Entity sex and Profile notes attributes
    SCPropertyDefinition *demographicSexPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"sex"];
//	demographicSexPropertyDef.title =
    demographicSexPropertyDef.type = SCPropertyTypeSelection;
	demographicSexPropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Male", @"Female", @"Intersexual",@"F2M",@"M2F",@"Undisclosed", nil] 
                                                               allowMultipleSelection:NO
                                                                     allowNoSelection:NO
                                                                autoDismissDetailView:YES hideDetailViewNavigationBar:NO];
    
    demographicSexPropertyDef.type=SCPropertyTypeCustom;
    demographicSexPropertyDef.uiElementClass=[EncryptedSCSelectionCell class];
    
    NSDictionary *encryProfileSexTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"sex",@"keyString",@"Sex",@"sex", nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    demographicSexPropertyDef.objectBindings=encryProfileSexTVCellKeyBindingsDic;
    
    demographicSexPropertyDef.autoValidate=NO;
    
    
    
    
    SCPropertyDefinition *demSexualOrientationPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"sexualOrientation"];
	demSexualOrientationPropertyDef.title = @"Sexual Orientation";
    demSexualOrientationPropertyDef.type = SCPropertyTypeSelection;
	demSexualOrientationPropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Asexual", @"Bisexual", @"Heterosexual",@"Gay", @"Lesbian",@"Uncertain/Questioning",@"Undisclosed", nil] 
                                                                     allowMultipleSelection:NO
                                                                           allowNoSelection:NO autoDismissDetailView:YES hideDetailViewNavigationBar:NO];
    SCPropertyDefinition *demographicNotesPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"profileNotes"];
//    demographicNotesPropertyDef.type=SCPropertyTypeTextView;
    
   
    demographicNotesPropertyDef.type=SCPropertyTypeCustom;
    demographicNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryProfileNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"profileNotes",@"keyString",@"Notes",@"profileNotes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    demographicNotesPropertyDef.objectBindings=encryProfileNotesTVCellKeyBindingsDic;
    demographicNotesPropertyDef.title=@"Notes";
    demographicNotesPropertyDef.autoValidate=NO;
    
    
    
    
    //Do some property definition customization for the Demographic Profile Entity gender attribute
    SCPropertyDefinition *demGenderPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"gender"];
    
   	demGenderPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *genderSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:genderDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO]; 
  
    genderSelectionAttribs.allowAddingItems = YES;
    genderSelectionAttribs.allowDeletingItems = YES;
    genderSelectionAttribs.allowMovingItems = YES;
    genderSelectionAttribs.allowEditingItems = YES;
    genderSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Gender Definitions)"];
    genderSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Gender Definition"];
    demGenderPropertyDef.attributes = genderSelectionAttribs;
    SCPropertyDefinition *genderNotesPropertyDef = [genderDef propertyDefinitionWithName:@"notes"];
    genderNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    //Do some property definition customization for the Demographic Profile Entity disabilities relationship
    SCPropertyDefinition *demDisabilitiesPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"disabilities"];
    
   	demDisabilitiesPropertyDef.type = SCPropertyTypeObjectSelection;
	
    SCObjectSelectionAttributes *disabilitySelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:disabilityDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:NO]; 
    disabilitySelectionAttribs.allowAddingItems = YES;
    disabilitySelectionAttribs.allowDeletingItems = YES;
    disabilitySelectionAttribs.allowMovingItems = YES;
    disabilitySelectionAttribs.allowEditingItems = YES;
    disabilitySelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Disability Definitions)"];
    disabilitySelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Disability Definition"];
    demDisabilitiesPropertyDef.attributes = disabilitySelectionAttribs;
    SCPropertyDefinition *disabilityNotesPropertyDef = [disabilityDef propertyDefinitionWithName:@"notes"];
    disabilityNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *disabilityNamePropertyDef = [disabilityDef propertyDefinitionWithName:@"disabilityName"];
    disabilityNamePropertyDef.type=SCPropertyTypeTextView;
    
    
    //Do some property definition customization for the Demographic Profile Entity education level relationship
    SCPropertyDefinition *demEducationLevelPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"educationLevel"];
    
   	demEducationLevelPropertyDef.type = SCPropertyTypeObjectSelection;
	     SCObjectSelectionAttributes *educationLevelSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:educationLevelDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO]; 
    
    educationLevelSelectionAttribs.allowAddingItems = YES;
    educationLevelSelectionAttribs.allowDeletingItems = YES;
    educationLevelSelectionAttribs.allowMovingItems = YES;
    educationLevelSelectionAttribs.allowEditingItems = YES;
    educationLevelSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Education Level Definitions)"];
    educationLevelSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Education Level Definition"];
    demEducationLevelPropertyDef.attributes = educationLevelSelectionAttribs;
    SCPropertyDefinition *educationLevelNotesPropertyDef = [educationLevelDef propertyDefinitionWithName:@"notes"];
    educationLevelNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *educationLevelPropertyDef = [educationLevelDef propertyDefinitionWithName:@"educationLevel"];
    educationLevelPropertyDef.type=SCPropertyTypeTextView;
    
    
    SCPropertyDefinition *demEmploymentStatusPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"employmentStatus"];
    //Do some property definition customization for the Demographic Profile Entity Employment Status relationship
   	demEmploymentStatusPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *employmentStatusSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:employmentStatuslDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    employmentStatusSelectionAttribs.allowAddingItems = YES;
    employmentStatusSelectionAttribs.allowDeletingItems = YES;
    employmentStatusSelectionAttribs.allowMovingItems = YES;
    employmentStatusSelectionAttribs.allowEditingItems = YES;
    employmentStatusSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Employment Status Definitions)"];
    employmentStatusSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Employment Status Definition"];
    demEmploymentStatusPropertyDef.attributes = employmentStatusSelectionAttribs;
    SCPropertyDefinition *employmentStatusNotesPropertyDef = [employmentStatuslDef propertyDefinitionWithName:@"notes"];
    employmentStatusNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *employmentStatusPropertyDef = [employmentStatuslDef propertyDefinitionWithName:@"employmentStatus"];
    employmentStatusPropertyDef.type=SCPropertyTypeTextView;
    
    
    //Do some property definition customization for the Demographic Profile Entity ethnicities relationship
    SCPropertyDefinition *demEthnicitiesPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"ethnicities"];
    
   	demEthnicitiesPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *ethnicitiesSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:ethnicitylDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:NO];
    ethnicitiesSelectionAttribs.allowAddingItems = YES;
    ethnicitiesSelectionAttribs.allowDeletingItems = YES;
    ethnicitiesSelectionAttribs.allowMovingItems = YES;
    ethnicitiesSelectionAttribs.allowEditingItems = YES;
    ethnicitiesSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Ethnicity Definitions)"];
    ethnicitiesSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Ethnicity Definition"];
    demEthnicitiesPropertyDef.attributes = ethnicitiesSelectionAttribs;
    SCPropertyDefinition *ethnicityNotesPropertyDef = [ethnicitylDef propertyDefinitionWithName:@"notes"];
    ethnicityNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *ethnicityNamePropertyDef = [ethnicitylDef propertyDefinitionWithName:@"ethnicityName"];
    ethnicityNamePropertyDef.type=SCPropertyTypeTextView;
    
    //Do some property definition customization for the Demographic Profile Entity Significant Life Event relationship
    SCPropertyDefinition *significantLifeEventPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"significantLifeEvents"];
    
   	significantLifeEventPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *significantLESelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:significantLifeEventDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:NO];
    significantLESelectionAttribs.allowAddingItems = YES;
    significantLESelectionAttribs.allowDeletingItems = YES;
    significantLESelectionAttribs.allowMovingItems = YES;
    significantLESelectionAttribs.allowEditingItems = YES;
    significantLESelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Significant LE Definitions)"];
    significantLESelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Define New Significant Event"];
    significantLifeEventPropertyDef.attributes = significantLESelectionAttribs;
    SCPropertyDefinition *eventPropertyDef = [significantLifeEventDef propertyDefinitionWithName:@"eventType"];
    eventPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *eventDescPropertyDef = [significantLifeEventDef propertyDefinitionWithName:@"desc"];
    eventDescPropertyDef.type=SCPropertyTypeTextView;
    eventDescPropertyDef.title=@"Description";
    
    //Do some property definition customization for the Demographic Profile Entity languages Spoken relationship
    SCPropertyDefinition *demLanguagesSpokenPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"languagesSpoken"];
    
    
    demLanguagesSpokenPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:languageSpokenDef
                                                                                              allowAddingItems:TRUE
                                                                                            allowDeletingItems:TRUE
                                                                                              allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
    
    SCPropertyDefinition *languagePropertyDef = [languageSpokenDef propertyDefinitionWithName:@"language"];
    languagePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *languageSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:languageDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    languageSelectionAttribs.allowAddingItems = YES;
    languageSelectionAttribs.allowDeletingItems = YES;
    languageSelectionAttribs.allowMovingItems = YES;
    languageSelectionAttribs.allowEditingItems = YES;
    languageSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Languages)"];
    languageSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add Language Definition"];
    languagePropertyDef.attributes = languageSelectionAttribs;
    SCPropertyDefinition *languageNotesPropertyDef = [languageDef propertyDefinitionWithName:@"notes"];
    languageNotesPropertyDef.type=SCPropertyTypeTextView;
    
    languageSpokenDef.titlePropertyName=@"language.language";
    SCPropertyDefinition *languageSpokenNotesPropertyDef = [languageSpokenDef propertyDefinitionWithName:@"notes"];
    languageSpokenNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    NSDictionary *fluencyLevelDataBindings = [NSDictionary 
                                              dictionaryWithObjects:[NSArray arrayWithObject:@"fluencyLevel"] 
                                              forKeys:[NSArray arrayWithObject:@"70"]]; // 1 is the control tag
	SCCustomPropertyDefinition *fluencyLevelDataProperty = [SCCustomPropertyDefinition definitionWithName:@"FluencyData"
                                                                                     uiElementNibName:scaleDataCellNibName
                                                                                       objectBindings:fluencyLevelDataBindings];
	
    
    
    [languageSpokenDef insertPropertyDefinition:fluencyLevelDataProperty atIndex:1];
    
    SCPropertyDefinition *primaryLanguagePropertyDef = [languageSpokenDef propertyDefinitionWithName:@"primaryLanguage"];
    primaryLanguagePropertyDef.type = SCPropertyTypeSegmented;
	primaryLanguagePropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    
    
    SCPropertyDefinition *onlyLanguagePropertyDef = [languageSpokenDef propertyDefinitionWithName:@"onlyLanguage"];
    onlyLanguagePropertyDef.type = SCPropertyTypeSegmented;
	onlyLanguagePropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    
    SCPropertyDefinition *nativeSpeakerPropertyDef = [languageSpokenDef propertyDefinitionWithName:@"nativeSpeaker"];
    nativeSpeakerPropertyDef.type = SCPropertyTypeSegmented;
	nativeSpeakerPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    SCPropertyDefinition *startedSpeakingPropertyDef = [languageSpokenDef propertyDefinitionWithName:@"startedSpeaking"];
	NSDateFormatter *monthYearFormatter = [[NSDateFormatter alloc] init];
	[monthYearFormatter setDateFormat:@"MMM yyyy"];
	startedSpeakingPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:monthYearFormatter
                                                                           datePickerMode:UIDatePickerModeDate
                                                            displayDatePickerInDetailView:NO];
    
    
    
    
    
    //Do some property definition customization for the Demographic Profile Entity culture Groups
    
    SCPropertyDefinition *demCultureGroupsPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"cultureGroups"];
    
   	demCultureGroupsPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *cultureGroupSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:cultureGroupDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:NO];
    cultureGroupSelectionAttribs.allowAddingItems = YES;
    cultureGroupSelectionAttribs.allowDeletingItems = YES;
    cultureGroupSelectionAttribs.allowMovingItems = YES;
    cultureGroupSelectionAttribs.allowEditingItems = YES;
    cultureGroupSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Culture Definitions)"];
    cultureGroupSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Culture Definition"];
    demCultureGroupsPropertyDef.attributes = cultureGroupSelectionAttribs;
    SCPropertyDefinition *cultureGroupNotesPropertyDef = [cultureGroupDef propertyDefinitionWithName:@"notes"];
    cultureGroupNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *cultureGroupNamePropertyDef = [cultureGroupDef propertyDefinitionWithName:@"cultureName"];
    cultureGroupNamePropertyDef.type=SCPropertyTypeTextView;
    
    
    //create an array of objects definition for the immigration History to-many relationship that with show up in a different view with  a place holder element>.
    
    //Create the property definition for the immigrationHistory property
    SCPropertyDefinition *migrationHistoryPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"migrationHistory"];
    migrationHistoryPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:migrationHistoryDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap Here to Add New Migration History"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
 
    //Do some property definition customization for the Immigration History Entity attribute
    SCPropertyDefinition *migrationFromPropertyDef = [migrationHistoryDef propertyDefinitionWithName:@"migratedFrom"];
  
    
    migrationFromPropertyDef.type=SCPropertyTypeCustom;
    migrationFromPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryMigrationFromTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"migratedFrom",@"keyString",@"Migrated From",@"migratedFrom",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    migrationFromPropertyDef.objectBindings=encryMigrationFromTVCellKeyBindingsDic;
    migrationFromPropertyDef.title=@"Migrated From";
    migrationFromPropertyDef.autoValidate=NO;
    
    
    SCPropertyDefinition *migrationToPropertyDef = [migrationHistoryDef propertyDefinitionWithName:@"migratedTo"];
    
    migrationToPropertyDef.type=SCPropertyTypeCustom;
    migrationToPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryMigrationToTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"migratedTo",@"keyString",@"To",@"migratedTo",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    migrationToPropertyDef.objectBindings=encryMigrationToTVCellKeyBindingsDic;
    migrationToPropertyDef.title=@"To";
    migrationToPropertyDef.autoValidate=NO;
    
    SCPropertyDefinition *migrationHistoryNotesPropertyDef = [migrationHistoryDef propertyDefinitionWithName:@"notes"];
    
    migrationHistoryNotesPropertyDef.type=SCPropertyTypeCustom;
    migrationHistoryNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryHistoryNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyString",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    migrationHistoryNotesPropertyDef.objectBindings=encryHistoryNotesTVCellKeyBindingsDic;
    migrationHistoryNotesPropertyDef.title=@"Notes";
    migrationHistoryNotesPropertyDef.autoValidate=NO;
    
    //Create the property definition for the arrivedDate property in the migration history class
    SCPropertyDefinition *arrivedDatePropertyDef = [migrationHistoryDef propertyDefinitionWithName:@"arrivedDate"];
    arrivedDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                      datePickerMode:UIDatePickerModeDate
                                                       displayDatePickerInDetailView:NO];
       
    migrationHistoryDef.titlePropertyName=@"arrivedDate";
    //Do some property definition customization for the Demographic Profile Entity races relationship
    
    SCPropertyDefinition *demRacesPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"races"];
    
   	demRacesPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *racesSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:raceDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:NO];
    racesSelectionAttribs.allowAddingItems = YES;
    racesSelectionAttribs.allowDeletingItems = YES;
    racesSelectionAttribs.allowMovingItems = YES;
    racesSelectionAttribs.allowEditingItems = YES;
    racesSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Race Definitions)"];
    racesSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Race Definition"];
    demRacesPropertyDef.attributes = racesSelectionAttribs;
    SCPropertyDefinition *raceNotesPropertyDef = [raceDef propertyDefinitionWithName:@"notes"];
    raceNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *raceNamePropertyDef = [raceDef propertyDefinitionWithName:@"raceName"];
    raceNamePropertyDef.type=SCPropertyTypeTextView;
    
    
    
    
    //Do some property definition customization for the Demographic Profile Entity spiritual beliefs relationship
    
    SCPropertyDefinition *demSpiritualBeliefsPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"spiritualBeliefs"];
    
   	demSpiritualBeliefsPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *spiritualBeliefSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:spiritualBeliefDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:NO];
    spiritualBeliefSelectionAttribs.allowAddingItems = YES;
    spiritualBeliefSelectionAttribs.allowDeletingItems = YES;
    spiritualBeliefSelectionAttribs.allowMovingItems = YES;
    spiritualBeliefSelectionAttribs.allowEditingItems = YES;
    spiritualBeliefSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Spiritual Belief Definitions)"];
    spiritualBeliefSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Spiritual Belief Definition"];
    demSpiritualBeliefsPropertyDef.attributes = spiritualBeliefSelectionAttribs;
    SCPropertyDefinition *spiritualBeliefNotesPropertyDef = [spiritualBeliefDef propertyDefinitionWithName:@"notes"];
    spiritualBeliefNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *spiritualBeliefNamePropertyDef = [spiritualBeliefDef propertyDefinitionWithName:@"beliefName"];
    spiritualBeliefNamePropertyDef.type=SCPropertyTypeTextView;
    
    
    
    //begin military service section
    
    //Create a class definition for Military History entity
    
    SCEntityDefinition *militaryServiceDef = [SCEntityDefinition definitionWithEntityName:@"MilitaryServiceEntity" 
                                                               managedObjectContext:managedObjectContext
                                                                      propertyNames:[NSArray arrayWithObjects:@"highestRank",@"awards",@"exposureToCombat", @"serviceDisability",@"tsClearance", @"serviceHistory",@"militarySpecialties", @"notes", nil]];  
    
    
    militaryServiceDef.orderAttributeName=@"order";
    
    SCPropertyDefinition *demMilitaryServicePropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"militaryService"];
    demMilitaryServicePropertyDef.type=SCPropertyTypeObject;
    demMilitaryServicePropertyDef.attributes = [SCObjectAttributes attributesWithObjectDefinition:militaryServiceDef];
    
    
    
  
    SCEntityDefinition *militaryServiceDatesDef = [SCEntityDefinition definitionWithEntityName:@"MilitaryServiceDatesEntity" 
                                                                    managedObjectContext:managedObjectContext
                                                                           propertyNames:[NSArray arrayWithObjects:@"branch",@"officerOrEnlisted",@"dischargeType",@"dateJoined",@"dateDischarged",  @"notes", nil]];  
    
    
    militaryServiceDatesDef.titlePropertyNameDelimiter=@", ";
    militaryServiceDatesDef.titlePropertyName=@"branch;dischargeType";
    
    
    
    
    SCPropertyDefinition *serviceHistoryPropertyDef = [militaryServiceDef propertyDefinitionWithName:@"serviceHistory"];
    serviceHistoryPropertyDef.type=SCPropertyTypeArrayOfObjects;
	serviceHistoryPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:militaryServiceDatesDef
                                                                                          allowAddingItems:YES
                                                                                        allowDeletingItems:YES
                                                                                          allowMovingItems:YES
                                                                                expandContentInCurrentView:YES
                                                                                 placeholderuiElement:[SCTableViewCell cellWithText:@"Add Enlistment/Commissions"]
                                                                                     addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap Here To Add Service Record"]
                                                                   addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:NO];
    
    
    
    SCPropertyDefinition *militaryServiceNotesPropertyDef = [militaryServiceDef propertyDefinitionWithName:@"notes"];
    militaryServiceNotesPropertyDef.type=SCPropertyTypeTextView;
    militaryServiceNotesPropertyDef.title=@"Other Notes";
    
    
    SCPropertyDefinition *militaryAwardsNotesPropertyDef = [militaryServiceDef propertyDefinitionWithName:@"awards"];
    militaryAwardsNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    
    
    
    
    SCPropertyDefinition *exposureToCombatPropertyDef = [militaryServiceDef propertyDefinitionWithName:@"exposureToCombat"];
    exposureToCombatPropertyDef.type = SCPropertyTypeSegmented;
	exposureToCombatPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    SCPropertyDefinition *serviceDisabilityPropertyDef = [militaryServiceDef propertyDefinitionWithName:@"serviceDisability"];
    serviceDisabilityPropertyDef.type = SCPropertyTypeSegmented;
	serviceDisabilityPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    SCPropertyDefinition *tsClearancePropertyDef = [militaryServiceDef propertyDefinitionWithName:@"tsClearance"];
    tsClearancePropertyDef.type = SCPropertyTypeSegmented;
	tsClearancePropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    
  /*
    SCPropertyDefinition *militarySpecialtiesPropertyDef = [militaryServiceDef propertyDefinitionWithName:@"militarySpecialties"];
    militarySpecialtiesPropertyDef.type = SCPropertyTypeTextView;
   */ 
   NSString*militarySpecialtiesPropName=@"militarySpecialties";
    if ([SCUtilities is_iPad]) {
        SCPropertyDefinition *militaryServiceSpecialtiesPropertyDef = [militaryServiceDef propertyDefinitionWithName:militarySpecialtiesPropName];
        militaryServiceSpecialtiesPropertyDef.type=SCPropertyTypeTextView;
    }
    else
    {
        
        [militaryServiceDef removePropertyDefinitionWithName:militarySpecialtiesPropName];
        NSDictionary *militarySpecialtiesBindings = [NSDictionary
                                                     dictionaryWithObjects:[NSArray arrayWithObject:militarySpecialtiesPropName]
                                                     forKeys:[NSArray arrayWithObject:@"80"]]; // 1 is the control tag
        SCCustomPropertyDefinition *militarySpecialtiesDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SpecialtiesTextView"
                                                                                                    uiElementNibName:@"TextViewAndLabelCell_iPhone"
                                                                                                      objectBindings:militarySpecialtiesBindings];
        
        
        [militaryServiceDef addPropertyDefinition:militarySpecialtiesDataProperty];
        militarySpecialtiesPropName=@"SpecialtiesTextView";
        
        
    }
    // Create a special group for rest of service related variables
    SCPropertyGroup *militaryServiceGroup = [SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"awards",@"exposureToCombat", @"highestRank",@"serviceDisability",@"tsClearance",militarySpecialtiesPropName,@"SpecialtiesTextView", @"notes", nil]];
    
    [militaryServiceDef.propertyGroups insertGroup:militaryServiceGroup atIndex:0];
    

    // Create a special group for military Records
    SCPropertyGroup *militaryRecordGroup = [SCPropertyGroup groupWithHeaderTitle:@"Service Record" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"serviceHistory", nil]];
    
    [militaryServiceDef.propertyGroups insertGroup:militaryRecordGroup atIndex:1];
    
   
	SCPropertyDefinition *branchOfServicePropertyDef = [militaryServiceDatesDef propertyDefinitionWithName:@"branch"];
    
    
	
    branchOfServicePropertyDef.type = SCPropertyTypeSelection;
	branchOfServicePropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Army", @"Navy", @"Air Force",@"Marines",@"Coast Guard", nil] 
                                                                allowMultipleSelection:NO
                                                                      allowNoSelection:NO autoDismissDetailView:YES hideDetailViewNavigationBar:NO];
    
    
 
    SCPropertyDefinition *officerOrEnlistedPropertyDef = [militaryServiceDatesDef propertyDefinitionWithName:@"officerOrEnlisted"];
    officerOrEnlistedPropertyDef.type = SCPropertyTypeSegmented;
	officerOrEnlistedPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Officer", @"Enlisted", nil]];
    officerOrEnlistedPropertyDef.title=nil;
    
    SCPropertyDefinition *dischargeTypePropertyDef = [militaryServiceDatesDef propertyDefinitionWithName:@"dischargeType"];
    
	
    dischargeTypePropertyDef.type = SCPropertyTypeSelection;
	dischargeTypePropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Honorable Discharge",@"Other Than Honorable Discharge",@"Dishonorable Discharge", nil] 
                                                              allowMultipleSelection:NO
                                                                    allowNoSelection:YES autoDismissDetailView:NO hideDetailViewNavigationBar:NO];
    
    
    
    
    SCPropertyDefinition *dateJoinedPropertyDef = [militaryServiceDatesDef propertyDefinitionWithName:@"dateJoined"];
	
	dateJoinedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                      datePickerMode:UIDatePickerModeDate
                                                       displayDatePickerInDetailView:YES];
    
    
    
    SCPropertyDefinition *dateDischargedPropertyDef = [militaryServiceDatesDef propertyDefinitionWithName:@"dateDischarged"];
	
	dateDischargedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                          datePickerMode:UIDatePickerModeDate
                                                           displayDatePickerInDetailView:YES];
   
    
    SCPropertyDefinition *militaryServiceDatesNotesPropertyDef = [militaryServiceDatesDef propertyDefinitionWithName:@"notes"];
    militaryServiceDatesNotesPropertyDef.type=SCPropertyTypeTextView;
    
  
   
      //end Military History section
    
    //Do some property definition customization for the Demographic Profile Entity military History relationship
    
    
    
    //Do some property definition customization for the Demographic Profile Entity additional variables relationship
    
    SCPropertyDefinition *additionalVariablesPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"additionalVariables"];
    
    additionalVariablesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:additionalVariableDef allowAddingItems:TRUE
                                                                                        allowDeletingItems:TRUE
                                                                                          allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];                 ;	

    SCPropertyDefinition *additionalVariableNamePropertyDef = [additionalVariableDef propertyDefinitionWithName:@"variableName"];
    additionalVariableNamePropertyDef.type = SCPropertyTypeObjectSelection;
	
    
    SCObjectSelectionAttributes *variableNameSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:additionalVariableNameDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    variableNameSelectionAttribs.allowAddingItems = YES;
    variableNameSelectionAttribs.allowDeletingItems = YES;
    variableNameSelectionAttribs.allowMovingItems = YES;
    variableNameSelectionAttribs.allowEditingItems = YES;
    variableNameSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Variable Name Definitions)"];
    variableNameSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add Variable Name Definition"];
    additionalVariableNamePropertyDef.attributes = variableNameSelectionAttribs;
    SCPropertyDefinition *additionalVariableNameNotesPropertyDef = [additionalVariableNameDef propertyDefinitionWithName:@"notes"];
    additionalVariableNameNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    SCPropertyDefinition *additionalVariableValuePropertyDef = [additionalVariableDef propertyDefinitionWithName:@"selectedValue"];
    additionalVariableValuePropertyDef.title=@"Selected Value(s)";
    additionalVariableValuePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *variableValueSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:additionalVariableValueDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:YES];
    variableValueSelectionAttribs.allowAddingItems = NO;
    variableValueSelectionAttribs.allowDeletingItems = NO;
    variableValueSelectionAttribs.allowMovingItems = YES;
    variableValueSelectionAttribs.allowEditingItems = YES;
    variableValueSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Values under variable name definition)"];
    variableValueSelectionAttribs.addNewObjectuiElement = nil;
    additionalVariableValuePropertyDef.attributes = variableValueSelectionAttribs;
    SCPropertyDefinition *additionalVariableValueNotesPropertyDef = [additionalVariableValueDef propertyDefinitionWithName:@"notes"];
    additionalVariableValueNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    
    
    
    SCPropertyDefinition *additionalVariableNotesPropertyDef = [additionalVariableDef propertyDefinitionWithName:@"notes"];
    additionalVariableNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *additionalVariableStingValuePropertyDef = [additionalVariableDef propertyDefinitionWithName:@"stringValue"];
    additionalVariableStingValuePropertyDef.type=SCPropertyTypeTextView;
    
    NSDictionary *scaleDataBindings = [NSDictionary 
                                       dictionaryWithObjects:[NSArray arrayWithObject:@"scale"] 
                                       forKeys:[NSArray arrayWithObject:@"70"]]; // 1 is the control tag
	SCCustomPropertyDefinition *scaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"ScaleData"
                                                                              uiElementNibName:scaleDataCellNibName
                                                                                objectBindings:scaleDataBindings];
	
    
    
    [additionalVariableDef insertPropertyDefinition:scaleDataProperty atIndex:2];
    NSDictionary *sliderOneDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObject:@"sliderOne"] 
                                           forKeys:[NSArray arrayWithObject:@"14"]]; // 1 is the control tag
	SCCustomPropertyDefinition *sliderOneDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SliderOneData"                                                                                  uiElementNibName:@"SliderOneDataCell_iPhone" objectBindings:sliderOneDataBindings];
	
    
    
    [additionalVariableDef insertPropertyDefinition:sliderOneDataProperty atIndex:3];
    
    NSDictionary *sliderTwoDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObject:@"sliderTwo"] 
                                           forKeys:[NSArray arrayWithObject:@"14"]]; // 1 is the control tag
	SCCustomPropertyDefinition *sliderTwoDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SliderTwoData"
                                                                                  uiElementNibName:@"SliderOneDataCell_iPhone" 
                                                                                    objectBindings:sliderTwoDataBindings];
	
    
    [additionalVariableDef insertPropertyDefinition:sliderTwoDataProperty atIndex:4];
    
    
    
    
    
    
    
    SCPropertyDefinition *additionalVariableDateValuePropertyDef = [additionalVariableDef propertyDefinitionWithName:@"dateValue"];
	additionalVariableDateValuePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                                       datePickerMode:UIDatePickerModeDate 
                                                                        displayDatePickerInDetailView:NO];
    
    SCPropertyDefinition *additionalVariableTimeValuePropertyDef = [additionalVariableDef propertyDefinitionWithName:@"timeValue"];
	additionalVariableTimeValuePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:timeFormatter datePickerMode:UIDatePickerModeTime displayDatePickerInDetailView:NO];
    
    
    NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
	[dateTimeFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    
	
    
    
    SCPropertyDefinition *timeValueTwoPropertyDef = [additionalVariableDef propertyDefinitionWithName:@"timeValueTwo"];
    timeValueTwoPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateTimeFormatter datePickerMode:UIDatePickerModeDateAndTime displayDatePickerInDetailView:NO];
    
    
    timeValueTwoPropertyDef.title=@"Date & Time";
    
    additionalVariableDef.titlePropertyName=@"variableName.variableName";
    
        
    //Create a class definition for the interpersonalEntity
    SCEntityDefinition *interpersonalDef = [SCEntityDefinition definitionWithEntityName:@"InterpersonalEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"relationship", @"notes"   , nil]];
    
    //Create a class definition for the relationshipEntity
    SCEntityDefinition *relationshipDef = [SCEntityDefinition definitionWithEntityName:@"RelationshipEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"relationship" , nil]];
    

    
    //create an array of objects definition for the interpersonal to-many relationship that with show up in a different view with  a place holder element>.
    
    //Create the property definition for the interpersonal property
    SCPropertyDefinition *interpersonalPropertyDef = [demographicProfileDef propertyDefinitionWithName:@"interpersonal"];
    interpersonalPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:interpersonalDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add interpersonal relationship" ]addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	

    //create an object selection for the relationship in the Interpersonal Entity 
    
    //create a property definition
    SCPropertyDefinition *interpersonalRelationshipPropertyDef = [interpersonalDef propertyDefinitionWithName:@"relationship"];
    
    //set a custom title
    interpersonalPropertyDef.title =@"Interpersonal Relationships";
    
    //set the title property name
    interpersonalDef.titlePropertyName=@"relationship.relationship;notes";
    interpersonalDef.titlePropertyNameDelimiter=@" - ";
    //set the property definition type to objects selection
	
    interpersonalRelationshipPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *interpersonalRelationshipSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:relationshipDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    
    //set some addtional attributes
    interpersonalRelationshipSelectionAttribs.allowAddingItems = YES;
    interpersonalRelationshipSelectionAttribs.allowDeletingItems = YES;
    interpersonalRelationshipSelectionAttribs.allowMovingItems = YES;
    interpersonalRelationshipSelectionAttribs.allowEditingItems = YES;
    

//    //add a placeholder element to tell the user what to do     when there are no other cells                                          
//    interpersonalRelationshipSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(tap + to add relationship definition)"];
//    
    
    //add an "Add New" element to appear when user clicks edit
    interpersonalRelationshipSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Relationship Type"];
    
    //add the selection attributes to the property definition
    interpersonalRelationshipPropertyDef.attributes = interpersonalRelationshipSelectionAttribs;
    
    //Create the property definition for the notes property in the interpersonal class
    SCPropertyDefinition *interpersonalNotesPropertyDef = [interpersonalDef propertyDefinitionWithName:@"notes"];
    
       
    interpersonalNotesPropertyDef.type=SCPropertyTypeCustom;
    interpersonalNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryInterpersonalNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyString",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    interpersonalNotesPropertyDef.objectBindings=encryInterpersonalNotesTVCellKeyBindingsDic;
    interpersonalNotesPropertyDef.title=@"Notes";
    interpersonalNotesPropertyDef.autoValidate=NO;
    
//       BOPickersDataSource *boPicker=[[BOPickersDataSource alloc]init];
    
    
    //create a property definition for the sleep Quality property in the clientPresentations class
    SCPropertyDefinition *visionPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"vision"];
    
    
    
    //set the property type to selection
    visionPropertyDef.type = SCPropertyTypeSelection;
    
    //set the selection attributes and define the list of items to be selected
    visionPropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:
                                                                               @"good/normal", @"contacts",@"glasses",
                                                                               @"Mildly Nearsighted",@"Moderately Nearsighted", @"Very Nearsighted", @"Mildly Farsighted",@"Moderately Farsighted", @"Very Farsighted", @"Reading Glasses", @"Astigmatism", @"Legally Blind Corrected",@"Color Blind ",@"Completely Blind",    
                                                                               nil]
                                                       allowMultipleSelection:YES
                                                             allowNoSelection:YES
                                                        autoDismissDetailView:NO hideDetailViewNavigationBar:NO];
    
    //create a property definition for the sleep Quality property in the clientPresentations class
    SCPropertyDefinition *hearingPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"hearing"];
    
    
    
    //set the property type to selection
    hearingPropertyDef.type = SCPropertyTypeSelection;
    
    //set the selection attributes and define the list of items to be selected
    hearingPropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:
                                                                                @"good/normal right",@"good/normal left", @"hearing aid right",@"hearing aid left",@"mild difficulty right",@"moderate difficulty right",@"severe difficulty right",@"mild difficulty left",@"moderate difficulty left",@"severe difficulty left",@"deaf",    
                                                                                nil]
                                                       allowMultipleSelection:YES
                                                             allowNoSelection:YES
                                                        autoDismissDetailView:NO hideDetailViewNavigationBar:NO];
    
    

    
    
    
//    NSDictionary *frequencyPickerDataBindings = [NSDictionary 
//                                              dictionaryWithObjects:[NSArray arrayWithObjects:@"contactFrequencyUnit",@"contactFrequencyNumber",@"contactFrequencyUnitLength",@"Contact Frequency",nil] 
//                                              forKeys:[NSArray arrayWithObjects:@"50", @"51",@"52", @"53", nil]]; // 2, 3, 4 are the control tags
//	
//    
//    NSString *frequencyPickerNibName;
//    if ([SCUtilities is_iPad]) 
//        frequencyPickerNibName=[NSString stringWithString:@"FrequencyPickerCell_iPad"];
//    else
//        frequencyPickerNibName=[NSString stringWithString:@"FrequencyPickerCell_iPhone"];
//    
//    SCCustomPropertyDefinition *frequencyProperty = [SCCustomPropertyDefinition definitionWithName:@"ContactFrequency" uiElementNibName:frequencyPickerNibName objectBindings:frequencyPickerDataBindings];
//	[interpersonalDef insertPropertyDefinition:frequencyProperty atIndex:1];
//    
//    NSString *longTimePickerCellNibName;
//    
//    if([SCUtilities is_iPad])
//        longTimePickerCellNibName=[NSString stringWithString:@"LongTimePickerCell_iPad"];
//    else
//        longTimePickerCellNibName=[NSString stringWithString:@"LongTimePickerCell_iPhone"];
//    
//    
//    
//    //create the dictionary with the data bindings
//    NSDictionary *durationDataBindings = [NSDictionary 
//                                                dictionaryWithObjects:[NSArray arrayWithObjects:@"duration",@"duration", @"Duration", nil ] 
//                                                forKeys:[NSArray arrayWithObjects:@"40" , @"41",@"42",   nil]]; // 40, 41,42 are the control tags
//	
//    //create the custom property definition for addtional time
//    SCCustomPropertyDefinition *durationPropertyDef = [SCCustomPropertyDefinition definitionWithName:@"Duration" uiElementNibName:longTimePickerCellNibName  objectBindings:durationDataBindings];	
//    
//    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
//    durationPropertyDef.autoValidate=FALSE;
//    
//       
//    [interpersonalDef insertPropertyDefinition:durationPropertyDef atIndex:2];
    
//    SCCustomPropertyDefinition *titleProperty = [SCCustomPropertyDefinition definitionWithName:@"Time of Day" uiElementClass:[ TimeOfDayPickerCell class] objectBindings:nil];
//	[interpersonalDef insertPropertyDefinition:titleProperty atIndex:3];

    
    //end demographic profile setup, will add demographic profile to clinician definition below 

    return self;
    
    
}



@end
