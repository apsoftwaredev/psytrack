/*
 *  ClientPresentations_Shared.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 10/22/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ClientPresentations_Shared.h"
#import "PTTAppDelegate.h"
#import "ClientsViewController_Shared.h"
#import "BehaviorPickerCell.h"
#import "BOPickersDataSource.h"
#import "ClientsSelectionCell.h"


@implementation ClientPresentations_Shared
@synthesize clientPresentationDef;
@synthesize tableModel;
@synthesize serviceDatePickerDate;


-(id)setupUsingSTV {

     NSManagedObjectContext *managedObjectContext= [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    
//    //Create a class definition for the ClientPresentationEntity
//    self.clientPresentationDef = [SCClassDefinition definitionWithEntityName:@"ClientPresentationEntity" 
//                                                        withManagedObjectContext:managedObjectContext
//                                                               withPropertyNames:[NSArray arrayWithObjects: @"behavioralObservations",@"medications",   @"clientsDesc",@"appitite", @"assessmentNotes", @"attitudeNotes", @"homicidality", @"improvement", @"interpersonalNotes", @"notableBehaviors", @"notableImagry",  @"orientedToBody", @"orientedToPerson", @"orientedToPlace", @"orientedToTime", @"otherRemarks",  @"plan", @"rapport", @"sensoryNotes", @"sleepHoursNightly", @"sleepQuality",  @"vision"  @"notes",    nil]];
    
    self.clientPresentationDef = [SCClassDefinition definitionWithEntityName:@"ClientPresentationEntity" 
                                                    withManagedObjectContext:managedObjectContext
                                                           autoGeneratePropertyDefinitions:YES];
   
    
    [self.clientPresentationDef removePropertyDefinitionWithName:@"interventionDelivered"];
    //Create the property definition for the affect Mood property in the client Presentatio class
    SCPropertyDefinition *affectNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"affectNotes"];
    
    affectNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *assessmentNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"assessmentNotes"];
    
    assessmentNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *improvementPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"improvement"];
    
    improvementPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *planPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"plan"];
    
    planPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *rapportPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"rapport"];
    
    rapportPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *sleepHoursNightlyPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"sleepHoursNightly"];
    
    sleepHoursNightlyPropertyDef.autoValidate=NO;
    
    //define a property group
    SCPropertyGroup *notesGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"affectNotes", @"appearanceNotes",  @"assessmentNotes", @"attentionNotes", @"attitudeNotes", @"improvement", @"interpersonalNotes", @"notableBehaviors", @"notableImagry",   @"plan",  @"rapport",  @"sensoryNotes", @"sleepHoursNightly",    @"sleepQuality",@"psychomotor", @"speechLanguage", @"vision",     nil ]];
    [self.clientPresentationDef.propertyGroups addGroup:notesGroup];
    
    SCPropertyGroup *orientationGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"orientedToBody", @"orientedToPerson",  @"orientedToPlace", @"orientedToTime",    nil ]];
    // add the notes property group to the clientpresentation class. 
    [self.clientPresentationDef.propertyGroups addGroup:orientationGroup];
    
  //    
//    
//    
//    
    self.clientPresentationDef.orderAttributeName=@"order";
    
    //create a property definition for the sleep Quality property in the clientPresentations class
    SCPropertyDefinition *sleepQualityPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"sleepQuality"];
    
   
    BOPickersDataSource *boPicker=[[BOPickersDataSource alloc]init];
    //set the property type to selection
    sleepQualityPropertyDef.type = SCPropertyTypeSelection;
    
    //set the selection attributes and define the list of items to be selected
    sleepQualityPropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithArray:[boPicker presentationDataWithPropertyName:@"sleepQuality"]] 
                                                            allowMultipleSelection:YES
                                                                  allowNoSelection:YES
                                                             autoDismissDetailView:NO hideDetailViewNavigationBar:NO];
   
    
    

    //create a property definition for the sleep Quality property in the clientPresentations class
    SCPropertyDefinition *visionPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"vision"];
    
    
  
    //set the property type to selection
    visionPropertyDef.type = SCPropertyTypeSelection;
    
    //set the selection attributes and define the list of items to be selected
    visionPropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithArray:[boPicker presentationDataWithPropertyName:@"vision"]] 
                                                             allowMultipleSelection:YES
                                                                   allowNoSelection:YES
                                                              autoDismissDetailView:NO hideDetailViewNavigationBar:NO];
    

    //create a property definition for the orientated to place property in the cleintPresentation Def class
    SCPropertyDefinition *orientedToBodyPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"orientedToBody"];
    orientedToBodyPropertyDef.title=@"Body";
    //set the property type to segmented
    orientedToBodyPropertyDef.type = SCPropertyTypeSegmented;
    
    //set the selection attributes and define the list of items to be selected
    orientedToBodyPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No" , nil]];
    
    
    //create a property definition for the orientated to place property in the cleintPresentation Def class
    SCPropertyDefinition *orientedToPersonPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"orientedToPerson"];
    orientedToPersonPropertyDef.title=@"Person";
    //set the property type to segmented
    orientedToPersonPropertyDef.type = SCPropertyTypeSegmented;
    
    //set the selection attributes and define the list of items to be selected
    orientedToPersonPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No" , nil]];
    
    //create a property definition for the orientated to place property in the cleintPresentation Def class
    SCPropertyDefinition *orientedToPlacePropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"orientedToPlace"];
    orientedToPlacePropertyDef.title=@"Place";
    
    //set the property type to segmented
    orientedToPlacePropertyDef.type = SCPropertyTypeSegmented;
    
    //set the selection attributes and define the list of items to be selected
    orientedToPlacePropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No" , nil]];
    
    //create a property definition for the orientated to place property in the cleintPresentation Def class
    SCPropertyDefinition *orientedToTimePropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"orientedToTime"];
    
    //set the property type to segmented
    orientedToTimePropertyDef.type = SCPropertyTypeSegmented;
    
    orientedToTimePropertyDef.title=@"Time";
    //set the selection attributes and define the list of items to be selected
    orientedToTimePropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No" , nil]];
    
    
    
    
    NSString *scaleDataCellNibName=nil;
    if ([SCHelper is_iPad]) {
        scaleDataCellNibName=@"ScaleDataCell_iPad";
                
    } else
    {
        
        scaleDataCellNibName=@"ScaleDataCell_iPhone";

        
    }
    
    [self.clientPresentationDef removePropertyDefinitionWithName:@"comfortLevel"];
       
    NSDictionary *comfortLevelScaleDataBindings = [NSDictionary 
                                               dictionaryWithObjects:[NSArray arrayWithObjects:@"comfortLevel", @"Comfort Level",nil] 
                                              forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *comfortLevelscaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"comfortLevelscaleData"
                                                                                      withuiElementNibName:scaleDataCellNibName
                                                                                        withObjectBindings:comfortLevelScaleDataBindings];
	
    
    
    [self.clientPresentationDef addPropertyDefinition:comfortLevelscaleDataProperty];
    
    
      [self.clientPresentationDef removePropertyDefinitionWithName:@"stressLevel"];
    NSDictionary *stressLevelScaleDataBindings = [NSDictionary 
                                                   dictionaryWithObjects:[NSArray arrayWithObjects:@"stressLevel",@"Stress Level", nil] 
                                                   forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *stressLevelScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"stressLevelScaleData"
                                                                                          withuiElementNibName:scaleDataCellNibName
                                                                                            withObjectBindings:stressLevelScaleDataBindings];
	
    
    
    [self.clientPresentationDef addPropertyDefinition:stressLevelScaleDataProperty];
    
     [self.clientPresentationDef removePropertyDefinitionWithName:@"alliance"];
    
    NSDictionary *allianceScaleDataBindings = [NSDictionary 
                                                   dictionaryWithObjects:[NSArray arrayWithObjects:@"alliance",@"Alliance", nil ] 
                                                   forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *allianceScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"allianceScaleData"
                                                                                          withuiElementNibName:scaleDataCellNibName
                                                                                            withObjectBindings:allianceScaleDataBindings];
	
    
    
    [self.clientPresentationDef addPropertyDefinition:allianceScaleDataProperty];
    

      [self.clientPresentationDef removePropertyDefinitionWithName:@"happinessLevel"]; 
    NSDictionary *happinessLevelScaleDataBindings = [NSDictionary 
                                               dictionaryWithObjects:[NSArray arrayWithObjects:@"happinessLevel",@"Happiness Level",nil] 
                                               forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *happinessLevelScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"happinessLevelScaleData"
                                                                                      withuiElementNibName:scaleDataCellNibName
                                                                                        withObjectBindings:happinessLevelScaleDataBindings];
	
    
    
    [self.clientPresentationDef addPropertyDefinition:happinessLevelScaleDataProperty];
    
    [self.clientPresentationDef removePropertyDefinitionWithName:@"energyLevel"]; 
    NSDictionary *energyLevelScaleDataBindings = [NSDictionary 
                                                      dictionaryWithObjects:[NSArray arrayWithObjects:@"energyLevel",@"Energy Level", nil ] 
                                                     forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *energyLevelScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"energyLevelScaleData"
                                                                                             withuiElementNibName:scaleDataCellNibName
                                                                                               withObjectBindings:energyLevelScaleDataBindings];
	
    
    
    [self.clientPresentationDef addPropertyDefinition:energyLevelScaleDataProperty];
   
    [self.clientPresentationDef removePropertyDefinitionWithName:@"hearingLevel"]; 
    NSDictionary *hearingLevelScaleDataBindings = [NSDictionary 
                                                  dictionaryWithObjects:[NSArray arrayWithObjects:@"hearingLevel",@"Hearing Level", nil ] 
                                                  forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *hearingLevelScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"hearingLevelScaleData"
                                                                                         withuiElementNibName:scaleDataCellNibName
                                                                                           withObjectBindings:hearingLevelScaleDataBindings];
	
    
    
    [self.clientPresentationDef addPropertyDefinition:hearingLevelScaleDataProperty];
    
    [self.clientPresentationDef removePropertyDefinitionWithName:@"painLevel"];
    NSDictionary *painLevelScaleDataBindings = [NSDictionary 
                                                   dictionaryWithObjects:[NSArray arrayWithObjects:@"painLevel",@"Pain Level", nil ] 
                                                   forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *painLevelScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"painLevelScaleData"
                                                                                          withuiElementNibName:scaleDataCellNibName
                                                                                            withObjectBindings:painLevelScaleDataBindings];
	
    
    
    [self.clientPresentationDef addPropertyDefinition:painLevelScaleDataProperty];
    
     [self.clientPresentationDef removePropertyDefinitionWithName:@"sexualSatisfaction"];
    NSDictionary *sexualSatisfactionScaleDataBindings = [NSDictionary 
                                                dictionaryWithObjects:[NSArray arrayWithObjects:@"sexualSatisfaction",@"Sexual Satisfaction", nil ] 
                                                forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *sexualSatisfactionScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"sexualSatisfactionScaleData"
                                                                                       withuiElementNibName:scaleDataCellNibName
                                                                                         withObjectBindings:sexualSatisfactionScaleDataBindings];
	
    
    
    [self.clientPresentationDef addPropertyDefinition:sexualSatisfactionScaleDataProperty];
    
    [self.clientPresentationDef removePropertyDefinitionWithName:@"trust"];

    NSDictionary *trustScaleDataBindings = [NSDictionary 
                                                           dictionaryWithObjects:[NSArray arrayWithObjects:@"trust",@"Trust Level", nil ] 
                                                           forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *trustScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"trustScaleData"
                                                                                                  withuiElementNibName:scaleDataCellNibName
                                                                                                    withObjectBindings:trustScaleDataBindings];
	
    
    
    [self.clientPresentationDef addPropertyDefinition:trustScaleDataProperty];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"symptomSeverity"];
    
    NSDictionary *symptomSeverityScaleDataBindings = [NSDictionary 
                                            dictionaryWithObjects:[NSArray arrayWithObjects:@"symptomSeverity",@"Symptom Severity", nil ] 
                                            forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *symptomSeverityScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"symptomSeverityScaleData"
                                                                                   withuiElementNibName:scaleDataCellNibName
                                                                                     withObjectBindings:symptomSeverityScaleDataBindings];
	
    
    
    [self.clientPresentationDef addPropertyDefinition:symptomSeverityScaleDataProperty];
    
    [self.clientPresentationDef removePropertyDefinitionWithName:@"depth"];
    NSDictionary *depthScaleDataBindings = [NSDictionary 
                                                      dictionaryWithObjects:[NSArray arrayWithObjects:@"depth",@"Depth", nil ] 
                                                      forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *depthScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"depthScaleData"
                                                                                             withuiElementNibName:scaleDataCellNibName
                                                                                               withObjectBindings:depthScaleDataBindings];
	
    
    
    [self.clientPresentationDef addPropertyDefinition:depthScaleDataProperty];
     [self.clientPresentationDef removePropertyDefinitionWithName:@"suicideIdeation"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"suicidePlan"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"suicideMeans"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"suicideHistory"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"order"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"testSessionDelivered"];
     [self.clientPresentationDef removePropertyDefinitionWithName:@"client"];
    NSDictionary *suicidalityDataBindings = [NSDictionary 
                                             dictionaryWithObjects:[NSArray arrayWithObjects:@"suicideIdeation",@"suicidePlan",@"suicideMeans", @"suicideHistory",    nil ] 
                                             forKeys:[NSArray arrayWithObjects:@"20",@"21",@"22",@"23",nil]]; // 20,21,22,23 are the binding keys 
    SCCustomPropertyDefinition *suicidalityDataProperty = [SCCustomPropertyDefinition definitionWithName:@"suicidalityData"
                                                                                    withuiElementNibName:@"SuicidalityCell"
                                                                                      withObjectBindings:suicidalityDataBindings];
	
    
    
    [self.clientPresentationDef addPropertyDefinition:suicidalityDataProperty];
    
    //Create a property definition for the clientDesc property.
    SCPropertyDefinition *clientDescPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"clientsDesc"];
    
    //set the clientDscs property definition type to a Text View Cell
    clientDescPropertyDef.type = SCPropertyTypeTextView;
    
    //override the auto title generation for the clientDesc property definition and set it to a custom title
    clientDescPropertyDef.title=@"";
    
    
    
    
   
    
   
    
    /****************************************************************************************/
    /*	BEGIN Class Definition and attributes for the Client Entity */
    /****************************************************************************************/ 
    
    //get the client setup from the clients View Controller Shared
    // Add a custom property that represents a custom cells for the description defined TextFieldAndLableCell.xib
	
    //create the dictionary with the data bindings
    NSDictionary *clientDataBindings = [NSDictionary 
                                          dictionaryWithObjects:[NSArray arrayWithObject:@"client"] 
                                          forKeys:[NSArray arrayWithObject:@"1" ]]; // 1 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *clientDataProperty = [SCCustomPropertyDefinition definitionWithName:@"CLientData"
                                                                                 withuiElementClass:[ClientsSelectionCell class] withObjectBindings:clientDataBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    clientDataProperty.autoValidate=FALSE;
    
    
    //insert the custom property definition into the clientData class at index 
    [self.clientPresentationDef addPropertyDefinition:clientDataProperty];

    
    
    
    /****************************************************************************************/
    /*	END of Class Definition and attributes for the Client Entity */
    /****************************************************************************************/
    /*the client def will be used in the joined clientPresentations table */

    
    
    
    //Do some property definition customization for the ClientPresentation Entity defined in clientPresentationDef
    
    //create an object selection for the C relationship in the Client Entity 
    
    
   
    //set the title property name
    self.clientPresentationDef.titlePropertyName=@"client.clientIDCode";
    
    //set the property definition type to objects selection
	
    
    //Create the property definition for the notes property in the clientPresentation class
    SCPropertyDefinition *clientPresentationNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"notes"];
    
    //set the clientPresentationNotesPropertyDef property definition type to a Text View Cell
    clientPresentationNotesPropertyDef.type = SCPropertyTypeTextView;
    
    
    //define a property group
    SCPropertyGroup *mainGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"CLientData", nil]];
    
    // add the main property group to the clientPresentations class. 
    [self.clientPresentationDef.propertyGroups insertGroup:mainGroup atIndex:0];
    
    //define a property group
    SCPropertyGroup *clientRatingsGroup = [SCPropertyGroup groupWithHeaderTitle:@"Subjective Ratings" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"comfortLevelscaleData", @"stressLevelScaleData", @"happinessLevelScaleData",  @"energyLevelScaleData",  @"hearingLevelScaleData",  @"painLevelScaleData", @"sexualSatisfactionScaleData", @"trustScaleData",  @"symptomSeverityScaleData",  @"suicidalityData",       nil]];
    [self.clientPresentationDef.propertyGroups insertGroup:clientRatingsGroup atIndex:1];
    
    //define a property group
    SCPropertyGroup *clinicianRatingsGroup = [SCPropertyGroup groupWithHeaderTitle:@"Clinician Subjective Ratings" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"allianceScaleData",   @"depthScaleData",      nil]];
    [self.clientPresentationDef.propertyGroups insertGroup:clinicianRatingsGroup atIndex:2];
    
    //define a property group
    SCPropertyGroup *clientDescGroup = [SCPropertyGroup groupWithHeaderTitle:@"Client's Description of Problem" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"clientsDesc", nil]];
    [self.clientPresentationDef.propertyGroups addGroup:clientDescGroup];
    
    //define a property group
    SCPropertyGroup *clientPresentationNotesGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"notes", nil]];
    
    // add the clientPresentationNotesGroup property group to the clientPresentation class. 
    [self.clientPresentationDef.propertyGroups addGroup:clientPresentationNotesGroup];
    

   
    
    //Create a property definition for the appearanceNotes property.
    SCPropertyDefinition *appearanceNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"appearanceNotes"];
    
    //set the appearanceNotes property definition type to a Text View Cell
    appearanceNotesPropertyDef.type = SCPropertyTypeTextView;
    
    
    //Create a property definition for the attentionNotes property.
    SCPropertyDefinition *attentionNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"attentionNotes"];
    
    //set the attentionNotes property definition type to a Text View Cell
    attentionNotesPropertyDef.type = SCPropertyTypeTextView;
    
    //Create a property definition for the attitudeNotes property.
    SCPropertyDefinition *attitudeNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"attitudeNotes"];
    
    //set the attitudeNotes property definition type to a Text View Cell
    attitudeNotesPropertyDef.type = SCPropertyTypeTextView;
    
    //Create a property definition for the languageNotes property.
    SCPropertyDefinition *languageNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"speechLanguage"];
    
    //set the languageNotes property definition type to a Text View Cell
    languageNotesPropertyDef.type = SCPropertyTypeTextView;
    
    
    
    //Create a property definition for the sensoryNotes property.
    SCPropertyDefinition *sensoryNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"sensoryNotes"];
    
    //set the sensoryNotes property definition type to a Text View Cell
    sensoryNotesPropertyDef.type = SCPropertyTypeTextView;
    
  
    
    //Create a property definition for the notableBehaviors property.
    SCPropertyDefinition *notableBehaviorsPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"notableBehaviors"];
    
    //set the notableBehaviors property definition type to a Text View Cell
    notableBehaviorsPropertyDef.type = SCPropertyTypeTextView;
    
    //Create a property definition for the notableImagry property.
    SCPropertyDefinition *notableImagryPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"notableImagry"];
    
    //set the notableImagry property definition type to a Text View Cell
    notableImagryPropertyDef.type = SCPropertyTypeTextView;
    
    //Create a property definition for the interpersonalNotes property.
    SCPropertyDefinition *interpersonalNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"interpersonalNotes"];
    
    //set the interpersonalNotes property definition type to a Text View Cell
    interpersonalNotesPropertyDef.type = SCPropertyTypeTextView;
    
    
    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *psychomotorNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"psychomotor"];
    
    //set the psychoMotorNotes property definition type to a Text View Cell
    psychomotorNotesPropertyDef.type = SCPropertyTypeTextView;
    
    
