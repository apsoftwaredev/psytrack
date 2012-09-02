//
//  CommunityServiceVC.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/1/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "CommunityServiceVC.h"
#import "PTTAppDelegate.h"
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
    
    SCEntityDefinition *communityServiceDef=[SCEntityDefinition definitionWithEntityName:@"MediaAppearanceEntity" managedObjectContext:managedObjectContext propertyNamesString:@"dateEnded;dateStarted;hours;notes;order"];
    
    SCEntityDefinition *organizationDef=[SCEntityDefinition definitionWithEntityName:@"OrganizationEntity" managedObjectContext:managedObjectContext propertyNamesString:@"name;notes;size"];
    
    
    
    
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

@end
