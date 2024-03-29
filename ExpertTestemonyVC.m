//
//  ExpertTestemonyVC.m
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 9/1/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ExpertTestemonyVC.h"
#import "PTTAppDelegate.h"
#import "ClientsSelectionCell.h"
#import "EncryptedSCTextViewCell.h"
#import "LogEntity.h"

@interface ExpertTestemonyVC ()

@end

@implementation ExpertTestemonyVC

- (void) viewDidLoad
{
    [super viewDidLoad];
    dateFormatter = [[NSDateFormatter alloc] init];

    //set the date format
    [dateFormatter setDateFormat:@"M/d/yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];

    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];

    SCEntityDefinition *expertTestemonyDef = [SCEntityDefinition definitionWithEntityName:@"ExpertTestemonyEntity" managedObjectContext:managedObjectContext propertyNamesString:@"caseName;attorneys;hours;judge;plantifDefendant;courtAppearances;logs; organization;publications;notes"];

    expertTestemonyDef.orderAttributeName = @"order";
    SCEntityDefinition *logDef = [SCEntityDefinition definitionWithEntityName:@"LogEntity" managedObjectContext:managedObjectContext propertyNamesString:@"dateTime;notes"];

    SCEntityDefinition *organizationDef = [SCEntityDefinition definitionWithEntityName:@"OrganizationEntity" managedObjectContext:managedObjectContext propertyNamesString:@"name;notes;size"];

    organizationDef.keyPropertyName = @"name";
    organizationDef.titlePropertyName = @"name";

    SCEntityDefinition *courtApperancesDef = [SCEntityDefinition definitionWithEntityName:@"ExpertTestemonyAppearanceEntity" managedObjectContext:managedObjectContext propertyNamesString:@"dateAppeared;notes"];

    SCPropertyDefinition *organizationPropertyDef = [expertTestemonyDef propertyDefinitionWithName:@"organization"];
    organizationPropertyDef.type = SCPropertyTypeObjectSelection;
    organizationPropertyDef.autoValidate = NO;
    SCSelectionAttributes *organizationSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:organizationDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];

    organizationSelectionAttribs.allowAddingItems = YES;
    organizationSelectionAttribs.allowDeletingItems = YES;
    organizationSelectionAttribs.allowEditingItems = YES;
    organizationSelectionAttribs.allowMovingItems = NO;
    organizationSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new organization"];
    organizationSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap edit to add organizations"];
    organizationPropertyDef.attributes = organizationSelectionAttribs;

    SCPropertyDefinition *organizationNamePropertyDef = [organizationDef propertyDefinitionWithName:@"name"];
    organizationNamePropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *organizationNotesPropertyDef = [organizationDef propertyDefinitionWithName:@"notes"];
    organizationNotesPropertyDef.type = SCPropertyTypeTextView;

    //Create a class definition for Publication entity
    SCEntityDefinition *publicationDef = [SCEntityDefinition definitionWithEntityName:@"PublicationEntity"
                                                                 managedObjectContext:managedObjectContext
                                                                        propertyNames:[NSArray arrayWithObjects:@"publicationTitle",@"authors",@"datePublished", @"publisher",@"volume", @"pageNumbers",@"publicationType",@"notes",
                                                                                       nil]];

    SCPropertyDefinition *publicationTitlePropertyDef = [publicationDef propertyDefinitionWithName:@"publicationTitle"];
    publicationTitlePropertyDef.title = @"Title";

    //set the order attributes name defined in the Publication Entity
    publicationDef.orderAttributeName = @"order";
    publicationDef.titlePropertyName = @"publicationTitle;datePublished";
    SCEntityDefinition *publicationTypeDef = [SCEntityDefinition definitionWithEntityName:@"PublicationTypeEntity"
                                                                     managedObjectContext:managedObjectContext
                                                                            propertyNames:[NSArray arrayWithObjects:@"publicationType",
                                                                                           nil]];

    //set the order attributes name defined in the Publication Type Entity
    publicationTypeDef.orderAttributeName = @"order";
    SCPropertyDefinition *publicationTypePropertyDef = [publicationDef propertyDefinitionWithName:@"publicationType"];

    publicationTypePropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *publicationSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:publicationTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    publicationSelectionAttribs.allowAddingItems = YES;
    publicationSelectionAttribs.allowDeletingItems = YES;
    publicationSelectionAttribs.allowMovingItems = YES;
    publicationSelectionAttribs.allowEditingItems = YES;
    publicationSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Define publication types)"];
    publicationSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new publication type"];
    publicationTypePropertyDef.attributes = publicationSelectionAttribs;

    SCPropertyDefinition *datePublishedPropertyDef = [publicationDef propertyDefinitionWithName:@"datePublished"];
    datePublishedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                         datePickerMode:UIDatePickerModeDate
                                                          displayDatePickerInDetailView:NO];

    publicationTitlePropertyDef.type = SCPropertyTypeTextView;
    SCPropertyDefinition *publicationAuthorsPropertyDef = [publicationDef propertyDefinitionWithName:@"authors"];

    publicationAuthorsPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *publicationPublisherPropertyDef = [publicationDef propertyDefinitionWithName:@"publisher"];

    publicationPublisherPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *publicationNotesPropertyDef = [publicationDef propertyDefinitionWithName:@"notes"];

    publicationNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *publicationsPropertyDef = [expertTestemonyDef propertyDefinitionWithName:@"publications"];
    publicationsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:publicationDef
                                                                                   allowAddingItems:TRUE
                                                                                 allowDeletingItems:TRUE
                                                                                   allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];

    //Create the property definition for the referralInOrOut property in the referralDef class
    SCPropertyDefinition *plaintifDefendantropertyDef = [expertTestemonyDef propertyDefinitionWithName:@"plantifDefendant"];

    //set the property definition type to segmented
    plaintifDefendantropertyDef.type = SCPropertyTypeSegmented;

    //set the segmented attributes for the referralInOrOut property definition
    plaintifDefendantropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Plantif", @"Defendant", nil]];
    //override the auto title generation for the referralInOrOut property definition and set it to a custom title
    plaintifDefendantropertyDef.title = @"Client";

    SCPropertyDefinition *attorneysPropertyDef = [expertTestemonyDef propertyDefinitionWithName:@"attorneys"];

    attorneysPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *caseNamePropertyDef = [expertTestemonyDef propertyDefinitionWithName:@"caseName"];

    caseNamePropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *expertTestemonyNotesPropertyDef = [expertTestemonyDef propertyDefinitionWithName:@"notes"];

    expertTestemonyNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *courtAppearacnesPropertyDef = [expertTestemonyDef propertyDefinitionWithName:@"courtAppearances"];

    courtAppearacnesPropertyDef.type = SCPropertyTypeArrayOfObjects;
    courtAppearacnesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:courtApperancesDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add Court Appearance"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:NO];

    SCPropertyDefinition *dateAppearedPropertyDef = [courtApperancesDef propertyDefinitionWithName:@"dateAppeared"];
    dateAppearedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                        datePickerMode:UIDatePickerModeDate
                                                         displayDatePickerInDetailView:YES];

    SCPropertyDefinition *courtAppearanceNotesPropertyDef = [courtApperancesDef propertyDefinitionWithName:@"notes"];

    courtAppearanceNotesPropertyDef.type = SCPropertyTypeTextView;

    //create the dictionary with the data bindings
    NSDictionary *clientDataBindings = [NSDictionary
                                        dictionaryWithObjects:[NSArray arrayWithObjects:@"client",@"Client",@"client",[NSNumber numberWithBool:NO],nil]
                                                      forKeys:[NSArray arrayWithObjects:@"1",@"90",@"92",@"93",nil ]];
    //create the custom property definition
    SCCustomPropertyDefinition *clientDataProperty = [SCCustomPropertyDefinition definitionWithName:@"CLientData"
                                                                                     uiElementClass:[ClientsSelectionCell class] objectBindings:clientDataBindings];

    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    clientDataProperty.autoValidate = FALSE;

    /*
     **************************************************************************************
        END of Class Definition and attributes for the Client Entity
     **************************************************************************************
     */

    //insert the custom property definition into the clientData class at index
    [expertTestemonyDef insertPropertyDefinition:clientDataProperty atIndex:3];

    SCPropertyDefinition *logsPropertyDef = [expertTestemonyDef propertyDefinitionWithName:@"logs"];

    logsPropertyDef.type = SCPropertyTypeArrayOfObjects;

    logsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:logDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add Logs"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];

    //do some customizing of the log notes, change it to "Number" to make it shorter
    SCPropertyDefinition *logNotesPropertyDef = [logDef propertyDefinitionWithName:@"notes"];

    logNotesPropertyDef.title = @"Notes";

    logNotesPropertyDef.type = SCPropertyTypeTextView;

    NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc]init];
    [dateTimeFormatter setDateFormat:@"ccc M/d/yy h:mm a"];
    [dateTimeFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    SCPropertyDefinition *logDatePropertyDef = [logDef propertyDefinitionWithName:@"dateTime"];
    logDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateTimeFormatter
                                                                   datePickerMode:UIDatePickerModeDateAndTime
                                                    displayDatePickerInDetailView:YES];

    [expertTestemonyDef removePropertyDefinitionWithName:@"hours"];

    //create the dictionary with the data bindings
    NSDictionary *hoursDataBindings = [NSDictionary
                                       dictionaryWithObjects:[NSArray arrayWithObjects:@"hours",nil]
                                                     forKeys:[NSArray arrayWithObjects:@"1",nil ]];

    //create the custom property definition
    SCCustomPropertyDefinition *hoursDataProperty = [SCCustomPropertyDefinition definitionWithName:@"LengthData"
                                                                                  uiElementNibName:@"TotalHoursAndMinutesCell" objectBindings:hoursDataBindings];

    hoursDataProperty.title = nil;
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    hoursDataProperty.autoValidate = FALSE;

    [expertTestemonyDef addPropertyDefinition:hoursDataProperty];

    [courtApperancesDef addPropertyDefinition:hoursDataProperty];

    if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
    {
        self.tableView.backgroundView = nil;
        UIView *newView = [[UIView alloc]init];
        [self.tableView setBackgroundView:newView];
    }

    self.tableView.backgroundColor = [UIColor clearColor];

    [self setNavigationBarType:SCNavigationBarTypeAddEditRight];

    objectsModel = [[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:expertTestemonyDef];

    objectsModel.editButtonItem = self.editButton;

    objectsModel.addButtonItem = self.addButton;

    UIViewController *navtitle = self.navigationController.topViewController;

    navtitle.title = @"Expert Testemony";

    self.view.backgroundColor = [UIColor clearColor];

    objectsModel.searchPropertyName = @"dateOfService";

    objectsModel.allowMovingItems = TRUE;

    objectsModel.autoAssignDelegateForDetailModels = TRUE;
    objectsModel.autoAssignDataSourceForDetailModels = TRUE;

    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];

    self.tableViewModel = objectsModel;
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
    {
        UIColor *backgroundColor = nil;

        if (indexPath.row == NSNotFound || tableModel.tag > 0)
        {
            //            backgroundImage=[UIImage imageNamed:@"iPad-background-blue.png"];
            backgroundColor = (UIColor *)(UIWindow *)appDelegate.window.backgroundColor;
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


- (BOOL) disablesAutomaticKeyboardDismissal
{
    return NO;
}


- (void) tableViewModel:(SCTableViewModel *)tableModel willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableModel.tag == 0)
    {
        NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"ExpertTestemonyEntity"])
        {
            NSString *caseNameStr = [cellManagedObject valueForKey:@"caseName"];
            NSString *notesStr = [cellManagedObject valueForKey:@"notes"];
            NSInteger plantifDefendant = (NSInteger)[(NSNumber *)[cellManagedObject valueForKey:@"plantifDefendant"] integerValue];
            NSString *cellText = nil;

            if (caseNameStr && caseNameStr.length)
            {
                cellText = caseNameStr;
            }

            if (notesStr && notesStr.length)
            {
                cellText = cellText ? [cellText stringByAppendingFormat:@"; %@",notesStr] : notesStr;
            }

            cell.textLabel.text = cellText;

            if (plantifDefendant)
            {
                cell.textLabel.textColor = [UIColor redColor];
            }
            else
            {
                cell.textLabel.textColor = [UIColor blueColor];
            }
        }
    }
    else if (tableModel.tag == 2 && tableModel.sectionCount)
    {
        NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;

        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"LogEntity"])
        {
            LogEntity *logObject = (LogEntity *)cellManagedObject;

            if (logObject.dateTime)
            {
                NSString *displayString = [dateFormatter stringFromDate:logObject.dateTime];

                NSString *notesString = logObject.notes;
                if (notesString && notesString.length)
                {
                    displayString = [displayString stringByAppendingFormat:@": %@",notesString];
                }

                cell.textLabel.text = displayString;
            }
        }

        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)] && [cellManagedObject.entity.name isEqualToString:@"ExpertTestemonyAppearanceEntity"])
        {
            NSDate *dateAppeared = [cellManagedObject valueForKey:@"dateAppeared"];
            NSString *notesStr = [cellManagedObject valueForKey:@"notes"];

            if (dateAppeared)
            {
                NSString *displayString = [dateFormatter stringFromDate:dateAppeared];

                if (notesStr && notesStr.length)
                {
                    displayString = [displayString stringByAppendingFormat:@": %@",notesStr];
                }

                cell.textLabel.text = displayString;
            }
        }
    }
}


@end
