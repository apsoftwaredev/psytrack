//
//  OtherActivityVC.m
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 9/1/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "OtherActivityVC.h"
#import "PTTAppDelegate.h"
#import "LogEntity.h"



@interface OtherActivityVC ()

@end

@implementation OtherActivityVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    SCEntityDefinition *otherActivityDef=[SCEntityDefinition definitionWithEntityName:@"OtherActivityEntity" managedObjectContext:managedObjectContext propertyNamesString:@"activity;dates;logs;notes"];
    
    otherActivityDef.orderAttributeName=@"order";
    
    SCEntityDefinition *logDef=[SCEntityDefinition definitionWithEntityName:@"LogEntity" managedObjectContext:managedObjectContext propertyNamesString:@"dateTime;notes"];
    
    
    
    
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
    
    
    [otherActivityDef addPropertyDefinition:hoursDataProperty];
    

    
    SCPropertyDefinition *otherActivityPropertyDef=[otherActivityDef propertyDefinitionWithName:@"activity"];
    
    otherActivityPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *otherActivityNotesPropertyDef=[otherActivityDef propertyDefinitionWithName:@"notes"];
    
    otherActivityNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *logsPropertyDef=[otherActivityDef propertyDefinitionWithName:@"logs"];
    
    logsPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    logsPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:logDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add Logs"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];
    
    
    
    //do some customizing of the log notes, change it to "Number" to make it shorter
    SCPropertyDefinition *logNotesPropertyDef = [logDef propertyDefinitionWithName:@"notes"];
    
    logNotesPropertyDef.title = @"Notes";
    logNotesPropertyDef.type=SCPropertyTypeTextView;
    
//    logNotesPropertyDef.type=SCPropertyTypeCustom;
//    logNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
//    
//    NSDictionary *encryLogNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyString",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
//    
//    
//    logNotesPropertyDef.objectBindings=encryLogNotesTVCellKeyBindingsDic;
//    //    phoneNumberPropertyDef.title=@"Phone Number";
//    logNotesPropertyDef.autoValidate=NO;

    
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
    
    objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:otherActivityDef];
    
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Other Activities";
    
    
    
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

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
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
    if (tableModel.tag==0) {
        appDelegate.okayToSaveContext=YES;
    }
    else if (tableModel.tag>1){
        
        appDelegate.okayToSaveContext=NO;
        
    }
    
    
}
-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillDismissForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableModel.tag==0) {
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        appDelegate.okayToSaveContext=YES;
    }
    
    
}

-(void)tableViewModel:(SCTableViewModel *)tableModel willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableModel.tag==0){
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"OtherActivityEntity"])
        {
            
            NSString *activityStr=[cellManagedObject valueForKey:@"activity"];
            NSString *notesStr=[cellManagedObject valueForKey:@"notes"];
            NSString *dates=[cellManagedObject valueForKey:@"dates"];
            NSString *cellText=nil;
            
            if (activityStr&&activityStr.length) {
                cellText=activityStr;
            }
            
            if (notesStr &&notesStr.length) {
                
                
                if (cellText&&cellText.length) {
                    cellText=[cellText stringByAppendingFormat:@": %@",notesStr];
                }
                else
                {
                    
                    cellText=notesStr;
                }
                
                
            }
            
            if (dates && dates.length) {
                
                
                cellText=cellText?[cellText stringByAppendingFormat:@"; %@",dates]:dates;
                
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
               
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                
                //set the date format
                [dateFormatter setDateFormat:@"M/d/yyyy"];
                [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
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
