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
#import "ConsultationEntity.h"
#import "RateChargeEntity.h"
#import "RateEntity.h"
#import "LogEntity.h"
#import "PaymentEntity.h"
@interface ConsultationsViewController ()

@end

@implementation ConsultationsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
   dateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateFormatter setDateFormat:@"M/d/yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

    SCEntityDefinition *consultationDef=[SCEntityDefinition definitionWithEntityName:@"ConsultationEntity" managedObjectContext:managedObjectContext propertyNamesString:@"organization;startDate;endDate;hours;proBono;referrals;logs;notes;rateCharges;fees;paid;payments"];
    
    
    SCEntityDefinition *logDef=[SCEntityDefinition definitionWithEntityName:@"LogEntity" managedObjectContext:managedObjectContext propertyNamesString:@"dateTime;notes"];
    
    
   
    
    //Create a class definition for ReferralEntity to track the referrals
    SCEntityDefinition *referralDef = [SCEntityDefinition definitionWithEntityName:@"ReferralEntity" 
                                                              managedObjectContext:managedObjectContext
                                                                     propertyNames:[NSArray arrayWithObjects:@"clinician",@"dateReferred",@"otherSource", @"notes", nil]];
    
       
    referralDef.titlePropertyName=@"clinician.combinedName";
    
    
    SCEntityDefinition *otherReferralSourceDef=[SCEntityDefinition definitionWithEntityName:@"OtherReferralSourceEntity" managedObjectContext:managedObjectContext propertyNamesString:@"sourceName;notes"];
    
    otherReferralSourceDef.titlePropertyName=@"sourceName";
    SCEntityDefinition *organizationDef=[SCEntityDefinition definitionWithEntityName:@"OrganizationEntity" managedObjectContext:managedObjectContext propertyNamesString:@"name;notes;size"];
    
    organizationDef.keyPropertyName=@"name";
    organizationDef.titlePropertyName=@"name";
    
    
    SCEntityDefinition *rateDef=[SCEntityDefinition definitionWithEntityName:@"RateEntity" managedObjectContext:managedObjectContext propertyNamesString:@"rateName;dateStarted;dateEnded;hourlyRate;notes"];
    
    rateDef.titlePropertyName=@"rateName;hourlyRate";
    rateDef.titlePropertyNameDelimiter=@" $";
    
    SCEntityDefinition *feeDef=[SCEntityDefinition definitionWithEntityName:@"FeeEntity" managedObjectContext:managedObjectContext propertyNamesString:@"feeName;amount;dateCharged;feeType"];
    
    
    SCPropertyGroup *feesAndRatesPropertyGroup=[SCPropertyGroup groupWithHeaderTitle:@"Charges and Payments" footerTitle:nil propertyNames:[NSArray arrayWithObjects:@"rateCharges",@"fees",@"payments",@"paid",@"proBono", nil]];
    
    [consultationDef.propertyGroups addGroup:feesAndRatesPropertyGroup];
    
    feeDef.orderAttributeName=@"order";
    feeDef.titlePropertyName=@"feeName;amount";
    feeDef.titlePropertyNameDelimiter=@" $";
    
    SCEntityDefinition *feeTypeDef=[SCEntityDefinition definitionWithEntityName:@"FeeTypeEntity" managedObjectContext:managedObjectContext propertyNamesString:@"feeType"];
    
    feeTypeDef.keyPropertyName=@"feeType";
    feeTypeDef.orderAttributeName=@"order";
    
    
    SCEntityDefinition *paymentDef=[SCEntityDefinition definitionWithEntityName:@"PaymentEntity" managedObjectContext:managedObjectContext propertyNamesString:@"amount;dateReceived;dateCleared;paymentSource;paymentType;notes"];
    paymentDef.titlePropertyName=@"paymentSource.source;amount";
    paymentDef.titlePropertyNameDelimiter=@" $";
    paymentDef.orderAttributeName=@"order";
    SCEntityDefinition *paymentSourceDef=[SCEntityDefinition definitionWithEntityName:@"PaymentSourceEntity" managedObjectContext:managedObjectContext propertyNamesString:@"source"];
    
    paymentSourceDef.orderAttributeName=@"order";
    
    SCEntityDefinition *paymentTypeDef=[SCEntityDefinition definitionWithEntityName:@"PaymentTypeEntity" managedObjectContext:managedObjectContext propertyNamesString:@"paymentType"];
    
    paymentTypeDef.orderAttributeName=@"order";
    
    SCEntityDefinition *rateChargeDef=[SCEntityDefinition definitionWithEntityName:@"RateChargeEntity" managedObjectContext:managedObjectContext propertyNamesString:@"dateCharged;hours;rate;notes"];
    
    
    rateChargeDef.orderAttributeName=@"order";
    rateChargeDef.titlePropertyName=@"rate.rateName;rate.hourlyRate";
    rateChargeDef.titlePropertyNameDelimiter=@" $";
    
    
    
    
    [rateChargeDef removePropertyDefinitionWithName:@"hours"];
    
    
    
    //create the dictionary with the data bindings
    NSDictionary *hoursDataBindings = [NSDictionary 
                                       dictionaryWithObjects:[NSArray arrayWithObjects:@"hours",nil] 
                                       forKeys:[NSArray arrayWithObjects:@"1",nil ]];
    
    
    
    
    //create the custom property definition
    SCCustomPropertyDefinition *rateChargedHoursDataProperty = [SCCustomPropertyDefinition definitionWithName:@"rateChargedHoursData"
                                                                                  uiElementNibName:@"TotalHoursAndMinutesCell" objectBindings:hoursDataBindings];
    
    rateChargedHoursDataProperty.title=nil;
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    rateChargedHoursDataProperty.autoValidate=FALSE;
    
    
    [rateChargeDef insertPropertyDefinition:rateChargedHoursDataProperty atIndex:1];
    

    
    
    SCPropertyDefinition *rateChargesPropertyDef=[consultationDef propertyDefinitionWithName:@"rateCharges"];
    
    rateChargesPropertyDef.type=SCPropertyTypeArrayOfObjects;
    rateChargesPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:rateChargeDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add Rate Charges"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:NO];
    
    
    
    
    
    SCPropertyDefinition *rateChargesNotesPropertyDef=[rateChargeDef propertyDefinitionWithName:@"notes"];
    rateChargesNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *rateChargedDateChargedPropertyDef = [rateChargeDef propertyDefinitionWithName:@"dateCharged"];
	rateChargedDateChargedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                               datePickerMode:UIDatePickerModeDate 
                                                                displayDatePickerInDetailView:NO];
    
    
    
    SCPropertyDefinition *paymentDateReceivedPropertyDef = [paymentDef propertyDefinitionWithName:@"dateReceived"];
	paymentDateReceivedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                           datePickerMode:UIDatePickerModeDate 
                                                            displayDatePickerInDetailView:NO];
    
    
    SCPropertyDefinition *paymentDateClearedPropertyDef = [paymentDef propertyDefinitionWithName:@"dateCleared"];
	paymentDateClearedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                         datePickerMode:UIDatePickerModeDate 
                                                          displayDatePickerInDetailView:NO];
    
    
    SCPropertyDefinition *paymentNotesPropertyDef=[paymentDef propertyDefinitionWithName:@"notes"];
    paymentNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *paymentTypePropertyDef=[paymentDef propertyDefinitionWithName:@"paymentType"];
    paymentTypePropertyDef.type=SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes* paymentTypeSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:paymentTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    paymentTypeSelectionAttribs.allowAddingItems=YES;
    paymentTypeSelectionAttribs.allowDeletingItems=YES;
    paymentTypeSelectionAttribs.allowEditingItems=YES;
    paymentTypeSelectionAttribs.allowMovingItems=YES;
    paymentTypeSelectionAttribs.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add new payment type"];
    paymentTypeSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap Edit to add payment types"];
    paymentTypePropertyDef.attributes=paymentTypeSelectionAttribs;
    
    
    
    SCPropertyDefinition *paymentSourcePropertyDef=[paymentDef propertyDefinitionWithName:@"paymentSource"];
    paymentSourcePropertyDef.type=SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes* paymentSourceSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:paymentSourceDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    paymentSourceSelectionAttribs.allowAddingItems=YES;
    paymentSourceSelectionAttribs.allowDeletingItems=YES;
    paymentSourceSelectionAttribs.allowEditingItems=YES;
    paymentSourceSelectionAttribs.allowMovingItems=YES;
    paymentSourceSelectionAttribs.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add new payment source"];
    paymentSourceSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap Edit to add payment sources"];
    paymentSourcePropertyDef.attributes=paymentSourceSelectionAttribs;
    
    
    SCPropertyDefinition *consultationPaymentsPropertyDef=[consultationDef propertyDefinitionWithName:@"payments"];
    
    consultationPaymentsPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    consultationPaymentsPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:paymentDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add Payments"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:NO];
    
    
    
    
    
    SCPropertyDefinition *feeDateChargedPropertyDef = [feeDef propertyDefinitionWithName:@"dateCharged"];
	feeDateChargedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                         datePickerMode:UIDatePickerModeDate 
                                                          displayDatePickerInDetailView:NO];
    
    
    
    SCPropertyDefinition *rateDateStartedPropertyDef = [rateDef propertyDefinitionWithName:@"dateStarted"];
	rateDateStartedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                     datePickerMode:UIDatePickerModeDate 
                                                      displayDatePickerInDetailView:NO];
    
    
    SCPropertyDefinition *rateDateEndedPropertyDef = [rateDef propertyDefinitionWithName:@"dateEnded"];
	rateDateEndedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                       datePickerMode:UIDatePickerModeDate 
                                                        displayDatePickerInDetailView:NO];
    
    SCPropertyDefinition *rateNotesPropertyDef = [rateDef propertyDefinitionWithName:@"notes"];
	
	rateNotesPropertyDef.type = SCPropertyTypeTextView;
    
    
    SCPropertyDefinition *rateChargeRatePropertyDef=[rateChargeDef propertyDefinitionWithName:@"rate"];
    
    
    
    
    rateChargeRatePropertyDef.type=SCPropertyTypeObjectSelection;
    rateChargeRatePropertyDef.autoValidate=NO;
    SCObjectSelectionAttributes *rateSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:rateDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    
    
    rateSelectionAttribs.allowMovingItems=YES;
    rateSelectionAttribs.allowEditingItems=YES;
    rateSelectionAttribs.allowAddingItems=YES;
    rateSelectionAttribs.allowDeletingItems=YES;
    rateSelectionAttribs.allowMultipleSelection=NO;
    rateSelectionAttribs.allowNoSelection=YES;
    rateSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap edit to add rates"];
    rateSelectionAttribs.addNewObjectuiElement= [SCTableViewCell cellWithText:@"Add new rate"];
    rateChargeRatePropertyDef.attributes=rateSelectionAttribs;
    

      
    SCPropertyDefinition *feeTypeNamePropertyDef=[feeTypeDef propertyDefinitionWithName:@"feeType"];
    
    feeTypeNamePropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *feeTypePropertyDef=[feeDef propertyDefinitionWithName:@"feeType"];
    
    feeTypePropertyDef.type=SCPropertyTypeObjectSelection;
    
    SCSelectionAttributes *feeTypeSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:feeTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    
    
    feeTypeSelectionAttribs.allowMovingItems=YES;
    feeTypeSelectionAttribs.allowEditingItems=YES;
    feeTypeSelectionAttribs.allowAddingItems=YES;
    feeTypeSelectionAttribs.allowDeletingItems=YES;
    feeTypeSelectionAttribs.allowMultipleSelection=NO;
    feeTypeSelectionAttribs.allowNoSelection=YES;
    feeTypeSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap edit to add fee types"];
    feeTypeSelectionAttribs.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add new fee type"];
    feeTypePropertyDef.attributes=feeTypeSelectionAttribs;
    
    
    SCPropertyDefinition *consultationFeesPropertyDef=[consultationDef propertyDefinitionWithName:@"fees"];
    
    consultationFeesPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    consultationFeesPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:feeDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add fees"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:NO];
    
  
    
    SCPropertyDefinition *organizationPropertyDef=[consultationDef propertyDefinitionWithName:@"organization"];
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
    

    
    
    SCPropertyDefinition *consultationReferralsPropertyDef=[consultationDef propertyDefinitionWithName:@"referrals"];
    
    consultationReferralsPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    consultationReferralsPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:referralDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add Referrals"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];
    
    
    
    
    [consultationDef removePropertyDefinitionWithName:@"hours"];
    
       
    
     
    
    
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
    
   
    //Create the property definition for the dateReferred property in the referralDef Class
    SCPropertyDefinition *dateReferredPropertyDef = [referralDef propertyDefinitionWithName:@"dateReferred"];
    
    //Set the date attributes in the dateReferredPropertyDef property definition and make it so the date picker appears in a detail view.
    dateReferredPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
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
    referralDef.keyPropertyName=@"dateReferred";
    
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
    
    NSDateFormatter *dateTimeFormatter=[[NSDateFormatter alloc]init];
    [dateTimeFormatter setDateFormat:@"ccc M/d/yy h:mm a"];
    [dateTimeFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    SCPropertyDefinition *logDatePropertyDef=[logDef propertyDefinitionWithName:@"dateTime"];
    logDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateTimeFormatter
                                                                     datePickerMode:UIDatePickerModeDateAndTime
                                                      displayDatePickerInDetailView:YES];
    

    
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
    
    
    if([SCUtilities is_iPad]){
        
        self.tableView.backgroundView=nil;
        UIView *newView=[[UIView alloc]init];
        [self.tableView setBackgroundView:newView];
        
        
    }
    self.tableView.backgroundColor=[UIColor clearColor];
    consultationDef.titlePropertyName=@"organization.name";
  
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    
    
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Consultations";
    
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    
    
