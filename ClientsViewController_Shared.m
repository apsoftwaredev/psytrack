/*
 *  ClientsViewController_Shared.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/26/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ClientsViewController_Shared.h"
#import "PTTAppDelegate.h"
#import "DemographicDetailViewController_Shared.h"
#import "ButtonCell.h"
#import "ClientEntity.h"
#import "EncryptedSCTextFieldCell.h"
#import "EncryptedSCDateCell.h"
#import "EncryptedSCTextViewCell.h"
#import "DrugNameObjectSelectionCell.h"
#import "ClinicianSelectionCell.h"

@implementation ClientsViewController_Shared
@synthesize clientDef;


-(id)setupTheClientsViewModelUsingSTV{

managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMM dd, yyyy"];
    
    
    
    DemographicDetailViewController_Shared *demographicDetailViewController_Shared =[[DemographicDetailViewController_Shared alloc]init];
    
    [demographicDetailViewController_Shared setupTheDemographicView];
    [demographicDetailViewController_Shared.demographicProfileDef removePropertyDefinitionWithName:@"client"];
    
    //Create a class definition for Client entity
    
   
    
	self.clientDef = [SCEntityDefinition definitionWithEntityName:@"ClientEntity" 
                                                      managedObjectContext:managedObjectContext 
                                                             propertyNames:[NSArray arrayWithObjects:@"clientIDCode", @"dateOfBirth", @"keyString",
                                                                                @"initials",  @"demographicInfo", @"dateAdded",@"currentClient",@"phoneNumbers", @"logs", @"medicationHistory",@"diagnoses", @"vitals",  
                                                                @"notes",@"groups",nil]];
	
    
    
   
    //NSLog(@"client def entity description %@",self.clientDef.entity.description);
    
    SCPropertyDefinition *clientIdCodePropertyDef  =[self.clientDef propertyDefinitionWithName:@"clientIDCode"];
    
    clientIdCodePropertyDef.type=SCPropertyTypeCustom;
    clientIdCodePropertyDef.uiElementClass=[EncryptedSCTextFieldCell class];
    
    NSDictionary *encryClientIDCodeTFCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"clientIDCode",@"keyString",@"Client ID Code",@"clientIDCode",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    

    clientIdCodePropertyDef.objectBindings=encryClientIDCodeTFCellKeyBindingsDic;
    clientIdCodePropertyDef.title=@"Client ID Code";
    clientIdCodePropertyDef.autoValidate=NO;

    
    self.clientDef.titlePropertyName = @"clientIDCode";	
    self.clientDef.keyPropertyName= @"clientIDCode";
    
    NSInteger indexOfkeyString=(NSInteger )[self.clientDef indexOfPropertyDefinitionWithName:@"keyString"];
    [self.clientDef removePropertyDefinitionAtIndex:indexOfkeyString];
    
    SCPropertyDefinition *initialsPropertyDef  =[self.clientDef propertyDefinitionWithName:@"initials"];
    
    initialsPropertyDef.type=SCPropertyTypeCustom;
    initialsPropertyDef.uiElementClass=[EncryptedSCTextFieldCell class];
    
    NSDictionary *encryInitialsTFCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"initials",@"keyString",@"Initials",@"initials",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    initialsPropertyDef.objectBindings=encryInitialsTFCellKeyBindingsDic;
    initialsPropertyDef.title=@"Initials";
    initialsPropertyDef.autoValidate=NO;
    
    
    
    
    
     NSDictionary *encryDateOfBirthCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"dateOfBirth",@"keyString",@"Date Of Birth",@"dateOfBirth",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32",@"33",@"34",nil]];
////    
//    
    SCPropertyDefinition *clientDateOfBirthPropertyDef = [self.clientDef propertyDefinitionWithName:@"dateOfBirth"];
    clientDateOfBirthPropertyDef.type=SCPropertyTypeCustom;
    clientDateOfBirthPropertyDef.uiElementClass=[EncryptedSCDateCell class];
    clientDateOfBirthPropertyDef.objectBindings=encryDateOfBirthCellKeyBindingsDic;
    
    clientDateOfBirthPropertyDef.autoValidate=NO;
    
//    clientDateOfBirthPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
//                                                                             datePickerMode:UIDatePickerModeDate 
//                                                              displayDatePickerInDetailView:NO];
    
    
    
    SCPropertyDefinition *clientDateAddedPropertyDef = [self.clientDef propertyDefinitionWithName:@"dateAdded"];
	clientDateAddedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                             datePickerMode:UIDatePickerModeDate 
                                                              displayDatePickerInDetailView:NO];

    SCPropertyDefinition *currentClientPropertyDef = [self.clientDef propertyDefinitionWithName:@"currentClient"];
    currentClientPropertyDef.type = SCPropertyTypeSegmented;
	currentClientPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    SCPropertyDefinition *demographicProfilePropertyDef = [self.clientDef propertyDefinitionWithName:@"demographicInfo"];
   
    demographicProfilePropertyDef.attributes = [SCObjectAttributes attributesWithObjectDefinition:demographicDetailViewController_Shared.demographicProfileDef];
    SCPropertyDefinition *clientNotesPropertyDef = [self.clientDef propertyDefinitionWithName:@"notes"];
//    clientNotesPropertyDef.type=SCPropertyTypeTextView;
    NSDictionary *encryClientNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyString",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32",@"33",@"34",nil]];
    ////    
    //    
//    SCPropertyDefinition *clientDateOfBirthPropertyDef = [self.clientDef propertyDefinitionWithName:@"dateOfBirth"];
    clientNotesPropertyDef.type=SCPropertyTypeCustom;
    clientNotesPropertyDef.title=@"Notes";
    clientNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    clientNotesPropertyDef.objectBindings=encryClientNotesTVCellKeyBindingsDic;
    
    clientNotesPropertyDef.autoValidate=NO;

    //Create a class definition for the phone NumberEntity
    SCEntityDefinition *phoneDef = [SCEntityDefinition definitionWithEntityName:@"PhoneEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"phoneName",
                                                                            @"phoneNumber", @"extension", nil]];
                       
    
    //Do some property definition customization for the phone Entity defined in phoneDef
    
    //create an array of objects definition for the phoneNumber to-many relationship that with show up in a different view with a place holder element>.
    
    //Create the property definition for the phoneNumbers property
    SCPropertyDefinition *phoneNumbersPropertyDef = [self.clientDef propertyDefinitionWithName:@"phoneNumbers"];
    phoneNumbersPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:phoneDef allowAddingItems:TRUE
                                                                                      allowDeletingItems:TRUE
                                                                                        allowMovingItems:FALSE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add New Phone Number"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    //create the phone name selection cell
    SCPropertyDefinition *phoneNamePropertyDef = [phoneDef propertyDefinitionWithName:@"phoneName"];
	
    phoneNamePropertyDef.type = SCPropertyTypeSelection;
	phoneNamePropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Cabin",@"Cell",@"Home", @"Home2", @"School", @"Work",@"Other",nil] 
                                                          allowMultipleSelection:NO allowNoSelection:NO autoDismissDetailView:YES hideDetailViewNavigationBar:NO];
    
    
    //do some customizing of the phone number title, change it to "Number" to make it shorter
    SCPropertyDefinition *phoneNumberPropertyDef = [phoneDef propertyDefinitionWithName:@"phoneNumber"];
    phoneNumberPropertyDef.title = @"Number";
    
   
    phoneNumberPropertyDef.type=SCPropertyTypeCustom;
    phoneNumberPropertyDef.uiElementClass=[EncryptedSCTextFieldCell class];
    
    NSDictionary *encryPhoneNumberTFCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"phoneNumber",@"keyString",@"Number",@"phoneNumber",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    phoneNumberPropertyDef.objectBindings=encryPhoneNumberTFCellKeyBindingsDic;
//    phoneNumberPropertyDef.title=@"Phone Number";
    phoneNumberPropertyDef.autoValidate=NO;
    
    
    
    
    phoneDef.titlePropertyName=@"phoneName;phoneNumber";
	if (![SCUtilities is_iPad]) {
    
    SCCustomPropertyDefinition *callButtonProperty = [SCCustomPropertyDefinition definitionWithName:@"CallButton" uiElementClass:[ButtonCell class] objectBindings:nil];
    [phoneDef insertPropertyDefinition:callButtonProperty atIndex:3];
        
    }
//    SCPropertyGroup *phoneGroup = [SCPropertyGroup groupWithHeaderTitle:@"Phone Number" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"phoneName",@"phoneNumber",@"extension" @"CallButton", nil]];
//    
//    // add the phone property group
//    [phoneDef.propertyGroups addGroup:phoneGroup];
    
   
    
    //Create a class definition for the logsEntity
    SCEntityDefinition *logDef = [SCEntityDefinition definitionWithEntityName:@"LogEntity" 
                                                        managedObjectContext:managedObjectContext
                                                          propertyNames:[NSArray arrayWithObjects:@"dateTime",
                                                                             @"notes",
                                                                              nil]];
    
    
    SCPropertyDefinition *logsPropertyDef = [self.clientDef propertyDefinitionWithName:@"logs"];
    logsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:logDef allowAddingItems:TRUE
                                                                                      allowDeletingItems:TRUE
                                                                                        allowMovingItems:FALSE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add New Log Entry"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];
    
    //Do some property definition customization for the Log Entity defined in logDef
    
    //do some customizing of the log notes, change it to "Number" to make it shorter
    SCPropertyDefinition *logNotesPropertyDef = [logDef propertyDefinitionWithName:@"notes"];
   
    logNotesPropertyDef.title = @"Notes";
    
    
    logNotesPropertyDef.type=SCPropertyTypeCustom;
    logNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryLogNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyString",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    logNotesPropertyDef.objectBindings=encryLogNotesTVCellKeyBindingsDic;
    //    phoneNumberPropertyDef.title=@"Phone Number";
    logNotesPropertyDef.autoValidate=NO;

    
    
    
    
    logDef.titlePropertyName=@"dateTime;notes";
    
    //Create the property definition for the dateTime property in the logDef class  definition
    SCPropertyDefinition *dateTimePropertyDef = [logDef propertyDefinitionWithName:@"dateTime"];
    
    //format the the date using a date formatter
    //define and initialize a date formatter
    NSDateFormatter *dateTimeDateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateTimeDateFormatter setDateFormat:@"ccc M/d/yy h:mm a"];
    //Set the date attributes in the dateTime property definition and make it so the date picker appears in the Same view.
    dateTimePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateTimeDateFormatter
                                                                   datePickerMode:UIDatePickerModeDateAndTime
                                                    displayDatePickerInDetailView:NO];
    

//    
//    //Create a class definition for the medication Entity
//    SCEntityDefinition *diagnosesDef = [SCEntityDefinition definitionWithEntityName:@"DiagnosisHistoryEntity" 
//                                                          managedObjectContext:managedObjectContext
//                                                                 propertyNames:[NSArray arrayWithObjects:@"drugName",@"dateStarted",  @"discontinued", @"symptomsTargeted",@"sideEffects",@"medLogs",
//                                                                                    @"notes",@"applNo", @"productNo",   
//                                                                                    nil]];
//
//    axis
//    dateDiagnosed
//    dateRecovered
//    notes
//    onset
//    order
//    prognosis
//    severity
//    status
    
    //Create a class definition for the medication Entity
    SCEntityDefinition *medicationDef = [SCEntityDefinition definitionWithEntityName:@"MedicationEntity" 
                                                   managedObjectContext:managedObjectContext
                                                          propertyNames:[NSArray arrayWithObjects:@"drugName",@"dateStarted",  @"discontinued", @"symptomsTargeted",@"medLogs",
                                                                             @"notes",@"applNo", @"productNo",   
                                                                             nil]];
    
    
    
    
    
    
    
    NSInteger applNoIndex=(NSInteger)[medicationDef indexOfPropertyDefinitionWithName:@"applNo"];   
    
    [medicationDef removePropertyDefinitionAtIndex:applNoIndex];
    
    NSInteger productNoIndex=[medicationDef indexOfPropertyDefinitionWithName:@"productNo"];
    [medicationDef removePropertyDefinitionAtIndex:productNoIndex];
    
    
    SCEntityDefinition *medicationReviewDef =[SCEntityDefinition definitionWithEntityName:@"MedicationReviewEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects: @"logDate",@"dosage",@"doseChange",@"sxChange",@"lastDose", @"adherence",@"sideEffects", @"nextReview", @"notes" , nil]];
    
    
    
    
    
    
    
    
    //create a property definition for the drugName property in the medicationDef class
    SCPropertyDefinition *drugNamePropertyDef = [medicationDef propertyDefinitionWithName:@"drugName"];
    
    //add a custom title
    drugNamePropertyDef.title = @"Drug Name";
    

    //get the client setup from the clients View Controller Shared
    // Add a custom property that represents a custom cells for the description defined TextFieldAndLableCell.xib
	
    //create the dictionary with the data bindings
    NSDictionary *drugNameDataBindings = [NSDictionary 
                                        dictionaryWithObjects:[NSArray arrayWithObject:@"drugName"] 
                                        forKeys:[NSArray arrayWithObject:@"1" ]]; // 1 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *drugNameDataProperty = [SCCustomPropertyDefinition definitionWithName:@"DrugNameData"
                                                                                 uiElementClass:[DrugNameObjectSelectionCell class] objectBindings:drugNameDataBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    drugNameDataProperty.autoValidate=FALSE;

    
    
    
   
    //insert the custom property definition into the clientData class at index 
    [medicationDef insertPropertyDefinition:drugNameDataProperty atIndex:0];
    
    SCPropertyDefinition *medicationsPropertyDef = [self.clientDef propertyDefinitionWithName:@"medicationHistory"];
    medicationsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:medicationDef allowAddingItems:TRUE
                                                                              allowDeletingItems:TRUE
                                                                                allowMovingItems:FALSE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add New Medication Entry"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];
    
    //Do some property definition customization for the medication Entity defined in medicationDef
    
    //do some customizing of the medication notes
    SCPropertyDefinition *medicationNotesPropertyDef = [medicationDef propertyDefinitionWithName:@"notes"];
    
    medicationNotesPropertyDef.type=SCPropertyTypeCustom;
    medicationNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryMedicationlNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyString",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    medicationNotesPropertyDef.objectBindings=encryMedicationlNotesTVCellKeyBindingsDic;
    medicationNotesPropertyDef.title=@"Notes";
    medicationNotesPropertyDef.autoValidate=NO;
    
    medicationDef.titlePropertyName=@"drugName";
    medicationDef.keyPropertyName=@"dateStarted";
   
    
   
    //format the the date using a date formatter
    //define and initialize a date formatter
    NSDateFormatter *medDateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [medDateFormatter setDateFormat:@"ccc M/d/yyyy"];
    //Set the date attributes in the dateTime property definition and make it so the date picker appears in the Same view.
   
    //Create the property definition for the dateStarted property in the medicationDef class  definition
    SCPropertyDefinition *dateStartedPropertyDef = [medicationDef propertyDefinitionWithName:@"dateStarted"];
    
    dateStartedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:medDateFormatter
                                                                    datePickerMode:UIDatePickerModeDate
                                                     displayDatePickerInDetailView:NO];
    
    
    //Create the property definition for the discontinued property in the medicationDef class  definition
    SCPropertyDefinition *discontinuedPropertyDef = [medicationDef propertyDefinitionWithName:@"discontinued"];
    
    discontinuedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:medDateFormatter
                                                                       datePickerMode:UIDatePickerModeDate
                                                        displayDatePickerInDetailView:NO];
    
       
   
    //Create a class definition for the Additional Symptoms Entity
    SCEntityDefinition *symptomDef = [SCEntityDefinition definitionWithEntityName:@"AdditionalSymptomEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"symptomName",   @"notes",@"onset",nil]];
    
//    SCEntityDefinition *symptomDef = [SCEntityDefinition definitionWithEntityName:@"AdditionalSymptomEntity" 
//                                                       managedObjectContext:managedObjectContext
//                                                autoGeneratePropertyDefinitions:YES];    
    
    
    
    //Do some property definition customization for the additional symptoms Entity defined in symptomsDef
    NSString *scaleDataCellNibName=nil;

    if ([SCUtilities is_iPad]) {
        
        scaleDataCellNibName=@"ScaleDataCell_iPad";
    
        
    } else
    {
        
        scaleDataCellNibName=@"ScaleDataCell_iPhone";       
    }
    
    NSDictionary *severityLevelDataBindings = [NSDictionary 
                                              dictionaryWithObjects:[NSArray arrayWithObject:@"severity"] 
                                              forKeys:[NSArray arrayWithObject:@"70"]]; // 1 is the control tag
	SCCustomPropertyDefinition *severityLevelDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SeverityData"
                                                                                     uiElementNibName:scaleDataCellNibName
                                                                                       objectBindings:severityLevelDataBindings];
	
    
    
    [symptomDef insertPropertyDefinition:severityLevelDataProperty atIndex:1];
    
    SCPropertyDefinition *symptomsTargetedPropertyDef = [medicationDef propertyDefinitionWithName:@"symptomsTargeted"];
    
    
    symptomsTargetedPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:symptomDef
                                                                                              allowAddingItems:YES
                                                                                            allowDeletingItems:YES
                                                                                            allowMovingItems:YES expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add symptoms"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    
    //Create a class definition for the symptom NameEntity
    SCEntityDefinition *symptomNameDef = [SCEntityDefinition definitionWithEntityName:@"AdditionalSymptomNameEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"symptomName",@"symptomDescription" , nil]];
    
    //Do some property definition customization for the <#name#> Entity defined in <#classDef#>
       
    SCPropertyDefinition *symptomNamePropertyDef = [symptomDef propertyDefinitionWithName:@"symptomName"];
    symptomNamePropertyDef.type = SCPropertyTypeObjectSelection;
    symptomNamePropertyDef.title=@"Symptom";
	SCObjectSelectionAttributes *symptomNameSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:symptomNameDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    
 
    symptomNameSelectionAttribs.allowAddingItems = YES;
    symptomNameSelectionAttribs.allowDeletingItems = YES;
    symptomNameSelectionAttribs.allowMovingItems = YES;
    symptomNameSelectionAttribs.allowEditingItems = YES;
    symptomNameSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap edit to add sypmtoms)"];
    symptomNameSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add Symptom Definition"];
    symptomNamePropertyDef.attributes = symptomNameSelectionAttribs;
    SCPropertyDefinition *symptomDescriptionPropertyDef = [symptomNameDef propertyDefinitionWithName:@"symptomDescription"];
    
    symptomDescriptionPropertyDef.type=SCPropertyTypeTextView;
    
    symptomDef.titlePropertyName=@"symptomName.symptomName";
    SCPropertyDefinition *symptomNotesPropertyDef = [symptomDef propertyDefinitionWithName:@"notes"];
    symptomNotesPropertyDef.type=SCPropertyTypeTextView;
    
    

    symptomDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *medLogsPropertyDef = [medicationDef propertyDefinitionWithName:@"medLogs"];
    medLogsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:medicationReviewDef allowAddingItems:TRUE
                                                                                     allowDeletingItems:TRUE
                                                                                       allowMovingItems:FALSE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add New Medication Log Entry"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];
    
    //Do some property definition customization for the medication Entity defined in medicationDef
    
    //do some customizing of the medication notes
    SCPropertyDefinition *medicationReviewNotesPropertyDef = [medicationReviewDef propertyDefinitionWithName:@"notes"];
    
    
    medicationReviewNotesPropertyDef.type=SCPropertyTypeCustom;
    medicationReviewNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryMedicationlReviewNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyString",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    medicationReviewNotesPropertyDef.objectBindings=encryMedicationlReviewNotesTVCellKeyBindingsDic;
    medicationReviewNotesPropertyDef.title=@"Notes";
    medicationReviewNotesPropertyDef.autoValidate=NO;
    
    medicationReviewDef.keyPropertyName=@"logDate";
    medicationReviewDef.titlePropertyName=@"logDate";
    //Create the property definition for the date property in the medicatioReviewnDef class  definition
    SCPropertyDefinition *medLogDatePropertyDef = [medicationReviewDef propertyDefinitionWithName:@"logDate"];
    
    medLogDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                       datePickerMode:UIDatePickerModeDate
                                                        displayDatePickerInDetailView:NO];
    
    //Create the property definition for the date property in the medicatioReviewnDef class  definition
    SCPropertyDefinition *medLogNextReviewDatePropertyDef = [medicationReviewDef propertyDefinitionWithName:@"nextReview"];
    
    medLogNextReviewDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateTimeDateFormatter
                                                                      datePickerMode:UIDatePickerModeDateAndTime
                                                       displayDatePickerInDetailView:NO];
    
    //Create a class definition for the sideEffectEntity
    SCEntityDefinition *sideEffectDef = [SCEntityDefinition definitionWithEntityName:@"SideEffectEntity" 
                                                          managedObjectContext:managedObjectContext
                                                                 propertyNames:[NSArray arrayWithObjects:@"effect", nil]];
    
    //Do some property definition customization for the sideeffect Entity defined in sideEffectDef
    
    
    SCPropertyDefinition *sideEffectsPropertyDef = [medicationReviewDef propertyDefinitionWithName:@"sideEffects"];
    
   	sideEffectsPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *sideEffectsSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:sideEffectDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:YES];
    sideEffectsSelectionAttribs.allowAddingItems = YES;
    sideEffectsSelectionAttribs.allowDeletingItems = YES;
    sideEffectsSelectionAttribs.allowMovingItems = NO;
    sideEffectsSelectionAttribs.allowEditingItems = YES;
    sideEffectsSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap edit to add side effects)"];
    sideEffectsSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new side effect definition"];
    
    
    sideEffectDef.titlePropertyName=@"effect";
    sideEffectsPropertyDef.attributes = sideEffectsSelectionAttribs;
    

    
    //Create the property definition for the change property in the medicationReview class
    SCPropertyDefinition *sxChangePropertyDef = [medicationReviewDef propertyDefinitionWithName:@"sxChange"];
    
    //set the property definition type to segmented
    sxChangePropertyDef.type = SCPropertyTypeSegmented;
    
    //set the segmented attributes for the change property definition 
    sxChangePropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Worse", @"Same", @"Imporved"   , nil]];
    
    //Create the property definition for the change property in the medicationReview class
    SCPropertyDefinition *doseChangePropertyDef = [medicationReviewDef propertyDefinitionWithName:@"doseChange"];
    
    //set the property definition type to segmented
    doseChangePropertyDef.type = SCPropertyTypeSegmented;
    
    //set the segmented attributes for the change property definition 
    doseChangePropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"None",@"Decrease", @"Increase"  , nil]];
    
    NSString *satisfactionDataCellNibName;
    if ([SCUtilities is_iPad]) {
       satisfactionDataCellNibName= @"ScaleDataCell_iPad";
    }
    else
    {
     satisfactionDataCellNibName= @"ScaleDataCell_iPhone";   
    }
    NSDictionary *satisfactionLevelDataBindings = [NSDictionary 
                                              dictionaryWithObjects:[NSArray arrayWithObject:@"satisfaction"] 
                                              forKeys:[NSArray arrayWithObject:@"70"]]; // 1 is the control tag
	
    
    SCCustomPropertyDefinition *satisfactionLevelDataProperty = [SCCustomPropertyDefinition definitionWithName:@"satisfaction"
                                                                                     uiElementNibName:satisfactionDataCellNibName
                                                                                       objectBindings:satisfactionLevelDataBindings];
    
    
    
    [medicationReviewDef addPropertyDefinition:satisfactionLevelDataProperty];
    
   
    
    
    
   
//    SCPropertyDefinition *prescriberPropertyDef = [medicationReviewDef propertyDefinitionWithName:@"prescriber"];
    
    
   
    //get the client setup from the clients View Controller Shared
    // Add a custom property that represents a custom cells for the description defined TextFieldAndLableCell.xib
	
    //create the dictionary with the data bindings
    NSDictionary *clinicianDataBindings = [NSDictionary 
                                          dictionaryWithObjects:[NSArray arrayWithObjects:@"prescriber",@"Prescriber",[NSNumber numberWithBool:YES],@"prescriber",[NSNumber numberWithBool:NO],nil] 
                                          forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *clinicianDataProperty = [SCCustomPropertyDefinition definitionWithName:@"PrescriberData"
                                                                                   uiElementClass:[ClinicianSelectionCell class] objectBindings:clinicianDataBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    clinicianDataProperty.autoValidate=FALSE;
    
    
    
    
    
    /****************************************************************************************/
    /*	END of Class Definition and attributes for the Client Entity */
    /****************************************************************************************/
    
    //insert the custom property definition into the clientData class at index 
    [medicationReviewDef insertPropertyDefinition:clinicianDataProperty atIndex:1];
    