//    //define a property group
//    SCPropertyGroup *affectNotesGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"affectNotes"]];
//    
//    // add the affectNotes property group to the behavioralObservationsDef class. 
//    [behavioralObservationsDef.propertyGroups addGroup:affectNotesGroup];
//    
//    //define a property group
//    SCPropertyGroup *appearanceNotesGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"appearanceNotes"]];
//    
//    // add the appearanceNotes property group to the behavioralObservationsDef class. 
//    [behavioralObservationsDef.propertyGroups addGroup:appearanceNotesGroup];
//    
//    
//      //define a property group
//    SCPropertyGroup *attentionNotesGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"attentionNotes"]];
//    
//    // add the attentionNotes property group to the behavioralObservationsDef class. 
//    [behavioralObservationsDef.propertyGroups addGroup:attentionNotesGroup];
//    
//      //define a property group
//    SCPropertyGroup *attitudeNotesGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"attitudeNotes"]];
//    
//    // add the attitudeNotes property group to the behavioralObservationsDef class. 
//    [behavioralObservationsDef.propertyGroups addGroup:attitudeNotesGroup];
//    
//        //define a property group
//    SCPropertyGroup *interpersonalNotesGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"interpersonalNotes"]];
//    
//    // add the interpersonalNotes property group to the behavioralObservationsDef class. 
//    [behavioralObservationsDef.propertyGroups addGroup:interpersonalNotesGroup];
//   
//      //define a property group
//    SCPropertyGroup *languageNotesGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"languageNotes"]];
//    
//    // add the languageNotes property group to the behavioralObservationsDef class. 
//    [behavioralObservationsDef.propertyGroups addGroup:languageNotesGroup];
//    
//       //define a property group
//    SCPropertyGroup *notableBehaviorsGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"notableBehaviors"]];
//    
//    // add the notableBehaviors property group to the behavioralObservationsDef class. 
//    [behavioralObservationsDef.propertyGroups addGroup:notableBehaviorsGroup];
//    
//    
//      //define a property group
//    SCPropertyGroup *notableImagryGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"notableImagry"]];
//   
//    // add the notableImagry property group to the behavioralObservationsDef class. 
//    [behavioralObservationsDef.propertyGroups addGroup:notableImagryGroup];
//        //define a property group
//    SCPropertyGroup *psychomotorNotesGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"psychomotorNotes"]];
//    
//    // add the psychomotorNotes property group to the behavioralObservationsDef class. 
//    [behavioralObservationsDef.propertyGroups addGroup:psychomotorNotesGroup];
//   
//      //define a property group
//    SCPropertyGroup *sensoryNotesGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"sensoryNotes"]];
//    
//    // add the sensoryNotes property group to the behavioralObservationsDef class. 
//    [behavioralObservationsDef.propertyGroups addGroup:sensoryNotesGroup];
//
   
       

       
//    //create the dictionary with the data bindings
//    NSDictionary *pickerDataBindings = [NSDictionary 
//                                        dictionaryWithObjects:[NSArray arrayWithObjects:@"facialExpressions",@"Facial Expressions",nil] 
//                                        forKeys:[NSArray arrayWithObjects:@"2", @"3", nil]]; // 1 is the control tags
//	
//    
//    
//    
//    SCCustomPropertyDefinition *titleProperty = [SCCustomPropertyDefinition definitionWithName:@"Facial Expressions"withuiElementClass:[BehaviorPickerCell class] withObjectBindings:pickerDataBindings];
//	[behavioralObservationsDef insertPropertyDefinition:titleProperty atIndex:2];
	
    //create the dictionary with the data bindings
        
    [mainGroup addPropertyName:@"Age"];
    [mainGroup addPropertyName:@"WechslerAge"];
    //create the dictionary with the data bindings
   
  
