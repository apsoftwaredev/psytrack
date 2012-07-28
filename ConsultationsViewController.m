//
//  ConsultationsViewController.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/27/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ConsultationsViewController.h"
#import "PTTAppDelegate.h"
#import "EncryptedSCTextViewCell.h"
#import "ClinicianSelectionCell.h"
#import "TotalHoursAndMinutesCell.h"
#import "ReferralEntity.h"
#import "OtherReferralSourceEntity.h"
@interface ConsultationsViewController ()

@end

@implementation ConsultationsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateFormatter setDateFormat:@"M/d/yyyy"];
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

    SCEntityDefinition *consultationDef=[SCEntityDefinition definitionWithEntityName:@"ConsultationEntity" managedObjectContext:managedObjectContext propertyNamesString:@"organization;startDate;endDate;hours;proBono;referrals;logs;notes;rate;fees"];
    
    
    SCEntityDefinition *logDef=[SCEntityDefinition definitionWithEntityName:@"LogEntity" managedObjectContext:managedObjectContext propertyNamesString:@"dateTime;notes"];
    
    
   
    
    //Create a class definition for ReferralEntity to track the referrals
    SCEntityDefinition *referralDef = [SCEntityDefinition definitionWithEntityName:@"ReferralEntity" 
                                                              managedObjectContext:managedObjectContext
                                                                     propertyNames:[NSArray arrayWithObjects:@"clinician",@"referralDate",@"otherSource", @"notes", nil]];
    
       
    referralDef.titlePropertyName=@"clinician.combinedName";
    referralDef.keyPropertyName=@"referralDate";
    
    SCEntityDefinition *otherReferralSourceDef=[SCEntityDefinition definitionWithEntityName:@"OtherReferralSourceEntity" managedObjectContext:managedObjectContext propertyNamesString:@"sourceName;notes"];
    
    
    SCEntityDefinition *organizationDef=[SCEntityDefinition definitionWithEntityName:@"OrganizationEntity" managedObjectContext:managedObjectContext propertyNamesString:@"name;notes;size"];
    
    organizationDef.keyPropertyName=@"name";
    organizationDef.titlePropertyName=@"name";
    
    
    SCEntityDefinition *rateDef=[SCEntityDefinition definitionWithEntityName:@"RateEntity" managedObjectContext:managedObjectContext propertyNamesString:@"serviceDesc;dateStarted;dateEnded;hourlyRate;notes"];
    
    
    SCEntityDefinition *feeDef=[SCEntityDefinition definitionWithEntityName:@"FeeEntity" managedObjectContext:managedObjectContext propertyNamesString:@"descr;amount;dateCharged;feeType"];
    
    SCEntityDefinition *feeTypeDef=[SCEntityDefinition definitionWithEntityName:@"FeeTypeEntity" managedObjectContext:managedObjectContext propertyNamesString:@"feeType"];
    
    SCPropertyDefinition *organizationPropertyDef=[consultationDef propertyDefinitionWithName:@"organization"];
    organizationPropertyDef.type=SCPropertyTypeObjectSelection;
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
    

    
    
    SCPropertyDefinition *consultationReferralsPropertyDef=[consultationDef propertyDefinitionWithName:@"referrals"];
    
    consultationReferralsPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    consultationReferralsPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:referralDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add Referrals"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];
    
    
    
    
    [consultationDef removePropertyDefinitionWithName:@"hours"];
    
       
    
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
    
    
    [consultationDef addPropertyDefinition:hoursDataProperty];
    

    
    
    NSInteger indexOfClientProperty=(NSInteger )[referralDef indexOfPropertyDefinitionWithName:@"clinician"];
    [referralDef removePropertyDefinitionAtIndex:indexOfClientProperty];
    
    
        
    
    SCPropertyDefinition *otherReferralSourcePropertyDef=[referralDef propertyDefinitionWithName:@"otherSource"];
    
    otherReferralSourcePropertyDef.type=SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *otherReferralSourceSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:otherReferralSourceDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    otherReferralSourceSelectionAttribs.allowAddingItems=YES;
    otherReferralSourceSelectionAttribs.allowDeletingItems=YES;
    otherReferralSourceSelectionAttribs.allowEditingItems=YES;
    otherReferralSourceSelectionAttribs.allowMovingItems=YES;
    otherReferralSourceSelectionAttribs.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add other referral source"];
    otherReferralSourceSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap Edit to add other referral source"];
    otherReferralSourcePropertyDef.attributes=otherReferralSourceSelectionAttribs;
    
    SCPropertyDefinition *otherReferralSourceNotes=[otherReferralSourceDef propertyDefinitionWithName:@"notes"];
    otherReferralSourceNotes.type=SCPropertyTypeTextView;
    
    otherReferralSourceDef.keyPropertyName=@"referralDate";
    
    otherReferralSourcePropertyDef.autoValidate=NO;
  
        
        //create the dictionary with the data bindings
    NSDictionary *clinicianDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObjects:@"clinician",@"Referred by Clinician",[NSNumber numberWithBool:NO],@"clinician",[NSNumber numberWithBool:NO],nil] 
                                           forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
	
        //create the custom property definition
        SCCustomPropertyDefinition *clinicianDataProperty = [SCCustomPropertyDefinition definitionWithName:@"ClinicianData"
                                                                                            uiElementClass:[ClinicianSelectionCell class] objectBindings:clinicianDataBindings];
        
        
        
        
        //insert the custom property definition into the clientData class at index 
        
    clinicianDataProperty.autoValidate=NO;
        [referralDef insertPropertyDefinition:clinicianDataProperty atIndex:1];
    
   
    //Create the property definition for the referralDate property in the referralDef Class
    SCPropertyDefinition *referralDatePropertyDef = [referralDef propertyDefinitionWithName:@"referralDate"];
    
    //Set the date attributes in the referralDatePropertyDef property definition and make it so the date picker appears in a detail view.
    referralDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                        datePickerMode:UIDatePickerModeDate
                                                         displayDatePickerInDetailView:TRUE];
    
    
    
    //create a property definition for the notes property in the referral class definition
    SCPropertyDefinition *referralNotesPropertyDef = [referralDef propertyDefinitionWithName:@"notes"];
    
    referralNotesPropertyDef.type=SCPropertyTypeCustom;
    referralNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryReferralNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyString",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    referralNotesPropertyDef.objectBindings=encryReferralNotesTVCellKeyBindingsDic;
    referralNotesPropertyDef.title=@"Notes";
    referralNotesPropertyDef.autoValidate=NO;
    
    //Create the property definition for the referralInOrOut property in the referralDef class
    SCPropertyDefinition *referralInOrOutPropertyDef = [referralDef propertyDefinitionWithName:@"referralInOrOut"];
    
    //set the property definition type to segmented
    referralInOrOutPropertyDef.type = SCPropertyTypeSegmented;
    
    //set the segmented attributes for the referralInOrOut property definition 
    referralInOrOutPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"IN to Me", @"OUT to Clinician" , nil]];
    //override the auto title generation for the referralInOrOut property definition and set it to a custom title
    referralInOrOutPropertyDef.title=@"Referal";
    
    //set the order attributes name defined in the Referral Entity
    referralDef.orderAttributeName=@"order";
    
    
    //create an object selection for the client relationship in the referral Entity 
    
    //create a property definition
    //    SCPropertyDefinition *clientReferredPropertyDef = [referralDef propertyDefinitionWithName:@"client"];
    //    
    //set the title property name
    referralDef.titlePropertyName=@"client.clientIDCode";
    referralDef.keyPropertyName=@"referralDate";
    
    SCPropertyDefinition *logsPropertyDef=[consultationDef propertyDefinitionWithName:@"logs"];
    
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
    

    
    SCPropertyDefinition *startDatePropertyDef = [consultationDef propertyDefinitionWithName:@"startDate"];
	startDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                        datePickerMode:UIDatePickerModeDate 
                                                         displayDatePickerInDetailView:NO];
    
    
    SCPropertyDefinition *endDateDatePropertyDef = [consultationDef propertyDefinitionWithName:@"endDate"];
	endDateDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                          datePickerMode:UIDatePickerModeDate 
                                                           displayDatePickerInDetailView:NO];
    
    SCPropertyDefinition *notesPropertyDef = [consultationDef propertyDefinitionWithName:@"notes"];
	
	notesPropertyDef.type = SCPropertyTypeTextView;
    
   

    
    
    
    
    objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:consultationDef];
    
    
    if(![SCUtilities is_iPad]){
        
        self.tableView.backgroundView=nil;
        UIView *newView=[[UIView alloc]init];
        [self.tableView setBackgroundView:newView];
        
        
    }
    self.tableView.backgroundColor=[UIColor clearColor];
    consultationDef.titlePropertyName=@"organization.name";
  
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    NSLog(@"self.navigationItem.rightBarButtonItems are %@",self.buttonsToolbar.items);
    
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Consultations";
    
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    
    
	objectsModel.searchPropertyName = @"dateOfService";
    
    objectsModel.allowMovingItems=TRUE;
    
    objectsModel.autoAssignDelegateForDetailModels=TRUE;
    objectsModel.autoAssignDataSourceForDetailModels=TRUE;
    
    
    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    
    self.tableViewModel=objectsModel;
    
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
        SCArrayOfObjectsSection *objectsSection=(SCArrayOfObjectsSection *)[tableModel sectionAtIndex:0];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&& [cellManagedObject isKindOfClass:[ReferralEntity class]]) {
        
            ReferralEntity *referralObject=(ReferralEntity *)cellManagedObject;
            ClinicianEntity *clinician=(ClinicianEntity *)referralObject.clinician;
            OtherReferralSourceEntity *otherReferralSource=(OtherReferralSourceEntity *)referralObject.otherSource;
            
            if (clinician) {
                cell.textLabel.text=clinician.combinedName;

            }
            else if (otherReferralSource) {
                cell.textLabel.text=otherReferralSource.sourceName;
            }
            
            
                       
        }
        NSLog(@"objects section bound object is %@",objectsSection.boundObject);
        
    }

}
-(BOOL)tableViewModel:(SCTableViewModel *)tableModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath{

    BOOL valid=NO;
    if (tableModel.tag==3) {
        SCObjectSection *objectSection=(SCObjectSection *)[tableModel sectionAtIndex:indexPath.section];
        NSLog(@"object section bound object is %@",objectSection.boundObject);
        SCTableViewCell *cell=[tableModel cellAtIndexPath:indexPath];
        
        
        NSManagedObject *sectionManagedObject=(NSManagedObject *)objectSection.boundObject;
        if (sectionManagedObject&& [sectionManagedObject isKindOfClass:[ReferralEntity class]]) {
            SCTableViewCell *otherCell=nil;
            if (cell.tag==1) {
                otherCell=(SCTableViewCell *)[objectSection cellAtIndex:2];
                
            }else if (cell.tag==2) {
                otherCell=(SCTableViewCell*)[objectSection cellAtIndex:1];
            }
            
            if ([cell isKindOfClass:[ClinicianSelectionCell class]]) {
                ClinicianSelectionCell *clinicianSelectionCell=(ClinicianSelectionCell *)cell;
                
                if (clinicianSelectionCell.clinicianObject) {
                    return YES;
                }
            }
            if ([cell isKindOfClass:[EncryptedSCTextViewCell class]]) {
                return YES;
            }
            NSLog(@"cell tag is %i",cell.tag);
           NSLog(@"cell class is %@",cell.class);
            NSLog(@"other cell class is %@",otherCell.class);
            if ([cell isKindOfClass:[SCObjectSelectionCell class]]) {
                SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cell;
                if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]]) {
                 
                    return YES;
                }
                if ([otherCell isKindOfClass:[ClinicianSelectionCell class]]) {
                    ClinicianSelectionCell *clinicianSelectionCell=(ClinicianSelectionCell *)otherCell;
                    
                    if (clinicianSelectionCell.clinicianObject) {
                        return YES;
                    }
                }
                if ([otherCell isKindOfClass:[SCObjectSelectionCell class]]) {
                    SCObjectSelectionCell *otherCellObjectSelectionCell=(SCObjectSelectionCell *)otherCell;
                    if (![otherCellObjectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]]) {
                        return YES;
                    }
                    
                }
            }
            
           
                        
            
        }
        
    }
    
return valid;    



}
@end