//   	prescriberPropertyDef.type = SCPropertyTypeObjectSelection;
//    
//    SCEntityDefinition *prescriberDef =[SCEntityDefinition definitionWithEntityName:@"ClinicianEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"prefix",@"firstName",@"middleName", @"lastName",@"suffix",@"credentialInitials", nil]];
//    prescriberDef.titlePropertyName=@"lastName;firstName";
//    prescriberDef.titlePropertyNameDelimiter=@", ";
//    prescriberDef.keyPropertyName=@"lastName";
//    
//    SCPropertyGroup *prescriberNameGroup =[SCPropertyGroup groupWithHeaderTitle:@"Prescriber Name" footerTitle:@"Select this prescriber under the Clinician tab to add or view more details." propertyNames:[NSArray arrayWithObjects:@"prefix",@"firstName",@"middleName", @"lastName",@"suffix",@"credentialInitials", nil]];
//    
//    SCObjectSelectionAttributes *prescriberSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:prescriberDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
//    prescriberSelectionAttribs.allowAddingItems = YES;
//    prescriberSelectionAttribs.allowDeletingItems = YES;
//    prescriberSelectionAttribs.allowMovingItems = YES;
//    prescriberSelectionAttribs.allowEditingItems = YES;
//    prescriberSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add prescribers)"];
//    prescriberSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New prescriber"];
//    prescriberPropertyDef.attributes = prescriberSelectionAttribs;
//    
//    
//    [prescriberDef.propertyGroups addGroup:prescriberNameGroup];
//    
    
    
    //Create a property definition for the adherence property.
    SCPropertyDefinition *adherencePropertyDef = [medicationReviewDef propertyDefinitionWithName:@"adherence"];
    
    //set the adherence property definition type to a selectiong Cell
    adherencePropertyDef.type = SCPropertyTypeSelection;
    
       
    //set the selection attributes and define the list of items to be selected
    adherencePropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Refuses", @"Poor", @"Needs Assistance",@"Frequently Forgets",@"Adequate",@"Good",@"Excellent", nil] 
                                                            allowMultipleSelection:YES
                                                                  allowNoSelection:YES
                                                             autoDismissDetailView:NO hideDetailViewNavigationBar:NO];
    
    
    //define a property group
    SCPropertyGroup *followUpGroup = [SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"doseChange",   @"sxChange",@"lastDose", @"adherence",@"sideEffects", @"satisfaction", nil]];
    
    // add the followup property group to the medication Review class. 
    [medicationReviewDef.propertyGroups addGroup:followUpGroup];
    
    SCPropertyGroup *notesGroup = [SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObject:@"notes"]];
    
    // add the followup property group to the behavioralObservationsDef class. 
    [medicationReviewDef.propertyGroups addGroup:notesGroup];
    
    
    //Create a class definition for the vitals Entity
    SCEntityDefinition *vitalsDef = [SCEntityDefinition definitionWithEntityName:@"VitalsEntity" 
                                                        managedObjectContext:managedObjectContext
                                                               propertyNames:[NSArray arrayWithObjects:@"dateTaken",@"systolicPressure",@"diastolicPressure", @"heartRate",@"temperature",@"heightTall", @"heightUnit",   @"weight",  @"weightUnit",  nil]];
    
    
    
    
    
    
    
    
    //Create the property definition for the dateTaken property in the vitals class  definition
    SCPropertyDefinition *dateTakenPropertyDef = [vitalsDef propertyDefinitionWithName:@"dateTaken"];
    
    dateTakenPropertyDef.type=SCPropertyTypeDate;
    
    //Do some property definition customization for the vitals Entity defined in vitalsDef
    NSDictionary *heightPickerDataBindings = [NSDictionary 
                                              dictionaryWithObjects:[NSArray arrayWithObjects:@"heightTall",@"Height",@"heightUnit",nil] 
                                              forKeys:[NSArray arrayWithObjects:@"2", @"3",@"4", nil]]; // 1 is the control tags
	
    
    NSString *heightPickerNibName;
    if ([SCUtilities is_iPad]) 
        heightPickerNibName=@"HeightPickerCell_iPad";
    else
        heightPickerNibName=@"HeightPickerCell_iPhone";
    
    SCCustomPropertyDefinition *heightProperty = [SCCustomPropertyDefinition definitionWithName:@"HeightTall" uiElementNibName:heightPickerNibName objectBindings:heightPickerDataBindings];
	
    
    
    [vitalsDef insertPropertyDefinition:heightProperty atIndex:1];
    
    NSDictionary *weightPickerDataBindings = [NSDictionary 
                                              dictionaryWithObjects:[NSArray arrayWithObjects:@"weight",@"Weight",@"weightUnit",nil] 
                                              forKeys:[NSArray arrayWithObjects:@"2", @"3",@"4", nil]]; // 1 is the control tags
	
    
    
    
    [vitalsDef removePropertyDefinitionWithName:@"weight"];
    [vitalsDef removePropertyDefinitionWithName:@"weightUnit"];
    [vitalsDef removePropertyDefinitionWithName:@"heightTall"];
    [vitalsDef removePropertyDefinitionWithName:@"heightUnit"];
    
    NSString *weightPickerNibName;
    if ([SCUtilities is_iPad]) 
        weightPickerNibName=@"WeightPickerCell_iPad";
    else
        weightPickerNibName=@"WeightPickerCell_iPhone";
    
    SCCustomPropertyDefinition *weightProperty = [SCCustomPropertyDefinition definitionWithName:@"Weight" uiElementNibName:weightPickerNibName objectBindings:weightPickerDataBindings];
	
    
    [vitalsDef insertPropertyDefinition:weightProperty atIndex:1];
    
    //Create the property definition for the systolic pressure property in the vitalsDef class
    SCPropertyDefinition *systolicPropertyDef = [vitalsDef propertyDefinitionWithName:@"systolicPressure"];
    
    systolicPropertyDef.autoValidate=NO;
    
    //Create the property definition for the diastolic pressure property in the vitalsDef class
    SCPropertyDefinition *diastolicPropertyDef = [vitalsDef propertyDefinitionWithName:@"diastolicPressure"];
    
    diastolicPropertyDef.autoValidate=NO;
    
    //Create the property definition for the heart Rate property in the vitalsDef class
    SCPropertyDefinition *heartRatePropertyDef = [vitalsDef propertyDefinitionWithName:@"heartRate"];
    
    heartRatePropertyDef.autoValidate=NO;
    
    //Create the property definition for the temperature property in the vitalsDef class
    SCPropertyDefinition *temperaturePropertyDef = [vitalsDef propertyDefinitionWithName:@"temperature"];
    
    temperaturePropertyDef.autoValidate=NO;
    temperaturePropertyDef.type=SCPropertyTypeNumericTextField;
    
    
    //create an array of objects definition for the vitals to-many relationship that with show up in a different view  without a place holder element>.
    
    //Create the property definition for the vitals property
    SCPropertyDefinition *vitalsPropertyDef = [self.clientDef propertyDefinitionWithName:@"vitals"];
    vitalsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:vitalsDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to add vitals"]                                                      addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
    vitalsPropertyDef.title=@"Vitals/Height/Weight";
    SCPropertyGroup *clientInfoGroup = [SCPropertyGroup groupWithHeaderTitle:@"De-Identified Client Data" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"clientIDCode", @"dateOfBirth",@"initials",@"demographicInfo",@"dateAdded",@"currentClient",@"phoneNumbers", @"logs",@"medicationHistory",@"diagnoses", @"vitals", @"notes", nil]];
    
    
    SCEntityDefinition *clientGroupDef=[SCEntityDefinition definitionWithEntityName:@"ClientGroupEntity" managedObjectContext:managedObjectContext propertyNamesString:@"Client Group:(groupName,addNewClients)"];
    
    SCPropertyDefinition *groupsPropertyDef=[self.clientDef propertyDefinitionWithName:@"groups"];
    
   
    groupsPropertyDef.type=SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *clientGroupSelectionAttribs=[[SCObjectSelectionAttributes alloc]initWithObjectsEntityDefinition:clientGroupDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:YES] ;
    clientGroupSelectionAttribs.allowAddingItems=YES;
    clientGroupSelectionAttribs.allowDeletingItems=YES;
    clientGroupSelectionAttribs.allowEditingItems=YES;
    clientGroupSelectionAttribs.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add Group"];
    clientGroupSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap Edit to add new groups"];
    
    groupsPropertyDef.attributes=clientGroupSelectionAttribs;
    groupsPropertyDef.title=@"Groups";
    
    SCPropertyGroup *groupsGroup=[SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObject:@"groups"]];
    


    
    [self.clientDef.propertyGroups addGroup:clientInfoGroup];
    [self.clientDef.propertyGroups addGroup:groupsGroup];