//    stressLevel
//    appitite
//    assessmentNotes
//    attitudeNotes
//    clientsDesc
//    comfortLevel
//    alliance
//    happinessLevel
//    energyLevel
//    hearingLevel
//    height
//    homicidality
//    improvement
//    interpersonalNotes
//    notableBehaviors
//    notableImagry
//    notes
//    order
//    orientatedToBody
//    orientatedToPerson
//    orientatedToPlace
//    orientatedToTime
//    otherRemarks
//    painLevel
//    plan
//    sexualSatisfaction
//    rapport
//    sensoryNotes
//    sleepHoursNightly
//    sleepQuality
//    suicidality
//    symptomSeverity
//    trust
//    vision
//    depth
//    weight
//    weightUnit
    
    
    return  self;

}




-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{


    detailTableViewModel.delegate=self;

    if([SCHelper is_iPad]&&detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
        

        [detailTableViewModel.modeledTableView setBackgroundView:nil];
        [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
        [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    
    
    }

}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

//NSLog(@"tableview model tag is %i",tableViewModel.tag);
    
 

    
 UIView *scaleView=[cell viewWithTag:70];
               
        if ([scaleView isKindOfClass:[UISegmentedControl class]]) 
        {
        
            SCControlCell *controlCell=(SCControlCell *)cell;
            UILabel *label =(UILabel *)[cell viewWithTag:71];
            NSString *propertyNameString=[controlCell.objectBindings valueForKey:@"2"];
            label.text=propertyNameString;
        }
    
    if ([cell isKindOfClass:[ClientsSelectionCell class]]) {
        
        ClientsSelectionCell *clientsSelectionCell=(ClientsSelectionCell *)cell;
        
        
        [clientsSelectionCell setTestDate:serviceDatePickerDate];
        
        
    }
    

 
 




}

-(void)tableViewControllerDidDisappear:(SCTableViewController *)tableViewController cancelButtonTapped:(BOOL)cancelTapped doneButtonTapped:(BOOL)doneTapped{

//NSLog(@"detail view will appear for row at index path");


}






-(void)tableViewModel:(SCTableViewModel *)tableViewModel willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{


//NSLog(@"cell text is %@",cell.textLabel.text);
    //NSLog(@"section is %i",indexPath.section);
    //NSLog(@"tablemodel is %i",tableViewModel.tag);
    if ((tableViewModel.tag==3 && indexPath.section==0 && [cell.textLabel.text isEqualToString:@"Wechsler Test Age"])||(tableViewModel.tag==3 && indexPath.section==0 && [cell.textLabel.text isEqualToString:@"Test Age"])) 
    {
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
        
        
        
        //        SCLabelCell *actualAge=[SCLabelCell cellWithText:@"Age" withBoundObject:nil withPropertyName:@"Age"];
        //        SCLabelCell *wechslerAge=[SCLabelCell cellWithText:@"Wechsler Age" withBoundObject:nil withPropertyName:@"WechslerAge"];
        //        
        //        [section addCell:actualAge];
        //        [section addCell:wechslerAge];
        //        [section reloadBoundValues];
        [self addWechlerAgeCellToSection:(SCTableViewSection *)section];
        
    }


}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSInteger)index{

    //NSLog(@"tableviewmodel tab is %i",tableViewModel.tag);

    if (tableViewModel.tag==3&&index==0) 
    {
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:index];
        
       
      
            SCLabelCell *actualAge=[SCLabelCell cellWithText:@"Test Age" withBoundObject:nil withPropertyName:@"TestAge"];
            SCLabelCell *wechslerAge=[SCLabelCell cellWithText:@"Wechsler Test Age" withBoundObject:nil withPropertyName:@"WechslerTestAge"];
            
            [section addCell:actualAge];
            [section addCell:wechslerAge];
            [section reloadBoundValues];
       
        }
    
    

