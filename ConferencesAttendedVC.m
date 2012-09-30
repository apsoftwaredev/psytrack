//
//  ConferencesAttendedVC.m
//  PsyTrack
//
//  Created by Daniel Boice on 8/12/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ConferencesAttendedVC.h"
#import "PTTAppDelegate.h"
#import "EncryptedSCTextViewCell.h"
#import "TotalHoursAndMinutesCell.h"
#import "LogEntity.h"
#import "ConferenceEntity.h"

@interface ConferencesAttendedVC ()

@end

@implementation ConferencesAttendedVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    
    dateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateFormatter setDateFormat:@"M/d/yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    

    
    SCEntityDefinition *conferenceDef=[SCEntityDefinition definitionWithEntityName:@"ConferenceEntity" managedObjectContext:managedObjectContext propertyNamesString:@"title;attendenceSize;startDate;endDate;notableTopics;notableSpeakers;hostingOrganizations;logs;myPresentationsnotes;notes"];
    
    SCEntityDefinition *logDef=[SCEntityDefinition definitionWithEntityName:@"LogEntity" managedObjectContext:managedObjectContext propertyNamesString:@"dateTime;notes"];
    
    SCEntityDefinition *organizationDef=[SCEntityDefinition definitionWithEntityName:@"OrganizationEntity" managedObjectContext:managedObjectContext propertyNamesString:@"name;notes;size"];
    
    
    
    SCPropertyDefinition *otherNotesPropertyDef = [conferenceDef propertyDefinitionWithName:@"notes"];
    
    otherNotesPropertyDef.type=SCPropertyTypeTextView;
    otherNotesPropertyDef.title=@"Other Notes";
    
    SCPropertyDefinition *notableTopicsPropertyDef = [conferenceDef propertyDefinitionWithName:@"notableTopics"];
    
    notableTopicsPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *notableSpeakersPropertyDef = [conferenceDef propertyDefinitionWithName:@"notableSpeakers"];
    notableSpeakersPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *startDatePropertyDef = [conferenceDef propertyDefinitionWithName:@"startDate"];
	startDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                                 datePickerMode:UIDatePickerModeDate
                                                                  displayDatePickerInDetailView:NO];
    
    SCPropertyDefinition *endDatePropertyDef = [conferenceDef propertyDefinitionWithName:@"endDate"];
	endDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                     datePickerMode:UIDatePickerModeDate
                                                      displayDatePickerInDetailView:NO];
    

    
    //create the dictionary with the data bindings
    NSDictionary *hoursDataBindings = [NSDictionary
                                       dictionaryWithObjects:[NSArray arrayWithObjects:@"hours",nil]
                                       forKeys:[NSArray arrayWithObjects:@"1",nil ]];
    
    
    
    
    //create the custom property definition
    SCCustomPropertyDefinition *hoursDataProperty = [SCCustomPropertyDefinition definitionWithName:@"hoursData"
                                                                                             uiElementNibName:@"TotalHoursAndMinutesCell" objectBindings:hoursDataBindings];
    
    hoursDataProperty.title=nil;
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    hoursDataProperty.autoValidate=FALSE;
    
    
    [conferenceDef insertPropertyDefinition:hoursDataProperty atIndex:1];
    

    
    organizationDef.keyPropertyName=@"name";
    organizationDef.titlePropertyName=@"name";
    

    
    SCPropertyDefinition *organizationPropertyDef=[conferenceDef propertyDefinitionWithName:@"hostingOrganizations"];
    organizationPropertyDef.type=SCPropertyTypeObjectSelection;
    organizationPropertyDef.autoValidate=NO;
    SCSelectionAttributes *organizationSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:organizationDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:YES];
    
    organizationSelectionAttribs.allowAddingItems=YES;
    organizationSelectionAttribs.allowDeletingItems=YES;
    organizationSelectionAttribs.allowEditingItems=YES;
    organizationSelectionAttribs.allowMovingItems=YES;
    organizationSelectionAttribs.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add new organization"];
    organizationSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap edit to add organizations"];
    organizationPropertyDef.attributes=organizationSelectionAttribs;
    
    SCPropertyDefinition *organizationNamePropertyDef=[organizationDef propertyDefinitionWithName:@"name"];
    organizationNamePropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *organizationNotesPropertyDef=[organizationDef propertyDefinitionWithName:@"notes"];
    organizationNotesPropertyDef.type=SCPropertyTypeTextView;
    

    
    SCPropertyDefinition *logsPropertyDef=[conferenceDef propertyDefinitionWithName:@"logs"];
    
    logsPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    logsPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:logDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add Logs"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];
    
    
    
    //do some customizing of the log notes, change it to "Number" to make it shorter
    SCPropertyDefinition *logNotesPropertyDef = [logDef propertyDefinitionWithName:@"notes"];
    
    logNotesPropertyDef.title = @"Notes";
    
    
    logNotesPropertyDef.type=SCPropertyTypeCustom;
    logNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryLogNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyString",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    logNotesPropertyDef.objectBindings=encryLogNotesTVCellKeyBindingsDic;
    //    phoneNumberPropertyDef.title=@"Phone Number";
    logNotesPropertyDef.autoValidate=NO;
    
    NSDateFormatter *dateTimeFormatter=[[NSDateFormatter alloc]init];
    [dateTimeFormatter setDateFormat:@"ccc M/d/yy h:mm a"];
    [dateTimeFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    SCPropertyDefinition *logDatePropertyDef=[logDef propertyDefinitionWithName:@"dateTime"];
    logDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateTimeFormatter
                                                                   datePickerMode:UIDatePickerModeDateAndTime
                                                    displayDatePickerInDetailView:YES];
    

    
    if([SCUtilities is_iPad]||[SCUtilities systemVersion]>=6){
        
        self.tableView.backgroundView=nil;
        UIView *newView=[[UIView alloc]init];
        [self.tableView setBackgroundView:newView];
        
        
    }
    self.tableView.backgroundColor=[UIColor clearColor];
    
    
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    
    objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:conferenceDef];
    
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Conferences Attended";
    
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    
    
	objectsModel.searchPropertyName = @"dateOfService";
    
    objectsModel.allowMovingItems=TRUE;
    
    objectsModel.autoAssignDelegateForDetailModels=TRUE;
    objectsModel.autoAssignDataSourceForDetailModels=TRUE;
    
    
    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    
    self.tableViewModel=objectsModel;
    
    

}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    if ([SCUtilities is_iPad]||[SCUtilities systemVersion]>=6) {
        //        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        UIColor *backgroundColor=nil;
        
        if(indexPath.row==NSNotFound|| tableModel.tag>0)
        {
            //            backgroundImage=[UIImage imageNamed:@"iPad-background-blue.png"];
            backgroundColor=(UIColor *)(UIWindow *)appDelegate.window.backgroundColor;
            
            
            
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
}

-(void)tableViewModel:(SCTableViewModel *)tableModel willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableModel.tag==0) {
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        NSString *displayText=nil;
        if ([cellManagedObject isKindOfClass:[ConferenceEntity class]]) {
            ConferenceEntity *conferenceObject=(ConferenceEntity *)cellManagedObject;
        
            if (conferenceObject.startDate){
            
                displayText=[dateFormatter stringFromDate:conferenceObject.startDate];
                
            
            
            }
            
            if (displayText && displayText.length) {
                
                displayText=[displayText stringByAppendingFormat:@": %@",conferenceObject.title];
                
            }
            
            
        }
        cell.textLabel.text=displayText;
        
    }
    
    if (tableModel.tag==2&&tableModel.sectionCount) {
        
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"LogEntity"]) {
            
            LogEntity *logObject=(LogEntity *)cellManagedObject;
            
            if (logObject.dateTime) {
                NSString *displayString=[dateFormatter stringFromDate:logObject.dateTime];
                
                NSString *notesString=logObject.notes;
                if(notesString &&notesString.length){
                    
                    
                    displayString=[displayString stringByAppendingFormat:@": %@",notesString];
                    
                }
                cell.textLabel.text=displayString;
                
            }
            
            
        }
        
        
    }
    
}


@end
