/*
 *  ClientPresentations_Shared.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
#import "BOPickersDataSource.h"
#import "ClientsSelectionCell.h"
#import "InstrumentEntity.h"
#import "InstrumentScoreNameEntity.h"
#import "InstrumentScoreEntity.h"
#import "ClientInstrumentScoresEntity.h"
#import "SuicidaltiyCell.h"
#import "RateEntity.h"

@implementation ClientPresentations_Shared
@synthesize clientPresentationDef;
//@synthesize tableModel;
@synthesize serviceDatePickerDate;
@synthesize  sendingControllerSetup;

- (id) setupUsingSTV
{
    NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

    self.clientPresentationDef = [SCEntityDefinition definitionWithEntityName:@"ClientPresentationEntity" managedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"interventionDelivered"];

    //Create the property definition for the affect Mood property in the client Presentatio class
    SCPropertyDefinition *affectNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"affect"];

    affectNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *assessmentNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"assessment"];

    assessmentNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *improvementPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"improvement"];

    improvementPropertyDef.type = SCPropertyTypeTextView;
    SCPropertyDefinition *planPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"plan"];

    planPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *rapportPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"rapport"];

    rapportPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *sleepHoursNightlyPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"sleepHoursNightly"];

    sleepHoursNightlyPropertyDef.type = SCPropertyTypeNumericTextField;

    SCNumericTextFieldAttributes *numericAttributes = [SCNumericTextFieldAttributes attributesWithMinimumValue:nil maximumValue:nil allowFloatValue:YES];
    [numericAttributes.numberFormatter setGroupingSeparator:@","];
    [numericAttributes.numberFormatter setGroupingSize:3];
    sleepHoursNightlyPropertyDef.attributes = numericAttributes;
    //define a property group
    SCPropertyGroup *notesGroup = [SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"affect", @"appearance",  @"assessment", @"attention", @"attitude",@"homework", @"improvement", @"interpersonal", @"behaviors", @"imagery",   @"plan",  @"rapport",  @"sensory", @"sleepHoursNightly",    @"sleepQuality",@"psychomotor", @"speechLanguage",  @"cultural",  @"additionalVariables", @"concentration",@"eyeContact",@"insight",@"intellect",@"judgement", @"medical",@"memory",@"mood",@"perception",@"psychosocial",@"clientsDesc",@"thoughtContent", nil ]];
    [self.clientPresentationDef.propertyGroups addGroup:notesGroup];

    SCPropertyGroup *orientationGroup = [SCPropertyGroup groupWithHeaderTitle:@"Client Orientation" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"orientedToBody", @"orientedToPerson",  @"orientedToPlace", @"orientedToTime",    nil ]];
    // add the notes property group to the clientpresentation class.
    [self.clientPresentationDef.propertyGroups addGroup:orientationGroup];

    self.clientPresentationDef.orderAttributeName = @"order";

    //create a property definition for the sleep Quality property in the clientPresentations class
    SCPropertyDefinition *sleepQualityPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"sleepQuality"];

    BOPickersDataSource *boPicker = [[BOPickersDataSource alloc]init];
    //set the property type to selection
    sleepQualityPropertyDef.type = SCPropertyTypeSelection;

    //set the selection attributes and define the list of items to be selected
    sleepQualityPropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithArray:[boPicker presentationDataWithPropertyName:@"sleepQuality"]]
                                                             allowMultipleSelection:YES
                                                                   allowNoSelection:YES
                                                              autoDismissDetailView:NO hideDetailViewNavigationBar:NO];

    //create a property definition for the orientated to place property in the cleintPresentation Def class
    SCPropertyDefinition *orientedToBodyPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"orientedToBody"];
    orientedToBodyPropertyDef.title = @"Situation";
    //set the property type to segmented
    orientedToBodyPropertyDef.type = SCPropertyTypeSegmented;

    //set the selection attributes and define the list of items to be selected
    orientedToBodyPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No", nil]];

    //create a property definition for the orientated to place property in the cleintPresentation Def class
    SCPropertyDefinition *orientedToPersonPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"orientedToPerson"];
    orientedToPersonPropertyDef.title = @"Person";
    //set the property type to segmented
    orientedToPersonPropertyDef.type = SCPropertyTypeSegmented;

    //set the selection attributes and define the list of items to be selected
    orientedToPersonPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No", nil]];

    //create a property definition for the orientated to place property in the cleintPresentation Def class
    SCPropertyDefinition *orientedToPlacePropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"orientedToPlace"];
    orientedToPlacePropertyDef.title = @"Place";

    //set the property type to segmented
    orientedToPlacePropertyDef.type = SCPropertyTypeSegmented;

    //set the selection attributes and define the list of items to be selected
    orientedToPlacePropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No", nil]];

    //create a property definition for the orientated to place property in the cleintPresentation Def class
    SCPropertyDefinition *orientedToTimePropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"orientedToTime"];

    //set the property type to segmented
    orientedToTimePropertyDef.type = SCPropertyTypeSegmented;

    orientedToTimePropertyDef.title = @"Time";
    //set the selection attributes and define the list of items to be selected
    orientedToTimePropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No", nil]];

    NSString *scaleDataCellNibName = nil;
    if ([SCUtilities is_iPad])
    {
        scaleDataCellNibName = @"ScaleDataCell_iPad";
    }
    else
    {
        scaleDataCellNibName = @"ScaleDataCell_iPhone";
    }

    [self.clientPresentationDef removePropertyDefinitionWithName:@"happinessLevel"];
    NSDictionary *happinessLevelScaleDataBindings = [NSDictionary
                                                     dictionaryWithObjects:[NSArray arrayWithObjects:@"happinessLevel",@"Happiness Level",nil]
                                                                   forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *happinessLevelScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"happinessLevelScaleData"
                                                                                                uiElementNibName:scaleDataCellNibName
                                                                                                  objectBindings:happinessLevelScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:happinessLevelScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"comfortLevel"];

    NSDictionary *comfortLevelScaleDataBindings = [NSDictionary
                                                   dictionaryWithObjects:[NSArray arrayWithObjects:@"comfortLevel", @"Comfort Level",nil]
                                                                 forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *comfortLevelscaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"comfortLevelscaleData"
                                                                                              uiElementNibName:scaleDataCellNibName
                                                                                                objectBindings:comfortLevelScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:comfortLevelscaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"stressLevel"];
    NSDictionary *stressLevelScaleDataBindings = [NSDictionary
                                                  dictionaryWithObjects:[NSArray arrayWithObjects:@"stressLevel",@"Stress Level", nil]
                                                                forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *stressLevelScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"stressLevelScaleData"
                                                                                             uiElementNibName:scaleDataCellNibName
                                                                                               objectBindings:stressLevelScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:stressLevelScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"liabilityRisk"];
    NSDictionary *liabilityRiskScaleDataBindings = [NSDictionary
                                                    dictionaryWithObjects:[NSArray arrayWithObjects:@"liabilityRisk",@"Risk Concern Level", nil]
                                                                  forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *liabilityRiskScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"liabilityRiskScaleData"
                                                                                               uiElementNibName:scaleDataCellNibName
                                                                                                 objectBindings:liabilityRiskScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:liabilityRiskScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"safetyRisk"];
    NSDictionary *safetyRiskScaleDataBindings = [NSDictionary
                                                 dictionaryWithObjects:[NSArray arrayWithObjects:@"safetyRisk",@"Safety Risk Level", nil]
                                                               forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *safetyRiskScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"safetyRiskScaleData"
                                                                                            uiElementNibName:scaleDataCellNibName
                                                                                              objectBindings:safetyRiskScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:safetyRiskScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"progressClinician"];
    NSDictionary *progressClinicianScaleDataBindings = [NSDictionary
                                                        dictionaryWithObjects:[NSArray arrayWithObjects:@"progressClinician",@"Progress (Clinician)", nil]
                                                                      forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *progressClinicianScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"progressClinicianScaleData"
                                                                                                   uiElementNibName:scaleDataCellNibName
                                                                                                     objectBindings:progressClinicianScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:progressClinicianScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"progressClient"];
    NSDictionary *progressClientScaleDataBindings = [NSDictionary
                                                     dictionaryWithObjects:[NSArray arrayWithObjects:@"progressClient",@"Progress (Client)", nil]
                                                                   forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *progressClientScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"progressClientScaleData"
                                                                                                uiElementNibName:scaleDataCellNibName
                                                                                                  objectBindings:progressClientScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:progressClientScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"alliance"];

    NSDictionary *allianceScaleDataBindings = [NSDictionary
                                               dictionaryWithObjects:[NSArray arrayWithObjects:@"alliance",@"Alliance", nil ]
                                                             forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *allianceScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"allianceScaleData"
                                                                                          uiElementNibName:scaleDataCellNibName
                                                                                            objectBindings:allianceScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:allianceScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"energyLevel"];
    NSDictionary *energyLevelScaleDataBindings = [NSDictionary
                                                  dictionaryWithObjects:[NSArray arrayWithObjects:@"energyLevel",@"Energy Level", nil ]
                                                                forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *energyLevelScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"energyLevelScaleData"
                                                                                             uiElementNibName:scaleDataCellNibName
                                                                                               objectBindings:energyLevelScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:energyLevelScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"communicativeAbility"];
    NSDictionary *communicativeAbilityScaleDataBindings = [NSDictionary
                                                           dictionaryWithObjects:[NSArray arrayWithObjects:@"communicativeAbility",@"Communicative Ability", nil ]
                                                                         forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *commnicativeAbilityScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"communicativeAbilityScaleData"
                                                                                                     uiElementNibName:scaleDataCellNibName
                                                                                                       objectBindings:communicativeAbilityScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:commnicativeAbilityScaleDataProperty];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"hopeLevel"];

    NSDictionary *hopeLevelScaleDataBindings = [NSDictionary
                                                dictionaryWithObjects:[NSArray arrayWithObjects:@"hopeLevel",@"Hope Level", nil ]
                                                              forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *hopeLevelScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"hopeLevelScaleData"
                                                                                           uiElementNibName:scaleDataCellNibName
                                                                                             objectBindings:hopeLevelScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:hopeLevelScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"painLevel"];
    NSDictionary *painLevelScaleDataBindings = [NSDictionary
                                                dictionaryWithObjects:[NSArray arrayWithObjects:@"painLevel",@"Pain Level", nil ]
                                                              forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *painLevelScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"painLevelScaleData"
                                                                                           uiElementNibName:scaleDataCellNibName
                                                                                             objectBindings:painLevelScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:painLevelScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"sexualSatisfaction"];
    NSDictionary *sexualSatisfactionScaleDataBindings = [NSDictionary
                                                         dictionaryWithObjects:[NSArray arrayWithObjects:@"sexualSatisfaction",@"Sex Life Satisfaction Level", nil ]
                                                                       forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *sexualSatisfactionScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"sexualSatisfactionScaleData"
                                                                                                    uiElementNibName:scaleDataCellNibName
                                                                                                      objectBindings:sexualSatisfactionScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:sexualSatisfactionScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"copingLevel"];

    NSDictionary *copingLevelScaleDataBindings = [NSDictionary
                                                  dictionaryWithObjects:[NSArray arrayWithObjects:@"copingLevel",@"Coping Level", nil ]
                                                                forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *copingLevelScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"copingLevelScaleData"
                                                                                             uiElementNibName:scaleDataCellNibName
                                                                                               objectBindings:copingLevelScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:copingLevelScaleDataProperty];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"symptomSeverity"];

    NSDictionary *symptomSeverityScaleDataBindings = [NSDictionary
                                                      dictionaryWithObjects:[NSArray arrayWithObjects:@"symptomSeverity",@"Symptom Severity", nil ]
                                                                    forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *symptomSeverityScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"symptomSeverityScaleData"
                                                                                                 uiElementNibName:scaleDataCellNibName
                                                                                                   objectBindings:symptomSeverityScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:symptomSeverityScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"openness"];

    NSDictionary *opennessScaleDataBindings = [NSDictionary
                                               dictionaryWithObjects:[NSArray arrayWithObjects:@"openness",@"Level of Openness", nil ]
                                                             forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *opennessScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"opennessScaleData"
                                                                                          uiElementNibName:scaleDataCellNibName
                                                                                            objectBindings:opennessScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:opennessScaleDataProperty];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"depth"];
    NSDictionary *depthScaleDataBindings = [NSDictionary
                                            dictionaryWithObjects:[NSArray arrayWithObjects:@"depth",@"Depth", nil ]
                                                          forKeys:[NSArray arrayWithObjects:@"70",@"2",nil]]; // 70 and 2 are the control tags
    SCCustomPropertyDefinition *depthScaleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"depthScaleData"
                                                                                       uiElementNibName:scaleDataCellNibName
                                                                                         objectBindings:depthScaleDataBindings];

    [self.clientPresentationDef addPropertyDefinition:depthScaleDataProperty];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"suicideIdeation"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"suicidePlan"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"suicideMeans"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"suicideHistory"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"order"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"testSessionDelivered"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"homicideIdeation"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"homicidePlan"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"homicideMeans"];
    [self.clientPresentationDef removePropertyDefinitionWithName:@"homicideHistory"];

    [self.clientPresentationDef removePropertyDefinitionWithName:@"client"];
    NSDictionary *suicidalityDataBindings = [NSDictionary
                                             dictionaryWithObjects:[NSArray arrayWithObjects:@"suicideIdeation",@"suicidePlan",@"suicideMeans", @"suicideHistory", @"suicide",   nil ]
                                                           forKeys:[NSArray arrayWithObjects:@"20",@"21",@"22",@"23",@"41",nil]]; // 20,21,22,23 are the binding keys
    SCCustomPropertyDefinition *suicidalityDataProperty = [SCCustomPropertyDefinition definitionWithName:@"suicidalityData"
                                                                                        uiElementNibName:@"SuicidalityCell"
                                                                                          objectBindings:suicidalityDataBindings];

    [self.clientPresentationDef addPropertyDefinition:suicidalityDataProperty];

    NSDictionary *homicidalityDataBindings = [NSDictionary
                                              dictionaryWithObjects:[NSArray arrayWithObjects:@"homicideIdeation",@"homicidePlan",@"homicideMeans", @"homicideHistory", @"homicide",   nil ]
                                                            forKeys:[NSArray arrayWithObjects:@"20",@"21",@"22",@"23",@"41",nil]]; // 20,21,22,23 are the binding keys
    SCCustomPropertyDefinition *homicidalityDataProperty = [SCCustomPropertyDefinition definitionWithName:@"homicidalityData"
                                                                                         uiElementNibName:@"SuicidalityCell"
                                                                                           objectBindings:homicidalityDataBindings];

    [self.clientPresentationDef addPropertyDefinition:homicidalityDataProperty];

    //Create a property definition for the clientDesc property.
    SCPropertyDefinition *clientDescPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"clientsDesc"];

    //set the clientDscs property definition type to a Text View Cell
    clientDescPropertyDef.type = SCPropertyTypeTextView;

    //override the auto title generation for the clientDesc property definition and set it to a custom title
    clientDescPropertyDef.title = @"Struggled With";

    //Create a class definition for Additional Variables entity
    SCEntityDefinition *additionalVariableDef = [SCEntityDefinition definitionWithEntityName:@"AdditionalVariableEntity"
                                                                        managedObjectContext:managedObjectContext
                                                                               propertyNames:[NSArray arrayWithObjects:@"variableName",@"selectedValue",@"stringValue",@"timeValue",@"dateValue",@"timeValueTwo", @"notes",nil]];

    additionalVariableDef.orderAttributeName = @"order";
    //Create a class definition for Additional Variable Name entity
    SCEntityDefinition *additionalVariableNameDef = [SCEntityDefinition definitionWithEntityName:@"AdditionalVariableNameEntity"
                                                                            managedObjectContext:managedObjectContext
                                                                                   propertyNames:[NSArray arrayWithObjects:@"variableName",@"notes",@"variableValues",nil]];

    additionalVariableNameDef.orderAttributeName = @"order";

    SCEntityDefinition *additionalVariableValueDef = [SCEntityDefinition definitionWithEntityName:@"AdditionalVariableValueEntity"
                                                                             managedObjectContext:managedObjectContext
                                                                                    propertyNames:[NSArray arrayWithObjects:@"variableValue",@"notes",nil]];

    additionalVariableValueDef.orderAttributeName = @"order";

    SCPropertyDefinition *variableValuesInVariableNamePropertyDef = [additionalVariableNameDef propertyDefinitionWithName:@"variableValues"];
    variableValuesInVariableNamePropertyDef.title = @"Selectable Values";
    variableValuesInVariableNamePropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:additionalVariableValueDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add new variable value"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];

    SCPropertyDefinition *additionalVariablesPropertyDef = [clientPresentationDef propertyDefinitionWithName:@"additionalVariables"];

    additionalVariablesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:additionalVariableDef allowAddingItems:TRUE
                                                                                        allowDeletingItems:TRUE
                                                                                          allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];

    SCPropertyDefinition *additionalVariableNamePropertyDef = [additionalVariableDef propertyDefinitionWithName:@"variableName"];
    additionalVariableNamePropertyDef.type = SCPropertyTypeObjectSelection;

    SCObjectSelectionAttributes *variableNameSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:additionalVariableNameDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    variableNameSelectionAttribs.allowAddingItems = YES;
    variableNameSelectionAttribs.allowDeletingItems = YES;
    variableNameSelectionAttribs.allowMovingItems = YES;
    variableNameSelectionAttribs.allowEditingItems = YES;
    variableNameSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Variable Name Definitions)"];
    variableNameSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add Variable Name Definition"];
    additionalVariableNamePropertyDef.attributes = variableNameSelectionAttribs;
    SCPropertyDefinition *additionalVariableNameNotesPropertyDef = [additionalVariableNameDef propertyDefinitionWithName:@"notes"];
    additionalVariableNameNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *additionalVariableValuePropertyDef = [additionalVariableDef propertyDefinitionWithName:@"selectedValue"];
    additionalVariableValuePropertyDef.title = @"Selected Value(s)";
    additionalVariableValuePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *variableValueSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:additionalVariableValueDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:YES];
    variableValueSelectionAttribs.allowAddingItems = NO;
    variableValueSelectionAttribs.allowDeletingItems = NO;
    variableValueSelectionAttribs.allowMovingItems = YES;
    variableValueSelectionAttribs.allowEditingItems = YES;
    variableValueSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Variable Values Under Variable Name)"];
    additionalVariableValuePropertyDef.attributes = variableValueSelectionAttribs;
    SCPropertyDefinition *additionalVariableValueNotesPropertyDef = [additionalVariableValueDef propertyDefinitionWithName:@"notes"];
    additionalVariableValueNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *additionalVariableNotesPropertyDef = [additionalVariableDef propertyDefinitionWithName:@"notes"];
    additionalVariableNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *additionalVariableStingValuePropertyDef = [additionalVariableDef propertyDefinitionWithName:@"stringValue"];
    additionalVariableStingValuePropertyDef.type = SCPropertyTypeTextView;

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

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];

    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setTimeStyle:NSDateFormatterShortStyle];

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

    timeValueTwoPropertyDef.title = @"Date & Time";

    additionalVariableDef.titlePropertyName = @"variableName.variableName";

    /*
     **************************************************************************************
        BEGIN Class Definition and attributes for the Client Entity
     **************************************************************************************
     */

    //get the client setup from the clients View Controller Shared
    // Add a custom property that represents a custom cells for the description defined TextFieldAndLableCell.xib

    //create the dictionary with the data bindings
    NSDictionary *clientDataBindings = [NSDictionary
                                        dictionaryWithObjects:[NSArray arrayWithObjects:@"client",@"Client",@"client",[NSNumber numberWithBool:NO],nil]
                                                      forKeys:[NSArray arrayWithObjects:@"1",@"90",@"92",@"93",nil ]]; // 1 are the control tags

    //create the custom property definition
    SCCustomPropertyDefinition *clientDataProperty = [SCCustomPropertyDefinition definitionWithName:@"CLientData"
                                                                                     uiElementClass:[ClientsSelectionCell class] objectBindings:clientDataBindings];

    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    clientDataProperty.autoValidate = FALSE;

    //insert the custom property definition into the clientData class at index
    [self.clientPresentationDef insertPropertyDefinition:clientDataProperty atIndex:0];

    /*
     **************************************************************************************
        END of Class Definition and attributes for the Client Entity
     **************************************************************************************
       the client def will be used in the joined clientPresentations table
     */

    //Do some property definition customization for the ClientPresentation Entity defined in clientPresentationDef

    //create an object selection for the C relationship in the Client Entity

    //set the title property name
    self.clientPresentationDef.titlePropertyName = @"client.clientIDCode";

    //set the property definition type to objects selection

    //Create the property definition for the notes property in the clientPresentation class
    SCPropertyDefinition *clientPresentationNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"otherNotes"];

    //set the clientPresentationNotesPropertyDef property definition type to a Text View Cell
    clientPresentationNotesPropertyDef.type = SCPropertyTypeTextView;

    //define a property group
    SCPropertyGroup *mainGroup = [SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"CLientData", nil]];

    // add the main property group to the clientPresentations class.
    [self.clientPresentationDef.propertyGroups insertGroup:mainGroup atIndex:0];

    //define a property group
    SCPropertyGroup *clientRatingsGroup = [SCPropertyGroup groupWithHeaderTitle:@"Subjective Ratings" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"happinessLevelScaleData",@"progressClientScaleData",@"comfortLevelscaleData", @"stressLevelScaleData",  @"copingLevelScaleData", @"hopeLevelScaleData", @"energyLevelScaleData",    @"painLevelScaleData", @"sexualSatisfactionScaleData",  @"symptomSeverityScaleData",  @"suicidalityData", @"homicidalityData",      nil]];
    [self.clientPresentationDef.propertyGroups insertGroup:clientRatingsGroup atIndex:1];

    //define a property group
    SCPropertyGroup *clinicianRatingsGroup = [SCPropertyGroup groupWithHeaderTitle:@"Clinician Subjective Ratings" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"allianceScaleData",@"communicativeAbilityScaleData", @"opennessScaleData",@"progressClinicianScaleData",  @"depthScaleData", @"safetyRisk",@"liabilityRiskScaleData", @"safetyRiskScaleData",    nil]];
    [self.clientPresentationDef.propertyGroups insertGroup:clinicianRatingsGroup atIndex:2];

    //define a property group
    SCPropertyGroup *clientPresentationNotesGroup = [SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"otherNotes", nil]];

    // add the clientPresentationNotesGroup property group to the clientPresentation class.
    [self.clientPresentationDef.propertyGroups addGroup:clientPresentationNotesGroup];

    //Create a property definition for the appearanceNotes property.
    SCPropertyDefinition *appearanceNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"appearance"];

    //set the appearanceNotes property definition type to a Text View Cell
    appearanceNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the attentionNotes property.
    SCPropertyDefinition *attentionNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"attention"];
    //set the attentionNotes property definition type to a Text View Cell
    attentionNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the cultural property.
    SCPropertyDefinition *culturalPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"cultural"];
    //set the cultural property definition type to a Text View Cell
    culturalPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the attitudeNotes property.
    SCPropertyDefinition *attitudeNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"attitude"];

    //set the attitudeNotes property definition type to a Text View Cell
    attitudeNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the languageNotes property.
    SCPropertyDefinition *languageNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"speechLanguage"];

    //set the languageNotes property definition type to a Text View Cell
    languageNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the sensoryNotes property.
    SCPropertyDefinition *sensoryNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"sensory"];

    //set the sensoryNotes property definition type to a Text View Cell
    sensoryNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the notableBehaviors property.
    SCPropertyDefinition *notableBehaviorsPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"behaviors"];

    //set the notableBehaviors property definition type to a Text View Cell
    notableBehaviorsPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the notableImagery property.
    SCPropertyDefinition *notableImageryPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"imagery"];

    //set the notableImagery property definition type to a Text View Cell
    notableImageryPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the interpersonalNotes property.
    SCPropertyDefinition *interpersonalNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"interpersonal"];

    //set the interpersonalNotes property definition type to a Text View Cell
    interpersonalNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *psychomotorNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"psychomotor"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    psychomotorNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *concentrationNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"concentration"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    concentrationNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *eyeContactnNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"eyeContact"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    eyeContactnNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *insightNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"insight"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    insightNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *homeworkNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"homework"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    homeworkNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *intellectNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"intellect"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    intellectNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *judgementNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"judgement"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    judgementNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *medicalNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"medical"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    medicalNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *memoryNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"memory"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    memoryNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *moodNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"mood"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    moodNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *perceptionNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"perception"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    perceptionNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *psychosocialNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"psychosocial"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    psychosocialNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.
    SCPropertyDefinition *thoughtContentNotesPropertyDef = [self.clientPresentationDef propertyDefinitionWithName:@"thoughtContent"];

    //set the psychoMotorNotes property definition type to a Text View Cell
    thoughtContentNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a property definition for the psychoMotorNotes property.

    //Create a class definition for the instrument Score Entity
    SCEntityDefinition *instrumentScoreDef = [SCEntityDefinition definitionWithEntityName:@"InstrumentScoreEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"scoreName",@"rawScore", @"scaledScore", @"standardScore", @"percentile", @"tScore",   @"zScore",@"baseRate",  @"confidence", @"cIFloor", @"cICeiling",  @"notes",    nil]];

    SCEntityDefinition *instrumentDef = [SCEntityDefinition definitionWithEntityName:@"InstrumentEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"acronym", @"instrumentName",@"instrumentType", @"publisher", @"ages", @"sampleSize",@"scoreNames",@"notes", nil]];

    SCEntityDefinition *clientInstrumentScoresDef = [SCEntityDefinition definitionWithEntityName:@"ClientInstrumentScoresEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"instrument", @"scores",@"notes",   nil]];

    SCEntityDefinition *instrumentScoreNameDef = [SCEntityDefinition definitionWithEntityName:@"InstrumentScoreNameEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"scoreName", @"abbreviatedName", @"notes", nil]];

    SCPropertyDefinition *clientInstrumentNotesPropertyDef = [clientInstrumentScoresDef propertyDefinitionWithName:@"notes"];

    clientInstrumentNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *instrumentNotesPropertyDef = [instrumentDef propertyDefinitionWithName:@"notes"];

    instrumentNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *scoreNotesPropertyDef = [instrumentScoreDef propertyDefinitionWithName:@"notes"];

    scoreNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *instrumentScoreNameNotesPropertyDef = [instrumentScoreNameDef propertyDefinitionWithName:@"notes"];

    instrumentScoreNameNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create the property definition for the instrument Scores property
    SCPropertyDefinition *clientInstrumentScoresPropertyDef = [clientPresentationDef propertyDefinitionWithName:@"instrumentScores"];

    clientInstrumentScoresPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:clientInstrumentScoresDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add new instrument scores"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];

    clientInstrumentScoresDef.titlePropertyName = @"instrument.instrumentName";
    SCPropertyDefinition *instrumentPropertyDef = [clientInstrumentScoresDef propertyDefinitionWithName:@"instrument"];

    clientInstrumentScoresDef.orderAttributeName = @"order";
    //set the title property name
    instrumentDef.titlePropertyName = @"acronym";
    instrumentDef.orderAttributeName = @"order";
    //set the property definition type to objects selection

    instrumentPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *instrumentSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:instrumentDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];

    //set some addtional attributes
    instrumentSelectionAttribs.allowAddingItems = YES;
    instrumentSelectionAttribs.allowDeletingItems = YES;
    instrumentSelectionAttribs.allowMovingItems = YES;
    instrumentSelectionAttribs.allowEditingItems = YES;

    //add a placeholder element to tell the user what to do     when there are no other cells
    instrumentSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Instruments)"];

    //add an "Add New" element to appear when user clicks edit
    instrumentSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new instrument"];

    //add the selection attributes to the property definition
    instrumentPropertyDef.attributes = instrumentSelectionAttribs;

    SCPropertyDefinition *scoreNameInInstrumentPropertyDef = [instrumentDef propertyDefinitionWithName:@"scoreNames"];

    scoreNameInInstrumentPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:instrumentScoreNameDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:NO expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"(Define score names)"] addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap here to define score name"] addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];

    //Create a class definition for the instrument type Entity
    SCEntityDefinition *instrumentTypeDef = [SCEntityDefinition definitionWithEntityName:@"InstrumentTypeEntity"
                                                                    managedObjectContext:managedObjectContext
                                                                           propertyNames:[NSArray arrayWithObjects:@"instrumentType", @"notes", nil]];

    //create a property definition
    SCPropertyDefinition *instrumentTypePropertyDef = [instrumentDef propertyDefinitionWithName:@"instrumentType"];

    //set the title property name
    instrumentTypeDef.titlePropertyName = @"instrumentType";

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
    SCPropertyDefinition *instrumentTypeNotesPropertyDef = [instrumentTypeDef propertyDefinitionWithName:@"notes"];
    instrumentTypeNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a class definition for the instrument type Entity
    SCEntityDefinition *instrumentPublisherDef = [SCEntityDefinition definitionWithEntityName:@"InstrumentPublisherEntity"
                                                                         managedObjectContext:managedObjectContext
                                                                                propertyNames:[NSArray arrayWithObjects:@"publisherName", @"notes", nil]];

    //create a property definition
    SCPropertyDefinition *instrumentPublisherPropertyDef = [instrumentDef propertyDefinitionWithName:@"publisher"];

    //set the title property name
    instrumentPublisherDef.titlePropertyName = @"publisherName";
    instrumentPublisherDef.orderAttributeName = @"order";
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
    instrumentPublisherNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *scoresPropertyDef = [clientInstrumentScoresDef propertyDefinitionWithName:@"scores"];

    //set the title property name
    instrumentScoreDef.titlePropertyName = @"scoreName.abbreviatedName;rawScore;scaledScore;standardScore;percentile;tScore;cIFloor;cICeiling";

    scoresPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:instrumentScoreDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:NO expandContentInCurrentView:YES placeholderuiElement:[SCTableViewCell cellWithText:@"(add scores)"] addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add new score"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:NO];

    SCPropertyDefinition *instrumentScoreNameInScoresPropertyDef = [instrumentScoreDef propertyDefinitionWithName:@"scoreName"];

    //set the title property name
    instrumentScoreNameDef.titlePropertyName = @"abbreviatedName";

    //set the property definition type to objects selection

    instrumentScoreNameInScoresPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *instrumentScoreNameInScoresSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:instrumentScoreNameDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];

    //set some addtional attributes
    instrumentScoreNameInScoresSelectionAttribs.allowAddingItems = NO;
    instrumentScoreNameInScoresSelectionAttribs.allowDeletingItems = NO;
    instrumentScoreNameInScoresSelectionAttribs.allowMovingItems = NO;
    instrumentScoreNameInScoresSelectionAttribs.allowEditingItems = YES;

    //add a placeholder element to tell the user what to do     when there are no other cells
    instrumentScoreNameInScoresSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(define score names under instruments)"];

    //add an "Add New" element to appear when user clicks edit
    instrumentScoreNameInScoresSelectionAttribs.addNewObjectuiElement = nil;

    //add the selection attributes to the property definition
    instrumentScoreNameInScoresPropertyDef.attributes = instrumentScoreNameInScoresSelectionAttribs;

    SCPropertyGroup *instrumentInClientInstrumentScoresPropertyGroup = [SCPropertyGroup groupWithHeaderTitle:@"Select instrument before scores" footerTitle:@"If you change the instrument, the scores added under a different instrument will be removed." propertyNames:[NSArray arrayWithObject:@"instrument"]];

    [clientInstrumentScoresDef.propertyGroups addGroup:instrumentInClientInstrumentScoresPropertyGroup];

    SCPropertyGroup *scoresInClientInstrumentScoresPropertyGroup = [SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObject:@"scores"]];

    [clientInstrumentScoresDef.propertyGroups addGroup:scoresInClientInstrumentScoresPropertyGroup];

    SCPropertyGroup *notesInClientInstrumentScoresPropertyGroup = [SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObject:@"notes"]];

    [clientInstrumentScoresDef.propertyGroups addGroup:notesInClientInstrumentScoresPropertyGroup];

    //Create a class definition for the Instrument Entity
    SCEntityDefinition *clientBatteryNotesDef = [SCEntityDefinition definitionWithEntityName:@"ClientBatteryNotesEntity"
                                                                        managedObjectContext:managedObjectContext
                                                                               propertyNames:[NSArray arrayWithObjects:@"battery",@"countAsTrainingBattery",
                                                                                              @"notes", nil]];

    //set the title property name
    clientBatteryNotesDef.titlePropertyName = @"battery.batteryName;battery.acronym";
    clientBatteryNotesDef.titlePropertyNameDelimiter = @" - ";
    clientBatteryNotesDef.orderAttributeName = @"order";

    //Create the property definition for the instrument Scores property
    SCPropertyDefinition *clientBatteryNotesPropertyDef = [clientPresentationDef propertyDefinitionWithName:@"batteries"];

    clientBatteryNotesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:clientBatteryNotesDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add battery"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];

    SCPropertyDefinition *countAsTrainingPropertyDef = [clientBatteryNotesDef propertyDefinitionWithName:@"countAsTrainingBattery"];

    if ([SCUtilities is_iPad])
    {
        countAsTrainingPropertyDef.title = @"Count as Completed Training Battery";
    }
    else
    {
        countAsTrainingPropertyDef.title = @"Completed Battery";
    }

    countAsTrainingPropertyDef.cellActions.didLayoutSubviews = ^(SCTableViewCell *cell, NSIndexPath *indexPath)
    {
        [cell.textLabel sizeToFit];
    };

    //Create a class definition for the Instrument Entity
    SCEntityDefinition *batteryDef = [SCEntityDefinition definitionWithEntityName:@"BatteryEntity"
                                                             managedObjectContext:managedObjectContext
                                                                    propertyNames:[NSArray arrayWithObjects:@"batteryName", @"acronym", @"publisher",@"instruments", @"sampleSize", @"ages",@"notes", nil]];

    SCPropertyDefinition *clientBatteryNotesNotesPropertyDef = [clientBatteryNotesDef propertyDefinitionWithName:@"notes"];
    clientBatteryNotesNotesPropertyDef.type = SCPropertyTypeTextView;

    //create a property definition
    SCPropertyDefinition *batteryPropertyDef = [clientBatteryNotesDef propertyDefinitionWithName:@"battery"];

    //set the title property name
    batteryDef.titlePropertyName = @"batteryName;acronym";
    batteryDef.titlePropertyNameDelimiter = @" - ";
    batteryDef.orderAttributeName = @"order";
    //set the property definition type to objects selection

    batteryPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *batterySelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:batteryDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];

    //set some addtional attributes
    batterySelectionAttribs.allowAddingItems = YES;
    batterySelectionAttribs.allowDeletingItems = YES;
    batterySelectionAttribs.allowMovingItems = YES;
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
    batteryInstrumentsPropertyDef.type = SCPropertyTypeObjectSelection;

    SCObjectSelectionAttributes *batteryInstrumentsSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:instrumentDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:YES];
    batteryInstrumentsSelectionAttribs.allowAddingItems = YES;
    batteryInstrumentsSelectionAttribs.allowDeletingItems = YES;
    batteryInstrumentsSelectionAttribs.allowMovingItems = YES;
    batteryInstrumentsSelectionAttribs.allowEditingItems = YES;
    batteryInstrumentsSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"(Add Instrument)"];

    batteryInstrumentsSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Instruments)"];

    batteryInstrumentsPropertyDef.attributes = batteryInstrumentsSelectionAttribs;

    //Create the property definition for the notes property in the genderDef class
    SCPropertyDefinition *batteryNotesPropertyDef = [batteryDef propertyDefinitionWithName:@"notes"];
    batteryNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyGroup *instrumentGroup = [SCPropertyGroup groupWithHeaderTitle:@"Instruments" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"instrumentScores",@"batteries",    nil]];
    [self.clientPresentationDef.propertyGroups insertGroup:instrumentGroup atIndex:1];

    //begin rate paste

    //end

    NSString *ratePropertyNameString = @"hourlyRate";
    NSString *rateEntityNameString = @"RateEntity";

    SCEntityDefinition *rateDef = [SCEntityDefinition definitionWithEntityName:rateEntityNameString managedObjectContext:managedObjectContext propertyNamesString:@"rateName;dateStarted;dateEnded;hourlyRate;notes"];

    rateDef.orderAttributeName = @"order";

    SCPropertyDefinition *hourlyRatePropertyDef = [rateDef propertyDefinitionWithName:@"hourlyRate"];
    hourlyRatePropertyDef.type = SCPropertyTypeNumericTextField;

    hourlyRatePropertyDef.attributes = numericAttributes;

    SCPropertyDefinition *ratePropertyDef = [self.clientPresentationDef propertyDefinitionWithName:ratePropertyNameString];
    ratePropertyDef.type = SCPropertyTypeObjectSelection;

    SCObjectSelectionAttributes *rateSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:rateDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    rateSelectionAttribs.allowAddingItems = YES;
    rateSelectionAttribs.allowDeletingItems = YES;
    rateSelectionAttribs.allowMovingItems = YES;
    rateSelectionAttribs.allowEditingItems = YES;
    rateSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"(Add Rates)"];

    ratePropertyDef.attributes = rateSelectionAttribs;

    SCPropertyDefinition *rateStrPropertyDef = [rateDef propertyDefinitionWithName:ratePropertyNameString];
    rateStrPropertyDef.type = SCPropertyTypeNumericTextField;
    SCPropertyDefinition *rateNotesPropertyDef = [rateDef propertyDefinitionWithName:@"notes"];
    rateNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *rateDateStartedPropertyDef = [rateDef propertyDefinitionWithName:@"dateStarted"];
    rateDateStartedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                           datePickerMode:UIDatePickerModeDate
                                                            displayDatePickerInDetailView:NO];

    SCPropertyDefinition *rateDateEndedPropertyDef = [rateDef propertyDefinitionWithName:@"dateEnded"];
    rateDateEndedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                         datePickerMode:UIDatePickerModeDate
                                                          displayDatePickerInDetailView:NO];

    SCPropertyGroup *paymentGroup = [SCPropertyGroup groupWithHeaderTitle:@"Payment Information" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"hourlyRate",@"paid", @"proBono",nil]];

    [self.clientPresentationDef.propertyGroups addGroup:paymentGroup];

    return self;
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *scaleView = [cell viewWithTag:70];

    if ([scaleView isKindOfClass:[UISegmentedControl class]])
    {
        SCCustomCell *controlCell = (SCCustomCell *)cell;
        UILabel *label = (UILabel *)[cell viewWithTag:71];
        NSString *propertyNameString = [controlCell.objectBindings valueForKey:@"2"];
        label.text = propertyNameString;
    }

    if ([cell isKindOfClass:[ClientsSelectionCell class]])
    {
        ClientsSelectionCell *clientsSelectionCell = (ClientsSelectionCell *)cell;

        [clientsSelectionCell setTestDate:serviceDatePickerDate];
        clientsSelectionCell.addAgeCells = YES;
    }

    if (tableViewModel.tag == 5)
    {
        UIView *sliderView = [cell viewWithTag:14];

        switch (cell.tag)
        {
            case 3:

                if ([sliderView isKindOfClass:[UISlider class]])
                {
                    UISlider *sliderOne = (UISlider *)sliderView;
                    UILabel *slabel = (UILabel *)[cell viewWithTag:10];

                    slabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
                    UIImage *sliderLeftTrackImage = [[UIImage imageNamed:@"sliderbackground-gray.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:0];
                    UIImage *sliderRightTrackImage = [[UIImage imageNamed:@"sliderbackground.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:0];
                    [sliderOne setMinimumTrackImage:sliderLeftTrackImage forState:UIControlStateNormal];
                    [sliderOne setMaximumTrackImage:sliderRightTrackImage forState:UIControlStateNormal];
                    [sliderOne setMinimumValue:-1.0];
                    [sliderOne setMaximumValue:0];
                }

                break;
            case 4:

                if ([sliderView isKindOfClass:[UISlider class]])
                {
                    UISlider *sliderTwo = (UISlider *)sliderView;

                    UILabel *slabelTwo = (UILabel *)[cell viewWithTag:10];
                    UIImage *sliderTwoLeftTrackImage = [[UIImage imageNamed:@"sliderbackground.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:0];
                    UIImage *sliderTwoRightTrackImage = [[UIImage imageNamed:@"sliderbackground-gray.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:0];
                    [sliderTwo setMinimumTrackImage:sliderTwoLeftTrackImage forState:UIControlStateNormal];
                    [sliderTwo setMaximumTrackImage:sliderTwoRightTrackImage forState:UIControlStateNormal];

                    slabelTwo.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
                    [sliderTwo setMinimumValue:0.0];
                    [sliderTwo setMaximumValue:1.0];
                }

                break;

            default:
                break;
        } /* switch */
    }
}


- (void) tableViewControllerDidDisappear:(SCTableViewController *)tableViewController cancelButtonTapped:(BOOL)cancelTapped doneButtonTapped:(BOOL)doneTapped
{
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( (tableViewModel.tag == 3 && indexPath.section == 0 && [cell.textLabel.text isEqualToString:@"Age (30-Day Months)"]) || ( tableViewModel.tag == 3 && indexPath.section == 0 && ([cell.textLabel.text isEqualToString:@"Test Age"] || [cell.textLabel.text isEqualToString:@"Age on Service Date"]) ) )
    {
        SCTableViewSection *section = (SCTableViewSection *)[tableViewModel sectionAtIndex:0];

        [self addWechlerAgeCellToSection:(SCTableViewSection *)section];
    }
    else if (tableViewModel.tag == 3 && tableViewModel.sectionCount > 7)
    {
        if ( cell.tag == 0 && [cell.textLabel.text isEqualToString:@"Hourly Rate"] && ([cell isKindOfClass:[SCObjectSelectionCell class]]) )
        {
            SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cell;

            if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]])
            {
                RateEntity *rateObject = (RateEntity *)[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex intValue]];

                if (rateObject.hourlyRate && rateObject.rateName)
                {
                    NSLocale *locale = [NSLocale currentLocale];
                    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc]init];
                    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                    [currencyFormatter setLocale:locale];

                    [currencyFormatter setGroupingSize:3];
                    [currencyFormatter setGroupingSeparator:@","];

                    NSString *textToDisplay = [NSString stringWithFormat:@"%@ %@",rateObject.rateName,[currencyFormatter stringFromNumber:rateObject.hourlyRate]];

                    objectSelectionCell.label.text = textToDisplay;
                    currencyFormatter = nil;
                }
            }
        }
    }
    else if (tableViewModel.tag == 4 && tableViewModel.sectionCount)
    {
        NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;

        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"RateEntity"])
        {
            RateEntity *rateObject = (RateEntity *)cellManagedObject;

            if (rateObject.hourlyRate)
            {
                NSLocale *locale = [NSLocale currentLocale];
                NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc]init];
                [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
                [currencyFormatter setLocale:locale];

                [currencyFormatter setGroupingSize:3];
                [currencyFormatter setGroupingSeparator:@","];

                NSString *textToDisplay = rateObject.rateName ? [NSString stringWithFormat:@"%@ %@",rateObject.rateName,[currencyFormatter stringFromNumber:rateObject.hourlyRate]] : [currencyFormatter stringFromNumber:rateObject.hourlyRate];

                cell.textLabel.text = textToDisplay;
            }
        }
    }
    else if (tableViewModel.tag == 5 && tableViewModel.sectionCount > 1 && indexPath.section == 1)
    {
        NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;

        if ([cellManagedObject isKindOfClass:[InstrumentScoreEntity class]])
        {
            InstrumentScoreEntity *instrumentScoreEntity = (InstrumentScoreEntity *)cellManagedObject;

            NSString *textStr = (NSString *)[instrumentScoreEntity valueForKeyPath:@"scoreName.abbreviatedName"];

            if (instrumentScoreEntity.rawScore)
            {
                textStr = [textStr stringByAppendingFormat:@" RS:%.1f",[instrumentScoreEntity.rawScore floatValue]];
            }

            if (instrumentScoreEntity.scaledScore)
            {
                textStr = [textStr stringByAppendingFormat:@" ScS:%i",[instrumentScoreEntity.scaledScore integerValue]];
            }

            if (instrumentScoreEntity.standardScore)
            {
                textStr = [textStr stringByAppendingFormat:@" StS:%.0f",[instrumentScoreEntity.standardScore floatValue]];
            }

            if (instrumentScoreEntity.percentile)
            {
                textStr = [textStr stringByAppendingFormat:@" P:%.0f%%",[instrumentScoreEntity.percentile floatValue]];
            }

            if (instrumentScoreEntity.tScore)
            {
                textStr = [textStr stringByAppendingFormat:@" tS:%.0f",[instrumentScoreEntity.tScore floatValue]];
            }

            if (instrumentScoreEntity.zScore)
            {
                textStr = [textStr stringByAppendingFormat:@" zS:%.2f",[instrumentScoreEntity.zScore floatValue]];
            }

            if (instrumentScoreEntity.baseRate)
            {
                textStr = [textStr stringByAppendingFormat:@" BR:%.1f",[instrumentScoreEntity.baseRate floatValue]];
            }

            if (instrumentScoreEntity.cIFloor && instrumentScoreEntity.cICeiling && instrumentScoreEntity.confidence)
            {
                textStr = [textStr stringByAppendingFormat:@" C:%.0f%% %.1f-%.1f",[instrumentScoreEntity.confidence floatValue],[instrumentScoreEntity.cIFloor floatValue],[instrumentScoreEntity.cICeiling floatValue]];
            }

            cell.textLabel.text = textStr;
        }
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailModelConfiguredForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    detailTableViewModel.tag = tableModel.tag + 1;
    detailTableViewModel.delegate = self;
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    if (tableViewModel.tag == 3 && index == 0)
    {
        SCTableViewSection *section = (SCTableViewSection *)[tableViewModel sectionAtIndex:index];

        SCLabelCell *actualAge = [SCLabelCell cellWithText:(self.sendingControllerSetup != kTrackAssessment) ? @"Age on Service Date":@"SD Test Age" boundObject:nil labelTextPropertyName:@"TestAge"]
        ;

        SCLabelCell *wechslerAge = [SCLabelCell cellWithText:@"Age (30-day Months)" boundObject:nil labelTextPropertyName:@"WechslerTestAge"];

        [section addCell:actualAge];
        [section addCell:wechslerAge];
    }

    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];

    if (section.headerTitle != nil)
    {
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.text = section.headerTitle;
        headerLabel.textColor = [UIColor whiteColor];
        [containerView addSubview:headerLabel];
        section.headerView = containerView;
    }

    if (section.footerTitle != nil)
    {
        float width = 300;
        float height = 60;
        float leftPad = 10;
        if ([SCUtilities is_iPad])
        {
            width = 550;
            height = 40;
            leftPad = 70;
        }

        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(leftPad, 0, width, 90)];
        UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPad, 20, width, height)];
        footerLabel.backgroundColor = [UIColor clearColor];
        footerLabel.text = section.footerTitle;
        footerLabel.textColor = [UIColor whiteColor];
        [footerLabel setNumberOfLines:5];

            [footerLabel setTextAlignment:NSTextAlignmentCenter];
            [footerLabel setLineBreakMode:NSLineBreakByWordWrapping];

        footerLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [containerView addSubview:footerLabel];
        section.footerView = containerView;
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailViewWillDismissForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedInstrument && tableModel.tag == 4)
    {
        selectedInstrument = nil;
    }

    if (selectedVariableName && tableModel.tag == 4)
    {
        selectedVariableName = nil;
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    if (detailTableViewModel.tag == 5 && detailTableViewModel.sectionCount)
    {
        SCTableViewSection *section = (SCTableViewSection *)[detailTableViewModel sectionAtIndex:0];

        if ([section isKindOfClass:[SCObjectSection class]])
        {
            SCObjectSection *objectSection = (SCObjectSection *)section;

            NSManagedObject *sectionManagedObject = (NSManagedObject *)objectSection.boundObject;

            if (sectionManagedObject && [sectionManagedObject respondsToSelector:@selector(entity)] && [sectionManagedObject.entity.name isEqualToString:@"AdditionalVariableEntity"] && objectSection.cellCount > 1)
            {
                SCTableViewCell *cellAtZero = (SCTableViewCell *)[objectSection cellAtIndex:1];
                if ([cellAtZero isKindOfClass:[SCObjectSelectionCell class]])
                {
                    SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cellAtZero;

                    NSObject *additionalVariableNameObject = [sectionManagedObject valueForKeyPath:@"variableName"];

                    if ( indexPath.row != NSNotFound && ( selectedVariableName || (additionalVariableNameObject && [additionalVariableNameObject isKindOfClass:[AdditionalVariableNameEntity class]]) ) )
                    {
                        if (!selectedVariableName)
                        {
                            selectedVariableName = (AdditionalVariableNameEntity *)additionalVariableNameObject;
                        }

                        if (selectedVariableName.variableName.length)
                        {
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                      @"variableName.variableName like %@",[NSString stringWithString:(NSString *)selectedVariableName.variableName]];

                            SCDataFetchOptions *dataFetchOptions = [SCDataFetchOptions optionsWithSortKey:@"variableValue" sortAscending:YES filterPredicate:predicate];

                            objectSelectionCell.selectionItemsFetchOptions = dataFetchOptions;

                            [objectSelectionCell reloadBoundValue];
                        }
                    }
                    else
                    {
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                  @"variableName.variableName = nil"];

                        SCDataFetchOptions *dataFetchOptions = [SCDataFetchOptions optionsWithSortKey:@"variableValue" sortAscending:YES filterPredicate:predicate];

                        objectSelectionCell.selectionItemsFetchOptions = dataFetchOptions;
                        [objectSelectionCell reloadBoundValue];
                    }
                }
            }
        }
    }

    if ( detailTableViewModel.sectionCount)
    {
        SCTableViewSection *section = (SCTableViewSection *)[detailTableViewModel sectionAtIndex:0];

        if ([section isKindOfClass:[SCArrayOfObjectsSection class]])
        {
            SCArrayOfObjectsSection *arrayOfObjectsSection = (SCArrayOfObjectsSection *)section;
            NSManagedObject *sectionManagedObject = (NSManagedObject *)arrayOfObjectsSection.boundObject;

            if (sectionManagedObject && [sectionManagedObject respondsToSelector:@selector(entity)] && [sectionManagedObject.entity.name isEqualToString:@"InstrumentScoreEntity"] )
            {
                if (selectedInstrument && arrayOfObjectsSection.cellCount)
                {
                    NSObject *instrumentObject = [sectionManagedObject valueForKeyPath:@"clientInstrumentScore.instrument"];
                    if (!instrumentObject && !selectedInstrument)
                    {
                        [arrayOfObjectsSection removeAllCells];
                        SCTableViewCell *placeholderCell = [SCTableViewCell cellWithText:@"Select an instrument with score names first"];
                        [arrayOfObjectsSection addCell:placeholderCell];
                        [arrayOfObjectsSection setAllowRowSelection:NO];
                        [placeholderCell setSelectable:NO];
                    }
                }
            }
        }
        else if ([section isKindOfClass:[SCObjectSection class]])
        {
            SCObjectSection *objectSection = (SCObjectSection *)section;

            NSManagedObject *sectionManagedObject = (NSManagedObject *)objectSection.boundObject;

            if (sectionManagedObject && [sectionManagedObject respondsToSelector:@selector(entity)] && [sectionManagedObject.entity.name isEqualToString:@"InstrumentScoreEntity"] && objectSection.cellCount)
            {
                SCTableViewCell *cellAtOne = (SCTableViewCell *)[objectSection cellAtIndex:0];
                if ([cellAtOne isKindOfClass:[SCObjectSelectionCell class]])
                {
                    SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cellAtOne;

                    NSObject *instrumentObject = [sectionManagedObject valueForKeyPath:@"clientInstrumentScore.instrument"];

                    if ( selectedInstrument || (instrumentObject && [instrumentObject isKindOfClass:[InstrumentEntity class]]) )
                    {
                        if (!selectedInstrument)
                        {
                            selectedInstrument = (InstrumentEntity *)instrumentObject;
                        }

                        if (selectedInstrument.instrumentName.length)
                        {
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                      @"instrument.instrumentName like %@",[NSString stringWithString:(NSString *)selectedInstrument.instrumentName]];

                            SCDataFetchOptions *dataFetchOptions = [SCDataFetchOptions optionsWithSortKey:@"abbreviatedName" sortAscending:YES filterPredicate:predicate];

                            objectSelectionCell.selectionItemsFetchOptions = dataFetchOptions;

                            [objectSelectionCell reloadBoundValue];
                        }
                    }
                    else
                    {
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                  @"instrument.instrumentName = nil"];

                        SCDataFetchOptions *dataFetchOptions = [SCDataFetchOptions optionsWithSortKey:@"abbreviatedName" sortAscending:YES filterPredicate:predicate];

                        objectSelectionCell.selectionItemsFetchOptions = dataFetchOptions;
                        [objectSelectionCell reloadBoundValue];
                    }
                }
            }
        }
    }

    if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
    {
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        UIColor *backgroundColor = nil;
        if (indexPath.row == NSNotFound || tableModel.tag > 0)
        {
            backgroundColor = (UIColor *)(UIView *)(UIWindow *)appDelegate.window.backgroundColor;
        }
        else
        {
            backgroundColor = [UIColor clearColor];
        }

        if (detailTableViewModel.modeledTableView.backgroundColor != backgroundColor)
        {
            [detailTableViewModel.modeledTableView setBackgroundView:nil];
            UIView *view = [[UIView alloc]init];
            [detailTableViewModel.modeledTableView setBackgroundView:view];
            [detailTableViewModel.modeledTableView setBackgroundColor:backgroundColor];
        }
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTableViewCell *cell = (SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];

    NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;
    if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"ClientInstrumentScoresEntity"] && [cell isKindOfClass:[SCObjectSelectionCell class]] && cell.tag == 0)
    {
        SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cell;

        if ([objectSelectionCell.selectedItemIndex intValue] > -1)
        {
            selectedInstrument = [objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];

            UINavigationItem *navigationItem = (UINavigationItem *)tableViewModel.viewController.navigationItem;

            navigationItem.title = selectedInstrument.instrumentName;

            if ([cellManagedObject isKindOfClass:[ClientInstrumentScoresEntity class]])
            {
                BOOL shouldRemoveCells = NO;
                if (tableViewModel.sectionCount > 1)
                {
                    SCTableViewSection *sectionAtOne = [tableViewModel sectionAtIndex:1];

                    if ([sectionAtOne isKindOfClass:[SCArrayOfObjectsSection class]])
                    {
                        SCArrayOfObjectsSection *arrayOfObjectsSection = (SCArrayOfObjectsSection *)sectionAtOne;

                        for (int i = 0; i < arrayOfObjectsSection.cellCount; i++)
                        {
                            SCTableViewCell *cellAtIndex = (SCTableViewCell *)[arrayOfObjectsSection cellAtIndex:i];

                            NSManagedObject *cellAtIndexManagedObject = (NSManagedObject *)cellAtIndex.boundObject;

                            if (cellAtIndexManagedObject && [cellAtIndexManagedObject respondsToSelector:@selector(entity)] && [cellAtIndexManagedObject.entity.name isEqualToString:@"InstrumentScoreEntity"])
                            {
                                NSString *instrumentScoreNameInstrument = [cellAtIndexManagedObject valueForKeyPath:@"scoreName.instrument.instrumentName"];

                                if (![selectedInstrument.instrumentName isEqualToString:instrumentScoreNameInstrument])
                                {
                                    shouldRemoveCells = YES;
                                    break;
                                }
                            }
                        }
                    }
                }

                if (shouldRemoveCells)
                {
                    NSMutableSet *mutableSet = (NSMutableSet *)[cellManagedObject mutableSetValueForKey:@"scores"];
                    [mutableSet removeAllObjects];
                    [objectSelectionCell commitChanges];

                    [tableViewModel reloadBoundValues];
                    [tableViewModel.modeledTableView reloadData];
                }
            }
        }
    }
    else if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"AdditionalVariableEntity"])
    {
        if (cell.tag == 0 && [cell isKindOfClass:[SCObjectSelectionCell class]] )
        {
            SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cell;

            if ([objectSelectionCell.selectedItemIndex intValue] > -1)
            {
                NSManagedObject *selectedVariableNameManagedObject = [objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];
                if ([selectedVariableNameManagedObject isKindOfClass:[AdditionalVariableNameEntity class]])
                {
                    selectedVariableName = (AdditionalVariableNameEntity *)selectedVariableNameManagedObject;

                    SCTableViewCell *variableValueCell = (SCTableViewCell *)[tableViewModel cellAfterCell:objectSelectionCell rewind:NO];

                    if ([variableValueCell isKindOfClass:[SCObjectSelectionCell class]])
                    {
                        SCObjectSelectionCell *variableValueObjectSelectionCell = (SCObjectSelectionCell *)variableValueCell;

                        if (selectedVariableName.variableName.length)
                        {
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                                      @"variableName.variableName like %@",[NSString stringWithString:(NSString *)selectedVariableName.variableName]];

                            SCDataFetchOptions *dataFetchOptions = [SCDataFetchOptions optionsWithSortKey:@"variableValue" sortAscending:YES filterPredicate:predicate];

                            variableValueObjectSelectionCell.selectionItemsFetchOptions = dataFetchOptions;

                            [variableValueObjectSelectionCell reloadBoundValue];
                        }
                    }
                }
            }
        }
        else if (cell.tag == 3)
        {
            UIView *viewOne = [cell viewWithTag:14];

            if ([viewOne isKindOfClass:[UISlider class]])
            {
                UISlider *sliderOne = (UISlider *)viewOne;
                UILabel *sOnelabel = (UILabel *)[cell viewWithTag:10];

                sOnelabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
            }
        }
        else if (cell.tag == 4)
        {
            UIView *viewTwo = [cell viewWithTag:14];
            if ([viewTwo isKindOfClass:[UISlider class]])
            {
                UISlider *sliderTwo = (UISlider *)viewTwo;
                UILabel *sTwolabel = (UILabel *)[cell viewWithTag:10];

                sTwolabel.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
            }
        }
    }
    else if (tableViewModel.tag == 3)
    {
        SCTableViewSection *sectionZero = (SCTableViewSection *)[tableViewModel sectionAtIndex:0];

        [self addWechlerAgeCellToSection:(SCTableViewSection *)sectionZero];

        if (indexPath.section == 0 && cell.tag == 0 && tableViewModel.sectionCount > 1)
        {
            SCTableViewSection *sectionAtTwo = (SCTableViewSection *)[tableViewModel sectionAtIndex:2];
            if (sectionAtTwo.cellCount > 10)
            {
                SCTableViewCell *cellZeroSectionZero = (SCTableViewCell *)[sectionZero cellAtIndex:0];

                if ([cellZeroSectionZero isKindOfClass:[ClientsSelectionCell class]])
                {
                    ClientsSelectionCell *clientsSelectionCell = (ClientsSelectionCell *)cellZeroSectionZero;

                    ClientEntity *clientSelected = (ClientEntity *)clientsSelectionCell.clientObject;

                    SCTableViewCell *cellAtTen = (SCTableViewCell *)[sectionAtTwo cellAtIndex:10];

                    if ([cellAtTen isKindOfClass:[SuicidaltiyCell class]])
                    {
                        SuicidaltiyCell *suicideCell = (SuicidaltiyCell *)cellAtTen;

                        [suicideCell setHasHistory:clientSelected];
                    }

                    SCTableViewCell *cellAtEleven = (SCTableViewCell *)[sectionAtTwo cellAtIndex:11];

                    if ([cellAtEleven isKindOfClass:[SuicidaltiyCell class]])
                    {
                        SuicidaltiyCell *homicideCell = (SuicidaltiyCell *)cellAtEleven;

                        [homicideCell setHasHistory:clientSelected];
                    }
                }
            }
        }
    }
}