SCTableViewSection *section = [tableViewModel sectionAtIndex:index];

//    if (tableViewModel.tag==1 &&index==0) {
//        [section insertCell:[SCLabelCell cellWithText:@"Age"] atIndex:2];
//        [section insertCell:[SCLabelCell cellWithText:@"Wechsler Age"] atIndex:3];
//    }


//NSLog(@"did add section at index header title is %@",section.headerTitle);

if(section.headerTitle !=nil)
{
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.text = section.headerTitle;
    headerLabel.textColor = [UIColor whiteColor];
    [containerView addSubview:headerLabel];
    section.headerView = containerView;
    
    
}
        
        
        
        
        
   
}


//- (void)tableViewModel:(SCTableViewModel *)tableViewModel didLayoutSubviewsForCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if([cell isKindOfClass:[SCSelectionCell class]])
//    {
//       
//        CGRect frame = cell.textLabel.frame;
//        frame.size.width = myNewWidth;
//        cell.textLabel.frame = frame;
//    }
//}
//
-(void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath{

    SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
   
    if (tableViewModel.tag==3&&indexPath.section==0&&cell.tag==0) {
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
        [self addWechlerAgeCellToSection:(SCTableViewSection *)section];
    }





}
-(void)addWechlerAgeCellToSection:(SCTableViewSection *)section {
    
    
    SCLabelCell *actualAgeCell=(SCLabelCell*)[section cellAtIndex:1];
    SCLabelCell *wechslerAgeCell=(SCLabelCell*)[section cellAtIndex:2];
//    SCTableViewCell *clientCell=(SCTableViewCell *)[section cellAtIndex:0];
//    SCTableViewCell *testDateCell=(SCTableViewCell*)[section cellAtIndex:3];
    ClientsViewController_Shared *clientsViewController_Shared=[[ClientsViewController_Shared alloc]init];
    
    SCTableViewCell *clientCell=(SCTableViewCell *)[section cellAtIndex:0];
   
    NSDate *clientDateOfBirth=nil;    
    if ([clientCell isKindOfClass:[ClientsSelectionCell class]]) {
        ClientsSelectionCell *clientObjectsSelectionCell=(ClientsSelectionCell *)clientCell;
        if (clientObjectsSelectionCell.clientObject) {
       
        //NSLog(@"client objects selection cell %@",[clientObjectsSelectionCell.clientObject valueForKey:@"dateOfBirth"]);
        
//        NSArray *array=[[NSArray alloc]init];
       //NSLog(@"cleint object %@",clientObjectsSelectionCell.clientObject);
//        int itemsCount=clientObjectsSelectionCell.items.count;
//        if (itemsCount>=0&&clientObjectsSelectionCell.clientObject) {
////            clientDateOfBirth=(NSDate *)[(NSArray *)[clientObjectsSelectionCell.items valueForKey:@"dateOfBirth"]lastObject];
            
           
            
            
            NSManagedObject *clientObject=(NSManagedObject *)clientObjectsSelectionCell.clientObject;
            clientDateOfBirth=(NSDate *)[clientObject valueForKey:@"dateOfBirth"];

        }else{
            NSString *noClientString=[NSString stringWithString:@"choose client"];
            wechslerAgeCell.label.text=noClientString; 
            actualAgeCell.label.text=noClientString;
            return;
    
        }
        
       
        
       
        
        //NSLog(@"client date of birth is %@",clientDateOfBirth);
    }
    //NSLog(@"client cell class is  %@", [clientCell class]);
        
    
//    //NSLog(@"client cell bound object %@",[clientManagedObject valueForKey:@"client.dateOfBirth"]);
//   //NSLog(@"client date of birth is %@", [clientCell.boundObject valueForKey:@"dateOfBirth"]);
    //NSLog(@"master model is %@",self.serviceDatePickerDate);
   
    if (serviceDatePickerDate && clientDateOfBirth) {
        wechslerAgeCell.label.text=(NSString *)[clientsViewController_Shared calculateWechslerAgeWithBirthdate:(NSDate *)clientDateOfBirth toDate:(NSDate *)serviceDatePickerDate];
        actualAgeCell.label.text=(NSString *)[clientsViewController_Shared calculateActualAgeWithBirthdate:(NSDate *)clientDateOfBirth toDate:(NSDate *)serviceDatePickerDate];
    }
    else
    {
        if (!serviceDatePickerDate) {
            wechslerAgeCell.label.text=[NSString stringWithString:@"no test date"];
            actualAgeCell.label.text=[NSString stringWithString:@"no test date"];
        }
        else if (!clientDateOfBirth)
        {
        
            wechslerAgeCell.label.text=[NSString stringWithString:@"no birthdate"];
            actualAgeCell.label.text=[NSString stringWithString:@"no birthdate"];
        }
        else
        {
            wechslerAgeCell.label.text=[NSString stringWithString:@"0y 0m"];
            actualAgeCell.label.text=[NSString stringWithString:@"0y 0m"];
        }
       
    
    }
//    actualAgeCell.label.text=[clientsViewController_Shared calculateActualAgeWithBirthdate:birthdateCell.datePicker.date];
//    
    
}
-(BOOL)tableViewModel:(SCTableViewModel *)tableViewModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath{
//NSLog(@"tablemodel tag in validate cell is %i",tableViewModel.tag);

    if (tableViewModel.tag==3){
        
        
        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        
        if ([cell isKindOfClass:[ClientsSelectionCell class]]) {
            ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)cell;
            //NSLog(@"client selection cell boud object is %@",clientSelectionCell.boundObject);
            if (clientSelectionCell.clientObject) {
                return YES;
            }
            
        }

    }
    return NO;
}

@end