//    self.clientDef.orderAttributeName=@"order";
    

    return self;


}



-(NSString *)calculateWechslerAgeWithBirthdate:(NSDate *)birthdate{

    
    NSDate *now=[NSDate date];
    NSDateFormatter *dayFormater=[[NSDateFormatter alloc]init];
    [dayFormater setDateFormat:@"d"];
    
    NSDateFormatter *monthFormater=[[NSDateFormatter alloc]init];
    [monthFormater setDateFormat:@"M"];
    
    NSDateFormatter *yearFormater=[[NSDateFormatter alloc]init];
    [yearFormater setDateFormat:@"Y"];
    
    //NSLog(@"date years %@, months%@, days %@",[yearFormater stringFromDate:birthdate],[monthFormater stringFromDate:birthdate],[dayFormater stringFromDate:birthdate]);
    
    int nowYear, nowMonth, nowDay;
    
    nowYear=[[yearFormater stringFromDate:now]intValue];
    
    nowMonth=[[monthFormater stringFromDate:now]intValue];
    
    nowDay=[[dayFormater stringFromDate:now]intValue];
    
    int birthYear, birthMonth, birthDay;
    
    birthYear=[[yearFormater stringFromDate:birthdate]intValue];
    
    birthMonth=[[monthFormater stringFromDate:birthdate]intValue];
    
    birthDay=[[dayFormater stringFromDate:birthdate]intValue];
    
    int difYear,difMonth,difDay;
    if (birthDay >nowDay) {
        
        difDay=(nowDay+30)-birthDay;
        
        if (nowMonth>=birthMonth) {
             difMonth=(nowMonth-1)-birthMonth;
        
        }
        else
        {
            difMonth=((nowMonth+12)-1)-birthMonth;
            nowYear=nowYear-1;
        }
       
        
        
    }
    else
    {
        difDay=nowDay-birthDay;
        if (nowMonth>=birthMonth) {
            difMonth=nowMonth-birthMonth;
            
        }
        else
        {
            difMonth=(nowMonth+12)-birthMonth;
            nowYear=nowYear-1;
        }
    }
    
    difYear=nowYear-birthYear;
    
    if (difMonth<0) {
        difMonth=12-difMonth;
        difYear=difYear-1;
    }
    
    NSString *age =[NSString stringWithFormat:@"%iy %im %id",difYear,difMonth,difDay];
    



    return age;
}