//	objectsModel.searchPropertyName = @"dateOfService";
    
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
    return YES;
}


-(void)tableViewModel:(SCTableViewModel *)tableModel didAddSectionAtIndex:(NSUInteger)index{
    
    SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:index];
    if(section.headerTitle !=nil)
{
   
    
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
        
        
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.tag=60;
        headerLabel.text=section.headerTitle;
        [containerView addSubview:headerLabel];
        
        section.headerView = containerView;
        
    }
    
    
        
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
        
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"RateChargeEntity"]) {
            RateChargeEntity *rateChargeObject=(RateChargeEntity *)cellManagedObject;
            NSDate *hours=rateChargeObject.hours;
            
            NSTimeInterval hoursTI=[hours timeIntervalSince1970];
            
            RateEntity *rateObject=(RateEntity *)rateChargeObject.rate;
            
            
            NSTimeInterval  hoursTIHours=hoursTI/60/60;
            
            NSDecimal hoursDecimal=[[NSNumber numberWithDouble:hoursTIHours]decimalValue];
            
            NSDecimalNumber *hoursDecimalNumber = [NSDecimalNumber decimalNumberWithDecimal:
                                    hoursDecimal];
            
           
           NSDecimalNumber *totalChargeDecimalNumber=  [rateObject.hourlyRate decimalNumberByMultiplyingBy:hoursDecimalNumber];
            NSLocale *locale = [NSLocale currentLocale];
            NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc]init];
            [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            [currencyFormatter setLocale:locale];
            NSString *textToDisplay=[NSString stringWithFormat:@"%@ %.2lf hrs at $%@ hr (%@ total)",rateObject.rateName,[hoursDecimalNumber floatValue],rateObject.hourlyRate,[currencyFormatter stringFromNumber:  totalChargeDecimalNumber]];
            
            cell.textLabel.text=textToDisplay;
            
        }
        
       else if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"ReferralEntity"]) {
        
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
       else if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"LogEntity"]) {
            
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
       else if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"PaymentEntity"]) {
           
           PaymentEntity *paymentObject=(PaymentEntity *)cellManagedObject;
           
           NSDate *dateReceived=paymentObject.dateReceived;
           NSString *dateReceivedStr;
           if (dateReceived) {
               dateReceivedStr=[dateFormatter stringFromDate:dateReceived];
           }
           
           NSDate *dateCleared=paymentObject.dateCleared;
           NSString *dateClearedStr;
           if (dateCleared) {
               dateClearedStr=[dateFormatter stringFromDate:dateCleared];
           }
           
           NSLocale *locale = [NSLocale currentLocale];
           NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc]init];
           [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
           [currencyFormatter setLocale:locale];
           
           NSString *displayString=nil;
           if (dateCleared) {
               
               displayString=[dateClearedStr stringByAppendingFormat:@": %@",[currencyFormatter stringFromNumber:paymentObject.amount]];
               cell.textLabel.textColor=[UIColor blackColor];
                              
           }else if (dateReceived){
           
               displayString=[dateReceivedStr stringByAppendingFormat:@": %@",[currencyFormatter stringFromNumber:paymentObject.amount]];
           
               cell.textLabel.textColor=[UIColor redColor];
           }
           else if (paymentObject.amount){
               displayString = [currencyFormatter stringFromNumber:paymentObject.amount];
           
           }
           
           cell.textLabel.text=displayString;
           
           
           
           
           
       }
 
        
        
    }

}
-(BOOL)tableViewModel:(SCTableViewModel *)tableModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath{

    BOOL valid=NO;
    SCObjectSection *objectSection=(SCObjectSection *)[tableModel sectionAtIndex:indexPath.section];
    
    SCTableViewCell *cell=[tableModel cellAtIndexPath:indexPath];
    NSManagedObject *sectionManagedObject=(NSManagedObject *)objectSection.boundObject;
    
    if (tableModel.tag==1) {
        
       
        if (sectionManagedObject && [sectionManagedObject respondsToSelector:@selector(entity)]&&[sectionManagedObject.entity.name isEqualToString:@"ConsultationEntity"]&&[cell isKindOfClass:[SCObjectSelectionCell class]]) {
            SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cell;
            
            if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]]) {
                return YES;
            }
            
        }

    }
    if (tableModel.tag==3) {
       
       
        if (sectionManagedObject&& [sectionManagedObject respondsToSelector:@selector(entity)]&&[sectionManagedObject.entity.name isEqualToString:@"RateChargeEntity"]) {
        
            if (cell.tag==2&&[cell isKindOfClass:[SCObjectSelectionCell class]]) {
                SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cell;
                
                if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]]) {
                    return YES;
                }
            }
        
        
        }
        
                
        
        else if (sectionManagedObject&& [sectionManagedObject respondsToSelector:@selector(entity)]&&[sectionManagedObject.entity.name isEqualToString:@"ReferralEntity"]) {
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
        else
        {
        
            return YES;
        }
        
    }
    
return valid;    



}
@end
