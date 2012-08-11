//
//  CoursesTakenViewController.m
//  PsyTrack
//
//  Created by Daniel Boice on 8/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "CoursesTakenViewController.h"
#import "PTTAppDelegate.h"
#import "ClinicianSelectionCell.h"
#import "EncryptedSCTextViewCell.h"
#import "LogEntity.h"

@interface CoursesTakenViewController ()

@end

@implementation CoursesTakenViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    SCEntityDefinition *degreeCourseDef=[SCEntityDefinition definitionWithEntityName:@"DegreeCourseEntity" managedObjectContext:managedObjectContext propertyNamesString:@"courseName;credits;startDate;endDate;grade;degree;logs;notes"];
    
   
    SCEntityDefinition *degreeDef=[SCEntityDefinition definitionWithEntityName:@"DegreeEntity" managedObjectContext:managedObjectContext propertyNamesString:@"degree;school;dateAwarded;notes"];
    
    
    SCEntityDefinition *degreeNameDef=[SCEntityDefinition definitionWithEntityName:@"DegreeNameEntity" managedObjectContext:managedObjectContext propertyNamesString:@"degreeName;notes"];
    
    SCEntityDefinition *schoolDef=[SCEntityDefinition definitionWithEntityName:@"SchoolEntity" managedObjectContext:managedObjectContext propertyNamesString:@"schoolName;notes"];
    
    
    SCEntityDefinition *logDef=[SCEntityDefinition definitionWithEntityName:@"LogEntity" managedObjectContext:managedObjectContext propertyNamesString:@"dateTime;notes"];
    
    
    degreeDef.titlePropertyName=@"degree.degreeName";
    degreeCourseDef.keyPropertyName=@"courseName";
    SCPropertyDefinition *schoolNotesPropertyDef=[schoolDef propertyDefinitionWithName:@"notes"];
    schoolNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    SCPropertyDefinition *degreeNameNotesPropertyDef=[degreeNameDef propertyDefinitionWithName:@"notes"];
    degreeNameNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    SCPropertyDefinition *degreeNotesPropertyDef=[degreeDef propertyDefinitionWithName:@"notes"];
    degreeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    SCPropertyDefinition *degreeCourseNotesPropertyDef=[degreeCourseDef propertyDefinitionWithName:@"notes"];
    degreeCourseNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
     dateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateFormatter setDateFormat:@"M/d/yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    

    
    SCPropertyDefinition *schoolPropertyDef=[degreeDef propertyDefinitionWithName:@"school"];
    schoolPropertyDef.type=SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes* schoolSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:schoolDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    schoolSelectionAttribs.allowAddingItems=YES;
    schoolSelectionAttribs.allowDeletingItems=YES;
    schoolSelectionAttribs.allowEditingItems=YES;
    schoolSelectionAttribs.allowMovingItems=YES;
    schoolSelectionAttribs.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add new school"];
    schoolSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap Edit to add school"];
    schoolPropertyDef.attributes=schoolSelectionAttribs;
    

    
    SCPropertyDefinition *degreeDateAwardedPropertyDef = [degreeDef propertyDefinitionWithName:@"dateAwarded"];
	degreeDateAwardedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                          datePickerMode:UIDatePickerModeDate
                                                           displayDatePickerInDetailView:NO];
    
    
    
    SCPropertyDefinition *degreeCourseStartDatePropertyDef = [degreeCourseDef propertyDefinitionWithName:@"startDate"];
	degreeCourseStartDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                           datePickerMode:UIDatePickerModeDate
                                                            displayDatePickerInDetailView:NO];
    

    SCPropertyDefinition *degreeCourseEndDatePropertyDef = [degreeCourseDef propertyDefinitionWithName:@"endDate"];
	degreeCourseEndDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                                 datePickerMode:UIDatePickerModeDate
                                                                  displayDatePickerInDetailView:NO];
    
    
    SCPropertyDefinition *degreePropertyDef=[degreeCourseDef propertyDefinitionWithName:@"degree"];
    degreePropertyDef.type=SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes* degreeSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:degreeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    degreeSelectionAttribs.allowAddingItems=YES;
    degreeSelectionAttribs.allowDeletingItems=YES;
    degreeSelectionAttribs.allowEditingItems=YES;
    degreeSelectionAttribs.allowMovingItems=YES;
    degreeSelectionAttribs.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add new degrees"];
    degreeSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap Edit to add degrees"];
    degreePropertyDef.attributes=degreeSelectionAttribs;
    
    SCPropertyDefinition *degreeNamePropertyDef=[degreeDef propertyDefinitionWithName:@"degree"];
    degreeNamePropertyDef.type=SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes* degreeNameSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:degreeNameDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    degreeNameSelectionAttribs.allowAddingItems=YES;
    degreeNameSelectionAttribs.allowDeletingItems=YES;
    degreeNameSelectionAttribs.allowEditingItems=YES;
    degreeNameSelectionAttribs.allowMovingItems=YES;
    degreeNameSelectionAttribs.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add new degree names"];
    degreeNameSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap Edit to add degree names"];
    degreeNamePropertyDef.attributes=degreeNameSelectionAttribs;
    

    
    
    
    SCPropertyDefinition *logsPropertyDef=[degreeCourseDef propertyDefinitionWithName:@"logs"];
    
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
    

    
    //create the dictionary with the data bindings
    NSDictionary *clinicianDataBindings = [NSDictionary
                                           dictionaryWithObjects:[NSArray arrayWithObjects:@"instructors",@"Instructors",[NSNumber numberWithBool:NO],@"instructors",[NSNumber numberWithBool:YES],nil]
                                           forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
	
    
       

    
    //create the custom property definition
    SCCustomPropertyDefinition *clinicianDataProperty = [SCCustomPropertyDefinition definitionWithName:@"ClinicianData"
                                                                                        uiElementClass:[ClinicianSelectionCell class] objectBindings:clinicianDataBindings];
    
    
    
    
    //insert the custom property definition into the clientData class at index
    
    clinicianDataProperty.autoValidate=NO;
    
    [degreeCourseDef insertPropertyDefinition:clinicianDataProperty atIndex:5];
    
    if(![SCUtilities is_iPad]){
        
        self.tableView.backgroundView=nil;
        UIView *newView=[[UIView alloc]init];
        [self.tableView setBackgroundView:newView];
        
        
    }
    self.tableView.backgroundColor=[UIColor clearColor];
    
    
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    
    objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:degreeCourseDef];
    
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Courses Taken";
    
    
    
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