-(NSString *)calculateActualAgeWithBirthdate:(NSDate *)birthdate{


    NSDate *now =[NSDate date];
    
//    NSTimeInterval ageInterval=[birthdate timeIntervalSinceNow];
    
    //define a gregorian calandar
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
   
    //define the calandar unit flags
    NSUInteger unitFlags = NSDayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
     
    //define the date components
    NSDateComponents *dateComponents = [gregorianCalendar components:unitFlags
                                                                              fromDate:birthdate
                                                                                toDate:now
                                                                               options:0];
    
    int day, month, year;
    day=[dateComponents day];
    month=[dateComponents month];
    year=[dateComponents year];
 
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];

    [dateFormatter setDateFormat:@"M"];
    int dateMonth=[[dateFormatter stringFromDate:birthdate]intValue];
    if (dateMonth==4||dateMonth==6||dateMonth==9||dateMonth==11) {
        day=day-1;
    }
    if(dateMonth==2){
    
        day=day-3;
        [dateFormatter setDateFormat:@"Y"];
        int yearDiff=[[dateFormatter stringFromDate:birthdate]intValue];
        if (((yearDiff % 4 == 0) && (yearDiff % 100 != 0)) || (yearDiff % 400 == 0)) {
            [dateFormatter setDateFormat:@"Md"];
            if ([[dateFormatter stringFromDate:birthdate]intValue]==229) {
                day=day-1;
            }
            day=day+1; //leap year
           
        }
        
                
        
    }
    
    [dateFormatter setDateFormat:@"d"];
    int dateDiff=[[dateFormatter stringFromDate:birthdate]intValue];
    int nowDay=[[dateFormatter stringFromDate:now]intValue];
    if (dateDiff==nowDay) {
        
        day=0;
        
    }
    else if (dateDiff< nowDay)
    {
        
        day=nowDay-dateDiff;
    }


    
    return [NSString stringWithFormat:@"%iy %im %id", year,month,day];
}


