/*
 *  TestAdministrationViewController_iPad.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 10/5/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "TestAdministrationsViewController_iPad.h"
#import "PTTAppDelegate.h"
#import "Time_Shared.h"
#import "ButtonCell.h"
#import "ClinicianSelectionCell.h"






@implementation TestAdministrationsViewController_iPad





#pragma mark -
#pragma mark View lifecycle




- (void)viewDidLoad {
    [super viewDidLoad];
    

   
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE, M/d/yyyy"];
    
   
    
    
    
	
	// Get managedObjectContext from application delegate
    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
	
    
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Assessments";
    
    
    SCEntityDefinition *testSessionDeliveredDef =[SCEntityDefinition definitionWithEntityName:@"TestingSessionDeliveredEntity"
                                                                   managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"dateOfService",  @"time",@"clientPresentations",  @"notes", @"paperwork", @"assessmentType",     @"supervisor",    @"trainingType", @"site",  @"eventIdentifier",     nil]];        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
   
 
    NSInteger eventIdentifierPropertyIndex = [testSessionDeliveredDef indexOfPropertyDefinitionWithName:@"eventIdentifier"];
    [testSessionDeliveredDef removePropertyDefinitionAtIndex:eventIdentifierPropertyIndex];

    SCPropertyDefinition *dateOfServicePropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"dateOfService"];
	dateOfServicePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                              datePickerMode:UIDatePickerModeDate 
                                                               displayDatePickerInDetailView:YES];
    
    dateOfServicePropertyDef.title=@"Testing Date";
    SCPropertyDefinition *notesPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"notes"];
    notesPropertyDef.type=SCPropertyTypeTextView;
    
    testSessionDeliveredDef.titlePropertyName=@"dateOfService";
    testSessionDeliveredDef.keyPropertyName=@"dateOfService";
    
    
    //add a button to add an event to the calandar
    
    //create a custom property definition for the Button Cell
    
    NSDictionary *buttonCellObjectBinding=[NSDictionary dictionaryWithObject:@"eventIdentifier" forKey:@"event_identifier"];
    SCCustomPropertyDefinition *eventButtonProperty = [SCCustomPropertyDefinition definitionWithName:@"EventButtonCell" uiElementClass:[ButtonCell class] objectBindings:buttonCellObjectBinding];
    
    //add the property definition to the test administration detail view  
    [testSessionDeliveredDef addPropertyDefinition:eventButtonProperty];
    //define a property group
    SCPropertyGroup *eventGroup = [SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"dateOfService",@"time",@"clientPresentations", @"EventButtonCell",nil]];
    
    // add the event Group property group to the behavioralObservationsDef class. 
    [testSessionDeliveredDef.propertyGroups addGroup:eventGroup];
       
   
    SCPropertyGroup *peopleGroup =[SCPropertyGroup groupWithHeaderTitle:nil footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"SupervisorData",@"paperwork",   @"notes",nil]];
    
    
    
    [testSessionDeliveredDef.propertyGroups addGroup:peopleGroup];
    
    
    SCPropertyGroup *detailsGroup =[SCPropertyGroup groupWithHeaderTitle:@"Administration Details" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"testsAdministered",@"assessmentType",@"treatmentSetting",@"trainingType", @"relatedSupportTime", nil]];
    
   
    
    [testSessionDeliveredDef.propertyGroups addGroup:detailsGroup]; 
    
    
    
    SCPropertyDefinition *licenseNumbersCreditedPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"licenseNumbersCredited"];
    licenseNumbersCreditedPropertyDef.title=@"Licenses Credited";
    
    SCPropertyGroup *creditsGroup =[SCPropertyGroup groupWithHeaderTitle:@"Credits" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"degreesCredited",@"certificationsCredited",@"licenseNumbersCredited",nil]];
    
    
    [testSessionDeliveredDef.propertyGroups addGroup:creditsGroup];
    
    
 
    [testSessionDeliveredDef removePropertyDefinitionWithName:@"supervisor"];
    
    //create the dictionary with the data bindings
    NSDictionary *clinicianDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObjects:@"supervisor",@"Supervisor",[NSNumber numberWithBool:NO],@"supervisor",[NSNumber numberWithBool:NO],nil] 
                                           forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *clinicianDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SupervisorData"
                                                                                        uiElementClass:[ClinicianSelectionCell class] objectBindings:clinicianDataBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    clinicianDataProperty.autoValidate=FALSE;
    
    
     [testSessionDeliveredDef insertPropertyDefinition:clinicianDataProperty atIndex:1];
    
    
    /****************************************************************************************/
    /*	END of Class Definition and attributes for the Client Entity */
    /****************************************************************************************/
    
  
    SCPropertyDefinition *clientsPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"clients"];
    
   	clientsPropertyDef.type = SCPropertyTypeObjectSelection;
    
    
    
    
    
    
    
    
    
    SCEntityDefinition *testSessionTypeDef=[SCEntityDefinition definitionWithEntityName:@"TestingSessionTypeEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"assessmentType", @"notes", nil]];
    
    
    
    
    testSessionTypeDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *testingSessionTypePropertyDef=[testSessionDeliveredDef propertyDefinitionWithName:@"assessmentType"];
    testingSessionTypePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *testSessionTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:testSessionTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    testSessionTypeSelectionAttribs.allowAddingItems = YES;
    testSessionTypeSelectionAttribs.allowDeletingItems = YES;
    testSessionTypeSelectionAttribs.allowMovingItems = YES;
    testSessionTypeSelectionAttribs.allowEditingItems = YES;
    testSessionTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Administration Types)"];
    testSessionTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Administration Type"];
    testingSessionTypePropertyDef.attributes = testSessionTypeSelectionAttribs;
    
    SCPropertyDefinition *testSessionTypePropertyDef=[testSessionTypeDef propertyDefinitionWithName:@"assessmentType"];
    testSessionTypePropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *testSessionTypeNotesPropertyDef=[testSessionTypeDef propertyDefinitionWithName:@"notes"];
    testSessionTypeNotesPropertyDef.type=SCPropertyTypeTextView;
    
   
    //Training Type  start
    SCEntityDefinition *trainingTypeDef=[SCEntityDefinition definitionWithEntityName:@"TrainingTypeEntity" managedObjectContext:managedObjectContext propertyNames:[NSArray arrayWithObjects:@"trainingType",@"selectedByDefault", @"notes", nil]];
    
    
    
    
    
    
    
    trainingTypeDef.orderAttributeName=@"order";
    
    
    
    SCPropertyDefinition *sessionTrainingTypePropertyDef=[testSessionDeliveredDef propertyDefinitionWithName:@"trainingType"];
    sessionTrainingTypePropertyDef.type =SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *trainingTypeSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:trainingTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    trainingTypeSelectionAttribs.allowAddingItems = YES;
    trainingTypeSelectionAttribs.allowDeletingItems = YES;
    trainingTypeSelectionAttribs.allowMovingItems = YES;
    trainingTypeSelectionAttribs.allowEditingItems = YES;
    trainingTypeSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Training Types)"];
    trainingTypeSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Training Type"];
    sessionTrainingTypePropertyDef.attributes = trainingTypeSelectionAttribs;
    
    SCPropertyDefinition *trainingTypePropertyDef=[trainingTypeDef propertyDefinitionWithName:@"trainingType"];
    trainingTypePropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *trainingTypeNotesPropertyDef=[trainingTypeDef propertyDefinitionWithName:@"notes"];
    trainingTypeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    //training type end
    
    
  
   

    
    SCPropertyDefinition *timePropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"time"];