- (void) addWechlerAgeCellToSection:(SCTableViewSection *)section
{
    if (section.cellCount > 2)
    {
        SCLabelCell *actualAgeCell = (SCLabelCell *)[section cellAtIndex:1];
        SCLabelCell *wechslerAgeCell = (SCLabelCell *)[section cellAtIndex:2];
        ClientsViewController_Shared *clientsViewController_Shared = [[ClientsViewController_Shared alloc]init];

        SCTableViewCell *clientCell = (SCTableViewCell *)[section cellAtIndex:0];

        NSDate *clientDateOfBirth = nil;
        if ([clientCell isKindOfClass:[ClientsSelectionCell class]])
        {
            ClientsSelectionCell *clientObjectsSelectionCell = (ClientsSelectionCell *)clientCell;
            if (clientObjectsSelectionCell.clientObject)
            {
                NSManagedObject *clientObject = (NSManagedObject *)clientObjectsSelectionCell.clientObject;
                clientDateOfBirth = (NSDate *)[clientObject valueForKey:@"dateOfBirth"];
            }
            else
            {
                NSString *noClientString = @"choose client";
                wechslerAgeCell.label.text = noClientString;
                actualAgeCell.label.text = noClientString;
                return;
            }
        }

//
//

        if (serviceDatePickerDate && clientDateOfBirth)
        {
            wechslerAgeCell.label.text = [NSString stringWithString:(NSString *)[clientsViewController_Shared calculateWechslerAgeWithBirthdate:(NSDate *)clientDateOfBirth toDate:(NSDate *)serviceDatePickerDate]];
            actualAgeCell.label.text = (NSString *)[clientsViewController_Shared calculateActualAgeWithBirthdate:(NSDate *)clientDateOfBirth toDate:(NSDate *)serviceDatePickerDate];
        }
        else
        {
            if (!serviceDatePickerDate)
            {
                wechslerAgeCell.label.text = @"no test date";
                actualAgeCell.label.text = @"no test date";
            }
            else if (!clientDateOfBirth)
            {
                if (wechslerAgeCell && [wechslerAgeCell respondsToSelector:@selector(label) ])
                {
                    wechslerAgeCell.label.text = @"no birthdate";
                    actualAgeCell.label.text = @"no birthdate";
                }
            }
            else
            {
                wechslerAgeCell.label.text = @"0y 0m";
                actualAgeCell.label.text = @"0y 0m";
            }
        }
    }
}


- (BOOL) tableViewModel:(SCTableViewModel *)tableViewModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableViewModel.tag == 3)
    {
        SCTableViewCell *cell = (SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];

        if ([cell isKindOfClass:[ClientsSelectionCell class]])
        {
            ClientsSelectionCell *clientSelectionCell = (ClientsSelectionCell *)cell;

            if (clientSelectionCell.clientObject)
            {
                return YES;
            }
        }
    }

    SCTableViewSection *section = (SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
    if ([section isKindOfClass:[SCObjectSection class]])
    {
        SCObjectSection *objectSection = (SCObjectSection *)section;

        NSManagedObject *sectionManagedObject = (NSManagedObject *)objectSection.boundObject;

        if (sectionManagedObject && [sectionManagedObject respondsToSelector:@selector(entity)] && [sectionManagedObject.entity.name isEqualToString:@"InstrumentScoreEntity"])
        {
            SCTableViewCell *cellAtOne = (SCTableViewCell *)[objectSection cellAtIndex:0];
            if ([cellAtOne isKindOfClass:[SCObjectSelectionCell class]])
            {
                SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cellAtOne;

                if (objectSelectionCell.label.text.length)
                {
                    return YES;
                }
            }
        }
    }

    return NO;
}


@end