-(NSString *)calculateWechslerAgeWithBirthdate:(NSDate *)birthdate toDate:(NSDate *)toDate{
    
    if (!toDate) {
        toDate=[NSDate date];
    }
    if (birthdate==NULL){
    
        return @"no birthdate";
    
    }
 
    NSDateFormatter *dayFormater=[[NSDateFormatter alloc]init];
    [dayFormater setDateFormat:@"d"];
    
    NSDateFormatter *monthFormater=[[NSDateFormatter alloc]init];
    [monthFormater setDateFormat:@"M"];
    
    NSDateFormatter *yearFormater=[[NSDateFormatter alloc]init];
    [yearFormater setDateFormat:@"Y"];
    
    //NSLog(@"date years %@, months%@, days %@",[yearFormater stringFromDate:birthdate],[monthFormater stringFromDate:birthdate],[dayFormater stringFromDate:birthdate]);
    
    int toYear, toMonth, toDateDay;
    
    toYear=[[yearFormater stringFromDate:toDate]intValue];
    
    toMonth=[[monthFormater stringFromDate:toDate]intValue];
    
    toDateDay=[[dayFormater stringFromDate:toDate]intValue];
    
    int birthYear, birthMonth, birthDay;
    
    birthYear=[[yearFormater stringFromDate:birthdate]intValue];
    
    birthMonth=[[monthFormater stringFromDate:birthdate]intValue];
    
    birthDay=[[dayFormater stringFromDate:birthdate]intValue];
    
    int difYear,difMonth,difDay;
    if (birthDay >toDateDay) {
        
        difDay=(toDateDay+30)-birthDay;
        
        if (toMonth>=birthMonth) {
            difMonth=(toMonth-1)-birthMonth;
            
        }
        else
        {
            difMonth=((toMonth+12)-1)-birthMonth;
            toYear=toYear-1;
        }
        
        
        
    }
    else
    {
        difDay=toDateDay-birthDay;
        if (toMonth>=birthMonth) {
            difMonth=toMonth-birthMonth;
            
        }
        else
        {
            difMonth=(toMonth+12)-birthMonth;
            toYear=toYear-1;
        }
    }
    
       
    difYear=toYear-birthYear;
   
    
    if (difMonth<0) {
        difYear=difYear-1;
        difMonth=12+difMonth;
        
    }
    if (difYear<0) {
        difYear=0;
        difMonth=0;
        difDay=0;
    }
    
    if (difDay<0&&difDay==0&&difYear==0) {
        difDay=0;
    }
    
    NSString *age =[NSString stringWithFormat:@"%iy %im %id",difYear,difMonth,difDay];
    
    
    
    
    return age;
}