timePropertyDef.attributes = [SCObjectAttributes attributesWithObjectDefinition:self.timeDef];
    
    timePropertyDef.title=@"Testing Time";
    
    
   
    


    //create an array of objects definition for the clientPresentation to-many relationship that with show up in a different view  without a place holder element>.
    
    //Create the property definition for the clientPresentations property
    
    SCPropertyDefinition *clientPresentationsPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"clientPresentations"];
    clientPresentationsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectDefinition:clientPresentations_Shared.clientPresentationDef
                                                                                    allowAddingItems:YES
                                                                                  allowDeletingItems:YES
                                                                                    allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"tap + to add clients"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:NO];	
   
    clientPresentationsPropertyDef.title=@"Clients Tested";
    
    //Create the property definition for the papwerwork property in the testsessiondelivered class
    SCPropertyDefinition *paperworkPropertyDef = [testSessionDeliveredDef propertyDefinitionWithName:@"paperwork"];
    
    //set the property definition type to segmented
    paperworkPropertyDef.type = SCPropertyTypeSegmented;
    
    //set the segmented attributes for the paperwork property definition 
    paperworkPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Incomplete", @"Complete",  nil]];

    
    
    
     NSPredicate *paperworkIncompletePredicate = [NSPredicate predicateWithFormat:@"paperwork == %@",[NSNumber numberWithInteger: 0]];
//     tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self
//										withEntityClassDefinition:testSessionDeliveredDef usingPredicate:paperworkIncompletePredicate];
    SCArrayOfObjectsModel *objectModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:testSessionDeliveredDef filterPredicate:paperworkIncompletePredicate];
    
