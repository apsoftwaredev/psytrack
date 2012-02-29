//
//  DemographicDetailViewController_Shared.m
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/24/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import "DemographicDetailViewController_Shared.h"
#import "PTTAppDelegate.h"
#import "TimeOfDayPickerCell.h"

@implementation DemographicDetailViewController_Shared
@synthesize demographicProfileDef;

-(id)setupTheDemographicView{
    
    
    NSManagedObjectContext *managedObjectContext=[(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    
    NSString *shortFieldCellNibName=nil;
    NSString *textFieldAndLableNibName=nil;
    NSString *scaleDataCellNibName=nil;
    if ([SCHelper is_iPad]) {
        textFieldAndLableNibName=@"TextFieldAndLabelCell_iPad";
        shortFieldCellNibName=@"ShortFieldCell_iPad";
        scaleDataCellNibName=@"ScaleDataCell_iPad";

        
       
        
    } else
    {
        textFieldAndLableNibName=@"TextFieldAndLabelCell_iPhone";
        shortFieldCellNibName=@"ShortFieldCell_iPhone";
        scaleDataCellNibName=@"ScaleDataCell_iPhone";       
    }
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMM dd, yyyy"];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
	[timeFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    //start Demographic Profile setup
    //Create a class definition for Demographic Profile entity
	self.demographicProfileDef = [SCClassDefinition definitionWithEntityName:@"DemographicProfileEntity" 
                                                    withManagedObjectContext:managedObjectContext
                                                           withPropertyNames:[NSArray arrayWithObjects:@"profileNotes",@"sex",@"gender", @"sexualOrientation",
                                                                              @"disabilities",@"educationLevel",@"employmentStatus", @"ethnicities",@"languagesSpoken",
                                                                              @"cultureGroups",@"immigrationHistory", @"interpersonal",  
                                                                              @"races",@"spiritualBeliefs",@"significantLifeEvents",@"militaryService", @"additionalVariables",nil]];
	
    
    
    //Create a class definition for Demographic Gender entity
    SCClassDefinition *genderDef = [SCClassDefinition definitionWithEntityName:@"GenderEntity" 
                                                      withManagedObjectContext:managedObjectContext
                                                             withPropertyNames:[NSArray arrayWithObjects:@"genderName",@"notes",nil]];
    
    genderDef.orderAttributeName=@"order";
    //Create a class definition for Demographic Immigration History entity
    SCClassDefinition *immigrationHistoryDef = [SCClassDefinition definitionWithEntityName:@"ImmigrationHistoryEntity" 
                                                                 withManagedObjectContext:managedObjectContext
                                                                        withPropertyNames:[NSArray arrayWithObjects:@"immigrationHistory",@"notes",nil]];
    immigrationHistoryDef.orderAttributeName=@"order";
    //Create a class definition for  Disablity entity
    SCClassDefinition *disabilityDef = [SCClassDefinition definitionWithEntityName:@"DisabilityEntity" 
                                                          withManagedObjectContext:managedObjectContext
                                                                 withPropertyNames:[NSArray arrayWithObjects:@"disabilityName",@"notes",nil]];
    disabilityDef.orderAttributeName=@"order";
    //Create a class definition for Education Level entity
    SCClassDefinition *educationLevelDef = [SCClassDefinition definitionWithEntityName:@"EducationLevelEntity" 
                                                              withManagedObjectContext:managedObjectContext
                                                                     withPropertyNames:[NSArray arrayWithObjects:@"educationLevel",@"notes",nil]];
    educationLevelDef.orderAttributeName=@"order";
    //Create a class definition for Employment Status entity
    SCClassDefinition *employmentStatuslDef = [SCClassDefinition definitionWithEntityName:@"EmploymentStatusEntity" 
                                                                 withManagedObjectContext:managedObjectContext
                                                                        withPropertyNames:[NSArray arrayWithObjects:@"employmentStatus",@"notes",nil]];
    
    employmentStatuslDef.orderAttributeName=@"order";
    //Create a class definition for Ethnicity entity
    SCClassDefinition *ethnicitylDef = [SCClassDefinition definitionWithEntityName:@"EthnicityEntity" 
                                                          withManagedObjectContext:managedObjectContext
                                                                 withPropertyNames:[NSArray arrayWithObjects:
                                                                                    @"ethnicityName",@"notes",nil]]; 
    ethnicitylDef.orderAttributeName=@"order";
    //Create a class definition for Culture Group entity
    SCClassDefinition *cultureGroupDef = [SCClassDefinition definitionWithEntityName:@"CultureGroupEntity" 
                                                            withManagedObjectContext:managedObjectContext
                                                                   withPropertyNames:[NSArray arrayWithObjects:@"cultureName",@"notes",nil]];  
    
    //Create a class definition for Languages Spoken entity
    SCClassDefinition *languageSpokenDef = [SCClassDefinition definitionWithEntityName:@"LanguageSpokenEntity" 
                                                              withManagedObjectContext:managedObjectContext
                                                                     withPropertyNames:[NSArray arrayWithObjects:@"language", @"primaryLanguage", @"nativeSpeaker", @"onlyLanguage", @"startedSpeaking", @"notes", nil]];  
    
    
    
    languageSpokenDef.orderAttributeName=@"order";
    //Create a class definition for Language entity
    SCClassDefinition *languageDef = [SCClassDefinition definitionWithEntityName:@"LanguageEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"language",@"notes",nil]];  
    
    
    languageDef.orderAttributeName=@"order";
    
    
    
    //Create a class definition for Race entity
    SCClassDefinition *raceDef = [SCClassDefinition definitionWithEntityName:@"RaceEntity" 
                                                    withManagedObjectContext:managedObjectContext
                                                           withPropertyNames:[NSArray arrayWithObjects:@"raceName",@"notes",nil]];  
    
    //Create a class definition for Spiritual Belief entity
    SCClassDefinition *spiritualBeliefDef = [SCClassDefinition definitionWithEntityName:@"SpiritualBeliefEntity" 
                                                               withManagedObjectContext:managedObjectContext
                                                                      withPropertyNames:[NSArray arrayWithObjects:@"beliefName",@"notes",nil]];  
    
    
    spiritualBeliefDef.orderAttributeName=@"order";
    //Create a class definition for Significant Life Event entity
    SCClassDefinition *significantLifeEventDef = [SCClassDefinition definitionWithEntityName:@"SignificantLifeEventEntity" 
                                                                    withManagedObjectContext:managedObjectContext
                                                                           withPropertyNames:[NSArray arrayWithObjects:@"eventType",@"desc",nil]];  
    
    
    significantLifeEventDef.orderAttributeName=@"order";
    
    
    
    
    
    //Create a class definition for Additional Variables entity 
    SCClassDefinition *additionalVariableDef = [SCClassDefinition definitionWithEntityName:@"AdditionalVariableEntity" 
                                                                  withManagedObjectContext:managedObjectContext
                                                                         withPropertyNames:[NSArray arrayWithObjects:@"variableName",@"selectedValue",@"stringValue",@"timeValue",@"dateValue",@"timeValueTwo", @"notes",nil]];  
    
    
    
    
    
    
    
    
    
    additionalVariableDef.orderAttributeName=@"order";
    //Create a class definition for Additional Variable Name entity
    SCClassDefinition *additionalVariableNameDef = [SCClassDefinition definitionWithEntityName:@"AdditionalVariableNameEntity" 
                                                                      withManagedObjectContext:managedObjectContext
                                                                             withPropertyNames:[NSArray arrayWithObjects:@"variableName",@"notes",nil]]; 
    
    
    
    
    
    additionalVariableNameDef.orderAttributeName=@"order";
    
    SCClassDefinition *additionalVariableValueDef = [SCClassDefinition definitionWithEntityName:@"AdditionalVariableValueEntity" 
                                                                       withManagedObjectContext:managedObjectContext
                                                                              withPropertyNames:[NSArray arrayWithObjects:@"variableValue",@"notes",nil]]; 
    
    
    additionalVariableValueDef.orderAttributeName=@"order";
    
    
    //Do some property definition customization for the Demographic Profile Entity sex and Profile notes attributes
    SCPropertyDefinition *demographicSexPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"sex"];
	demographicSexPropertyDef.title = @"Sex";
    demographicSexPropertyDef.type = SCPropertyTypeSelection;
	demographicSexPropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Male", @"Female", @"Intersexual",@"F2M",@"M2F",@"Undisclosed", nil] 
                                                               allowMultipleSelection:NO
                                                                     allowNoSelection:NO
                                                                autoDismissDetailView:YES hideDetailViewNavigationBar:NO];
    
    SCPropertyDefinition *demSexualOrientationPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"sexualOrientation"];
	demSexualOrientationPropertyDef.title = @"Sexual Orientation";
    demSexualOrientationPropertyDef.type = SCPropertyTypeSelection;
	demSexualOrientationPropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Asexual", @"Bisexual", @"Heterosexual",@"Homosexual", @"Undisclosed", nil] 
                                                                     allowMultipleSelection:NO
                                                                           allowNoSelection:NO autoDismissDetailView:YES hideDetailViewNavigationBar:NO];
    SCPropertyDefinition *demographicNotesPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"profileNotes"];
    demographicNotesPropertyDef.type=SCPropertyTypeTextView;
    
    //Do some property definition customization for the Demographic Profile Entity gender attribute
    SCPropertyDefinition *demGenderPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"gender"];
    
   	demGenderPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *genderSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:genderDef allowMultipleSelection:NO allowNoSelection:NO];
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
	SCObjectSelectionAttributes *disabilitySelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:disabilityDef allowMultipleSelection:YES allowNoSelection:NO];
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
	SCObjectSelectionAttributes *educationLevelSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:educationLevelDef allowMultipleSelection:NO allowNoSelection:NO];
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
	SCObjectSelectionAttributes *employmentStatusSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:employmentStatuslDef allowMultipleSelection:NO allowNoSelection:NO];
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
	SCObjectSelectionAttributes *ethnicitiesSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:ethnicitylDef allowMultipleSelection:YES allowNoSelection:NO];
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
	SCObjectSelectionAttributes *significantLESelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:significantLifeEventDef allowMultipleSelection:YES allowNoSelection:NO];
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
    
    
    demLanguagesSpokenPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:languageSpokenDef
                                                                                              allowAddingItems:TRUE
                                                                                            allowDeletingItems:TRUE
                                                                                              allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
    
    SCPropertyDefinition *languagePropertyDef = [languageSpokenDef propertyDefinitionWithName:@"language"];
    languagePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *languageSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:languageDef allowMultipleSelection:NO allowNoSelection:NO];
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
                                                                                     withuiElementNibName:scaleDataCellNibName
                                                                                       withObjectBindings:fluencyLevelDataBindings];
	
    
    
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
	SCObjectSelectionAttributes *cultureGroupSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:cultureGroupDef allowMultipleSelection:YES allowNoSelection:NO];
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
    
    
    
    //Do some property definition customization for the Immigration History Entity attribute
    SCPropertyDefinition *immigrationHistoryPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"immigrationHistory"];
    
   	immigrationHistoryPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *immigrationHistorySelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:immigrationHistoryDef allowMultipleSelection:NO allowNoSelection:NO];
    immigrationHistorySelectionAttribs.allowAddingItems = YES;
    immigrationHistorySelectionAttribs.allowDeletingItems = YES;
    immigrationHistorySelectionAttribs.allowMovingItems = YES;
    immigrationHistorySelectionAttribs.allowEditingItems = YES;
    immigrationHistorySelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Immigration History Definitions)"];
    immigrationHistorySelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Immigration History Definition"];
    immigrationHistoryPropertyDef.attributes = immigrationHistorySelectionAttribs;
    SCPropertyDefinition *immigrationHistoryNotesPropertyDef = [immigrationHistoryDef propertyDefinitionWithName:@"notes"];
    immigrationHistoryNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *immigrationHistoryNamePropertyDef = [immigrationHistoryDef propertyDefinitionWithName:@"immigrationHistory"];
    immigrationHistoryNamePropertyDef.type=SCPropertyTypeTextView;
    
    
    
    //Do some property definition customization for the Demographic Profile Entity races relationship
    
    SCPropertyDefinition *demRacesPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"races"];
    
   	demRacesPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *racesSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:raceDef allowMultipleSelection:YES allowNoSelection:NO];
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
	SCObjectSelectionAttributes *spiritualBeliefSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:spiritualBeliefDef allowMultipleSelection:YES allowNoSelection:NO];
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
    
    SCClassDefinition *militaryServiceDef = [SCClassDefinition definitionWithEntityName:@"MilitaryServiceEntity" 
                                                               withManagedObjectContext:managedObjectContext
                                                                      withPropertyNames:[NSArray arrayWithObjects:@"highestRank",@"awards",@"exposureToCombat", @"serviceDisability",@"tsClearance", @"serviceHistory",@"militarySpecialties", @"notes", nil]];  
    
    
    militaryServiceDef.orderAttributeName=@"order";
    
    SCPropertyDefinition *demMilitaryServicePropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"militaryService"];
    demMilitaryServicePropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:militaryServiceDef
                                                                                              allowAddingItems:FALSE
                                                                                            allowDeletingItems:FALSE
                                                                                              allowMovingItems:FALSE];
    
    
    
  
    SCClassDefinition *militaryServiceDatesDef = [SCClassDefinition definitionWithEntityName:@"MilitaryServiceDatesEntity" 
                                                                    withManagedObjectContext:managedObjectContext
                                                                           withPropertyNames:[NSArray arrayWithObjects:@"branch",@"officerOrEnlisted",@"dischargeType",@"dateJoined",@"dateDischarged",  @"notes", nil]];  
    
    
    militaryServiceDatesDef.titlePropertyNameDelimiter=@", ";
    militaryServiceDatesDef.titlePropertyName=@"branch;dischargeType";
    
    
    
    
    SCPropertyDefinition *serviceHistoryPropertyDef = [militaryServiceDef propertyDefinitionWithName:@"serviceHistory"];
    
	serviceHistoryPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:militaryServiceDatesDef
                                                                                          allowAddingItems:YES
                                                                                        allowDeletingItems:YES
                                                                                          allowMovingItems:YES
                                                                                expandContentInCurrentView:YES 
                                                                                      placeholderuiElement:nil 
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
    
    
    
    SCPropertyDefinition *militarySpecialtiesPropertyDef = [militaryServiceDef propertyDefinitionWithName:@"militarySpecialties"];
    militarySpecialtiesPropertyDef.type = SCPropertyTypeTextView;
    
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
                                                                    allowNoSelection:YES autoDismissDetailView:YES hideDetailViewNavigationBar:NO];
    
    
    
    
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
    
    NSString*militarySpecialtiesPropName=@"militarySpecialties";
    if ([SCHelper is_iPad]) {
        SCPropertyDefinition *militaryServiceSpecialtiesPropertyDef = [militaryServiceDatesDef propertyDefinitionWithName:militarySpecialtiesPropName];
        militaryServiceSpecialtiesPropertyDef.type=SCPropertyTypeTextView;
    }
    else
    {
        
        [militaryServiceDef removePropertyDefinitionWithName:militarySpecialtiesPropName];
        NSDictionary *militarySpecialtiesBindings = [NSDictionary 
                                                     dictionaryWithObjects:[NSArray arrayWithObject:@"militarySpecialties"] 
                                                     forKeys:[NSArray arrayWithObject:@"80"]]; // 1 is the control tag
        SCCustomPropertyDefinition *militarySpecialtiesDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SpecialtiesTextView"
                                                                                                withuiElementNibName:@"TextViewAndLabelCell_iPhone"
                                                                                                  withObjectBindings:militarySpecialtiesBindings];
        
        
        [militaryServiceDef addPropertyDefinition:militarySpecialtiesDataProperty];
        militarySpecialtiesPropName=@"SpecialtiesTextView";

        
    }
    
    // Create a special group for military Records
    SCPropertyGroup *militaryRecordGroup = [SCPropertyGroup groupWithHeaderTitle:@"Service Record" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"serviceHistory", nil]];
    
    [militaryServiceDef.propertyGroups insertGroup:militaryRecordGroup atIndex:0];
    
    // Create a special group for rest of service related variables
    SCPropertyGroup *militaryServiceGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"awards",@"exposureToCombat", @"highestRank",@"serviceDisability",@"tsClearance",militarySpecialtiesPropName, @"notes", nil]];
    
    [militaryServiceDef.propertyGroups insertGroup:militaryServiceGroup atIndex:1];
    
    //end Military History section
    
    //Do some property definition customization for the Demographic Profile Entity military History relationship
    
    
    
    //Do some property definition customization for the Demographic Profile Entity additional variables relationship
    
    SCPropertyDefinition *additionalVariablesPropertyDef = [self.demographicProfileDef propertyDefinitionWithName:@"additionalVariables"];
    
    additionalVariablesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:additionalVariableDef
                                                                                               allowAddingItems:TRUE
                                                                                             allowDeletingItems:TRUE
                                                                                               allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
    
    SCPropertyDefinition *additionalVariableNamePropertyDef = [additionalVariableDef propertyDefinitionWithName:@"variableName"];
    additionalVariableNamePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *variableNameSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:additionalVariableNameDef allowMultipleSelection:NO allowNoSelection:NO];
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
	SCObjectSelectionAttributes *variableValueSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:additionalVariableValueDef allowMultipleSelection:YES allowNoSelection:YES];
    variableValueSelectionAttribs.allowAddingItems = YES;
    variableValueSelectionAttribs.allowDeletingItems = YES;
    variableValueSelectionAttribs.allowMovingItems = YES;
    variableValueSelectionAttribs.allowEditingItems = YES;
    variableValueSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Variable Value Definitions)"];
    variableValueSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add Variable Value Definition"];
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
                                                                              withuiElementNibName:scaleDataCellNibName
                                                                                withObjectBindings:scaleDataBindings];
	
    
    
    [additionalVariableDef insertPropertyDefinition:scaleDataProperty atIndex:2];
    NSDictionary *sliderOneDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObject:@"sliderOne"] 
                                           forKeys:[NSArray arrayWithObject:@"14"]]; // 1 is the control tag
	SCCustomPropertyDefinition *sliderOneDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SliderOneData"                                                                                  withuiElementNibName:@"SliderOneDataCell_iPhone" withObjectBindings:sliderOneDataBindings];
	
    
    
    [additionalVariableDef insertPropertyDefinition:sliderOneDataProperty atIndex:3];
    
    NSDictionary *sliderTwoDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObject:@"sliderTwo"] 
                                           forKeys:[NSArray arrayWithObject:@"14"]]; // 1 is the control tag
	SCCustomPropertyDefinition *sliderTwoDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SliderTwoData"
                                                                                  withuiElementNibName:@"SliderOneDataCell_iPhone" 
                                                                                    withObjectBindings:sliderTwoDataBindings];
	
    
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
    SCClassDefinition *interpersonalDef = [SCClassDefinition definitionWithEntityName:@"InterpersonalEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"relationship", @"notes"   , nil]];
    
    //Create a class definition for the relationshipEntity
    SCClassDefinition *relationshipDef = [SCClassDefinition definitionWithEntityName:@"RelationshipEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"relationship" , nil]];
    

    
    //create an array of objects definition for the interpersonal to-many relationship that with show up in a different view with  a place holder element>.
    
    //Create the property definition for the interpersonal property
    SCPropertyDefinition *interpersonalPropertyDef = [demographicProfileDef propertyDefinitionWithName:@"interpersonal"];
    interpersonalPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:interpersonalDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add relationship)"] addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add Interpersonal Relationship" ]addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];	

    //create an object selection for the relationship in the Interpersonal Entity 
    
    //create a property definition
    SCPropertyDefinition *interpersonalRelationshipPropertyDef = [interpersonalDef propertyDefinitionWithName:@"relationship"];
    
    //set a custom title
    interpersonalPropertyDef.title =@"Interpersonal Relationships";
    
    //set the title property name
    interpersonalDef.titlePropertyName=@"relationship.relationship";
    
    //set the property definition type to objects selection
	
    interpersonalRelationshipPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *interpersonalRelationshipSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:relationshipDef allowMultipleSelection:NO allowNoSelection:NO];
    
    //set some addtional attributes
    interpersonalRelationshipSelectionAttribs.allowAddingItems = YES;
    interpersonalRelationshipSelectionAttribs.allowDeletingItems = YES;
    interpersonalRelationshipSelectionAttribs.allowMovingItems = YES;
    interpersonalRelationshipSelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    interpersonalRelationshipSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(tap + to add relationship definition)"];
    
    
    //add an "Add New" element to appear when user clicks edit
    interpersonalRelationshipSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Relationship Definition"];
    
    //add the selection attributes to the property definition
    interpersonalRelationshipPropertyDef.attributes = interpersonalRelationshipSelectionAttribs;
    
    //Create the property definition for the notes property in the interpersonal class
    SCPropertyDefinition *interpersonalNotesPropertyDef = [interpersonalDef propertyDefinitionWithName:@"notes"];
    
       
    //set the notes property definition type to a Text View Cell
    interpersonalNotesPropertyDef.type = SCPropertyTypeTextView;
    
    NSDictionary *frequencyPickerDataBindings = [NSDictionary 
                                              dictionaryWithObjects:[NSArray arrayWithObjects:@"contactFrequencyUnit",@"contactFrequencyNumber",@"contactFrequencyUnitLength",@"Contact Frequency",nil] 
                                              forKeys:[NSArray arrayWithObjects:@"50", @"51",@"52", @"53", nil]]; // 2, 3, 4 are the control tags
	
    
    NSString *frequencyPickerNibName;
    if ([SCHelper is_iPad]) 
        frequencyPickerNibName=[NSString stringWithString:@"FrequencyPickerCell_iPad"];
    else
        frequencyPickerNibName=[NSString stringWithString:@"FrequencyPickerCell_iPhone"];
    
    SCCustomPropertyDefinition *frequencyProperty = [SCCustomPropertyDefinition definitionWithName:@"ContactFrequency" withuiElementNibName:frequencyPickerNibName withObjectBindings:frequencyPickerDataBindings];
	[interpersonalDef insertPropertyDefinition:frequencyProperty atIndex:1];
    
    NSString *longTimePickerCellNibName;
    
    if([SCHelper is_iPad])
        longTimePickerCellNibName=[NSString stringWithString:@"LongTimePickerCell_iPad"];
    else
        longTimePickerCellNibName=[NSString stringWithString:@"LongTimePickerCell_iPhone"];
    
    
    
    //create the dictionary with the data bindings
    NSDictionary *durationDataBindings = [NSDictionary 
                                                dictionaryWithObjects:[NSArray arrayWithObjects:@"duration",@"duration", @"Duration", nil ] 
                                                forKeys:[NSArray arrayWithObjects:@"40" , @"41",@"42",   nil]]; // 40, 41,42 are the control tags
	
    //create the custom property definition for addtional time
    SCCustomPropertyDefinition *durationPropertyDef = [SCCustomPropertyDefinition definitionWithName:@"Duration" withuiElementNibName:longTimePickerCellNibName  withObjectBindings:durationDataBindings];	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    durationPropertyDef.autoValidate=FALSE;
    
       
    [interpersonalDef insertPropertyDefinition:durationPropertyDef atIndex:2];
    
//    SCCustomPropertyDefinition *titleProperty = [SCCustomPropertyDefinition definitionWithName:@"Time of Day" withuiElementClass:[ TimeOfDayPickerCell class] withObjectBindings:nil];
//	[interpersonalDef insertPropertyDefinition:titleProperty atIndex:3];

    
    //end demographic profile setup, will add demographic profile to clinician definition below 

    return self;
    
    
}



@end