-(NSString *)calculateActualAgeWithBirthdate:(NSDate *)birthdate toDate:(NSDate *)toDate{
    
    if (!toDate) {
        toDate=[NSDate date];
    }
    if (birthdate==NULL){
       
        return [NSString stringWithFormat:@"no birthdate"];
    }
    
    //    NSTimeInterval ageInterval=[birthdate timeIntervalSinceNow];
    
    //define a gregorian calandar
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //define the calandar unit flags
    NSUInteger unitFlags = NSDayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    //define the date components
    NSDateComponents *dateComponents = [gregorianCalendar components:unitFlags
                                                            fromDate:birthdate
                                                              toDate:toDate
                                                             options:0];
    
    int day, month, year;
    day=[dateComponents day];
    month=[dateComponents month];
    year=[dateComponents year];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"M"];
    int dateMonth=[[dateFormatter stringFromDate:birthdate]intValue];
    if (dateMonth==4||dateMonth==6||dateMonth==9||dateMonth==11) {
        day=day-1;
    }
    if(dateMonth==2){
        
        day=day-3;
        [dateFormatter setDateFormat:@"Y"];
        int yearDiff=[[dateFormatter stringFromDate:birthdate]intValue];
        if (((yearDiff % 4 == 0) && (yearDiff % 100 != 0)) || (yearDiff % 400 == 0)) {
            [dateFormatter setDateFormat:@"Md"];
            if ([[dateFormatter stringFromDate:birthdate]intValue]==229) {
                day=day-1;
            }
            day=day+1; //leap year
            
        }
        
        
        
    }
    
    [dateFormatter setDateFormat:@"d"];
    int dateDiff=[[dateFormatter stringFromDate:birthdate]intValue];
    int toDateDay=[[dateFormatter stringFromDate:toDate]intValue];
    if (dateDiff==toDateDay) {
        
        day=0;
        
    }
    else if (dateDiff< toDateDay)
    {
        
        day=toDateDay-dateDiff;
    }
    
    if (year<0) {
        year=0;
        month=0;
        day=0;
    }
    if (day<0&&month==0&&year==0) {
        day=0;
    }
    return [NSString stringWithFormat:@"%iy %im %id", year,month,day];
}

@end
