//
//  CommunityServiceVC.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/1/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "CommunityServiceVC.h"
#import "PTTAppDelegate.h"
#import "EncryptedSCTextViewCell.h"
#import "LogEntity.h"

@interface CommunityServiceVC ()

@end

@implementation CommunityServiceVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    dateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateFormatter setDateFormat:@"M/d/yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    
    
    
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    SCEntityDefinition *communityServiceDef=[SCEntityDefinition definitionWithEntityName:@"CommunityServiceEntity" managedObjectContext:managedObjectContext propertyNamesString:@"projectName;dateStarted;dateEnded;logs;notes"];
    
    communityServiceDef.orderAttributeName=@"order";
    
    SCEntityDefinition *organizationDef=[SCEntityDefinition definitionWithEntityName:@"OrganizationEntity" managedObjectContext:managedObjectContext propertyNamesString:@"name;notes;size"];
    
    SCEntityDefinition *logDef=[SCEntityDefinition definitionWithEntityName:@"LogEntity" managedObjectContext:managedObjectContext propertyNamesString:@"dateTime;notes"];
    
    
    
    SCPropertyDefinition *dateStartedPropertyDef=[communityServiceDef propertyDefinitionWithName:@"dateStarted"];
    dateStartedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                        datePickerMode:UIDatePickerModeDate
                                                         displayDatePickerInDetailView:NO];
    
    SCPropertyDefinition *dateEndedPropertyDef=[communityServiceDef propertyDefinitionWithName:@"dateEnded"];
    dateEndedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                       datePickerMode:UIDatePickerModeDate
                                                        displayDatePickerInDetailView:NO];
    
    SCPropertyDefinition *communityServiceNotesPropertyDef=[communityServiceDef propertyDefinitionWithName:@"notes"];
    
    communityServiceNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *projectNamePropertyDef=[communityServiceDef propertyDefinitionWithName:@"projectName"];
    
    projectNamePropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *logsPropertyDef=[communityServiceDef propertyDefinitionWithName:@"logs"];
    
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
    
    
   
    
    
    organizationDef.keyPropertyName=@"name";
    organizationDef.titlePropertyName=@"name";
    
    
    
    SCPropertyDefinition *organizationPropertyDef=[communityServiceDef propertyDefinitionWithName:@"organization"];
    organizationPropertyDef.type=SCPropertyTypeObjectSelection;
    organizationPropertyDef.autoValidate=NO;
    SCSelectionAttributes *organizationSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:organizationDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    
    organizationSelectionAttribs.allowAddingItems=YES;
    organizationSelectionAttribs.allowDeletingItems=YES;
    organizationSelectionAttribs.allowEditingItems=YES;
    organizationSelectionAttribs.allowMovingItems=NO;
    organizationSelectionAttribs.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add new organization"];
    organizationSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap edit to add organizations"];
    organizationPropertyDef.attributes=organizationSelectionAttribs;
    
    SCPropertyDefinition *organizationNamePropertyDef=[organizationDef propertyDefinitionWithName:@"name"];
    organizationNamePropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *organizationNotesPropertyDef=[organizationDef propertyDefinitionWithName:@"notes"];
    organizationNotesPropertyDef.type=SCPropertyTypeTextView;
    

    
    
    //create the dictionary with the data bindings
    NSDictionary *hoursDataBindings = [NSDictionary
                                       dictionaryWithObjects:[NSArray arrayWithObjects:@"hours",nil]
                                       forKeys:[NSArray arrayWithObjects:@"1",nil ]];
    
    
    
    
    //create the custom property definition
    SCCustomPropertyDefinition *hoursDataProperty = [SCCustomPropertyDefinition definitionWithName:@"LengthData"
                                                                                  uiElementNibName:@"TotalHoursAndMinutesCell" objectBindings:hoursDataBindings];
    
    hoursDataProperty.title=nil;
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    hoursDataProperty.autoValidate=FALSE;
    
    
    [communityServiceDef addPropertyDefinition:hoursDataProperty];
    
    SCPropertyDefinition *dateInterviewedPropertyDef=[communityServiceDef propertyDefinitionWithName:@"dateInterviewed"];
    dateInterviewedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                           datePickerMode:UIDatePickerModeDate
                                                            displayDatePickerInDetailView:NO];
    

    
    if([SCUtilities is_iPad]){
        
        self.tableView.backgroundView=nil;
        UIView *newView=[[UIView alloc]init];
        [self.tableView setBackgroundView:newView];
        
        
    }
    self.tableView.backgroundColor=[UIColor clearColor];
    
    
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    
    objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:communityServiceDef];
    
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Community Service";
    
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    

    
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
    
    
    
    if ([SCUtilities is_iPad]) {
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
    
    if (tableModel.tag==0){
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"CommunityServiceEntity"])
        {
            
            NSString *projecteNameStr=[cellManagedObject valueForKey:@"projectName"];
            NSString *notesStr=[cellManagedObject valueForKey:@"notes"];
            NSDate *dateStarted=[cellManagedObject valueForKey:@"dateStarted"];
            NSString *cellText=nil;
            
            if (dateStarted) {
                cellText=[dateFormatter stringFromDate:dateStarted];
            }
            
            if (projecteNameStr &&projecteNameStr.length) {
                
                
                if (cellText&&cellText.length) {
                    cellText=[cellText stringByAppendingFormat:@": %@",projecteNameStr];
                }
                else
                {
                
                    cellText=projecteNameStr;
                }
                
                
            }
            
            if (notesStr &&notesStr.length) {
                
                
                cellText=cellText?[cellText stringByAppendingFormat:@"; %@",notesStr]:notesStr;
                
            }
            
            cell.textLabel.text=cellText;
            
            
            
            
            
        }
    }
    else if (tableModel.tag==2&&tableModel.sectionCount) {
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"LogEntity"])
        {
            
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
