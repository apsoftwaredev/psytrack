//
//  TeachingExperienceVC.m
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 8/12/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "TeachingExperienceVC.h"
#import "PTTAppDelegate.h"
#import "EncryptedSCTextViewCell.h"
#import "LogEntity.h"

@interface TeachingExperienceVC ()

@end

@implementation TeachingExperienceVC

- (void) viewDidLoad
{
    [super viewDidLoad];

    dateFormatter = [[NSDateFormatter alloc] init];

    //set the date format
    [dateFormatter setDateFormat:@"M/d/yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];

    NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

    SCEntityDefinition *teachingExperienceDef = [SCEntityDefinition definitionWithEntityName:@"TeachingExperienceEntity" managedObjectContext:managedObjectContext propertyNamesString:@"teachingRole;classTitle;credits;startDate;endDate;subject;school;publications;topics;logs;notes"];

    teachingExperienceDef.titlePropertyName = @"teachingRole;classTitle";

    teachingExperienceDef.titlePropertyNameDelimiter = @" - ";
    SCEntityDefinition *logDef = [SCEntityDefinition definitionWithEntityName:@"LogEntity" managedObjectContext:managedObjectContext propertyNamesString:@"dateTime;notes"];

    SCEntityDefinition *schoolDef = [SCEntityDefinition definitionWithEntityName:@"SchoolEntity" managedObjectContext:managedObjectContext propertyNamesString:@"schoolName;notes"];

    SCEntityDefinition *topicDef = [SCEntityDefinition definitionWithEntityName:@"TopicEntity" managedObjectContext:managedObjectContext propertyNamesString:@"topic;notes"];

    topicDef.keyPropertyName = @"topic";

    SCPropertyDefinition *topicPropertyDef = [topicDef propertyDefinitionWithName:@"topic"];
    topicPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *topicNotesPropertyDef = [topicDef propertyDefinitionWithName:@"notes"];
    topicNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *topicsPropertyDef = [teachingExperienceDef propertyDefinitionWithName:@"topics"];

    topicsPropertyDef.type = SCPropertyTypeObjectSelection;

    SCObjectSelectionAttributes *topicSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:topicDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:YES];

    topicSelectionAttribs.allowAddingItems = YES;
    topicSelectionAttribs.allowDeletingItems = YES;
    topicSelectionAttribs.allowMovingItems = YES;
    topicSelectionAttribs.allowEditingItems = YES;
    topicSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to add topics)"];
    topicSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Tap Here to add topic"];

    topicsPropertyDef.attributes = topicSelectionAttribs;

    SCPropertyDefinition *startDatePropertyDef = [teachingExperienceDef propertyDefinitionWithName:@"startDate"];
    startDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                     datePickerMode:UIDatePickerModeDate
                                                      displayDatePickerInDetailView:NO];

    SCPropertyDefinition *endDatePropertyDef = [teachingExperienceDef propertyDefinitionWithName:@"endDate"];
    endDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                   datePickerMode:UIDatePickerModeDate
                                                    displayDatePickerInDetailView:NO];

    SCPropertyDefinition *teachingExperienceTitlePropertyDef = [teachingExperienceDef propertyDefinitionWithName:@"classTitle"];
    teachingExperienceTitlePropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *teachingExperienceNotesPropertyDef = [teachingExperienceDef propertyDefinitionWithName:@"notes"];
    teachingExperienceNotesPropertyDef.type = SCPropertyTypeTextView;

    SCPropertyDefinition *schoolNotesPropertyDef = [schoolDef propertyDefinitionWithName:@"notes"];
    schoolNotesPropertyDef.type = SCPropertyTypeTextView;

    //create the dictionary with the data bindings
    NSDictionary *hoursDataBindings = [NSDictionary
                                       dictionaryWithObjects:[NSArray arrayWithObjects:@"hours",nil]
                                                     forKeys:[NSArray arrayWithObjects:@"1",nil ]];

    //create the custom property definition
    SCCustomPropertyDefinition *hoursDataProperty = [SCCustomPropertyDefinition definitionWithName:@"hoursData"
                                                                                  uiElementNibName:@"TotalHoursAndMinutesCell" objectBindings:hoursDataBindings];

    hoursDataProperty.title = nil;
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    hoursDataProperty.autoValidate = FALSE;

    [teachingExperienceDef insertPropertyDefinition:hoursDataProperty atIndex:1];

    SCPropertyDefinition *logsPropertyDef = [teachingExperienceDef propertyDefinitionWithName:@"logs"];

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

    SCPropertyDefinition *schoolPropertyDef = [teachingExperienceDef propertyDefinitionWithName:@"school"];
    schoolPropertyDef.type = SCPropertyTypeObjectSelection;

    SCObjectSelectionAttributes *schoolSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:schoolDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    schoolSelectionAttribs.allowAddingItems = YES;
    schoolSelectionAttribs.allowDeletingItems = YES;
    schoolSelectionAttribs.allowEditingItems = YES;
    schoolSelectionAttribs.allowMovingItems = YES;
    schoolSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new school"];
    schoolSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"Tap Edit to add school"];
    schoolPropertyDef.attributes = schoolSelectionAttribs;

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

    SCPropertyDefinition *publicationsPropertyDef = [teachingExperienceDef propertyDefinitionWithName:@"publications"];
    publicationsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:publicationDef
                                                                                   allowAddingItems:TRUE
                                                                                 allowDeletingItems:TRUE
                                                                                   allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];

    if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
    {
        self.tableView.backgroundView = nil;
        UIView *newView = [[UIView alloc]init];
        [self.tableView setBackgroundView:newView];
    }

    self.tableView.backgroundColor = [UIColor clearColor];

    [self setNavigationBarType:SCNavigationBarTypeAddEditRight];

    objectsModel = [[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:teachingExperienceDef];

    objectsModel.editButtonItem = self.editButton;

    objectsModel.addButtonItem = self.addButton;

    UIViewController *navtitle = self.navigationController.topViewController;

    navtitle.title = @"Teaching Experience";

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


- (BOOL) disablesAutomaticKeyboardDismissal
{
    return NO;
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
    {
        //        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;

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


- (void) tableViewModel:(SCTableViewModel *)tableModel willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableModel.tag == 2 && tableModel.sectionCount)
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
    }
}


@end