//    self.tableViewModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView 
//										entityDefinition:testSessionDeliveredDef];
    [self.searchBar setSelectedScopeButtonIndex:2];
    // Initialize tableModel
//    if (self.navigationItem.rightBarButtonItems.count>1) {
//        
//        objectModel.addButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:1];
//    }
//
//   
//    
//    if (self.navigationItem.rightBarButtonItems.count >0)
//    {
//        self.tableViewModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:0];
//    }
    
   
     [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
     NSLog(@"self.navigationItem.rightBarButtonItems are %@",self.buttonsToolbar.items);
   
       objectModel.editButtonItem = self.editButton;;
        
        objectModel.addButtonItem = self.addButton;

    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    objectModel.autoSortSections = TRUE;  
   objectModel.searchBar = self.searchBar;
	objectModel.searchPropertyName = @"dateOfService";
    
    objectModel.allowMovingItems=TRUE;
    
    objectModel.autoAssignDelegateForDetailModels=TRUE;
    objectModel.autoAssignDataSourceForDetailModels=TRUE;
    
    
    objectModel.enablePullToRefresh = TRUE;
    objectModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    
    self.tableViewModel=objectModel;
    [self updateAdministrationTotalLabel:self.tableViewModel];

  
        
    
}





- (void)tableViewModel:(SCArrayOfItemsModel *)tableViewModel
searchBarSelectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
    //NSLog(@"scope changed");
    
    
    
    
    if([tableViewModel isKindOfClass:[SCArrayOfObjectsModel class]])
    {
        SCArrayOfObjectsModel *objectsModel = (SCArrayOfObjectsModel *)tableViewModel;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit ) fromDate:[NSDate date]];
        //create a date with these components
        NSDate *startDate = [calendar dateFromComponents:components];
        [components setMonth:1];
        [components setDay:0]; //reset the other components
        [components setYear:0]; //reset the other components
        NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
        //NSLog(@"start dtate %@",startDate);
        //NSLog(@"end date is %@", endDate);
        
        NSPredicate *currentMonthPredicate = [NSPredicate predicateWithFormat:@"((dateOfService > %@) AND (dateOfService <= %@)) || (dateOfService = nil)",startDate,endDate];
        NSPredicate *paperworkIncompletePredicate = [NSPredicate predicateWithFormat:@"paperwork == %@",[NSNumber numberWithInteger: 0]];
        
        
        [self.searchBar setSelectedScopeButtonIndex:selectedScope];
        
        switch (selectedScope) {
            case 1: //all
                
                
                [objectsModel.dataFetchOptions setFilterPredicate:nil];
//             
                break;
                
            case 2: //case paperwork Incomplete
                [objectsModel.dataFetchOptions setFilterPredicate:paperworkIncompletePredicate];
                
                
                
                
                break;                
                
            default://current month
                
                [objectsModel.dataFetchOptions setFilterPredicate:currentMonthPredicate];
                
               
                
                
                break;
        }
        [objectsModel reloadBoundValues];
        [objectsModel.modeledTableView reloadData]; 
    }
}








-(void)tableViewModel:(SCTableViewModel *)tableViewModel didRemoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableViewModel.tag==0) {
        
        [self updateAdministrationTotalLabel:tableViewModel];
        
    }
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel didRemoveSectionAtIndex:(NSUInteger)index{
    
    if (tableViewModel.tag==0) {
        
        [self updateAdministrationTotalLabel:tableViewModel];
        
    }
    
    
}

-(void)updateAdministrationTotalLabel:(SCTableViewModel *)tableModel{
    
    if (tableModel.tag==0) {
   
        int cellCount=0;
    NSLog(@" table view model section count is %i",tableModel.sectionCount);
        if (tableModel.sectionCount >0){
            
            for (int i=0; i<tableModel.sectionCount; i++) {
                SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:i];
                cellCount=cellCount+section.cellCount;
                
            }
            
            
        }
        if (cellCount==0)
        {
            self.totalAdministrationsLabel.text=@"Tap + To Add Administrations";
        }
        else
        {
            self.totalAdministrationsLabel.text=[NSString stringWithFormat:@"Total Administrations: %i", cellCount];
        }
        
   
        
    }
    
    
    
    
}




-(void)tableViewModel:(SCTableViewModel *)tableModel didInsertRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self tableViewModel:(SCTableViewModel *)tableViewModel testFetchForRowAtIndexPath:(NSIndexPath *) indexPath];
    
       
    if (tableModel.tag==0) 
    {
        
        [self updateAdministrationTotalLabel:tableModel];
    }
    
    
    
    
}






@end
