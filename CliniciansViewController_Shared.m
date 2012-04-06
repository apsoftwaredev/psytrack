/*
 *  CliniciansViewController_Shared.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/23/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "CliniciansViewController_Shared.h"
#import "PTTAppDelegate.h"
#import "ButtonCell.h"
#import "DemographicDetailViewController_Shared.h"
#import "ClientsViewController_Shared.h"
#import "ClinicianEntity.h"
#import "CliniciansRootViewController_iPad.h"
#import "ClinicianViewController.h"
#import "EncryptedSCTextViewCell.h"
#import "MySource.h"
#import "PTABGroup.h"
#import "ClientsSelectionCell.h"


@implementation CliniciansViewController_Shared
//@synthesize objectsSection;
@synthesize clinicianDef;

@synthesize personVCFromSelectionList=personVCFromSelectionList_;
@synthesize personAddNewViewController=personAddNewViewController_;
@synthesize currentDetailTableViewModel=currentDetailTableViewModel_;
@synthesize rootViewController=rootViewController_;
@synthesize tableModel=tableModel_;
@synthesize tableView;
@synthesize abGroupObjectSelectionCell=abGroupObjectSelectionCell_;
@synthesize personViewController=personViewController_;

@synthesize iPadPersonBackgroundView=iPadPersonBackgroundView_;
@synthesize peoplePickerNavigationController=peoplePickerNavigationController_;
#pragma mark -
#pragma Generate SCTableView classes and properties


-(void)viewDidUnload{
    //    [super viewDidUnload];
   
     self.tableModel=nil;
    if (currentDetailTableViewModel_) {
        self.currentDetailTableViewModel=nil;
    }
    
    
   currentDetailTableViewModel_=nil;
   rootNavigationController=nil;
   rootViewController_=nil;
  
    //    ABRecordRef existingPersonRef;

    

   
   
    if (personViewController_){
    
        self.personViewController.view=nil;
        self.personViewController=nil;
    };
    if (peoplePickerNavigationController_) {
        self.peoplePickerNavigationController=nil;
        self.peoplePickerNavigationController.view=nil;
    }
    clinician=nil;
    //      ABAddressBookRef addressBook;
    
    if (abGroupObjectSelectionCell_){
    
        self.abGroupObjectSelectionCell=nil;
    };
    
   
    
    if (self.iPadPersonBackgroundView) {
        self.iPadPersonBackgroundView=nil;
    }
    
    if (personVCFromSelectionList_) {
        self.personVCFromSelectionList.view=nil;
        self.personVCFromSelectionList=nil;
        
    }
    if (personAddNewViewController) {
        personAddNewViewController.view=nil;
        self.personAddNewViewController=nil;
    }
    
    //    CFRelease(addressBook);
    //    CFRelease(existingPersonRef);
    
    
}

- (void) didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    [appDelegate displayMemoryWarning];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Gracefully handle reloading the view controller after a memory warning
    self.tableModel = (SCArrayOfObjectsModel *)[[SCModelCenter sharedModelCenter] modelForViewController:self];
    if(tableModel_)
    {
        [tableModel_ replaceModeledTableViewWith:self.tableView];
        return;
    }
    
  
    
    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];   
    //set different custom cells nib names for iPhone and iPad
    NSString *shortFieldCellNibName=nil;
    NSString *textFieldAndLableNibName=nil;
    NSString *scaleDataCellNibName=nil;
    NSString *switchAndLabelCellName=nil;
    if ([SCHelper is_iPad]) {
        
        textFieldAndLableNibName=@"TextFieldAndLabelCell_iPad";
        shortFieldCellNibName=@"ShortFieldCell_iPad";
        scaleDataCellNibName=@"ScaleDataCell_iPad";
        switchAndLabelCellName=@"switchAndLabelCell_iPad";
               
    } else
    {
        
        textFieldAndLableNibName=@"TextFieldAndLabelCell_iPhone";
        shortFieldCellNibName=@"ShortFieldCell_iPhone";
        scaleDataCellNibName=@"ScaleDataCell_iPhone";
        switchAndLabelCellName=@"switchAndLabelCell_iPhone";

    }
    
    //define some date formats to be used below using a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMM dd, yyyy"];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
	[timeFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    
    //add demographic information section from the shared demographic controller
    DemographicDetailViewController_Shared *demographicDetailViewController_Shared =[[DemographicDetailViewController_Shared alloc]init];
    
    //set up the demographic view
    [demographicDetailViewController_Shared setupTheDemographicView];
    
    /****************************************************************************************/
    /*	BEGIN Class Definition and attributes for the Degree Entity */
    /****************************************************************************************/ 
  
	
    
    SCClassDefinition *degreeDef = [SCClassDefinition definitionWithEntityName:@"DegreeEntity" 
													  withManagedObjectContext:managedObjectContext
															 withPropertyNames:[NSArray arrayWithObjects:@"degree",
																				@"school", @"dateAwarded",@"notes",nil]];
	
    
    
    
    //set the order attributes name defined in the Degree Entity
    degreeDef.orderAttributeName=@"order";
    
    //Create the property definition for the notes property in the degree Entity
	SCPropertyDefinition *degreeNotesPropertyDef = [degreeDef propertyDefinitionWithName:@"notes"];
    
    //set the notes property definition type to a Text View Cell
    degreeNotesPropertyDef.type=SCPropertyTypeTextView;
	
    

	//Create the property definition for the dateAwarded property in the degreeDef class  definition
    SCPropertyDefinition *degreeDateAwardedPropertyDef = [degreeDef propertyDefinitionWithName:@"dateAwarded"];
	
    //Set the date attributes in the degreeDateAwardedPropertyDef property definition and make it so the date picker appears in a separate view.
    degreeDateAwardedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
																			 datePickerMode:UIDatePickerModeDate 
															  displayDatePickerInDetailView:YES];
    
    /****************************************************************************************/
    /*	END of Class Definition and attributes for the Degree Entity */
    /****************************************************************************************/
    /*  will be used with degree name class. */
    
    
    /****************************************************************************************/
    /*	BEGIN Class Definition and attributes for the Degree Name Entity */
    /****************************************************************************************/ 
  
    SCClassDefinition *degreeNameDef = [SCClassDefinition definitionWithEntityName:@"DegreeNameEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"degreeName", @"notes",nil]];
    
    
    //set the order attributes name defined in the DegreeName Entity
    degreeNameDef.orderAttributeName=@"order";
    SCPropertyDefinition *degreePropertyDef = [degreeDef propertyDefinitionWithName:@"degree"];
    

	degreePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *degreeNameSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:degreeNameDef allowMultipleSelection:NO allowNoSelection:NO];
    degreeNameSelectionAttribs.allowAddingItems = YES;
    degreeNameSelectionAttribs.allowDeletingItems = YES;
    degreeNameSelectionAttribs.allowMovingItems = YES;
    degreeNameSelectionAttribs.allowEditingItems = YES;
    degreeNameSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Define Degrees)"];
    degreeNameSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Degree Name"];
    degreePropertyDef.attributes = degreeNameSelectionAttribs;
    degreeDef.titlePropertyName=@"degree.degreeName;dateAwarded";
    
    
     //Create the property definition for the degree name property in the DegreeName Entity
    SCPropertyDefinition *degreeNamePropertyDef = [degreeNameDef propertyDefinitionWithName:@"degreeName"];
    
    //set the degreeNamePropertyDef property definition type to a Text View Cell
    degreeNamePropertyDef.type=SCPropertyTypeTextView;
    
    //Create the property definition for the notes property in the DegreeName Entity
    SCPropertyDefinition *degreeNameNotesPropertyDef = [degreeNameDef propertyDefinitionWithName:@"notes"];
    degreeNameNotesPropertyDef.type=SCPropertyTypeTextView;
    
   
    /****************************************************************************************/
    /*	END of Class Definition and attributes for the Degree Name Entity */
    /****************************************************************************************/
   
    /****************************************************************************************/
    /*	BEGIN Class Definition and attributes for the School Entity */
    /****************************************************************************************/ 
      
    SCClassDefinition *schoolNameDef = [SCClassDefinition definitionWithEntityName:@"SchoolEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"schoolName", nil]];
    
    //set the order attributes name defined in the School Name Entity
      schoolNameDef.orderAttributeName=@"order";
    
    //Create the property definition for the school property in the degree Entity
    SCPropertyDefinition *schoolPropertyDef = [degreeDef propertyDefinitionWithName:@"school"];


    //set the property type to selection
    schoolPropertyDef.type = SCPropertyTypeObjectSelection;
	//set some addtional attributes
    SCObjectSelectionAttributes *schoolSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:schoolNameDef allowMultipleSelection:NO allowNoSelection:NO];
    schoolSelectionAttribs.allowAddingItems = YES;
    schoolSelectionAttribs.allowDeletingItems = YES;
    schoolSelectionAttribs.allowMovingItems = YES;
    schoolSelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do when there are no other cells 
    schoolSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Define School Names)"];
   
    //add an "Add New" element to appear when user clicks edit
    schoolSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New School"];
   
    //add the selection attributes to the property definition
    schoolPropertyDef.attributes = schoolSelectionAttribs;
    
    
    

    //Create a property definition for the schoolName property.
    SCPropertyDefinition *schoolNamePropertyDef = [schoolNameDef propertyDefinitionWithName:@"schoolName"];
    
    //set the schoolName property definition type to a Text View Cell
    schoolNamePropertyDef.type=SCPropertyTypeTextView;
    
    
    
    
    
    
    
    //Create a class definition for Influence entity
	SCClassDefinition *influenceDef = [SCClassDefinition definitionWithEntityName:@"InfluenceEntity" 
                                                         withManagedObjectContext:managedObjectContext
                                                                withPropertyNames:[NSArray arrayWithObjects:@"influence",@"notes", nil]];
    
        //set the order attributes name defined in the influence Entity
    influenceDef.orderAttributeName=@"order";
    SCPropertyDefinition *influenceNotesPropertyDef = [influenceDef propertyDefinitionWithName:@"notes"];
    influenceNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *influenceNamePropertyDef = [influenceDef propertyDefinitionWithName:@"influence"];
    influenceNamePropertyDef.type=SCPropertyTypeTextView;
    
    //Create a class definition for Employment entity
	SCClassDefinition *employmentDef = [SCClassDefinition definitionWithEntityName:@"EmploymentEntity" 
                                                          withManagedObjectContext:managedObjectContext
                                                                 withPropertyNames:[NSArray arrayWithObjects:@"employer",@"positions",@"dateStarted",
                                                                                    @"dateEnded",@"notes", nil]];
	
    //set the order attributes name defined in the Employment Entity
    employmentDef.orderAttributeName=@"order";
    SCClassDefinition *employmentTitleDef = [SCClassDefinition definitionWithEntityName:@"EmploymentTitleEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"jobTitle", @"desc", nil]];
    
    //set the order attributes name defined in the Employment Title Entity
    employmentTitleDef.orderAttributeName=@"order";
    
    SCClassDefinition *employmentPositionDef = [SCClassDefinition definitionWithEntityName:@"EmploymentPositionEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects: @"jobTitle",@"department",@"startedDate", @"endedDate", @"notes", nil]];
    
    //set the order attributes name defined in the Employment Position Entity
    employmentPositionDef.orderAttributeName=@"order";
    
    employmentPositionDef.titlePropertyName=@"jobTitle.jobTitle;startedDate";
    SCPropertyDefinition *employmentPositionDepartmentPropertyDef = [employmentPositionDef propertyDefinitionWithName:@"department"];
    employmentPositionDepartmentPropertyDef.type=SCPropertyTypeTextView;
    
//    SCPropertyGroup *nonClinicalSupNameGroup = [SCPropertyGroup groupWithHeaderTitle:@"clinician of My clinician Name" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"title", @"firstName",@"middleName",@"lastName",@"suffix",@"credentialInitials", nil]];
//    
    
//    SCPropertyGroup *nonClinicalSupDatesGroup = [SCPropertyGroup groupWithHeaderTitle:@"Supervision Dates" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"started",@"ended", nil]];
    
//    SCPropertyGroup *nonClinicalSupContactGroup = [SCPropertyGroup groupWithHeaderTitle:@"Contact Information" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"addresses", @"phoneNumbers",@"emailAddresses", nil]];
    
//    SCPropertyGroup *nonClinicalSupNotesGroup = [SCPropertyGroup groupWithHeaderTitle:@"Notes" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"notes"]];
    
//    SCPropertyGroupArray *nonClinicalSupervisorPropetyGroupArray=[[SCPropertyGroupArray alloc]init];
//    [nonClinicalSupervisorPropetyGroupArray addGroup:nonClinicalSupNameGroup];
//    [nonClinicalSupervisorPropetyGroupArray addGroup:nonClinicalSupDatesGroup];
//    [nonClinicalSupervisorPropetyGroupArray addGroup:nonClinicalSupContactGroup];
//    [nonClinicalSupervisorPropetyGroupArray addGroup:nonClinicalSupNotesGroup];
    
//    SCClassDefinition *nonClinicalSupervisorDef =[SCClassDefinition definitionWithEntityName:@"NonClinicalSupervisorEntity" withManagedObjectContext:managedObjectContext withPropertyGroups:nonClinicalSupervisorPropetyGroupArray];
    
    //set the order attributes name defined in the Non Clinical  Entity
//    nonClinicalSupervisorDef.orderAttributeName=@"order";
//    nonClinicalSupervisorDef.titlePropertyName=@"title;firstName;lastName;credendialInitials";
//    SCPropertyDefinition *nonClinicalSupervisorPropertyDef = [employmentPositionDef propertyDefinitionWithName:@"nonClinicalSupervisors"];
//    
//    nonClinicalSupervisorPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:nonClinicalSupervisorDef
//                                                                                                allowAddingItems:TRUE
//                                                                                              allowDeletingItems:TRUE
//                                                                                                allowMovingItems:TRUE];
//    
    
    //override the auto title generation for the nonClinicalSupervisor property definition and set it to a custom title
//    nonClinicalSupervisorPropertyDef.title=@"Supervisors";
//    SCPropertyDefinition *nonClinicalSupervisorNotesPropertyDef = [nonClinicalSupervisorDef propertyDefinitionWithName:@"notes"];
//    nonClinicalSupervisorNotesPropertyDef.type=SCPropertyTypeTextView;
//    nonClinicalSupervisorNotesPropertyDef.title=nil;
//    
//    
//    SCPropertyDefinition *nonClinicalSupStartedDatePropertyDef = [nonClinicalSupervisorDef propertyDefinitionWithName:@"started"];
//	nonClinicalSupStartedDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
//                                                                                     datePickerMode:UIDatePickerModeDate 
//                                                                      displayDatePickerInDetailView:NO];
    
    
    
//    SCPropertyDefinition *nonClinicalSupEndedDatePropertyDef = [nonClinicalSupervisorDef propertyDefinitionWithName:@"ended"];
//	nonClinicalSupEndedDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
//                                                                                   datePickerMode:UIDatePickerModeDate 
//                                                                    displayDatePickerInDetailView:NO];
    
    
    
    
    SCPropertyDefinition *employmentTitlePropertyDef = [employmentPositionDef propertyDefinitionWithName:@"jobTitle"];
    
    
	employmentTitlePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *employmentTitlesSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:employmentTitleDef allowMultipleSelection:NO allowNoSelection:NO];
    employmentTitlesSelectionAttribs.allowAddingItems = YES;
    employmentTitlesSelectionAttribs.allowDeletingItems = YES;
    employmentTitlesSelectionAttribs.allowMovingItems = YES;
    employmentTitlesSelectionAttribs.allowEditingItems = YES;
    employmentTitlesSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Define Job Titles)"];
    employmentTitlesSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Job Title"];
    employmentTitlePropertyDef.attributes = employmentTitlesSelectionAttribs;
	
    SCPropertyDefinition *employmentJobTitlePropertyDef = [employmentTitleDef propertyDefinitionWithName:@"jobTitle"];\
    employmentJobTitlePropertyDef.type=SCPropertyTypeTextView;
    
    
    
    SCPropertyDefinition *employmentDateStartedPropertyDef = [employmentDef propertyDefinitionWithName:@"dateStarted"];
	employmentDateStartedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                                 datePickerMode:UIDatePickerModeDate 
                                                                  displayDatePickerInDetailView:NO];
    
    SCPropertyDefinition *employmentPositionStartedDatePropertyDef = [employmentPositionDef propertyDefinitionWithName:@"startedDate"];
	employmentPositionStartedDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                                         datePickerMode:UIDatePickerModeDate 
                                                                          displayDatePickerInDetailView:NO];
    
    SCPropertyDefinition *employmentPositionEndedDatePropertyDef = [employmentPositionDef propertyDefinitionWithName:@"endedDate"];
	employmentPositionEndedDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                                       datePickerMode:UIDatePickerModeDate 
                                                                        displayDatePickerInDetailView:NO];
    
    SCPropertyDefinition *employmentPositionNotesPropertyDef = [employmentPositionDef propertyDefinitionWithName:@"notes"];
    employmentPositionNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    
    
    
 
    
    
    
    
    
    SCPropertyDefinition *employmentDateEndedPropertyDef = [employmentDef propertyDefinitionWithName:@"dateEnded"];
	employmentDateEndedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                               datePickerMode:UIDatePickerModeDate 
                                                                displayDatePickerInDetailView:NO];
    
    
    
    SCClassDefinition *employerDef = [SCClassDefinition definitionWithEntityName:@"EmployerEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"employerName",@"notes", nil]];
    
    //set the order attributes name defined in the Employer Entity    
    employerDef.orderAttributeName=@"order";
    SCPropertyDefinition *employmentEmployerNamePropertyDef = [employmentDef propertyDefinitionWithName:@"employer"];
    
 
	employmentEmployerNamePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *employerSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:employerDef allowMultipleSelection:NO allowNoSelection:NO];
    employerSelectionAttribs.allowAddingItems = YES;
    employerSelectionAttribs.allowDeletingItems = YES;
    employerSelectionAttribs.allowMovingItems = YES;
    employerSelectionAttribs.allowEditingItems = YES;
    employerSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Define Employers)"];
    employerSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new Employer"];
    employmentEmployerNamePropertyDef.attributes = employerSelectionAttribs;
	
    SCPropertyDefinition *employerNamePropertyDef = [employerDef propertyDefinitionWithName:@"employerName"];
    employerNamePropertyDef.type=SCPropertyTypeTextView;
    
    
    SCPropertyDefinition *employmentTitleDescPropertyDef = [employmentTitleDef propertyDefinitionWithName:@"desc"];
    
    //override the auto title generation for the desc property definition and set it to description
    employmentTitleDescPropertyDef.title=@"Description";
    employmentTitleDescPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *employmentNotesPropertyDef = [employmentDef propertyDefinitionWithName:@"notes"]; 
    employmentNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *employerNotesPropertyDef = [employerDef propertyDefinitionWithName:@"notes"];
    employerNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    employmentDef.titlePropertyName=@"employer.employerName;dateStarted";
    
 
    
    
    
    
    
    
    
    //Create a class definition for Award entity
	SCClassDefinition *awardDef = [SCClassDefinition definitionWithEntityName:@"AwardEntity" 
                                                     withManagedObjectContext:managedObjectContext
                                                            withPropertyNames:[NSArray arrayWithObjects:@"awardName",@"dateAwarded",@"desc", nil]];
    
    //set the order attributes name defined in the Award Entity    
    awardDef.orderAttributeName=@"order";
    SCPropertyDefinition *awardDateAwardedPropertyDef = [awardDef propertyDefinitionWithName:@"dateAwarded"];
	awardDateAwardedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                            datePickerMode:UIDatePickerModeDate 
                                                             displayDatePickerInDetailView:YES];
    SCPropertyDefinition *awardDescPropertyDef = [awardDef propertyDefinitionWithName:@"desc"];
    
    awardDescPropertyDef.title=@"Description";
    awardDescPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *awardNamePropertyDef = [awardDef propertyDefinitionWithName:@"awardName"];
    awardNamePropertyDef.type=SCPropertyTypeTextView;
    
    //Create a class definition for Membership entity
	SCClassDefinition *membershipDef = [SCClassDefinition definitionWithEntityName:@"MembershipEntity" 
                                                          withManagedObjectContext:managedObjectContext
                                                                 withPropertyNames:[NSArray arrayWithObjects:@"organization",@"memberSince",@"renewDate",@"desc", nil]];
    
    //set the order attributes name defined in the Membership Entity   
    membershipDef.orderAttributeName=@"order";
    SCClassDefinition *membershipOrganizationDef = [SCClassDefinition definitionWithEntityName:@"MembershipOrganizationEntity" 
                                                                      withManagedObjectContext:managedObjectContext
                                                                             withPropertyNames:[NSArray arrayWithObjects:@"organization",@"notes", nil]];
    
    //set the order attributes name defined in the Membership Organization Entity    
    membershipOrganizationDef.orderAttributeName=@"order";
    membershipDef.titlePropertyName=@"organization.organization";
    SCPropertyDefinition *organizationNamePropertyDef = [membershipDef propertyDefinitionWithName:@"organization"];
    
	organizationNamePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *organizationSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:membershipOrganizationDef allowMultipleSelection:NO allowNoSelection:NO];
    organizationSelectionAttribs.allowAddingItems = YES;
    organizationSelectionAttribs.allowDeletingItems = YES;
    organizationSelectionAttribs.allowMovingItems = YES;
    organizationSelectionAttribs.allowEditingItems = YES;
    organizationSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Define organizations)"];
    organizationSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new organization"];
    organizationNamePropertyDef.attributes = organizationSelectionAttribs;
    
    
    SCPropertyDefinition *membershipOrganizationNotesPropertyDef = [membershipOrganizationDef propertyDefinitionWithName:@"notes"]; 
    membershipOrganizationNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *membershipOrganizationNamePropertyDef = [membershipOrganizationDef propertyDefinitionWithName:@"organization"]; 
    membershipOrganizationNamePropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *membershipRenewDatePropertyDef = [membershipDef propertyDefinitionWithName:@"renewDate"];
	membershipRenewDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                               datePickerMode:UIDatePickerModeDate 
                                                                displayDatePickerInDetailView:NO];
    
    SCPropertyDefinition *membershipSincePropertyDef = [membershipDef propertyDefinitionWithName:@"memberSince"];
	membershipSincePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                           datePickerMode:UIDatePickerModeDate 
                                                            displayDatePickerInDetailView:NO]; 
    
    SCPropertyDefinition *membershipDescPropertyDef = [membershipDef propertyDefinitionWithName:@"desc"];
    //override the auto title generation for the membership desc property definition and set it to description
    membershipDescPropertyDef.title=@"Description";
    
    
    membershipDescPropertyDef.type=SCPropertyTypeTextView;
    //Create a class definition for Degree entity
	SCClassDefinition *licenseNumberDef = [SCClassDefinition definitionWithEntityName:@"LicenseNumberEntity" 
                                                             withManagedObjectContext:managedObjectContext
                                                                    withPropertyNames:[NSArray arrayWithObjects:@"licenseName",@"licenseNumber",@"status",
                                                                                       @"renewDate",@"notes", nil]];
    
    
    //set the order attributes name defined in the License Number Entity    
    licenseNumberDef.orderAttributeName=@"order";
    SCPropertyDefinition *licenseNumberRenewDatePropertyDef = [licenseNumberDef propertyDefinitionWithName:@"renewDate"];
	licenseNumberRenewDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                                  datePickerMode:UIDatePickerModeDate 
                                                                   displayDatePickerInDetailView:NO];
    
    
    
    //Create a class definition for License entity
	SCClassDefinition *licenseDef = [SCClassDefinition definitionWithEntityName:@"LicenseEntity" 
													   withManagedObjectContext:managedObjectContext
															  withPropertyNames:[NSArray arrayWithObjects:@"title",@"governingBody",
																				 @"country",@"notes",nil]];
	
	
        //set the order attributes name defined in the License Entity
    licenseDef.orderAttributeName=@"order";
    SCPropertyDefinition *licenseNamePropertyDef = [licenseNumberDef propertyDefinitionWithName:@"licenseName"];
    
    //override the auto title generation for the License Name property definition and set it to a shorter title
    licenseNamePropertyDef.title =@"License";
	//override the auto title generation for the <#name#> property definition and set it to a custom title
    licenseNamePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *licenseSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:licenseDef allowMultipleSelection:NO allowNoSelection:NO];
    licenseSelectionAttribs.allowAddingItems = YES;
    licenseSelectionAttribs.allowDeletingItems = YES;
    licenseSelectionAttribs.allowMovingItems = YES;
    licenseSelectionAttribs.allowEditingItems = YES;
    licenseSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Define licenses)"];
    licenseSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new License"];
    licenseNamePropertyDef.attributes = licenseSelectionAttribs;
	
    licenseNumberDef.titlePropertyName=@"licenseName.title";
    
    SCPropertyDefinition *licenseNumberNotesPropertyDef = [licenseNumberDef propertyDefinitionWithName:@"notes"];
	licenseNumberNotesPropertyDef.type = SCPropertyTypeTextView;
    
    SCPropertyDefinition *licenseNotesPropertyDef = [licenseDef propertyDefinitionWithName:@"notes"];
	licenseNotesPropertyDef.type = SCPropertyTypeTextView;
    
    SCPropertyDefinition *licenseTitlePropertyDef = [licenseDef propertyDefinitionWithName:@"title"];
	licenseTitlePropertyDef.type = SCPropertyTypeTextView;
    
    
    
    //Create a class definition for Certification entity
	SCClassDefinition *certificationDef = [SCClassDefinition definitionWithEntityName:@"CertificationEntity" 
															 withManagedObjectContext:managedObjectContext
																	withPropertyNames:[NSArray arrayWithObjects:@"certificationName",@"certifiedBy",@"completeDate",@"notes",
																					   nil]];	
    //set the order attributes name defined in the Certification Entity	
    certificationDef.orderAttributeName=@"order";
    
    //Create a class definition for Certification entity
	SCClassDefinition *certificationNameDef = [SCClassDefinition definitionWithEntityName:@"CertificationNameEntity" 
                                                                 withManagedObjectContext:managedObjectContext
                                                                        withPropertyNames:[NSArray arrayWithObjects:@"certName",@"desc",
                                                                                           nil]];	
    
    //set the order attributes name defined in the Certification Name Entity
    certificationNameDef.orderAttributeName=@"order";
    
    //Create a class definition for Certification Authority entity
	SCClassDefinition *certificationAuthorityDef = [SCClassDefinition definitionWithEntityName:@"CertificationAuthorityEntity" 
                                                                      withManagedObjectContext:managedObjectContext
                                                                             withPropertyNames:[NSArray arrayWithObjects:@"certAuthority",@"notes",
                                                                                                nil]];	
 
    //set the order attributes name defined in the Certification Authority Entity
    certificationAuthorityDef.orderAttributeName=@"order";
   
    //Do some property definition customization for the Certification Entity
    SCPropertyDefinition *certNotesPropertyDef = [certificationDef propertyDefinitionWithName:@"notes"];
	
	certNotesPropertyDef.type = SCPropertyTypeTextView;	
	
    SCPropertyDefinition *certCompletewDatePropertyDef = [certificationDef propertyDefinitionWithName:@"completeDate"];
	certCompletewDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                             datePickerMode:UIDatePickerModeDate 
                                                              displayDatePickerInDetailView:NO];
    
    
    certificationDef.titlePropertyName=@"certificationName.certName";
    SCPropertyDefinition *certificationNamePropertyDef = [certificationDef propertyDefinitionWithName:@"certificationName"];
    certificationNamePropertyDef.title =@"Certification";
	certificationNamePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *certSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:certificationNameDef allowMultipleSelection:NO allowNoSelection:NO];
    certSelectionAttribs.allowAddingItems = YES;
    certSelectionAttribs.allowDeletingItems = YES;
    certSelectionAttribs.allowMovingItems = YES;
    certSelectionAttribs.allowEditingItems = YES;
    certSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Define Certiifications)"];
    certSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new certification"];
    certificationNamePropertyDef.attributes = certSelectionAttribs;
	
    
    
    SCPropertyDefinition *certNameDescPropertyDef = [certificationNameDef propertyDefinitionWithName:@"desc"];
    certNameDescPropertyDef.title=@"Description";
	certNameDescPropertyDef.type = SCPropertyTypeTextView;
    SCPropertyDefinition *certNamePropertyDef = [certificationNameDef propertyDefinitionWithName:@"certName"];
    
	certNamePropertyDef.type = SCPropertyTypeTextView;
    
    SCPropertyDefinition *certificationAuthorityPropertyDef = [certificationDef propertyDefinitionWithName:@"certifiedBy"];
    
	certificationAuthorityPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *certAuthoritySelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:certificationAuthorityDef allowMultipleSelection:NO allowNoSelection:NO];
    certAuthoritySelectionAttribs.allowAddingItems = YES;
    certAuthoritySelectionAttribs.allowDeletingItems = YES;
    certAuthoritySelectionAttribs.allowMovingItems = YES;
    certAuthoritySelectionAttribs.allowEditingItems = YES;
    certAuthoritySelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Define Certifying Authorities)"];
    certAuthoritySelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new cert authority"];
    certificationAuthorityPropertyDef.attributes = certAuthoritySelectionAttribs;
	
    
    
    SCPropertyDefinition *certAuthNotesPropertyDef = [certificationAuthorityDef propertyDefinitionWithName:@"notes"];
    
	certAuthNotesPropertyDef.type = SCPropertyTypeTextView;
    SCPropertyDefinition *certAuthorityPropertyDef = [certificationAuthorityDef propertyDefinitionWithName:@"certAuthority"];
    
	certAuthorityPropertyDef.type = SCPropertyTypeTextView;
    
    
    
	//Create a class definition for Specialty entity
	SCClassDefinition *specialtyDef = [SCClassDefinition definitionWithEntityName:@"SpecialtyEntity" 
														 withManagedObjectContext:managedObjectContext
																withPropertyNames:[NSArray arrayWithObjects: @"specialty", @"startDate",@"notes",
																				   nil]];	
	
    
    //set the order attributes name defined in the Specialty Entity
    specialtyDef.orderAttributeName=@"order";
    SCPropertyDefinition *specialtyStartDatePropertyDef = [specialtyDef propertyDefinitionWithName:@"startDate"];
	specialtyStartDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                              datePickerMode:UIDatePickerModeDate 
                                                               displayDatePickerInDetailView:NO];
    
    
    SCClassDefinition *specialtyNameDef = [SCClassDefinition definitionWithEntityName:@"SpecialtyNameEntity" 
                                                             withManagedObjectContext:managedObjectContext
                                                                    withPropertyNames:[NSArray arrayWithObjects: @"specialtyName",@"desc",
                                                                                       nil]];	
    
    //set the order attributes name defined in the Specialty Name Entity
    specialtyNameDef.orderAttributeName=@"order";
    //Do some property definition customization for the Specialty Entity
	
    
    SCPropertyDefinition *specialtyPropertyDef = [specialtyDef propertyDefinitionWithName:@"specialty"];
    
    specialtyDef.titlePropertyName=@"specialty.specialtyName";
	specialtyPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *specialtySelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:specialtyNameDef allowMultipleSelection:NO allowNoSelection:NO];
    specialtySelectionAttribs.allowAddingItems = YES;
    specialtySelectionAttribs.allowDeletingItems = YES;
    specialtySelectionAttribs.allowMovingItems = YES;
    specialtySelectionAttribs.allowEditingItems = YES;
    specialtySelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Define specialties)"];
    specialtySelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new specialty"];
    specialtyPropertyDef.attributes = specialtySelectionAttribs;
	
    
    SCPropertyDefinition *specialtyNotesPropertyDef = [specialtyDef propertyDefinitionWithName:@"notes"];
    specialtyNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *specialtyNamePropertyDef = [specialtyNameDef propertyDefinitionWithName:@"specialtyName"];
    specialtyNamePropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *specialtyNameDescPropertyDef = [specialtyNameDef propertyDefinitionWithName:@"desc"];
	
    //override the auto title generation for the specialtyNameDesc property definition and set it to a Description
    specialtyNameDescPropertyDef.title = @"Description";
	specialtyNameDescPropertyDef.type = SCPropertyTypeTextView;	
	
	
    
    
    //Create a class definition for Publication entity
	SCClassDefinition *publicationDef = [SCClassDefinition definitionWithEntityName:@"PublicationEntity" 
                                                           withManagedObjectContext:managedObjectContext
                                                                  withPropertyNames:[NSArray arrayWithObjects:@"publicationTitle",@"authors",@"datePublished", @"publisher",@"volume", @"pageNumbers",@"publicationType",@"notes",
                                                                                     nil]];
    
    //set the order attributes name defined in the Publication Entity    
    publicationDef.orderAttributeName=@"order";
    publicationDef.titlePropertyName=@"publicationTitle;datePublished";
    SCClassDefinition *publicationTypeDef = [SCClassDefinition definitionWithEntityName:@"PublicationTypeEntity" 
                                                               withManagedObjectContext:managedObjectContext
                                                                      withPropertyNames:[NSArray arrayWithObjects: @"publicationType",
                                                                                         nil]];
    
    
    //set the order attributes name defined in the Publication Type Entity      
    publicationTypeDef.orderAttributeName=@"order";
    SCPropertyDefinition *publicationTypePropertyDef = [publicationDef propertyDefinitionWithName:@"publicationType"];
    
	publicationTypePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *publicationSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:publicationTypeDef allowMultipleSelection:NO allowNoSelection:NO];
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
    
    SCPropertyDefinition *publicationTitlePropertyDef = [publicationDef propertyDefinitionWithName:@"publicationTitle"];
	
	publicationTitlePropertyDef.type = SCPropertyTypeTextView;	
    SCPropertyDefinition *publicationAuthorsPropertyDef = [publicationDef propertyDefinitionWithName:@"authors"];
	
	publicationAuthorsPropertyDef.type = SCPropertyTypeTextView;	
    
    SCPropertyDefinition *publicationPublisherPropertyDef = [publicationDef propertyDefinitionWithName:@"publisher"];
	
	publicationPublisherPropertyDef.type = SCPropertyTypeTextView;	
    
    SCPropertyDefinition *publicationNotesPropertyDef = [publicationDef propertyDefinitionWithName:@"notes"];
	
	publicationNotesPropertyDef.type = SCPropertyTypeTextView;	
    
    
    //Create a class definition for Orientation History entity
	SCClassDefinition *orientationHistoryDef = [SCClassDefinition definitionWithEntityName:@"OrientationHistoryEntity" 
                                                                  withManagedObjectContext:managedObjectContext
                                                                         withPropertyNames:[NSArray arrayWithObjects:@"orientation",@"dateAdopted",@"endDate", @"notes",
                                                                                            nil]];
    
    //set the order attributes name defined in the (theoretical)Orientation Entity  
    orientationHistoryDef.orderAttributeName=@"order";
    //Create a class definition for Orientation entity
    SCClassDefinition *orientationDef = [SCClassDefinition definitionWithEntityName:@"OrientationEntity" 
                                                           withManagedObjectContext:managedObjectContext
                                                                  withPropertyNames:[NSArray arrayWithObjects: @"orientation", @"desc",
                                                                                     nil]];
    
    //set the order attributes name defined in the Orientation Entity  
    orientationDef.orderAttributeName=@"order";
    orientationHistoryDef.titlePropertyName=@"orientation.orientation";
    SCPropertyDefinition *orientationPropertyDef = [orientationHistoryDef propertyDefinitionWithName:@"orientation"];
    
	orientationPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *orientationSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:orientationDef allowMultipleSelection:NO allowNoSelection:NO];
    orientationSelectionAttribs.allowAddingItems = YES;
    orientationSelectionAttribs.allowDeletingItems = YES;
    orientationSelectionAttribs.allowMovingItems = YES;
    orientationSelectionAttribs.allowEditingItems = YES;
    orientationSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Define theoretical orientations)"];
    orientationSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new theoretical orientation"];
    orientationPropertyDef.attributes = orientationSelectionAttribs;
    
    SCPropertyDefinition *orientationStartDatePropertyDef = [orientationHistoryDef propertyDefinitionWithName:@"dateAdopted"];
	orientationStartDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                                datePickerMode:UIDatePickerModeDate 
                                                                 displayDatePickerInDetailView:NO];
    
    SCPropertyDefinition *orientationEndDatePropertyDef = [orientationHistoryDef propertyDefinitionWithName:@"endDate"];
	orientationEndDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                              datePickerMode:UIDatePickerModeDate 
                                                               displayDatePickerInDetailView:NO];
    SCPropertyDefinition *orientationNamePropertyDef = [orientationDef propertyDefinitionWithName:@"orientation"];
    orientationNamePropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *orientationHistoryNotesPropertyDef = [orientationHistoryDef propertyDefinitionWithName:@"notes"];
    orientationHistoryNotesPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *orientationDescPropertyDef = [orientationDef propertyDefinitionWithName:@"desc"];
    orientationDescPropertyDef.type=SCPropertyTypeTextView;
    
    orientationDescPropertyDef.title=@"Description";
     
//    /****************************************************************************************/
//    /*	BEGIN Class Definition and attributes for the Client Entity */
//    /****************************************************************************************/ 
//
//   //get the client setup from the clients View Controller Shared
//    
//    ClientsViewController_Shared *clientsViewController_Shared =[[ClientsViewController_Shared alloc]init];
//    
//    [clientsViewController_Shared setupTheClientsViewModelUsingSTV];  
//
//    /****************************************************************************************/
//    /*	END of Class Definition and attributes for the Client Entity */
//    /****************************************************************************************/
//    /*the client def will be used in the joined referral table */

 
    /****************************************************************************************/
    /*	Begin Class Definition and attributes for the Referral Entity */
    /****************************************************************************************/ 
    /* one clinician can have many client referrals */
    
    //Create a class definition for ReferralEntity to track the referrals
    SCClassDefinition *referralDef = [SCClassDefinition definitionWithEntityName:@"ReferralEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"client",@"referralDate",@"referralInOrOut", @"notes", nil]];
    
    //Do some property definition customization for the referralDef Entity
    
    NSInteger indexOfClientProperty=(NSInteger )[referralDef indexOfPropertyDefinitionWithName:@"client"];
    [referralDef removePropertyDefinitionAtIndex:indexOfClientProperty];
    
    
    /****************************************************************************************/
    /*	BEGIN Class Definition and attributes for the Client Entity */
    /****************************************************************************************/ 
    
    //get the client setup from the clients View Controller Shared
    // Add a custom property that represents a custom cells for the description defined TextFieldAndLableCell.xib
	
    //create the dictionary with the data bindings
    NSDictionary *clientDataBindings = [NSDictionary 
                                        dictionaryWithObjects:[NSArray arrayWithObject:@"client"] 
                                        forKeys:[NSArray arrayWithObject:@"1" ]]; // 1 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *clientDataProperty = [SCCustomPropertyDefinition definitionWithName:@"CLientData"
                                                                                 withuiElementClass:[ClientsSelectionCell class] withObjectBindings:clientDataBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    clientDataProperty.autoValidate=FALSE;
    
    
    
    
    
    /****************************************************************************************/
    /*	END of Class Definition and attributes for the Client Entity */
    /****************************************************************************************/
    
    //insert the custom property definition into the clientData class at index 
    [referralDef insertPropertyDefinition:clientDataProperty atIndex:0];
    

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
    
    NSDictionary *encryReferralNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyDate",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
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
//    //set the property definition type to objects selection
//	clientReferredPropertyDef.type = SCPropertyTypeObjectSelection;
//    SCObjectSelectionAttributes *clientReferredSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:clientsViewController_Shared.clientDef allowMultipleSelection:NO allowNoSelection:NO];
//    
//    //set some addtional attributes                                             
//    clientReferredSelectionAttribs.allowAddingItems = YES;
//    clientReferredSelectionAttribs.allowDeletingItems = NO;
//    clientReferredSelectionAttribs.allowMovingItems = YES;
//    clientReferredSelectionAttribs.allowEditingItems = YES;
//
//    
// 
//    //add an "Add New" element to appear when user clicks edit
//    clientReferredSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Client"];
//    
//    //add the selection attributes to the property definition
//    clientReferredPropertyDef.attributes = clientReferredSelectionAttribs;
    
    /****************************************************************************************/
    /*	END of Class Definition and attributes for the Referral Entity */
    /****************************************************************************************/
       
    /****************************************************************************************/
    /*	BEGIN Class Definition and attributes for the Clinician Entity */
    /****************************************************************************************/ 
    
    //Create a class definition for clinician entity
	self.clinicianDef = [SCClassDefinition definitionWithEntityName:@"ClinicianEntity" 
                                                         withManagedObjectContext:managedObjectContext 
                                                                withPropertyNames:[NSArray arrayWithObjects: @"degrees", 
                                                                                   @"licenseNumbers", @"certifications",@"specialties",@"publications",@"orientationHistory",@"awards",@"memberships",@"influences",@"employments",
                                                                                   @"demographicInfo",@"startedPracticing",@"clinicianType", @"atMyCurrentSite",  @"myCurrentSupervisor",@"myPastSupervisor",@"referrals",@"isPrescriber",@"logs",@"bio",@"notes", nil]];
	
    
    
    self.clinicianDef.titlePropertyName = @"firstName;lastName";	
    self.clinicianDef.keyPropertyName = @"lastName";
   	self.clinicianDef.orderAttributeName = @"order";
    
   
    
    
    
    
    NSDictionary *titleDataBindings = [NSDictionary 
                                       dictionaryWithObjects:[NSArray arrayWithObject:@"prefix"] 
                                       forKeys:[NSArray arrayWithObject:@"34"]]; // 1 & 2 are the control tags
	SCCustomPropertyDefinition *titleDataProperty = [SCCustomPropertyDefinition definitionWithName:@"TitleData"
                                                                              withuiElementNibName:shortFieldCellNibName 
                                                                                withObjectBindings:titleDataBindings];
	
    
    
    
    titleDataProperty.autoValidate=FALSE;
    [self.clinicianDef insertPropertyDefinition:titleDataProperty atIndex:0];
    
    
   
    NSDictionary *firstNameDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObject:@"firstName"] 
                                           forKeys:[NSArray arrayWithObject:@"50"]]; // 1 & 2 are the control tags
	SCCustomPropertyDefinition *firstNameDataProperty = [SCCustomPropertyDefinition definitionWithName:@"FirstNameData"
                                                                                  withuiElementNibName:textFieldAndLableNibName 
                                                                                    withObjectBindings:firstNameDataBindings];
	
    
    
    firstNameDataProperty.autoValidate=FALSE;
    [self.clinicianDef insertPropertyDefinition:firstNameDataProperty atIndex:1];
    
    
    
    
    NSDictionary *middleNameDataBindings = [NSDictionary 
                                            dictionaryWithObjects:[NSArray arrayWithObject:@"middleName"] 
                                            forKeys:[NSArray arrayWithObject:@"50"]]; // 1 & 2 are the control tags
	
    
    SCCustomPropertyDefinition *middleNameDataProperty = [SCCustomPropertyDefinition definitionWithName:@"MiddleNameData"
                                                                                   withuiElementNibName:textFieldAndLableNibName 
                                                                                     withObjectBindings:middleNameDataBindings];
	
    
    
    
    middleNameDataProperty.autoValidate=FALSE;
    [self.clinicianDef insertPropertyDefinition:middleNameDataProperty atIndex:2];
    
    
    
    
    
    NSDictionary *lastNameDataBindings = [NSDictionary 
                                          dictionaryWithObjects:[NSArray arrayWithObject:@"lastName"] 
                                          forKeys:[NSArray arrayWithObject:@"50"]]; // 1 & 2 are the control tags
	SCCustomPropertyDefinition *lastNameDataProperty = [SCCustomPropertyDefinition definitionWithName:@"LastNameData"
                                                                                 withuiElementNibName:textFieldAndLableNibName 
                                                                                   withObjectBindings:lastNameDataBindings];
	
    
    
    lastNameDataProperty.autoValidate=FALSE;
    
    
    [self.clinicianDef insertPropertyDefinition:lastNameDataProperty atIndex:3];
    
    
    NSDictionary *suffixDataBindings = [NSDictionary 
                                        dictionaryWithObjects:[NSArray arrayWithObject:@"suffix"] 
                                        forKeys:[NSArray arrayWithObject:@"34"]]; // 1 & 2 are the control tags
	SCCustomPropertyDefinition *suffixDataProperty = [SCCustomPropertyDefinition definitionWithName:@"SuffixData"
                                                                               withuiElementNibName:shortFieldCellNibName 
                                                                                 withObjectBindings:suffixDataBindings];
	
    
    
    suffixDataProperty.autoValidate=FALSE;
    [self.clinicianDef insertPropertyDefinition:suffixDataProperty atIndex:4];
    
    
    NSDictionary *credentialInitialsDataBindings = [NSDictionary 
                                                    dictionaryWithObjects:[NSArray arrayWithObject:@"credentialInitials"] 
                                                    forKeys:[NSArray arrayWithObject:@"50"]]; // 1 & 2 are the control tags
	
    
    SCCustomPropertyDefinition *credentialInitialsDataProperty = [SCCustomPropertyDefinition definitionWithName:@"CredentialInitialsData"
                                                                                           withuiElementNibName:textFieldAndLableNibName 
                                                                                             withObjectBindings:credentialInitialsDataBindings];
	
    
    
    credentialInitialsDataProperty.autoValidate=FALSE;
    
    [self.clinicianDef insertPropertyDefinition:credentialInitialsDataProperty atIndex:5];
    
    //Create a class definition for the cliniciantypeEntity
    SCClassDefinition *clinicianTypeDef = [SCClassDefinition definitionWithEntityName:@"ClinicianTypeEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"clinicianType", nil]];
    
    //Do some property definition customization for the clinician Type Entity defined in clinicianTypeDef
    
    
    
    SCPropertyDefinition *clinicianTypePropertyDef = [self.clinicianDef propertyDefinitionWithName:@"clinicianType"];
	
    
    clinicianTypePropertyDef.type = SCPropertyTypeObjectSelection;
    
   
    
    SCObjectSelectionAttributes *clinicianTypeSelectionAttributes=[[SCObjectSelectionAttributes alloc]initWithItemsEntityClassDefinition:clinicianTypeDef allowMultipleSelection:YES allowNoSelection:YES];
    
    clinicianTypeSelectionAttributes.allowAddingItems=YES;
    clinicianTypeSelectionAttributes.allowDeletingItems=YES;
    clinicianTypeSelectionAttributes.allowMovingItems=YES;
    clinicianTypeSelectionAttributes.allowEditingItems=YES;
    clinicianTypeSelectionAttributes.allowMultipleSelection=YES;
    clinicianTypeSelectionAttributes.allowNoSelection=YES;
    
    clinicianTypeSelectionAttributes.placeholderuiElement = [SCTableViewCell cellWithText:@"(Add Clinician Type Definitions)"];
    clinicianTypeSelectionAttributes.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Clinician Type Definition"];
    clinicianTypePropertyDef.attributes = clinicianTypeSelectionAttributes; 
    
    clinicianTypeDef.orderAttributeName=@"order";
//	clinicianTypePropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Licensed Psychologist",@"Licensed Psychiatrist", @"(PCP) Primary Care Physician", @"Other Medical Specialist", @"Nurse Practicioner or Physician's Assistant",@"Other Licenesed (BHP) Behavioral Health Professional", @"Psychology Intern",@"Medical Intern", @"Unlicenced PsyD or PhD",@"Unlicensed M.D. or D.O.",  @"Other Unlicensed Master's Level", @"Practicum Student",@"Paraprofessional",nil] 
//                                                              allowMultipleSelection:NO
//                                                                    allowNoSelection:NO
//                                                               autoDismissDetailView:YES hideDetailViewNavigationBar:NO];
    //Do some property definition customization for the clinician Class
    //create an array of objects definition for the referrals to-many relationship that with show up in a different view with a place holder element>.
    
    //Create the property definition for the referrals property
 SCPropertyDefinition *clinicianReferralsPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"referrals"];
    clinicianReferralsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:referralDef
                                                                                  allowAddingItems:TRUE
                                                                                 allowDeletingItems:TRUE
                                                                                    allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
    
    SCPropertyDefinition *degreesPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"degrees"];
	degreesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:degreeDef
																				   allowAddingItems:TRUE
																				 allowDeletingItems:TRUE
																				   allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];
	
    
    
    SCPropertyDefinition *publicationsPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"publications"];
	publicationsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:publicationDef
                                                                                        allowAddingItems:TRUE
                                                                                      allowDeletingItems:TRUE
                                                                                        allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];
    
    
    
    SCPropertyDefinition *awardsPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"awards"];
	awardsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:awardDef
                                                                                  allowAddingItems:TRUE
                                                                                allowDeletingItems:TRUE
                                                                                  allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
    SCPropertyDefinition *licenseNumbersPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"licenseNumbers"];
	licenseNumbersPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:licenseNumberDef
                                                                                          allowAddingItems:TRUE
                                                                                        allowDeletingItems:TRUE
                                                                                          allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];
    licenseNumbersPropertyDef.title=@"Licenses";
    
    
    SCPropertyDefinition *orientationHistoryPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"orientationHistory"];
	orientationHistoryPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:orientationHistoryDef
                                                                                              allowAddingItems:TRUE
                                                                                            allowDeletingItems:TRUE
                                                                                              allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];
    
    //override the auto title generation for the (theroetical) orientation History property definition and set it to a custom title
    orientationHistoryPropertyDef.title=@"Theoretical Orientation Hx";
    
    
    
    SCPropertyDefinition *membershipsPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"memberships"];
	membershipsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:membershipDef
                                                                                       allowAddingItems:TRUE
                                                                                     allowDeletingItems:TRUE
                                                                                       allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
   
    
    
    SCPropertyDefinition *influencesPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"influences"];
	influencesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:influenceDef
                                                                                      allowAddingItems:TRUE
                                                                                    allowDeletingItems:TRUE
                                                                                      allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
    SCPropertyDefinition *employmentPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"employments"];
	employmentPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:employmentDef
                                                                                      allowAddingItems:TRUE
                                                                                    allowDeletingItems:TRUE
                                                                                      allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];
	//override the auto title generation for the employment property definition and set it to a custom title
    employmentPropertyDef.title=@"Employment History";
    
    
    
    //Begin Contact Information
    
    
    
    
    /*
    
    //Create the class definitions for contactInformation Entity
    SCClassDefinition *contactInformationDef = [SCClassDefinition definitionWithEntityName:@"ContactInformationEntity" 
                                                                  withManagedObjectContext:managedObjectContext
                                                                         withPropertyNames:[NSArray arrayWithObjects:@"addresses", @"phoneNumbers",@"emailAddresses", nil]];	
    
    
    //Create link to Addressbook
    
    
    SCCustomPropertyDefinition *linkToAddressBookButtonProperty = [SCCustomPropertyDefinition definitionWithName:@"LinkToAddressBookButton" withuiElementClass:[ButtonCell class] withObjectBindings:nil];
    [contactInformationDef addPropertyDefinition:linkToAddressBookButtonProperty];                                                         
    
    
    SCCustomPropertyDefinition *addOrEditContactInAddressbookButtonProperty = [SCCustomPropertyDefinition definitionWithName:@"AddOrEditAddressBookButton" withuiElementClass:[ButtonCell class] withObjectBindings:nil];
    [contactInformationDef addPropertyDefinition:addOrEditContactInAddressbookButtonProperty];  
    
    
    SCCustomPropertyDefinition *viewPersonABBookButtonProperty = [SCCustomPropertyDefinition definitionWithName:@"ViewPersonABButton" withuiElementClass:[ButtonCell class] withObjectBindings:nil];
    [contactInformationDef addPropertyDefinition:viewPersonABBookButtonProperty]; 
    
    SCPropertyGroup *contactInformationpsyTrackGroup =[SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"addresses", @"phoneNumbers",@"emailAddresses", nil]];
    
    SCPropertyGroup *contactInformationAddressbookButtonsGroup =[SCPropertyGroup groupWithHeaderTitle:@"Addressbook Connection" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"LinkToAddressBookButton",@"AddOrEditAddressBookButton",@"ViewPersonABButton", nil ]];
    
    [contactInformationDef.propertyGroups addGroup:contactInformationpsyTrackGroup];
    [contactInformationDef.propertyGroups addGroup:contactInformationAddressbookButtonsGroup];
    
    //Create the class definition for Phone Entity
    SCClassDefinition *phoneDef = [SCClassDefinition definitionWithEntityName:@"PhoneEntity" 
													 withManagedObjectContext:managedObjectContext
															withPropertyNames:[NSArray arrayWithObjects:@"phoneName",@"phoneNumber",
																			   @"extention",@"privatePhone",
                                                                               
                                                                               nil]];	
    
    //set the phone order attribute name
    phoneDef.orderAttributeName=@"order";
    
    //Create a class definition for Address entity
	SCClassDefinition *addressDef = [SCClassDefinition definitionWithEntityName:@"AddressEntity" 
													   withManagedObjectContext:managedObjectContext															
                                                              withPropertyNames:[NSArray arrayWithObjects:@"addressName",@"postOfficeBox",@"streeetAddressOne",@"streetAddressTwo",										 @"city",@"stateOrProvince",@"country",@"zipCode",@"notes",	@"privateAddress",													  nil]];	
	
    
    //set the addressDef order attribute name
    addressDef.orderAttributeName=@"order";
    
    //Create a class definition for Email Entity
	SCClassDefinition *emailDef = [SCClassDefinition definitionWithEntityName:@"EmailEntity" 
													 withManagedObjectContext:managedObjectContext
															withPropertyNames:[NSArray arrayWithObject:@"privateEmail"]];
    
    //set the emailDef order attribute Name
    emailDef.orderAttributeName=@"order";
    
    //set the emailDef title property name to the description and the email address so it shows up in the list of email addresses
	emailDef.titlePropertyName = @"desc;emailAddress";
    
    
    
    //Do some property definition customization for the Phone Entity	
    
    
    //create the phone name selection cell
    SCPropertyDefinition *phoneNamePropertyDef = [phoneDef propertyDefinitionWithName:@"phoneName"];
	
    phoneNamePropertyDef.type = SCPropertyTypeSelection;
	phoneNamePropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Cabin",@"Cell",@"Home", @"Home2", @"School", @"Work",@"Other",nil] 
                                                          allowMultipleSelection:NO allowNoSelection:NO autoDismissDetailView:YES hideDetailViewNavigationBar:NO];
    
    
    //do some customizing of the phone number title, change it to "Number" to make it shorter
    SCPropertyDefinition *phoneNumberPropertyDef = [phoneDef propertyDefinitionWithName:@"phoneNumber"];
    phoneNumberPropertyDef.title = @"Number";
    
    phoneDef.titlePropertyName=@"phoneName;phoneNumber";
	
    SCCustomPropertyDefinition *callButtonProperty = [SCCustomPropertyDefinition definitionWithName:@"CallButton" withuiElementClass:[ButtonCell class] withObjectBindings:nil];
    [phoneDef insertPropertyDefinition:callButtonProperty atIndex:3];
    SCPropertyGroup *phoneGroup = [SCPropertyGroup groupWithHeaderTitle:@"Phone Number" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"phoneName",@"phoneNumber",@"extention",@"privatePhone", @"CallButton", nil]];
    
    // add the phone property group
    [phoneDef.propertyGroups addGroup:phoneGroup];
    
    
    
    //Do some property definition customization for the Address Entity
	
    
    SCPropertyDefinition *addressNamePropertyDef = [addressDef propertyDefinitionWithName:@"addressName"];
	addressNamePropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *streeetAddressOnePropertyDef = [addressDef propertyDefinitionWithName:@"streeetAddressOne"];
    //override the auto title generation for the streeetAddressOne property definition and set it to a custom title
    streeetAddressOnePropertyDef.title = @"Street 1";
	streeetAddressOnePropertyDef.type = SCPropertyTypeTextView;	
	
   
    SCPropertyDefinition *streeetAddressTwoPropertyDef = [addressDef propertyDefinitionWithName:@"streetAddressTwo"];
	 //override the auto title generation for the streetAddressTwo property definition and set it to a custom title
    streeetAddressTwoPropertyDef.title = @"Street 2";
	streeetAddressTwoPropertyDef.type = SCPropertyTypeTextView;	
	
    SCPropertyDefinition *postOfficeBoxPropertyDef = [addressDef propertyDefinitionWithName:@"postOfficeBox"];
	
    //override the auto title generation for the postOfficeBox property definition and set it to a custom title
    postOfficeBoxPropertyDef.title = @"P.O. Box";
	
	SCPropertyDefinition *stateOrProvicePropertyDef = [addressDef propertyDefinitionWithName:@"stateOrProvince"];
	stateOrProvicePropertyDef.title = @"State/Province";
	stateOrProvicePropertyDef.type=SCPropertyTypeTextView;
	SCPropertyDefinition *zipCodePropertyDef = [addressDef propertyDefinitionWithName:@"zipCode"];
	
    zipCodePropertyDef.autoValidate=FALSE;
    
    SCPropertyDefinition *addressNotesPropertyDef = [addressDef propertyDefinitionWithName:@"notes"];
    addressNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *addressesPropertyDef = [contactInformationDef propertyDefinitionWithName:@"addresses"];
	addressesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:addressDef
																					 allowAddingItems:TRUE
																				   allowDeletingItems:TRUE
																					 allowMovingItems:FALSE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Addresses)"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
	
    
    
    // Add a custom property that represents a custom cells for the email address and description defined TextFieldAndLableCell.xib
	
    
    NSDictionary *emailDescBindings = [NSDictionary 
                                       dictionaryWithObjects:[NSArray arrayWithObject:@"desc"] 
                                       forKeys:[NSArray arrayWithObjects:@"50", nil]]; // 1,2,3 are the control tags
	SCCustomPropertyDefinition *emailDescDataProperty = [SCCustomPropertyDefinition definitionWithName:@"EmailDescData"
                                                                                  withuiElementNibName:textFieldAndLableNibName 
                                                                                    withObjectBindings:emailDescBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    emailDescDataProperty.autoValidate=FALSE;
    
    
    
    [emailDef insertPropertyDefinition:emailDescDataProperty atIndex:0];
    
    NSDictionary *emailAddressBindings = [NSDictionary 
                                          dictionaryWithObjects:[NSArray arrayWithObject:@"emailAddress"] 
                                          forKeys:[NSArray arrayWithObjects:@"50", nil]]; // 1,2,3 are the control tags
	SCCustomPropertyDefinition *emailAddressDataProperty = [SCCustomPropertyDefinition definitionWithName:@"EmailAddressData"
                                                                                     withuiElementNibName:textFieldAndLableNibName 
                                                                                       withObjectBindings:emailAddressBindings];
	
    
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    emailAddressDataProperty.autoValidate=FALSE;
    
    [emailDef insertPropertyDefinition:emailAddressDataProperty atIndex:1]; 
    
    
    NSDictionary *emailSendReportsBindings = [NSDictionary 
                                              dictionaryWithObjects:[NSArray arrayWithObject:@"sendReports"] 
                                              forKeys:[NSArray arrayWithObjects:@"40", nil]]; // 1,2,3 are the control tags
	SCCustomPropertyDefinition *emailSendReportsDataProperty = [SCCustomPropertyDefinition definitionWithName:@"EmailSendReportsData"
                                                                                         withuiElementNibName:switchAndLabelCellName 
                                                                                           withObjectBindings:emailSendReportsBindings];
	
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    emailSendReportsDataProperty.autoValidate=FALSE;
    
    [emailDef insertPropertyDefinition:emailSendReportsDataProperty atIndex:2]; 
    
    
    
    
    
    
    
    
    
    
    
    
    
    SCPropertyDefinition *contactInformationPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"contactInformation"];
    contactInformationPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:contactInformationDef
                                                                                              allowAddingItems:FALSE
                                                                                            allowDeletingItems:FALSE
                                                                                              allowMovingItems:FALSE];
    
    
    
    
    
    
    //end Contact Information
   
    SCPropertyDefinition *employerAddressesPropertyDef = [employerDef propertyDefinitionWithName:@"addresses"];
    employerAddressesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:addressDef
                                                                                             allowAddingItems:TRUE
                                                                                           allowDeletingItems:TRUE
                                                                                             allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"Tap + To Add Addresses"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
    
    SCPropertyDefinition *employerPhoneNumbersPropertyDef = [employerDef propertyDefinitionWithName:@"phoneNumbers"];
    employerPhoneNumbersPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:phoneDef
                                                                                                allowAddingItems:TRUE
                                                                                              allowDeletingItems:TRUE
                                                                                                allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Phone Numbers)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
    
    SCPropertyDefinition *nonClinicalSupAddressesPropertyDef = [nonClinicalSupervisorDef propertyDefinitionWithName:@"addresses"];
    nonClinicalSupAddressesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:addressDef
                                                                                                   allowAddingItems:TRUE
                                                                                                 allowDeletingItems:TRUE
                                                                                                   allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Addresses)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
    
    SCPropertyDefinition *nonClinialSupPhoneNumbersPropertyDef = [nonClinicalSupervisorDef propertyDefinitionWithName:@"phoneNumbers"];
    nonClinialSupPhoneNumbersPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:phoneDef
                                                                                                     allowAddingItems:TRUE
                                                                                                   allowDeletingItems:TRUE
                                                                                                     allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Phone numbers)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
    
    
    
    SCPropertyDefinition *nonClinialSupEmailsPropertyDef = [nonClinicalSupervisorDef propertyDefinitionWithName:@"emailAddresses"];
    nonClinialSupEmailsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:emailDef
                                                                                               allowAddingItems:TRUE
                                                                                             allowDeletingItems:TRUE
                                                                                               allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Email addresses)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
    */
    SCPropertyDefinition *employmentPositionPropertyDef = [employmentDef propertyDefinitionWithName:@"positions"];
    employmentPositionPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:employmentPositionDef
                                                                                              allowAddingItems:TRUE
                                                                                            allowDeletingItems:TRUE
                                                                                              allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Positions)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];	
	SCPropertyDefinition *licensesPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"licenses"];
	licensesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:licenseDef
																					allowAddingItems:TRUE
																				  allowDeletingItems:TRUE
																					allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Licenses)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];
    SCPropertyDefinition *certificationsPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"certifications"];
	certificationsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:certificationDef
																						  allowAddingItems:TRUE
																						allowDeletingItems:TRUE
																						  allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Certifications)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];
	
	SCPropertyDefinition *specialtiesPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"specialties"];
    specialtiesPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:specialtyDef
                                                                                       allowAddingItems:TRUE
                                                                                     allowDeletingItems:TRUE
                                                                                       allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Specialties)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];
	
    SCPropertyDefinition *demographicProfilePropertyDef = [self.clinicianDef propertyDefinitionWithName:@"demographicInfo"];
    demographicProfilePropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:demographicDetailViewController_Shared.demographicProfileDef
                                                                                              allowAddingItems:FALSE
                                                                                            allowDeletingItems:FALSE
                                                                                              allowMovingItems:FALSE];
	
    /*
	SCPropertyDefinition *phoneNumbersPropertyDef = [contactInformationDef propertyDefinitionWithName:@"phoneNumbers"];
	phoneNumbersPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:phoneDef
																						allowAddingItems:TRUE
																					  allowDeletingItems:TRUE
																						allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Phone Numbers)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];
	
	SCPropertyDefinition *emailsPropertyDef = [contactInformationDef propertyDefinitionWithName:@"emailAddresses"];
	emailsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:emailDef
																				  allowAddingItems:TRUE
																				allowDeletingItems:TRUE
																				  allowMovingItems:TRUE expandContentInCurrentView:FALSE placeholderuiElement:[SCTableViewCell cellWithText:@"(Tap + To Add Email addresses)"] addNewObjectuiElement:FALSE addNewObjectuiElementExistsInNormalMode:FALSE addNewObjectuiElementExistsInEditingMode:FALSE];
	
	
    */
    //Create a class definition for the logsEntity
    SCClassDefinition *logDef = [SCClassDefinition definitionWithEntityName:@"LogEntity" 
                                                   withManagedObjectContext:managedObjectContext
                                                          withPropertyNames:[NSArray arrayWithObjects:@"dateTime",
                                                                             @"notes",
                                                                             nil]];
    
    
    SCPropertyDefinition *logsPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"logs"];
    logsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:logDef allowAddingItems:TRUE
                                                                              allowDeletingItems:TRUE
                                                                                allowMovingItems:FALSE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add New Log Entry"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];
    
    //Do some property definition customization for the Log Entity defined in logDef
    
    //do some customizing of the log notes, change it to "Number" to make it shorter
    SCPropertyDefinition *logNotesPropertyDef = [logDef propertyDefinitionWithName:@"notes"];
    
    logNotesPropertyDef.title = @"Notes";
    
    
    logNotesPropertyDef.type=SCPropertyTypeCustom;
    logNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryLogNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyDate",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    logNotesPropertyDef.objectBindings=encryLogNotesTVCellKeyBindingsDic;
    //    phoneNumberPropertyDef.title=@"Phone Number";
    logNotesPropertyDef.autoValidate=NO;
    
    

	SCPropertyDefinition *clinicianNotesPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"notes"];
    
    //override the auto title generation for the notes property definition and set it to blank, it will have the title in the header
    clinicianNotesPropertyDef.title=@"";
        
    
    clinicianNotesPropertyDef.type=SCPropertyTypeCustom;
    clinicianNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryClinicianNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyDate",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    clinicianNotesPropertyDef.objectBindings=encryClinicianNotesTVCellKeyBindingsDic;
    //    phoneNumberPropertyDef.title=@"Phone Number";
    clinicianNotesPropertyDef.autoValidate=NO;

	SCPropertyDefinition *clinicianBioPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"bio"];
    
	clinicianBioPropertyDef.type=SCPropertyTypeTextView;
	SCPropertyDefinition *startedPracticingPropertyDef = [self.clinicianDef propertyDefinitionWithName:@"startedPracticing"];
	startedPracticingPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
																			 datePickerMode:UIDatePickerModeDate 
															  displayDatePickerInDetailView:NO];
    
    
    //create a custom property definition for the addressbook button cell
    SCCustomPropertyDefinition *addressBookRecordButtonProperty = [SCCustomPropertyDefinition definitionWithName:@"addressBookButtonCell" withuiElementClass:[ButtonCell class] withObjectBindings:nil];
    
    //add the property definition to the clinician class 
    [self.clinicianDef addPropertyDefinition:addressBookRecordButtonProperty];
    
    //create a custom property definition for the delete addressbook link button cell
    SCCustomPropertyDefinition *deleteABLinkButtonCellProperty = [SCCustomPropertyDefinition definitionWithName:@"deleteABLinkButtonCell" withuiElementClass:[ButtonCell class] withObjectBindings:nil];
    
    //add the property definition to the clinician class 
    [self.clinicianDef addPropertyDefinition:deleteABLinkButtonCellProperty];
  

    
    SCPropertyGroup *clinicianListPropertiesGroup=[SCPropertyGroup groupWithHeaderTitle:@"Clinician List Properties" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects: @"atMyCurrentSite", @"myCurrentSupervisor",@"myPastSupervisor", nil]];
    
    
    
    
    SCPropertyGroup *credentialssGroup = [SCPropertyGroup groupWithHeaderTitle:@"Credentials" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"clinicianType",@"licenseNumbers", @"degrees", @"certifications",@"isPrescriber",nil]];
    
    SCPropertyGroup *professionalHistoryGroup =[SCPropertyGroup groupWithHeaderTitle:@"Professional History" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"employments",@"publications", @"awards", @"memberships",nil]];
    
    SCPropertyGroup *theoreticalDevelopmentGroup =[SCPropertyGroup groupWithHeaderTitle:@"Theoretical Development" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"specialties",@"influences", @"orientationHistory",nil]];
//    //define a property group
    SCPropertyGroup *clientInteractionGroup = [SCPropertyGroup groupWithHeaderTitle:@"Client Interaction" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"referrals",nil]];
    
    

    
    SCPropertyGroup *notesGroup = [SCPropertyGroup groupWithHeaderTitle:@"Notes" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"notes",@"bio", nil]];
    
    SCPropertyGroup *logsGroup = [SCPropertyGroup groupWithHeaderTitle:@"Logs" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"logs", nil]];
    
    [self.clinicianDef.propertyGroups addGroup:clinicianListPropertiesGroup];
    [self.clinicianDef.propertyGroups addGroup:credentialssGroup];
    [self.clinicianDef.propertyGroups addGroup:professionalHistoryGroup];
    [self.clinicianDef.propertyGroups addGroup:theoreticalDevelopmentGroup];
    // add the client Interaction property group to the clinician class definition. 
    [self.clinicianDef.propertyGroups addGroup:clientInteractionGroup];
    [self.clinicianDef.propertyGroups addGroup:notesGroup];
    [self.clinicianDef.propertyGroups addGroup:logsGroup]; 
//    // Create and add the objects section
//	objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil
//																	withEntityClassDefinition:self.clinicianDef];
//    
//    
//    objectsSection.itemsAccessoryType = UITableViewCellAccessoryNone;
    
    existingPersonRecordID=-1;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reloadTableViewData:)
     name:@"RefetchAllDatabaseData"
     object:nil];
    
    
}


-(IBAction)reloadTableViewData:(id)sender{
    
    //    [self.tableModel reloadBoundValues ];
    [self.tableView reloadData];
    
}
#pragma mark -
#pragma UIView methods
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    return YES;
    
}





#pragma mark -
#pragma mark SCTableViewModelDataSource methods

- (NSString *)tableViewModel:(SCArrayOfItemsModel *)tableViewModel sectionHeaderTitleForItem:(NSObject *)item AtIndex:(NSUInteger)index
{
	// Cast not technically neccessary, done just for clarity
	NSManagedObject *managedObject = (NSManagedObject *)item;
	
	NSString *objectName = (NSString *)[managedObject valueForKey:@"lastName"];
	
	// Return first charcter of objectName
	return [[objectName substringToIndex:1] uppercaseString];
}


#pragma mark -
#pragma SCTableViewModelDelegate methods spcific to traintrack view controller

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    
    [self tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)indexPath.section detailTableViewModel:(SCTableViewModel *)detailTableViewModel];
    
    
    if (tableViewModel.tag==1) {
        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        
        //NSLog(@"cell class is %@",[cell class]);
        
        //NSLog(@"cell tag is %i",cell.tag);
        if (cell.tag==429&&[cell isKindOfClass:[SCObjectSelectionCell class]]) {
            
            
            UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(abGroupsDoneButtonTapped:)];
            
            
            detailTableViewModel.viewController.navigationItem.rightBarButtonItem = doneButton;
            detailTableViewModel.tag=429;
            
        }
        
        
    }
    
    
}


-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)index detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    
   
    if([SCHelper is_iPad]){
        detailTableViewModel.delegate = self;
        detailTableViewModel.tag = tableViewModel.tag+1;
        
        UIView *view=[[UIView alloc]init];
        [view setBackgroundColor:[UIColor clearColor]];
        [detailTableViewModel.modeledTableView setBackgroundView:nil];
        [detailTableViewModel.modeledTableView setBackgroundView:view];
         // Make the table view transparent
    }
    
    
    
}

#pragma mark -
#pragma SCTableViewModelDelegate methods same as clinicianView Controller


- (void)tableViewModel:(SCTableViewModel *) tableViewModel willConfigureCell:(SCTableViewCell *) cell forRowAtIndexPath:(NSIndexPath *) indexPath
{
    
    if (tableViewModel.tag==0) 
    {
        
        cell.backgroundColor=[UIColor whiteColor];
        cell.height= 50;
        
        
        
    }
    if (tableViewModel.tag==1) 
    {
        
        UIView *viewShorterTextLabelView =(UIView *)[cell viewWithTag:35];
        UIView *viewLongerTextLabelView =(UIView *)[cell viewWithTag:51];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        if (cellManagedObject&&[cellManagedObject.entity.name  isEqualToString:@"ClinicianEntity"]) {
     
        
        switch (cell.tag) 
        {
            case 0:
                if ([viewShorterTextLabelView isKindOfClass:[UILabel class]]) 
                {
                    //NSLog(@"prefix");
                    UILabel *titleLabel =(UILabel *)viewShorterTextLabelView;
                    
                    titleLabel.text=@"Prefix:";
                }
                break;
            case 1:
                if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
                {
                    //NSLog(@"first name");
                    
                    UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
                    firstNameLabel.text=@"First Name:";  
                }
                break;
                
            case 2:
                if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
                {
                    //NSLog(@"middle name");
                    
                    UILabel *middleNameLabel =(UILabel *)viewLongerTextLabelView;
                    middleNameLabel.text=@"Middle Name:";
                } 
                break;
                
            case 3:
                if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
                {
                    
                    //NSLog(@"last name");
                    UILabel *lastNameLabel =(UILabel *)viewLongerTextLabelView;
                    lastNameLabel.text=@"Last Name:";
                    
                } 
                break;
            case 4:
                if ([viewShorterTextLabelView isKindOfClass:[UILabel class]]) 
                {
                    
                    //NSLog(@"suffix");
                    UILabel *suffixLabel =(UILabel *)viewShorterTextLabelView;
                    suffixLabel.text=@"Suffix:";
                } 
                break;
                
            case 5:
                if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
                {
                    
                    //NSLog(@"credential Intials");
                    UILabel *credentialInitialsLabel =(UILabel *)viewLongerTextLabelView;
                    credentialInitialsLabel.text=@"Credential Initials:";
                } 
                break;
                
                
            case 8:
                if ([cell  isKindOfClass:[ButtonCell class]]) 
                {
                    
                    
                    
                    
                    
                    int addressBookRecordIdentifier=(int )[(NSNumber *)[cell.boundObject valueForKey:@"aBRecordIdentifier"]intValue]; 
                    
                    //NSLog(@"addressbook identifier is %i",addressBookRecordIdentifier);
                    //NSLog(@"addressbook Identifier %@", cell.boundObject);
                    NSString *buttonText;
                    
                    if (addressBookRecordIdentifier!=-1 && ![self checkIfRecordIDInAddressBook:addressBookRecordIdentifier]) {
                        addressBookRecordIdentifier=-1;
                        [cell.boundObject setValue:[NSNumber numberWithInt:-1 ]forKey:@"aBRecordIdentifier"];
                    }
                    
                    
                    
                    if (addressBookRecordIdentifier!=-1) {
                        buttonText=[NSString stringWithString:@"Edit Address Book Record"];
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    else 
                    {
                        buttonText=[NSString stringWithString:@"Add to Address Book"];
                    }
                    
                    
                    ButtonCell *buttonCell=(ButtonCell *)cell;
                    UIView *view=[buttonCell viewWithTag:300];
                    //NSLog(@"view class is %@",[view.superclass class]);
                    if ([view.superclass isSubclassOfClass:[UIButton class]]) {
                        UIButton *button=(UIButton *)view;
                        [button setTitle:buttonText forState:UIControlStateNormal];
                        [button addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
                        [button setEnabled:[tableViewModel valuesAreValid]];
                        
                    }
                } 
                break;
                
                
            case 9:
                //this is the root table
                
                
            { 
                
                int addressBookRecordIdentifier=(int )[(NSNumber *)[cell.boundObject valueForKey:@"aBRecordIdentifier"]intValue]; 
                
                //NSLog(@"addressbook identifier is %i",addressBookRecordIdentifier);
                //NSLog(@"addressbook Identifier %@", cell.boundObject);
                NSString *buttonText;
                
            
                if (addressBookRecordIdentifier!=-1 && ![self checkIfRecordIDInAddressBook:addressBookRecordIdentifier]) {
                    addressBookRecordIdentifier=-1;
                    [cell.boundObject setValue:[NSNumber numberWithInt:-1 ]forKey:@"aBRecordIdentifier"];
                }
                
                
                
                if (addressBookRecordIdentifier!=-1) {
                    buttonText=[NSString stringWithString:@"Remove Address Book Link"];
                    
                    
                    
                    
                    
                    
                    
                    
                }
                else 
                {
                    buttonText=[NSString stringWithString:@"Look Up In Address Book"];
                }
                
                
                ButtonCell *buttonCell=(ButtonCell *)cell;
                UIView *view=[buttonCell viewWithTag:300];
                //NSLog(@"view class is %@",[view.superclass class]);
                if ([view.superclass isSubclassOfClass:[UIButton class]]) {
                    UIButton *button=(UIButton *)view;
                    [button setTitle:buttonText forState:UIControlStateNormal];
                    [button addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
                    
                    
                }
            }  
                
                break;
           

            default:
                break;
        }
        }
    }
    if (tableViewModel.tag==2) 
    {
        UIView *buttonView =[cell viewWithTag:300];
        if ([buttonView isKindOfClass:[UIButton class]]) 
        {
            UIButton *button=(UIButton *)buttonView;
            [cell setBackgroundColor:[UIColor clearColor]];
            switch (cell.tag) 
            {
                case 0:
                    
                {    
                    //NSLog(@"cell tag is %i",3);
                    [button setTitle:@"Look Up In Address book" forState:UIControlStateNormal];
                    
                    
                }
                    
                    break;
                case 1:
                    
                {    
                    //NSLog(@"cell tag is %i",4);
                    [button setTitle:@"Add Or Edit in Address Book" forState:UIControlStateNormal];
                    
                }
                    
                    break;     
                default:
                    break;
            }
        }
    }

    if (tableViewModel.tag==4) 
    {
        
        
//        UIView *viewOne = [cell viewWithTag:51];
//        UIView *viewSendReports =[cell viewWithTag:40];
        UIView *sliderView = [cell viewWithTag:14];
        UIView *scaleView = [cell viewWithTag:70];
        
        switch (cell.tag) 
        {
//            case 0:
//                
//                if([viewOne isKindOfClass:[UILabel class]])
//                {   
//                    UILabel *emailDesclabel = (UILabel *)viewOne;
//                    emailDesclabel.text=@"Email Description";
//                    
//                }
//                break;
            case 1:
                
//                if ([viewOne isKindOfClass:[UILabel class]]) 
//                {
//                    
//                    UILabel *emailLabel =(UILabel *)viewOne;
//                    emailLabel.text=@"Email Address:";
//                    
//                    UITextField *emailAddressField =(UITextField *)[cell viewWithTag:50];
//                    
//                    emailAddressField.keyboardType=UIKeyboardTypeEmailAddress;
//                    emailAddressField.autocapitalizationType=UITextAutocapitalizationTypeNone;
//                    
//                }
                
                if ([scaleView isKindOfClass:[UISegmentedControl class]]) 
                {
                    
                    UILabel *fluencyLevelLabel =(UILabel *)[cell viewWithTag:71];
                    fluencyLevelLabel.text=@"Fluency Level:";
                    
                }
                
                break;
                
//            case 2:
//                if ([viewSendReports isKindOfClass:[UISwitch class]]) 
//                {
//                    
//                    UILabel *emailLabel =(UILabel *)[cell viewWithTag:41];
//                    emailLabel.text=@"Send Reports:";  
//                    
//                }
//                
//                break;
//                
                
                
            case 3:
                
                
                if([sliderView isKindOfClass:[UISlider class]])
                {
                    UISlider *sliderOne = (UISlider *)sliderView;
                    UILabel *slabel = (UILabel *)[cell viewWithTag:10];
                    
                    slabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
                    UIImage *sliderLeftTrackImage = [[UIImage imageNamed: @"sliderbackground-gray.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
                    UIImage *sliderRightTrackImage = [[UIImage imageNamed: @"sliderbackground.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
                    [sliderOne setMinimumTrackImage: sliderLeftTrackImage forState: UIControlStateNormal];
                    [sliderOne setMaximumTrackImage: sliderRightTrackImage forState: UIControlStateNormal];
                    [sliderOne setMinimumValue:-1.0];
                    [sliderOne setMaximumValue:0];
                    
                }
                break;
            case 4:
                
                if([sliderView isKindOfClass:[UISlider class]])
                {
                    
                    UISlider *sliderTwo = (UISlider *)sliderView;
                    
                    UILabel *slabelTwo = (UILabel *)[cell viewWithTag:10];
                    UIImage *sliderTwoLeftTrackImage = [[UIImage imageNamed: @"sliderbackground.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
                    UIImage *sliderTwoRightTrackImage = [[UIImage imageNamed: @"sliderbackground-gray.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
                    [sliderTwo setMinimumTrackImage: sliderTwoLeftTrackImage forState: UIControlStateNormal];
                    [sliderTwo setMaximumTrackImage: sliderTwoRightTrackImage forState: UIControlStateNormal];
                    
                    slabelTwo.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];        
                    [sliderTwo setMinimumValue:0.0];
                    [sliderTwo setMaximumValue: 1.0];
                    
                }
                
                
                break;
                
            default:
                break;
                
                
        }
    }
    
    
    
}




- (void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillAppearForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    if (tableViewModel.tag==0) {
        self.currentDetailTableViewModel=detailTableViewModel;
    }
    
//    SCObjectSection *objectSection = (SCObjectSection *)[detailTableViewModel sectionAtIndex:0];
//    SCTextFieldCell *zipFieldCell = (SCTextFieldCell *)[objectSection cellForPropertyName:@"zipCode"];
//    zipFieldCell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    SCTextFieldCell *postOfficeBoxFieldCell = (SCTextFieldCell *)[objectSection cellForPropertyName:@"postOfficeBox"];
//    postOfficeBoxFieldCell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    
//    SCTextFieldCell *phoneNumberFieldCell = (SCTextFieldCell *)[objectSection cellForPropertyName:@"phoneNumber"];
//    phoneNumberFieldCell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation; 
//    
//    SCTextFieldCell *extentionFieldCell = (SCTextFieldCell *)[objectSection cellForPropertyName:@"extention"];
//    extentionFieldCell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation; 
//    
    
    
}



-(void)tableViewModel:(SCTableViewModel *)tableViewModel willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    //NSLog(@"table bies slkjd %i", tableViewModel.tag);
    SCTableViewCell *cell =tableViewModel.activeCell;
    deletePressedOnce=NO;
    switch (tableViewModel.tag) {
        case 1:
        {
            
            if (cell.tag==8 &&[cell isKindOfClass:[ButtonCell class]]&&![tableViewModel valuesAreValid]) {
                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                [appDelegate displayNotification:@"Add First and Last Name before Adding to Address Book or use the look up button to select the name." forDuration:3.0 location:kPTTScreenLocationTop inView:tableViewModel.modeledTableView.superview];
                
            }
            UITextField *view =(UITextField *)[cell viewWithTag:50];
            
            [view becomeFirstResponder];
            [view resignFirstResponder]; 
            
            
            
            
            
        }
            break;
        
        case 429:
        {
        //NSLog(@"cell bound object class is %i",tableViewModel.tag);
            SCTableViewCell *selectedCell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
            //NSLog(@"cell class %@", selectedCell.class);
            if ([selectedCell isKindOfClass:[SCTableViewCell class]]) {
                //NSLog(@"group cell");
            }
        
        
        }
        
        
        case 3:    
        {
            UIView *textViewView=(UIView *)[cell viewWithTag:80];
            if ([textViewView isKindOfClass:[UITextView class]]) {
                UITextView *textView=(UITextView *)textViewView;
                [textView becomeFirstResponder];
                [textView resignFirstResponder];
            }
            
            //NSLog(@"cell class is %@",[cell class]);
                       
            
            
        }
        default:
            break;
    }
    
}
//-(NSString *)fullName:(NSString *)fullName tableViewModel:(SCTableViewModel *)tableViewModel cell:(SCTableViewCell *)cell getNameValues:(BOOL)getNameValues{
//    
//        
//    
//    
//    if (getNameValues) {
//       
//        
//        if (tableViewModel.tag==0) {
//           
//            nameTitle=nil;
//            firstName=nil;
//            middleName=nil;
//            lastName=nil;
//            suffix=nil;
//            credentialIntitials=nil;  
//            NSManagedObject *managedObject = (NSManagedObject *)cell.boundObject;
//            nameTitle=(NSString *)[managedObject valueForKey:@"prefix"];
//            firstName=(NSString *)[managedObject valueForKey:@"firstName"];
//            middleName=(NSString *)[managedObject valueForKey:@"middleName"];
//            lastName=(NSString *)[managedObject valueForKey:@"lastName"];
//            suffix=(NSString *)[managedObject valueForKey:@"suffix"];
//            
//            credentialIntitials=(NSString *)[managedObject valueForKey:@"credentialInitials"];
//            addressBookRecordIdentifier=[managedObject valueForKey:@"addressBookIdentifier"];
//            
//        }
//       
//        
//        if (tableViewModel.tag==1) {
//            
//            nameTitle=nil;
//            firstName=nil;
//            middleName=nil;
//            lastName=nil;
//            suffix=nil;
//            credentialIntitials=nil; 
//            SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
//            SCControlCell *titleCell=(SCControlCell *)[section cellAtIndex:0];
//            SCControlCell *firstNameCell=(SCControlCell *)[section cellAtIndex:1];
//            SCControlCell *middleNameCell=(SCControlCell *)[section cellAtIndex:2];
//            SCControlCell *lastNameCell=(SCControlCell *)[section cellAtIndex:3];
//            SCControlCell *suffixCell=(SCControlCell *)[section cellAtIndex:4];
//            SCControlCell *credentialInitialsCell=(SCControlCell *)[section cellAtIndex:5];
//            
//            
//                  
//            
//       
//            
//            
//            
//            UITextField *titleTF=(UITextField *)[titleCell viewWithTag:34];
//            self.nameTitle=titleTF.text;
//            
//            
//            UITextField *firstNameTF=(UITextField *)[firstNameCell viewWithTag:50];
//            self.firstName=firstNameTF.text;
//            
//            
//            
//            UITextField *middleNameTF=(UITextField *)[middleNameCell viewWithTag:50];
//           self.middleName=middleNameTF.text;
//            
//            
//            UITextField *lastNameTF=(UITextField *)[lastNameCell viewWithTag:50];
//            self.lastName=lastNameTF.text;
//            
//            
//            UITextField *suffixTF=(UITextField *)[suffixCell viewWithTag:34];
//            self.suffix=suffixTF.text;
//            
//            
//            UITextField *credentialInitialsTF=(UITextField *)[credentialInitialsCell viewWithTag:50];
//           self.credentialIntitials=credentialInitialsTF.text;
//            
//        }
//        
//        
//    } 
// 
//        //NSLog(@"name values %@, %@, %@, %@, %@, %@", self.nameTitle, self.firstName, self.middleName, self.lastName,self.suffix, self.credentialIntitials );
//        
//
//    
//    if (self.nameTitle.length) {
//        fullName=[self.nameTitle stringByAppendingString:@" "];
//    } 
//
//    if (self.firstName.length) {
//        fullName=[fullName stringByAppendingString:self.firstName];
//    }
//    
//       
//    if (self.middleName.length ) 
//    {
//        NSString *middleInitial=[self.middleName substringToIndex:1];
//       
//        middleInitial=[middleInitial stringByAppendingString:@"."];
//        
//        
//        
//        fullName=[fullName stringByAppendingFormat:@" %@", middleInitial];
//        
//        
//    }
//    if (self.lastName.length  && fullName.length ) 
//    {
//        
//      
//        fullName=[fullName stringByAppendingFormat:@" %@",self.lastName];
//        
//    }
//    if (self.suffix.length  && fullName.length) {
//        
//        fullName=[fullName stringByAppendingFormat:@" %@",self.suffix];
//        
//    }
//    
//    if (self.credentialIntitials.length  && fullName.length) {
//        
//        fullName=[fullName stringByAppendingFormat:@", %@", self.credentialIntitials];
//
//    }
//     //NSLog(@"name values %@",fullName  );
//      
//    
//
//    return fullName;
//        
//        
// 
//
//}


- (void)tableViewModel:(SCTableViewModel *)tableViewModel 
       willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTableViewSection *section =[tableViewModel sectionAtIndex:0];
    
    //NSLog(@"section header title %@", section.headerTitle);
    //NSLog(@"table model tag is %i", tableViewModel.tag);
    
    
    switch (tableViewModel.tag) {
        case 0:
            //this is the root table
            
            
        {
            NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
           
            
            
             if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"ClinicianEntity"]) {
            ClinicianEntity *clinicianObject=(ClinicianEntity *)cellManagedObject;
           
           
           
                

            cell.textLabel.text=clinicianObject.combinedName;
             //NSLog(@"cellManagedObject%@",clinicianObject.combinedName);
             }
            
            
           
            
        }
            
            break;
        case 2:
        {
            NSManagedObject *managedObject = (NSManagedObject *)cell.boundObject;
            //identify the if the cell has a managedObject
            if (managedObject) {
                
                
                //NSLog(@"cell managed object is %@",[managedObject class]);
                //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
                if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
                    
//                    //NSLog(@"entity name is %@",managedObject.entity.name);
                    //identify the Languages Spoken table
                    if (![NSStringFromClass([managedObject class])isEqualToString:@"PTABGroup"] &&[managedObject.entity.name isEqualToString:@"LogEntity"]) {
                        //define and initialize a date formatter
                        NSDateFormatter *dateTimeDateFormatter = [[NSDateFormatter alloc] init];
                        
                        //set the date format
                        [dateTimeDateFormatter setDateFormat:@"ccc M/d/yy h:mm a"];
                        
                        NSDate *logDate=[managedObject valueForKey:@"dateTime"];
                        NSString *notes=[managedObject valueForKey:@"notes"];
                        
                        cell.textLabel.text=[NSString stringWithFormat:@"%@: %@",[dateTimeDateFormatter stringFromDate:logDate],notes];
                    }
                    if (![NSStringFromClass([managedObject class])isEqualToString:@"PTABGroup"] &&[managedObject.entity.name isEqualToString:@"ReferralEntity"]) {
                        //define and initialize a date formatter
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        
                        //set the date format
                        [dateFormatter setDateFormat:@"M/d/yyyy"];
                        
                        NSDate *referralDate=[managedObject valueForKey:@"referralDate"];
                        NSString *clientIDCode=[managedObject valueForKeyPath:@"client.clientIDCode"];
                        NSString *notes=[managedObject valueForKey:@"notes"];
                        NSNumber *referralInfo=[managedObject valueForKey:@"referralInOrOut"];
                    
                        NSString *labelString=[NSString string];
                      
                        if (referralDate) {
                            labelString=[[dateFormatter stringFromDate:referralDate] stringByAppendingString:@": "];
                        }
                        if (clientIDCode.length) {
                            labelString=[labelString stringByAppendingFormat:@"%@", clientIDCode];
                        }
                        if (notes.length) {
                            labelString=[labelString stringByAppendingFormat:@"; %@",notes];
                        }
                        if ([referralInfo isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                            cell.textLabel.textColor=[UIColor blueColor];
                            labelString=[@"In" stringByAppendingFormat:@" %@",labelString];
                        }
                        else {
                            labelString=[@"Out" stringByAppendingFormat:@" %@",labelString];
                        }
                        cell.textLabel.text=labelString;
                        
                        
                        
                        
                        
                    }

                    
                    
                    
                }
            }
        } 
            break;
        case 3:
            //this is a third level table
        {
            NSManagedObject *managedObject = (NSManagedObject *)cell.boundObject;
            
            //identify the if the cell has a managedObject
            if (managedObject) {
                
                
                
                //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
                if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
                    
                    
                    //identify the Languages Spoken table
                    if ([managedObject.entity.name  isEqualToString:@"LanguageSpokenEntity"]) {
                        //NSLog(@"the managed object entity is Languag spoken Entity");
                        //get the value of the primaryLangugage attribute
                        NSNumber *primaryLanguageNumber=(NSNumber *)[managedObject valueForKey:@"primaryLanguage"];
                        
                        
                        //NSLog(@"primary alanguage %@",  primaryLanguageNumber);
                        //if the primaryLanguage selection is Yes
                        if (primaryLanguageNumber==[NSNumber numberWithInteger:0]) {
                            //get the language
                            NSString *languageString =cell.textLabel.text;
                            //add (Primary) after the language
                            languageString=[languageString stringByAppendingString:@" (Primary)"];
                            //set the cell textlable text to the languageString -the language with (Primary) after it 
                            cell.textLabel.text=languageString;
                            //change the text color to red
                            cell.textLabel.textColor=[UIColor redColor];
                        }
                    }
                } 
                    if ([managedObject.entity.name isEqualToString:@"MigrationHistoryEntity"]) {
                        //NSLog(@"the managed object entity is Migration History Entity");
                        
                        
                        NSDate *arrivedDate=(NSDate *)[cell.boundObject valueForKey:@"arrivedDate"];
                        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                        
                        [dateFormatter setDateFormat:@"M/yyyy"];
                        
                        
                        NSString *arrivedDateStr=[dateFormatter stringFromDate:arrivedDate];
                        NSString *migratedFrom=[cell.boundObject valueForKey:@"migratedFrom"];
                        NSString *migratedTo=[cell.boundObject valueForKey:@"migratedTo"];
                        NSString *notes=[cell.boundObject valueForKey:@"notes"];    
                        
                        if (arrivedDateStr.length && migratedFrom.length&&migratedTo.length) {
                            
                            NSString * historyString=[arrivedDateStr stringByAppendingFormat:@":%@ to %@",migratedFrom,migratedTo];
                            
                            if (notes.length) 
                            {
                                historyString=[historyString stringByAppendingFormat:@"; %@",notes];
                            }
                            
                            cell.textLabel.text=historyString;
                            //change the text color to red
                        }

                    }
                
            }
        }
            
            
            break;
            
        case 4:
            //this is a fourth level detail view
            if (cell.tag==3)
            {
                //NSLog(@"cell tag is %i", cell.tag);
                UIView *viewOne = [cell viewWithTag:14];
                
                if([viewOne isKindOfClass:[UISlider class]])
                {
                    UISlider *sliderOne = (UISlider *)viewOne;
                    UILabel *slabel = (UILabel *)[cell viewWithTag:10];
                    //NSLog(@"detail will appear for row at index path label text%@",slabel.text);
                    
                    //NSLog(@"bound value is %f", sliderOne.value);
                    slabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
                    
                    
                    
                    
                }     
                
            }
            if (cell.tag==4)
            {
                //NSLog(@"cell tag is ");
                UIView *viewTwo = [cell viewWithTag:14];
                if([viewTwo isKindOfClass:[UISlider class]])
                {
                    
                    
                    //NSLog(@"cell tag is %i", cell.tag);
                    
                    
                    UISlider *sliderTwo = (UISlider *)viewTwo;
                    UILabel *slabelTwo = (UILabel *)[cell viewWithTag:10];
                    
                    
                    slabelTwo.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
                }
                
                
                
                
            }
            
            break;
        default:
            break;
    }
    
    
    
    
    
    
    
}


//-(void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    
//    
//}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillAppearForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
   
    SCTableViewCell *cell=(SCTableViewCell*)[tableViewModel cellAtIndexPath:indexPath];
    if (tableViewModel.tag==0||(tableViewModel.tag==1&&cell.tag==429)) {
        self.currentDetailTableViewModel=detailTableViewModel;
        
                
        
    }
   
    //
    //
    //    if (tableViewModel.tag==1) {
    //       
    //        [self fullName:nil tableViewModel:tableViewModel cell:nil getNameValues:YES];
    //    }
    //    
    //    //NSLog(@"detail table view model%i",detailTableViewModel.tag);
    //    if (tableViewModel.tag==0 ) {
    //        SCTableViewCell *cell =(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
    //        
    //        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
    //        
    //        ClinicianEntity *clinicianObject=(ClinicianEntity *)cellManagedObject;
    //        //NSLog(@"my information is %@",clinicianObject.myInformation);
    //        if ([clinicianObject.myInformation isEqualToNumber:[NSNumber numberWithBool:YES]]) {
    //            if (tableViewModel.sectionCount>3) {
    //            
    //            [detailTableViewModel removeSectionAtIndex:1];
    //            [detailTableViewModel removeSectionAtIndex:4];
    //            }
    //        }
    //      
    //        
    //        
    //    }
    //                                  
    //                                      
    
    
}

-(void)setSectionHeaderColorWithSection:(SCTableViewSection *)section color:(UIColor *)color{
    
    
    if(section.headerTitle !=nil)
    {
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
        
        
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = color;
        headerLabel.text=section.headerTitle;
        [containerView addSubview:headerLabel];
        
        section.headerView = containerView;
        
        
        
    }
    
    
    
    
    
}
- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSInteger)index
{
    
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
    
    //NSLog(@"tableview model tag is %i",tableViewModel.tag);
    //NSLog(@"tableview model view controller is%@ ",[tableViewModel.viewController class]);
    //NSLog(@"index is %i",index);
    //NSLog(@"tabelmodel section count is %i",tableViewModel.sectionCount);
    if (tableViewModel.tag==1 ) {
        //NSLog(@"section index is %i",index);
        
        
        
        if (index==6) {
            //NSLog(@"cells in section is %i",section.cellCount);
            
            
            
            SCTableViewSection *sectionOne=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
            SCTableViewCell *sectionOneClicianCell=(SCTableViewCell *)[sectionOne cellAtIndex:0];
            NSManagedObject *cellManagedObject=(NSManagedObject *)sectionOneClicianCell.boundObject;
            
            if ([cellManagedObject isKindOfClass:[ClinicianEntity class]]) {
                ClinicianEntity *clinicianObject=(ClinicianEntity *)cellManagedObject;
                
                
                //NSLog(@"my information is %@",clinicianObject.myInformation);
                if ([clinicianObject.myInformation isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                    
                    [tableViewModel removeSectionAtIndex:1];
                    [tableViewModel removeSectionAtIndex:4];
                    
                }
                
//                NSArray *addressBookGroupsArray=[NSArray arrayWithArray:[ self addressBookGroupsArray]];
//                
                
              
                
                //NSLog(@"client abrecordidntifier %i",[clinicianObject.aBRecordIdentifier intValue]);
                //NSLog(@"client abrecordidentifier %@",clinicianObject.aBRecordIdentifier);
                self.abGroupObjectSelectionCell=[[ABGroupSelectionCell alloc]initWithClinician:(ClinicianEntity *)clinicianObject];    
                
                abGroupObjectSelectionCell_.tag=429;
               
                [sectionOne addCell:abGroupObjectSelectionCell_];
            }
            
            
            
        }
    }
    
    
    
    
    [self setSectionHeaderColorWithSection:(SCTableViewSection *)section color:[UIColor whiteColor]];
    
    
    
}





-(BOOL)tableViewModel:(SCTableViewModel *)tableViewModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL valid = TRUE;
    
//    SCTableViewCell *cell = [tableViewModel cellAtIndexPath:indexPath];
    
    
//    
//    if (tableViewModel.tag==4) {
//        UILabel *emaiLabel=(UILabel *)[cell viewWithTag:51];
//        if (emaiLabel.text==@"Email Address:")
//        {
//            UITextField *emailField=(UITextField *)[cell viewWithTag:50];
//            
//            if(emailField.text.length){
//                valid=[self validateEmail:emailField.text];
//                
//                //NSLog(@"testing email address");
//            }
//            else
//            {
//                valid=FALSE;
//            }
//        }
//        
//        
//        
//    }
    
    
    //NSLog(@"table view model is alkjlaksjdfkj %i", tableViewModel.tag);
    
    if (tableViewModel.tag==1){
        
        
        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
        SCControlCell *firstNameCell =(SCControlCell *)[section cellAtIndex:1];
        SCControlCell *lastNameCell =(SCControlCell *)[section cellAtIndex:3];
        
        //NSLog(@"last Name cell tag is %i", lastNameCell.tag);
        UITextField *lastNameField =(UITextField *)[lastNameCell viewWithTag:50];
        UITextField *firstNameField =(UITextField *)[firstNameCell viewWithTag:50];
        //NSLog(@"first name field %@",firstNameField.text);
        //NSLog(@"last name field %@",lastNameField.text);
        
        if ( firstNameField.text.length && lastNameField.text.length) {
            
            valid=TRUE;
            //NSLog(@"first or last name is valid");
            
        }
        else
        {
            valid=FALSE;
        }
    }
    
    
    if (tableViewModel.tag==3&& tableViewModel.sectionCount){
        
        
        
        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
        
        if (section.cellCount>1) {
            SCTableViewCell *notesCell =(SCTableViewCell *)[section cellAtIndex:1];
            NSManagedObject *notesManagedObject=(NSManagedObject *)notesCell.boundObject;
            
            
            if (notesManagedObject && [notesManagedObject.entity.name isEqualToString:@"LogEntity"]&&[notesCell isKindOfClass:[EncryptedSCTextViewCell class]]) {
                EncryptedSCTextViewCell *encryptedNoteCell=(EncryptedSCTextViewCell *)notesCell;
                
                if (encryptedNoteCell.textView.text.length) 
                {
                    valid=TRUE;
                }
                else 
                {
                    valid=FALSE;
                }
                
            }
            SCTableViewCell *cellAtZero=(SCTableViewCell *)[section cellAtIndex:0];
            if (notesManagedObject && [notesManagedObject.entity.name isEqualToString:@"ReferralEntity"]&&[cellAtZero isKindOfClass:[ClientsSelectionCell class]]) {
                ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)cellAtZero;
                SCDateCell *dateCell;
                if ([notesCell isKindOfClass:[SCDateCell class]]) {
                    dateCell=(SCDateCell *)notesCell;
                }
                if (clientSelectionCell.label.text.length && dateCell && dateCell.label.text.length) 
                {
                    valid=TRUE;
                }
                else 
                {
                    valid=FALSE;
                }
                
            }

        }
        
        
    }
    
    if (tableViewModel.tag==4&& tableViewModel.sectionCount){
        
        
        
        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
        
        if (section.cellCount>3) 
        {
            SCTableViewCell *cellFrom=(SCTableViewCell *)[section cellAtIndex:0];
            SCTableViewCell *cellTo=(SCTableViewCell *)[section cellAtIndex:1];
            SCTableViewCell *cellArrivedDate=(SCTableViewCell *)[section cellAtIndex:2];
            NSManagedObject *cellManagedObject=(NSManagedObject *)cellFrom.boundObject;
            //NSLog(@"cell managed object entity name is %@",cellManagedObject.entity.name);  
            
            if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"MigrationHistoryEntity"] && [cellFrom isKindOfClass:[EncryptedSCTextViewCell class]]) {
                
                EncryptedSCTextViewCell *encryptedFrom=(EncryptedSCTextViewCell *)cellFrom;
                EncryptedSCTextViewCell *encryptedTo=(EncryptedSCTextViewCell *)cellTo;
                
                //NSLog(@"arrived date cell class is %@",[cellArrivedDate class]);
                SCDateCell *arrivedDateCell=(SCDateCell *)cellArrivedDate;
                
                if (encryptedFrom.textView.text.length && encryptedTo.textView.text.length &&arrivedDateCell.label.text.length) {
                    valid=YES;
                }
                else {
                    valid=NO;
                }
                
            }
        }        
    }
    

    
    
    return valid;
}






- (void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)IndexPath
{
    SCTableViewCell *cell = [tableViewModel cellAtIndexPath:IndexPath];
    
    
    if (tableViewModel.tag==1) {
        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
        SCTableViewCell *buttonTableViewCell=(SCTableViewCell *)[section cellAtIndex:8];
        if ([buttonTableViewCell isKindOfClass:[ButtonCell class]]) {
            ButtonCell * buttonCell =(ButtonCell *)buttonTableViewCell;
            
            UIButton *button=(UIButton *)[buttonCell viewWithTag:300];
            
            [button setEnabled:[tableViewModel valuesAreValid]];
        }
        
        
        
    }
    
    
    
    
    if (tableViewModel.tag==4){
        if (cell.tag==3)
        {
            UIView *viewOne = [cell viewWithTag:14];
            
            if([viewOne isKindOfClass:[UISlider class]])
            {
                UISlider *sliderOne = (UISlider *)viewOne;
                UILabel *sOnelabel = (UILabel *)[cell viewWithTag:10];
                
                sOnelabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
            }
        }  
        if (cell.tag==4)
        {        
            UIView *viewTwo =[cell viewWithTag:14];
            if([viewTwo isKindOfClass:[UISlider class]])
            {    
                UISlider *sliderTwo = (UISlider *)viewTwo;
                UILabel *sTwolabel = (UILabel *)[cell viewWithTag:10];
                
                sTwolabel.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
            }
            
            
            
        }
        
    }
}



-(void) tableViewModel:(SCTableViewModel *)tableViewModel customButtonTapped:(UIButton *)button forRowWithIndexPath:(NSIndexPath *)indexPath{
    
//    SCTableViewSection *section =[tableViewModel sectionAtIndex:indexPath.section];
    SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
    //NSLog(@"custom button tapped");
    
    
    if (tableViewModel.tag==1) {
        //NSLog(@"table model tag is %i",2);
        //NSLog(@"the cell tag is %i",cell.tag);
        switch (cell.tag)
        {
                //            case 0:
                //            {
                //                //NSLog(@"cell tag is %i",0);
                //                
                //
                //               
                //             
                //                
                ////                NSManagedObject *managedObject =nil;
                ////                //NSLog(@"the managed object is %@", 
                ////                      tableModel.items);   
                //              
                //                
                //               
                //                
                ////                //NSLog(@"the managed object is %@", 
                //////                    self.presentedViewController.parentViewController );
                ////                
                ////                //NSLog(@"the managed object context is %@", managedObjectContext);
                //////                [self showPeoplePickerController];
                //                
                //                
                //
                //                break;
                //            }
                //                
                //                
                //            case 1:
                //            {
                //                //NSLog(@"cell tag is %i",1);
                ////                [self showPersonViewController ];   
                //                break;
                //            }    
                //                
                //            case 2:
                //            {
                //                //NSLog(@"cell tag is %i",2);
                //                
                ////                [self showNewPersonViewController];
                //                
                //                
                //                break;
                //            }    
            case 8:
            {
                //NSLog(@"cell tag is %i",2);
                if ([cell isKindOfClass:[ButtonCell class]]) {
                    
                    
                    
                    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
                    
                    NSEntityDescription *entityDesctipion=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
                    if ([cellManagedObject.entity isKindOfEntity:entityDesctipion]) {
                        clinician=nil;
                        clinician=(ClinicianEntity *) cellManagedObject;
                        
                        
//                        SCTableViewCell *cellAtOne=(SCTableViewCell *)[section cellAtIndex:1];
//                        
//                        UIView *viewLongerTextLabelView =(UIView *)[cellAtOne viewWithTag:51];
//                        //NSLog(@"viewlonger text label view is %@",[viewLongerTextLabelView class]);
//                        if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
//                        {
//                            //NSLog(@"first name");
//                            
//                            UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
//                            //NSLog(@"label tex is %@",firstNameLabel.text);
//                            if ([firstNameLabel.text isEqualToString:@"First Name:"]) {
//                                [cellAtOne commitChanges];
//                            } 
//                        }
//                        
//                        SCTableViewCell *cellAtThree=(SCTableViewCell *)[section cellAtIndex:3];
//                        
//                        UIView *lastNameLabelView =(UIView *)[cellAtThree viewWithTag:51];
//                        
//                        if ([lastNameLabelView isKindOfClass:[UILabel class]]) 
//                        {
//                            //NSLog(@"last Name");
//                            
//                            UILabel *lastNameLabel =(UILabel *)lastNameLabelView;
//                            //NSLog(@"label last nametex is %@",lastNameLabel.text);
//                            if ([lastNameLabel.text isEqualToString:@"Last Name:"]) {
//                                [cellAtThree commitChanges];
//                            } 
//                        }
                        
                        
                        
                        //                        cellManagedObject=(NSManagedObject *)cell.boundObject;
                        //                        clinician=(ClinicianEntity *) cellManagedObject;
                        
                        
                        //NSLog(@"clinician %@",clinician);
                        
                        for (NSInteger i=0; i<tableViewModel.sectionCount;i++) {
                            SCTableViewSection *sectionAtIndex=(SCTableViewSection *)[tableViewModel sectionAtIndex:i];
                            
                            [sectionAtIndex commitCellChanges];
                        }
                        
                        [self evaluateWhichABViewControllerToShow];
                        
                    }
                    
                    
                    
                }
                break;
            }    
            case 9:
            {   //NSLog(@"cell tag is %i",2);
                if ([cell isKindOfClass:[ButtonCell class]]) {
                    
                    
                    
                    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
                    
                    NSEntityDescription *entityDesctipion=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
                    if ([cellManagedObject.entity isKindOfEntity:entityDesctipion]) {   
                        
                        
                        
                        int addressBookRecordIdentifier=(int )[(NSNumber *)[cell.boundObject valueForKey:@"aBRecordIdentifier"]intValue]; 
                        
                        //NSLog(@"addressbook identifier is %i",addressBookRecordIdentifier);
                        //NSLog(@"addressbook Identifier %@", cell.boundObject);
                        
                        if (addressBookRecordIdentifier!=-1) {
                            
                            
                            existingPersonRecordID=-1;
                            [cellManagedObject setNilValueForKey:@"aBRecordIdentifier"];
                            [cell commitChanges];
                            [currentDetailTableViewModel_ reloadBoundValues];
                            [currentDetailTableViewModel_.modeledTableView reloadData];
                            
                            
                            
                            
                        }
                        else
                        {
                            
                            [self showPeoplePickerController];
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                }
                break;
            }    
                
            default:
                break;
        }
        
        
        
        
    }
    
    

}

-(void)tableViewModelDidEndEditing:(SCTableViewModel *)tableViewModel{
    
   //NSLog(@"tableview model tag is %i",tableViewModel.tag);
    deletePressedOnce=NO;
    
    
    
    //NSLog(@"did end editiong");
    

    
}
//-(BOOL)tableViewModel:(SCTableViewModel *)tableViewModel willRemoveRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
//    //NSLog(@"delete sender is activated %@",cell.boundObject);
//    BOOL myInformation=(BOOL)[(NSNumber *)[cell.boundObject valueForKey:@"myInformation"]boolValue];
//    if (myInformation) {
//        PTTAppDelegate *appdelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//        UIView *notificationSuperView;
//        
//        
//        
//        
//        
//        if (!deletePressedOnce) {
//            
//            [appdelegate displayNotification:@"Can't Delete Your Own Record. Press Delete again to clear your information." forDuration:3.5 location:kPTTScreenLocationTop inView:notificationSuperView];
//            
//            deletePressedOnce=YES;
//        }
//        else
//        {
//            
//            NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
//            ClinicianEntity *clinicianObject=(ClinicianEntity *)cellManagedObject;
//            
//            NSEntityDescription *entityDescription=(NSEntityDescription *) clinicianObject.entity;
//            
//            
//            NSArray *boundObjectKeys=(NSArray *)[entityDescription attributesByName] ;
//            //NSLog(@"client entity keys %@",boundObjectKeys);
//            for (id attribute in boundObjectKeys){
//                BOOL setNil=YES;
//                if ([attribute isEqualToString:@"firstName"]) {
//                    [clinicianObject setValue:@"Enter Your" forKey:attribute];
//                    setNil=NO;
//                }
//                if ([attribute isEqualToString:@"lastName"]) {
//                    [clinicianObject setValue:@"Name Here" forKey:attribute];
//                    setNil=NO;
//                }
//                
//                if (setNil && ![attribute isEqualToString:@"myInformation"]&&![attribute isEqualToString:@"atMyCurrentSite"]&&![attribute isEqualToString:@"order"]) {
//                    [cellManagedObject setValue:nil forKey:attribute];
//                    //NSLog(@"attribute %@",attribute);
//                }
//                
//            }
//            
//            
//            NSArray *relationshipsByName=(NSArray *)[entityDescription relationshipsByName] ;
//            //NSLog(@"client entity keys %@",relationshipsByName);
//            
//            for (id relationship in relationshipsByName){
//                
//                
//                
//                
//                [clinicianObject setValue:nil forKey:relationship];
//                //NSLog(@"set nil value for relationship %@",relationship);
//                
//                
//            }
//            
//            
//            [tableViewModel reloadBoundValues];
//            [tableViewModel.modeledTableView reloadData];
//            [appdelegate displayNotification:@"My Personal Information Cleared" forDuration:3.0 location:kPTTScreenLocationTop inView:notificationSuperView];
//            deletePressedOnce=NO;
//            //NSLog(@"client entity keys after %@",cellManagedObject);
//        }
//        
//        return NO;
//    }
//    
//    return YES;
//}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillDisappearForSectionAtIndex:(NSUInteger)index{
    if (tableViewModel.tag==0) {
        if (![SCHelper is_iPad]) {
        
        currentDetailTableViewModel_.viewController.view=nil;
        self.currentDetailTableViewModel=nil;
            
        }
        [self resetABVariablesToNil];
        
    }
    
    
    
    
    
    
} 
-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewDidDisappearForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableViewModel.tag==0) {
        currentDetailTableViewModel_.viewController.view=nil;
        self.currentDetailTableViewModel=nil;
        [self resetABVariablesToNil];
    }
//    if (tableViewModel.tag==1) {
//        currentDetailTableViewModel=tableViewModel;
//    }
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillDisappearForRowAtIndexPath:(NSIndexPath *)indexPath{

//NSLog(@"table view model tag is %i",tableViewModel.tag);
    if (tableViewModel.tag==1) {
        self.currentDetailTableViewModel=tableViewModel;
    }


}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//	// use "buttonIndex" to decide your action
//	//
//    
//    if (alertView.tag==1) {
//       
//        if (buttonIndex==1) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel:" stringByAppendingString:alertView.message]]];
//        }
//    }
//    
//}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewDidAppearForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{

    
    [self tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:indexPath.section detailTableViewModel:(SCTableViewModel*) detailTableViewModel];
    




}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewDidAppearForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{


    
    if (detailTableViewModel.tag==3&& detailTableViewModel.sectionCount){
        
        
        
        SCTableViewSection *section=[detailTableViewModel sectionAtIndex:0];
        
        if (section.cellCount>1) {
            SCTableViewCell *notesCell =(SCTableViewCell *)[section cellAtIndex:1];
            NSManagedObject *notesManagedObject=(NSManagedObject *)notesCell.boundObject;
            
            
            if (notesManagedObject &&[notesManagedObject.entity.name isEqualToString:@"LogEntity"]&&[notesCell isKindOfClass:[EncryptedSCTextViewCell class]]) {
                
                [notesCell becomeFirstResponder];
            }
        }
        
    }



}
-(BOOL)checkIfRecordIDInAddressBook:(int)recordID{


    ABAddressBookRef addressBook;
    addressBook=nil;
    addressBook=ABAddressBookCreate();
    

    
    BOOL exists=NO;
    if (recordID>0) {
  
        ABRecordRef person=(ABRecordRef ) ABAddressBookGetPersonWithRecordID(addressBook, recordID);

        if (person) {
            exists=YES;
            CFRelease(person);
        } 
        
        
    }
    
        
    return exists;

}



#pragma mark Show all contacts
// Called when users tap "Display Picker" in the application. Displays a list of contacts and allows users to select a contact from that list.
// The application only shows the phone, email, and birthdate information of the selected contact.




-(void)showPeoplePickerController
{
    
	if (!self.peoplePickerNavigationController) {
        self.peoplePickerNavigationController=[[ABPeoplePickerNavigationController alloc]init];

    }
    else {
        
        self.peoplePickerNavigationController=nil;
        self.peoplePickerNavigationController.view=nil;
        self.peoplePickerNavigationController=[[ABPeoplePickerNavigationController alloc]init];
        
    }
        
    peoplePickerNavigationController_.peoplePickerDelegate = self;
	// Display only a person's phone, email, and birthdate
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty], 
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	
	
	peoplePickerNavigationController_.displayedProperties = displayedItems;
	// Show the picker 
    

    
    [peoplePickerNavigationController_ setPeoplePickerDelegate:self];
    
    
	// Display only a person's phone, email, and birthdate
    //	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty], 
    //                               [NSNumber numberWithInt:kABPersonEmailProperty],
    //                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	
    
    
    //	abToDisplay.peoplePicker.displayedProperties=displayedItems;
	// Show the picker 
    
    
	[currentDetailTableViewModel_.viewController.navigationController presentModalViewController:self.peoplePickerNavigationController animated:YES];
    
	
}


#pragma mark Display and edit a person
// Called when users tap "Display and Edit Contact" in the application. Searches for a contact named "Appleseed" in 
// in the address book. Displays and allows editing of all information associated with that contact if
// the search is successful. Shows an alert, otherwise.


-(void)evaluateWhichABViewControllerToShow
{
	// Fetch the address book 
    //	ABAddressBookRef addressBook = ABAddressBookCreate();
    
    
    ABAddressBookRef addressBook;
    addressBook=nil;
    addressBook=ABAddressBookCreate();

    //    
    //    
    //
    //    // Search for the person named "Appleseed" in the address book
    //	
    //    
    
    
    
    NSString *groupName=(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];
    int groupIdentifier=(NSInteger )[(NSNumber *)[[NSUserDefaults standardUserDefaults]valueForKey:kPTTAddressBookGroupIdentifier]intValue];
    
    BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults] boolForKey:kPTAutoAddClinicianToGroup];
    
    //NSLog(@"group Name %@",groupName);
    //    
    //    
    
    existingPersonRecordID=[(NSNumber *)clinician.aBRecordIdentifier intValue];
    if (existingPersonRecordID!=-1&&![self checkIfRecordIDInAddressBook:(int)existingPersonRecordID]) {
        existingPersonRecordID=-1;
        
        
    }
   
//    //NSLog(@"clinicianrecord identifier is %i",clinicianRecordIdentifier);
   
        
        
        //   ABRecordRef existingPersonRef=ABAddressBookGetPersonWithRecordID((ABAddressBookRef )addressBook, clinicianRecordIdentifier);
        // 
        //     }
        //    
        //    //NSLog(@"existingPerson_ record id %@",existingPersonRef);
        
        if (!groupName.length) {
            groupName=@"Clinicians";
            [[NSUserDefaults standardUserDefaults] setValue:groupName forKeyPath:kPTTAddressBookGroupName];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }  
        
        ABRecordRef group;
    
        group=nil;
  
        if (groupIdentifier>-1) {
            group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
            
        }
        
        if (!group && autoAddClinicianToGroup) {
            
            [self changeABGroupNameTo:groupName addNew:NO];
            
            groupIdentifier=(NSInteger )[(NSNumber *)[[NSUserDefaults standardUserDefaults]valueForKey:kPTTAddressBookGroupIdentifier]intValue];
            
            if (groupIdentifier>-1) {
                group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
                
            }
            
            
            
            //        ABRecordRef CFAddressBookGroupRecord =  ABGroupCreate ();
            
            //        group=ABGroupCreate();
            //        
            //        //        ABRecord *groupRecord=(ABRecord *)[group getRecordRef];
            //        
            //        //        //NSLog(@"group composite name is %@",groupRecord.compositeName);
            //       
            //        bool didSetGroupName=FALSE;
            //        didSetGroupName= (bool) ABRecordSetValue (
            //                              group,
            //                               (ABPropertyID) kABGroupNameProperty,
            //                               (__bridge CFStringRef)groupName  ,
            //                              nil
            //                               );  
            //        //        //NSLog(@"group record identifier is %i",groupRecord.recordID);
            //      
            //        BOOL wantToSaveChanges=TRUE;
            //        if (ABAddressBookHasUnsavedChanges(addressBook)) {
            //            
            //            if (wantToSaveChanges) 
            //            {
            //                bool didSave=FALSE;
            //                didSave = ABAddressBookSave(addressBook, nil);
            //                
            //                if (!didSave) {/* Handle error here. */}
            //           
            //            } 
            //            else 
            //            {
            //                
            //                ABAddressBookRevert(addressBook);
            //                
            //            }
            //            
            //        }
            
            //        ABRecord *groupRecord=[[ABRecord alloc]initWithABRef:(CFTypeRef)kABGroupType ];
            
            //        //NSLog(@"group idenitifer is%i",ABRecordGetRecordID(group));
            //        
            //        //NSLog(@"group name is %@", (__bridge NSString *)ABRecordCopyValue(group, kABGroupNameProperty));
            //        
            //        
            //        [[NSUserDefaults standardUserDefaults] setInteger:(NSInteger )ABRecordGetRecordID(group) forKey:kPTTAddressBookGroupIdentifier];
            //        
            //        [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        if (existingPersonRecordID==-1) {
            
          
            
           
            
            //crashes if try to release and show alert view
            NSString *name=[NSString string];
            name=(NSString *)[NSString stringWithFormat:@"%@ %@",clinician.firstName, clinician.lastName];
            
            CFArrayRef peopleWithNameArray=nil;
            
           
            
            ABAddressBookRef addressBookNew=nil;
            addressBookNew=ABAddressBookCreate();
            if (name.length && addressBookNew) {
                 peopleWithNameArray= ABAddressBookCopyPeopleWithName((ABAddressBookRef) addressBookNew, (__bridge CFStringRef) name);
            
           
            
            
            //NSLog(@" people with name array %@",peopleWithNameArray);
            
            int peopleCount=CFArrayGetCount((CFArrayRef) peopleWithNameArray);
            if (peopleCount==1  && !addExistingAfterPromptBool  ) {
                
                
                ABRecordRef  existingPersonRef=CFArrayGetValueAtIndex(peopleWithNameArray, 0);
                
                existingPersonRecordID=ABRecordGetRecordID(existingPersonRef);
                CFStringRef CFFirstName=ABRecordCopyValue((ABRecordRef) existingPersonRef, kABPersonFirstNameProperty);
                
                CFStringRef CFLastName=ABRecordCopyValue((ABRecordRef) existingPersonRef, kABPersonLastNameProperty);
                
                NSString *firstName=(__bridge_transfer NSString *)CFFirstName;
                
                NSString *lastName=(__bridge_transfer NSString *)CFLastName;
                
                CFRelease(CFFirstName);
                CFRelease(CFLastName);
                
                
                NSString *compositeName=[NSString stringWithFormat:@"%@ %@", firstName, lastName]; 
                NSString *alertMessage=[NSString stringWithFormat:@"Existing entry for %@ in the Address Book. Would you like to link this clinician to the existing Address Book entry?",compositeName];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Existing Contact With Name" message:alertMessage
                                                               delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Link to Existing", @"Create New", nil];
                
                alert.tag=kAlertTagFoundExistingPersonWithName;
                //NSLog(@"composite name is %@",compositeName);
                //NSLog(@"alert message is %@",alertMessage);
                
                [alert show];
                //            CFRelease(name);
                //            CFRelease(peopleWithNameArray);
                
                //            [self showUnknownPersonViewControllerWithABRecordRef:(ABRecordRef)person.recordRef];
                
                if (addressBookNew!=NULL) {
                    CFRelease(addressBookNew);
                }
                
                 name=NULL;
                
            }
               

            else if(peopleCount>1 && !addExistingAfterPromptBool)
            {
                ABRecordRef  existingPersonRef=CFArrayGetValueAtIndex(peopleWithNameArray, 0);
                
                CFStringRef CFFirstName=ABRecordCopyValue((ABRecordRef) existingPersonRef, kABPersonFirstNameProperty);
                
                CFStringRef CFLastName=ABRecordCopyValue((ABRecordRef) existingPersonRef, kABPersonLastNameProperty);
                
                NSString *firstName=(__bridge_transfer NSString *)CFFirstName;
                
                NSString *lastName=(__bridge_transfer NSString *)CFLastName;
                
                if (CFFirstName!=NULL) {
                    CFRelease(CFFirstName);
                }
                if (CFLastName!=NULL) {
                    CFRelease(CFLastName);

                }
                               
                
                NSString *compositeName=[NSString stringWithFormat:@"%@ %@", firstName, lastName];  
                NSString *alertMessage=[NSString stringWithFormat:@"Existing entries for %@ in the Address Book. Would you like to select an existing Address Book entry for this clinician?",compositeName];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Existing Contacts With Name" message:alertMessage
                                                               delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Choose Existing", @"Create New", nil];
                
                alert.tag=kAlertTagFoundExistingPeopleWithName;
                

                
                [alert show];
                group=nil;
                addressBook=nil;
                if (addressBook!=NULL) {
                    CFRelease(addressBook);
                }
                
                if (addressBookNew!=NULL) {
                    CFRelease(addressBookNew);
                }
                if (group!=NULL) {
                    CFRelease(group);
                    
                }
            
            }
                
                
               
            
            else
                
            {
                
                
                ABRecordRef  existingPersonRef=ABPersonCreate();
                
                //    ABPerson *person=(ABPerson *)personRecord;
                
                
                //NSLog(@"clinician first name is %@ and Clnician last name is %@",clinician.firstName,clinician.lastName);
                if (clinician.firstName.length) {
                ABRecordSetValue(existingPersonRef, kABPersonFirstNameProperty, (__bridge CFStringRef) clinician.firstName, nil) ; 
                }
                if (clinician.lastName.length) {
                ABRecordSetValue(existingPersonRef, kABPersonLastNameProperty, (__bridge CFStringRef) clinician.lastName, nil) ; 
                }
                if (clinician.prefix.length) {
                    ABRecordSetValue(existingPersonRef, kABPersonPrefixProperty, (__bridge CFStringRef) clinician.prefix, nil) ; 
                }
                if (clinician.middleName.length) {
                    ABRecordSetValue(existingPersonRef, kABPersonMiddleNameProperty, (__bridge CFStringRef) clinician.middleName, nil) ; 
                }
                
                if (clinician.suffix.length) {
                    ABRecordSetValue(existingPersonRef, kABPersonSuffixProperty, (__bridge CFStringRef) clinician.suffix, nil) ; 
                }
                
                if (clinician.notes.length) {
                    ABRecordSetValue(existingPersonRef, kABPersonNoteProperty, (__bridge CFStringRef) clinician.notes, nil) ;
                }
//                //NSLog(@"group issdfsdf %@",group);
                [personAddNewViewController_ setAddressBook:addressBook];
                if (self.personAddNewViewController) {
                    self.personAddNewViewController.view=nil;
                    self.personAddNewViewController=nil;
                }
                self.personAddNewViewController=[[ABNewPersonViewController alloc]init];;
                if (autoAddClinicianToGroup && group) {
                    personAddNewViewController_.parentGroup=group;
                }
                
               
                
                personAddNewViewController_.newPersonViewDelegate=self;
                [personAddNewViewController_ setDisplayedPerson:existingPersonRef];
                
                personAddNewViewController_.view.tag=837;
                
                //           [personAddNewViewController_ setAddressBook:addressBook];
                //            personAddNewViewController_=[[ABNewPersonViewController alloc]init];;
                //            personAddNewViewController_.parentGroup=group;
                //            personAddNewViewController_.newPersonViewDelegate=self;
                //            [personAddNewViewController_ setDisplayedPerson:existingPersonRef];
                //            
                //            personAddNewViewController_.view.tag=900;
                //            currentDetailTableViewModel.viewController.navigationController.delegate =self ;
                
                
                
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:personAddNewViewController_];	
                
                navController.delegate=self;
                [[currentDetailTableViewModel_.viewController navigationController] presentModalViewController:navController animated:YES];
                
                addExistingAfterPromptBool=FALSE;
                //            [currentDetailTableViewModel.viewController.navigationController presentModalViewController:personToAddViewController animated:YES ];
                if (group!=NULL) {
                    CFRelease(group);
                }  
                
            
//            if (addressBook!=NULL) {
//                CFRelease(addressBook);
//            }
//            if (addressBookNew!=NULL) {
//                    CFRelease(addressBookNew);
//                }
            }
            }
//            if (addressBook==) {
//                CFRelease(addressBook);
//            }
          
        }
        else
            
        {
            //NSLog(@"existing record id is %i",existingPersonRecordID);
            
            [self showPersonViewControllerForRecordID:(int)existingPersonRecordID];
            if (addressBook!=NULL) {
                CFRelease(addressBook);
            } 
        }
        
   
    
}



//        ABRecordID CFRecordID= (ABRecordID) ABRecordGetRecordID (
//                                                                 (ABRecordRef) CFAddressBookGroupRecord
//                                                                 );

//        recordIdentifier=(__bridge NSString)CFRecordID;

//        //NSLog(@"record identifier is %i",CFRecordID);
//        CFErrorRef error = NULL;
//        
//
//          bool didSet;
//            
//          didSet= (bool)  ABRecordSetValue ((ABRecordRef) CFAddressBookGroupRecord,
//                                             (ABPropertyID) kABGroupNameProperty,
//                                             (__bridge CFTypeRef) groupName,
//                                             &error
//                                             );
//        
//        group se
//            
//        //NSLog(@"abrecrod didset value is %i",didSet);
//            //NSLog(@"group record %@",CFAddressBookGroupRecord);
//        
//         //NSLog(@" record id is %i",CFRecordID);
//        
//       
//       didSet= (bool) ABAddressBookAddRecord (
//                                     (ABAddressBookRef) addressBook,
//                                     (ABRecordRef) CFAddressBookGroupRecord,
//                                    &error
//                                     );
//        
//        
//        //NSLog(@"address book add record didset value is %i",didSet);
//         //NSLog(@" record id is %i",CFRecordID);
//        
//        CFRecordID= (ABRecordID) ABRecordGetRecordID (
//                                                      (ABRecordRef) CFAddressBookGroupRecord
//                                                      );
//        
//        
//        //NSLog(@" record id is %i",CFRecordID);
//       
//        if (ABAddressBookHasUnsavedChanges(addressBook)) {
//            
//            bool didSave;
//                didSave = (bool) ABAddressBookSave(addressBook, &error);
//                
//                if (didSave) {
//                    //NSLog(@"did save is %i",didSave);
//                    
//                    
//                    //NSLog(@" record id is %i",CFRecordID);
//                    CFRecordID= (ABRecordID) ABRecordGetRecordID (
//                                                                  (ABRecordRef) CFAddressBookGroupRecord
//                                                                  );
//                    
//                    
//                    //NSLog(@" record id is %i",CFRecordID);
//                    
//                    groupIdentifier=(ABRecordID)CFRecordID;
//                    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInteger:groupIdentifier] forKeyPath:@"addressBookGroupIdentifier"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                
//        
//                } 
//                else 
//                {
//                    /* Handle error here. */
//               
//                    
//                }
//            
//        }
//        
//     
//        
//        
//        
//       
//    }  
//
//    
//            
////        bool didSet;
////        
////        
////        
////        didSet = ABRecordSetValue(aRecord, kABPersonFirstNameProperty, CFSTR("Katie"), &anError);
//        
////        if (!didSet) {/* Handle error here. */}
////        
////        
////        
////    }
////    else {
////    ABRecordRef CFAddressBookGroupRecord =   (ABRecordRef ) ABAddressBookGetGroupWithRecordID (
////                                                       (ABAddressBookRef )addressBook,
////                                                      (ABRecordID ) recordIdentifier
////                                                       );
////    }
//    
//   CFArrayRef CFGroupsArray= (CFArrayRef) ABAddressBookCopyArrayOfAllGroups (
//                                                  (ABAddressBookRef) addressBook
//                                                  );
//    
//    
//    NSArray *groupsArray=(__bridge NSArray*)CFGroupsArray;
//    
//    
//    //NSLog(@"groups array %@",groupsArray);

//    if (![groupsArray containsObject:grou) {
//        <#statements#>
//    }
//    ABRecordRef ABGroupCreate (
//                               void
//                               );

//    bool wantToSaveChanges = YES;
//    
//    bool didSave;
//    
//    CFErrorRef error = NULL;













//    CFStringRef CFShortFullName=(__bridge CFStringRef)[firstName stringByAppendingFormat:@" %@",lastName];
//    CFStringRef CFAddressBookRecordIdentifier=(__bridge CFStringRef)recordIdentifier;
//    NSArray *people = (__bridge NSArray *) ABAddressBookCopyArrayOfAllPeople(addressBook);

//CFArrayRef CFPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
//
//CFMutableArrayRef CFPeopleMutable = CFArrayCreateMutableCopy(
//                                                           
//                                                           kCFAllocatorDefault,
//                                                           
//                                                           CFArrayGetCount(CFPeople),
//                                                           
//                                                           CFPeople
//                                                           
//                                                           );
//CFArraySortValues(
//                  
//                  CFPeopleMutable,
//                  
//                  CFRangeMake(0, CFArrayGetCount(CFPeopleMutable)),
//                  
//                  (CFComparatorFunction) ABPersonComparePeopleByName,
//                  
//                  (void*) ABPersonGetSortOrdering()
//                  
//                  );
//
//
//NSMutableArray *peopleMutable= (__bridge NSMutableArray*) CFPeopleMutable;
////NSLog(@"people mutable is %@",peopleMutable);
//NSString *predicateString = [NSString stringWithFormat:@"[SELF] contains %",CFShortFullName];
//    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:predicateString];
//    NSArray *names = [peopleMutable filteredArrayUsingPredicate:searchPredicate];
//    //NSLog(@"names are %@", names);
//	 CFArrayRef *CFPeopleWithName = (CFArrayRef *)ABRecordCopyCompositeName( CFShortFullName);
//    NSArray *nsPeopleWithCompositeArray=(NSArray *)CFPeopleWithName;
//
//    
//  
//    // Display "Appleseed" information if found in the address book 
//	if ([names count]>0)
//	{
//        ABPersonViewController *picker = [[ABPersonViewController alloc] init] ;
//		picker.personViewDelegate = self;
//      ABRecordRef record = (__bridge ABRecordRef)[names objectAtIndex:0];
//        if (record !=nil) {
//          
//            picker.displayedPerson=record;
//        }
//        else
//        {
//        ABRecordRef person = (__bridge ABRecordRef)[nsPeopleWithCompositeArray objectAtIndex:0];
//        picker.displayedPerson = person;
//		}
//      
//        // Allow users to edit the person’s information
//		picker.allowsEditing = YES;
//		[self.navigationController pushViewController:picker animated:YES];
//	}
//	else 
//	{
//		if (firstName.length && lastName.length)
//        {
//        [self showUnknownPersonViewController];
//        }
//        else
//        {
//            [self showNewPersonViewController];
//        }
//        
//        
//        
//        if (ABAddressBookHasUnsavedChanges(addressBook)) {
//            
//            if (wantToSaveChanges) {
//                
//                didSave = ABAddressBookSave(addressBook, &error);
//                
//                if (!didSave) {/* Handle error here. */}
//                
//            } else {
//                
//                ABAddressBookRevert(addressBook);
//                
//            }
//            
//        }
//        
//        
//        
//        CFRelease(addressBook);
//        
//        // Show an alert if "Appleseed" is not in Contacts
////		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
////														message:@"Could not find Appleseed in the Contacts application" 
////													   delegate:nil 
////											  cancelButtonTitle:@"Cancel" 
////											  otherButtonTitles:nil];
////		[alert show];
////		[alert release];
//	}
//	

//}


//#pragma mark Create a new person
//// Called when users tap "Create New Contact" in the application. Allows users to create a new contact.
//-(void)showNewPersonViewControllerForClinician:(ABRecordRef )clinician
//{
//    
//	ABNewPersonViewController *picker = [[ABNewPersonViewController alloc] init];
//	picker.newPersonViewDelegate = self;
//	picker.displayedPerson =clinician;
//	
//    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:picker];
//	[self presentModalViewController:navigation animated:YES];
//
//
//
//}
//
//
//
//
//#pragma mark Add data to an existing person
//// Called when users tap "Edit Unknown Contact" in the application. 
//
//-(void)showUnknownPersonViewControllerWithABRecordRef:(ABRecordRef )recordRef
//{
//            
//    if (recordRef) {
//  
//        ABUnknownPersonViewController *picker = [[ABUnknownPersonViewController alloc] init];
//                picker.unknownPersonViewDelegate = self;
//                picker.displayedPerson = recordRef;
//                picker.allowsAddingToAddressBook = YES;
//                picker.allowsActions = YES;
//                
//        NSString *compositeName=(__bridge NSString *)ABRecordCopyCompositeName((ABRecordRef) recordRef);
//                picker.title = @"picker Title";
//                picker.message = [NSString stringWithFormat: @"Existing Entry for %@ in Address Book",compositeName];
//                
//        
////        UINavigationController *currentNavigationController=(UINavigationController*)currentDetailTableViewModel.viewController.navigationController;
//                [currentDetailTableViewModel.viewController.navigationController pushViewController:picker animated:YES];
//        
//
//        }
//        else 
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
//                                                            message:@"Could not create unknown user" 
//                                                           delegate:nil 
//                                                  cancelButtonTitle:@"Cancel"
//                                                  otherButtonTitles:nil];
//            [alert show];
//        }
//}
//	







//-(void)createpsyTrackAddressBook {
//    ABAddressBookRef addressBook;
//    
//    bool wantToSaveChanges = YES;
//    
//    bool didSave;
//    
//    CFErrorRef error = NULL;
//    
//    
//    
//    addressBook = ABAddressBookCreate();
//    
//    
//    
//    /* ... Work with the address book. ... */
//    
//    
//    
//    if (ABAddressBookHasUnsavedChanges(addressBook)) {
//        
//        if (wantToSaveChanges) {
//            
//            didSave = ABAddressBookSave(addressBook, &error);
//            
//            if (!didSave) {/* Handle error here. */}
//            
//        } else {
//            
//            ABAddressBookRevert(addressBook);
//            
//        }
//        
//    }
//    
//    
//    
//    CFRelease(addressBook);
//    
//}


#pragma mark Display and edit a person
// Called when users tap "Display and Edit Contact" in the application. Searches for a contact named "Appleseed" in 
// in the address book. Displays and allows editing of all information associated with that contact if
// the search is successful. Shows an alert, otherwise.
//-(void)showPersonViewControllerForABRecordRef:(ABRecordRef)recordRef;
//{
//	
//    if (recordRef) {
//   
//		
//    
//      
//        
//        ABPersonViewController *personViewController=[[ABPersonViewController alloc]init];;
//        personViewController.personViewDelegate = self;
//		personViewController.displayedPerson = existingPersonRef;
//        
//        personViewController.allowsEditing=YES;
//        personViewController.view.tag=837;
//          [currentDetailTableViewModel.viewController.navigationController setDelegate:self];
//        [currentDetailTableViewModel.viewController.navigationController pushViewController:personViewController animated:YES];
//        
//        
////        picker.personViewDelegate = self;
////		picker.displayedPerson = recordRef;
////		// Allow users to edit the person’s information
////		picker.allowsEditing = YES;
//		
//	}
//	
//	
//}


-(void)showPersonViewControllerForRecordID:(int)recordID
{
	
    
    if (recordID) {
        
        ABAddressBookRef addressBook;
        addressBook=nil;
        addressBook=ABAddressBookCreate();
        

        ABRecordRef existingPerson=nil;
        existingPerson=ABAddressBookGetPersonWithRecordID(addressBook, recordID);

        
       
        if (!self.personViewController) {
            self.personViewController=[[ABPersonViewController alloc]init];
        } 
        else {
            
            if ([SCHelper is_iPad]) {
           
            self.personViewController=nil;
            self.personViewController=[[ABPersonViewController alloc]init];
            self.personViewController.view=nil;
            
                if (!iPadPersonBackgroundView_) {
                    self.iPadPersonBackgroundView=[[UIView alloc]init];
                }    
           
          
                
                
            }
            
                
            
        }
//        [self.personViewController.view setBackgroundColor:[UIColor clearColor]];
        personViewController_.personViewDelegate = self;
		personViewController_.displayedPerson = existingPerson;
        
        personViewController_.allowsEditing=YES;
//        if (!self.iPadPersonBackgroundView) {
//            self.iPadPersonBackgroundView=[[UIView alloc]init];
//            iPadPersonBackgroundView_.tag=837;
//            [iPadPersonBackgroundView_ setBackgroundColor:[UIColor clearColor]];
//        }
//        self.personViewController.view=self.iPadPersonBackgroundView;
        if (personViewController_.view) {
            self.personViewController.view.tag=837;

        }
        
                [currentDetailTableViewModel_.viewController.navigationController setDelegate:self];
        [currentDetailTableViewModel_.viewController.navigationController pushViewController:personViewController_ animated:YES];
        
        
        //        picker.personViewDelegate = self;
        //		picker.displayedPerson = recordRef;
        //		// Allow users to edit the person’s information
        //		picker.allowsEditing = YES;
        
        
	}
	
	
}





-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    
//    peoplePicker.view=nil;
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    
    
}
#pragma mark ABPeoplePickerNavigationControllerDelegate methods
// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    
    
    // stick the buttons in the toolbar
    
    //NSLog(@"people picker view controllers are %@",peoplePicker.viewControllers); 
    
    UIViewController *membersViewController=(UIViewController *)[peoplePicker.viewControllers objectAtIndex:1];
    
    //NSLog(@"modal view controler is %@",membersViewController.modalViewController);
    
    membersViewController.navigationController.delegate=self;
    
    //NSLog(@"members view controller navigation controller viewcontrollers are %@",membersViewController.navigationController.viewControllers);
    
    
    for (UIViewController *viewController in membersViewController.navigationController.viewControllers) {
        viewController.view.tag=789;
    }
    //    peoplePicker.viewControllers.navigationItem.rightBarButtonItems=buttons;
    
    //    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return YES;
}


-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    //NSLog(@"will show view controller %@",viewController);
    
    
    //NSLog(@"will show view controller %@",viewController);
    if (viewController.view.tag==837) {
        
        
        UITableView *personViewTableView=(UITableView *)[viewController.view.subviews objectAtIndex:0];
        
            
        if ([SCHelper is_iPad]) {
            [personViewTableView setBackgroundView:nil];
            [personViewTableView setBackgroundView:self.iPadPersonBackgroundView];
        }
       
     
        [personViewTableView setBackgroundColor:UIColor.clearColor]; 
        //        

        
            
             
        
        personViewTableView.backgroundView.tag=837;
      
        [viewController.navigationController setDelegate:nil];
        
        
    }
    
    
    //    if (viewController.view.tag==900) {
    //        //NSLog(@"view controller tag is 900 and class is %@",[viewController class]);
    //        
    //        if ([viewController isKindOfClass:[ABNewPersonViewController class]]) {
    //           
    //            personAddNewViewController_=(ABNewPersonViewController *) viewController;
    //            viewController.navigationItem.leftBarButtonItem=nil;
    //            UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc]
    //                                             initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAddNewAddressBookPerson:)];
    //            cancelButton.style = UIBarButtonItemStyleBordered;
    //            
    //                        
    //            viewController.navigationItem.leftBarButtonItem=cancelButton;
    //            
    //            
    //            viewController.navigationItem.rightBarButtonItem=nil;
    //            
    //            UIBarButtonItem* doneButton = [[UIBarButtonItem alloc]
    //                                           initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTappedInABPersonViewController:)];
    //            doneButton.style = UIBarButtonItemStyleBordered;
    //
    //            viewController.navigationItem.rightBarButtonItem=doneButton;
    //            viewController.view.tag=0;
    //            
    //        }
    //        
    //        
    //    }
    
    if ([viewController isKindOfClass:[ABPersonViewController class]]&& viewController.view.tag!=837 ) {
        self.personVCFromSelectionList  = (ABPersonViewController *)viewController;
        
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
        // create a spacer
        //    UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
        //                                   initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
        
        
        
        // create a standard "add" button
        UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTappedInABPersonViewController:)];
        cancelButton.style = UIBarButtonItemStyleBordered;
        [buttons addObject:cancelButton];
        
        UIBarButtonItem *selectButton=[[UIBarButtonItem alloc]initWithTitle:@"Select" style:UIBarButtonItemStylePlain target:self action:@selector(selectButtonTappedInABPersonController:)];
        [buttons addObject:selectButton];
        
        
        //NSLog(@"child view controllers are %@",viewController.view.subviews);
        UITableView *personViewTableView=(UITableView *)[viewController.view.subviews objectAtIndex:0];
        
                        
            
        [personViewTableView setBackgroundView:nil];
        [personViewTableView setBackgroundView:[[UIView alloc]init]];
      
        [personViewTableView setBackgroundColor:UIColor.clearColor]; 
        viewController.navigationItem.rightBarButtonItems=buttons;
        
        
        viewController.navigationItem.rightBarButtonItems=buttons;
        
    }
}

// Does not allow users to perform default actions such as dialing a phone number, when they select a person property.
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person 
								property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	
    return YES;
}




#pragma mark ABPersonViewControllerDelegate methods
// Does not allow users to perform default actions such as dialing a phone number, when they select a contact property.
- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
					property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue
{
	return NO;
}


#pragma mark ABNewPersonViewControllerDelegate methods
// Dismisses the new-person view controller. 

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{    
    
    
    
    
    
    if (person) {
        ABAddressBookRef addressBookRef=personAddNewViewController_.addressBook;
        
        BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults] boolForKey:kPTAutoAddClinicianToGroup];
        bool didSave=NO;
        if (autoAddClinicianToGroup||abGroupObjectSelectionCell_.selectedItemsIndexes.count) 
        {
            
            int groupIdentifier=[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
            
            if (groupIdentifier==-1) {
                
                [self changeABGroupNameTo:nil addNew:YES];
                
            }
            
            groupIdentifier=[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
            
            
            if (groupIdentifier>-1) 
            {
                
                ABRecordRef group= ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBookRef, (ABRecordID) groupIdentifier);
                
                ABGroupAddMember(group, person, nil);
                didSave=( bool )  ABAddressBookAddRecord(addressBookRef, group, nil);
                //NSLog(@"group is %@",group);
            }
            
            
            
            
        }
        else 
        {
            
            didSave=(bool) ABAddressBookAddRecord(addressBookRef, person, nil);
        }
        
        
        
        
        
        BOOL wantToSaveChanges=YES;
        
        
        
        //NSLog(@"did save group add member %i ",didSave); 
        
        
        if (ABAddressBookHasUnsavedChanges(addressBookRef)) {
            
            if (wantToSaveChanges) {
                
                didSave = ABAddressBookSave(addressBookRef, nil);
                
                if (!didSave) 
                {
                    /* Handle error here. */
                }
                
            } 
            else 
            {
                
                ABAddressBookRevert(addressBookRef);
                
            }
            
        }
        
        
        //        if ([addressBook_ hasUnsavedChanges]) {
        //            //NSLog(@"displayed person is %@ and %@",personAddNewViewController_, personAddNewViewController_.displayedPerson);
        //            existingPerson_=[addressBook personWithRecordRef:personAddNewViewController_.displayedPerson];
        //            
        //            didSave= [addressBook addRecord:(ABRecord *)existingPerson_];
        //            //NSLog(@"didsave is equal to %i",didSave);
        //            didSave= [addressBook save];
        //            
        //
        //        }
        
        
        //    //NSLog(@"didsave addressbook is %i",didSave);
        
        
        ABRecordRef recordRef=personAddNewViewController_.displayedPerson;             
        //NSLog(@"existing person %@", recordRef);
        int aBRecordID=ABRecordGetRecordID((ABRecordRef) recordRef);
        //NSLog(@"abrecord id is %i  ",aBRecordID);
        SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel_ sectionAtIndex:0];
        SCTableViewCell *cell =(SCTableViewCell *)[section cellAtIndex:1];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        NSEntityDescription *entityDesctipion=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
        if ([cellManagedObject.entity isKindOfEntity:entityDesctipion]) {
            
            
            
            
            
            UIView *viewLongerTextLabelView =(UIView *)[cell viewWithTag:51];
            //NSLog(@"viewlonger text label view is %@",[viewLongerTextLabelView class]);
            if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
            {
                //NSLog(@"first name");
                
                UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
                //NSLog(@"label tex is %@",firstNameLabel.text);
                
                if (aBRecordID &&[firstNameLabel.text isEqualToString:@"First Name:"]) 
                {
                    
                    
                    
                    CFStringRef recordRefFirstName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonFirstNameProperty);
                    
                    CFStringRef recordRefLastName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonLastNameProperty);
                    
                    CFStringRef recordRefPrefix=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonPrefixProperty);
                    
                    CFStringRef recordRefSuffix=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonSuffixProperty);
                    
                    CFStringRef recordRefMiddleName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonMiddleNameProperty);
                    
                    
                    
                    if (recordRefPrefix && CFStringGetLength(recordRefPrefix)>0) 
                    {
                        [cell.boundObject setValue:(__bridge NSString*)recordRefPrefix forKey:@"prefix"];

                    }
                     if (recordRefFirstName &&  CFStringGetLength(recordRefFirstName)>0) {                  
                    [cell.boundObject setValue:(__bridge NSString*)recordRefFirstName forKey:@"firstName"];
                     }
                     if (recordRefMiddleName && CFStringGetLength(recordRefMiddleName)>0) {    
                    [cell.boundObject setValue:(__bridge NSString*)recordRefMiddleName forKey:@"middleName"];
                     }
                      
                    if (recordRefLastName && CFStringGetLength(recordRefLastName)>0) {
                         [cell.boundObject setValue:(__bridge NSString*)recordRefLastName forKey:@"lastName"];
                    }
                    if (recordRefSuffix && CFStringGetLength(recordRefSuffix)>0) {  
                        [cell.boundObject setValue:(__bridge NSString*)recordRefSuffix forKey:@"suffix"];
                    }
                    NSString *notesStr=[cell.boundObject valueForKey:@"notes"];
                    
                    //so it doesn't copy over some notes they have already written
                    if (!notesStr.length) {
                        CFStringRef recordRefNotes=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonNoteProperty);
                        if (recordRefNotes && CFStringGetLength(recordRefNotes)>0) {  
                            [cell.boundObject setValue:(__bridge NSString*)recordRefNotes forKey:@"notes"];
                        }
                        
                        if (recordRefNotes) {
                            CFRelease(recordRefNotes);
                        }
                    }
                    

                    
                    if (recordRefPrefix) {
                        CFRelease(recordRefPrefix);
                        
                    }
                    
                    if (recordRefFirstName) {
                        CFRelease(recordRefFirstName);
                    }
                    if (recordRefMiddleName) {
                        CFRelease(recordRefMiddleName);
                    }
                    
                    if (recordRefLastName) {
                        CFRelease(recordRefLastName);
                    }
                    if (recordRefSuffix) {
                        CFRelease(recordRefSuffix);
                        
                    }
                    
                    
                    
                    
                    
                    [cellManagedObject setValue:[NSNumber numberWithInt:aBRecordID ] forKey:@"aBRecordIdentifier"];
                    
                    
                    [cell commitChanges];
                    abGroupObjectSelectionCell_.items=[abGroupObjectSelectionCell_ addressBookGroupsArray];
                    
                    [abGroupObjectSelectionCell_ addPersonToSelectedGroups];
                    abGroupObjectSelectionCell_.synchWithABBeforeLoadBool=YES;

                    [currentDetailTableViewModel_ reloadBoundValues];
                    [currentDetailTableViewModel_.modeledTableView reloadData];
                    clinician=(ClinicianEntity *) cellManagedObject;
                    
                } 
            }
            
            
            
        }
        CFRelease(recordRef);
        
    }
    else
    {
        //NSLog(@"cancel button pressed");
    }
    
    
    existingPersonRecordID =-1;
    personAddNewViewController.view=nil;
    [personAddNewViewController_.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    //    CFRelease(person);
    
    
    
    
    
    
    
    
    
    //    [newPersonViewController dismissViewControllerAnimated:YES completion:nil];
    //        //NSLog(@"person record %@",newPersonViewController.navigationItem.leftBarButtonItem;
    
    
    
    
    //        [addressBook addRecord:existingPerson];
    //        [addressBook save];
    //        [group addMember:(ABPerson *)existingPerson_];
    //        
    //        if ([addressBook hasUnsavedChanges]) {
    //            [addressBook save];
    //        }
    //        
    //        ABRecordID recordID=(ABRecordID )existingPerson_.recordID;
    //
    //        
    //        //NSLog(@"person identifier is %i", recordID);
    //            existingPerson_=(ABPerson *)[addressBook personWithRecordID:recordID];
    //            [clinician setValue:[NSNumber numberWithInt:recordID] forKey:@"aBRecordIdentifier"];        
    //            //NSLog(@"person to display is %@",existingPerson_.recordRef);
    //            SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel sectionAtIndex:0];
    //            SCTableViewCell *cell =(SCTableViewCell *)[section cellAtIndex:1];
    //            NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
    //            
    //            NSEntityDescription *entityDesctipion=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
    //            if ([cellManagedObject.entity isKindOfEntity:entityDesctipion]) {
    //                
    //                
    //                
    //                
    //                
    //                UIView *viewLongerTextLabelView =(UIView *)[cell viewWithTag:51];
    //                //NSLog(@"viewlonger text label view is %@",[viewLongerTextLabelView class]);
    //                if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
    //                {
    //                    //NSLog(@"first name");
    //                    
    //                    UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
    //                    //NSLog(@"label tex is %@",firstNameLabel.text);
    //                    
    //                    if (recordID &&[firstNameLabel.text isEqualToString:@"First Name:"]) {
    //                        
    //                        
    //                        [cell.boundObject setValue:[NSNumber numberWithInt:recordID ] forKey:@"aBRecordIdentifier"];
    //                        [cell commitChanges];
    //                        [currentDetailTableViewModel reloadBoundValues];
    //                        [currentDetailTableViewModel.modeledTableView reloadData];
    //                        
    //                    } 
    //                }
    //                
    //                
    //                
    //                
    //            }
    //	[self dismissModalViewControllerAnimated:YES];
}


//#pragma mark ABUnknownPersonViewControllerDelegate methods
//// Dismisses the picker when users are done creating a contact or adding the displayed person properties to an existing contact. 
//- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person
//{
//	
//    
//  [unknownPersonView dismissViewControllerAnimated:YES completion:^{
//      
//      [self showPersonViewControllerForABRecordRef:person];
//  }];
//   
//    
//   
//}


//// Does not allow users to perform default actions such as emailing a contact, when they select a contact property.
//- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
//						   property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
//{
//	return NO;
//}

#pragma mark -
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// use "buttonIndex" to decide your action
    
    
    
    if (actionSheet.tag==kAlertTagFoundExistingPersonWithName) {
        switch (buttonIndex) {
            case 0:
                //NSLog(@"zero index");
                // on main thread in delegate method -alertView:clickedButtonAtIndex:
                // (do something with choosen buttonIndex)
                
                
                
                break;
            case 1:
            {
                //NSLog(@"one index");
                
                SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel_ sectionAtIndex:0];
                SCTableViewCell *cell =(SCTableViewCell *)[section cellAtIndex:1];
                NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
                
                NSEntityDescription *entityDesctipion=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
                if ([cellManagedObject.entity isKindOfEntity:entityDesctipion]) {
                    
                    
                    
                    
                    
                    UIView *viewLongerTextLabelView =(UIView *)[cell viewWithTag:51];
                    //NSLog(@"viewlonger text label view is %@",[viewLongerTextLabelView class]);
                    if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
                    {
                        //NSLog(@"first name");
                        
                        UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
                        //NSLog(@"label tex is %@",firstNameLabel.text);
                        
                        
                        
                        //NSLog(@"existing person %i", existingPersonRecordID);
                        if (existingPersonRecordID !=-1) {
                            
                            
                            
                            //                            int aBRecordID=ABRecordGetRecordID((ABRecordRef) existingPersonRef);
                            
                            if ([firstNameLabel.text isEqualToString:@"First Name:"]) {
                                
                                
                                [cell.boundObject setValue:[NSNumber numberWithInt:existingPersonRecordID ] forKey:@"aBRecordIdentifier"];
                                [cell commitChanges];
                                abGroupObjectSelectionCell_.synchWithABBeforeLoadBool=YES;
                                [currentDetailTableViewModel_ reloadBoundValues];
                                [currentDetailTableViewModel_.modeledTableView reloadData];
                                
                              
                            } 
                            
                        }
                    }
                    
                    
                    
                    [self showPersonViewControllerForRecordID:(int)existingPersonRecordID];
                }
            }
                break;
            case 2:
                //NSLog(@"two index");
                [self resetABVariablesToNil];
                addExistingAfterPromptBool=TRUE;
                [self evaluateWhichABViewControllerToShow];
                
                break;
            default:
                break;
                
        }
        return;
    }
    if (actionSheet.tag==kAlertTagFoundExistingPeopleWithName) {
        switch (buttonIndex) {
            case 0:
                //NSLog(@"zero index");
                // on main thread in delegate method -alertView:clickedButtonAtIndex:
                // (do something with choosen buttonIndex)
                
                
                
                break;
            case 1:
            {
                //                //NSLog(@"one index");
                //                ABAddressBook *aBtoFilter=[[ABAddressBook alloc]init];
                //                
                //                NSArray *arrayWithAllPeople=[aBtoFilter allPeople];
                //                
                //                //NSLog(@"array with all people is %@",arrayWithAllPeople);
                //                NSArray *arrayWithCompositeName=[aBtoFilter allPeopleWithName:existingPerson.compositeName];
                //               
                //                
                //               //NSLog(@"array with all people with composite name is %@",arrayWithCompositeName);
                //                
                //                
                //                for (ABPerson *personInArray in arrayWithAllPeople) {
                //                    
                //                     //NSLog(@"person composite name is %@",personInArray.compositeName);
                //                    if (![personInArray.firstName isEqualToString:existingPerson.firstName]||![personInArray.lastName isEqualToString:existingPerson.lastName]) {
                //                     //NSLog(@"person composite name to remove is %@",personInArray.compositeName);
                //                         [aBtoFilter removeRecord:(ABRecord *)personInArray];
                //                        
                //                    }    
                //                   
                //                    
                //                }
                //                //NSLog(@"abtofilter all people %@",[aBtoFilter allPeople]);
                
                [self showPeoplePickerController];
                
            }
                break;
            case 2:
                //NSLog(@"two index");
                
                [self resetABVariablesToNil];
                addExistingAfterPromptBool=TRUE;
                [self evaluateWhichABViewControllerToShow];
                
                
                break;
            default:
                break;
        }
    }
    
	//
}

-(IBAction)cancelButtonTappedInABPersonViewController:(id)sender{
    
    //NSLog(@"cancel button clicked");
    //NSLog(@"sender class is %@",[sender class]);
    if (personVCFromSelectionList_) {
        [self.personVCFromSelectionList dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

-(IBAction)selectButtonTappedInABPersonController:(id)sender{
    
    
    
    
    
    SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel_ sectionAtIndex:0];
    SCTableViewCell *cell =(SCTableViewCell *)[section cellAtIndex:1];
    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
    
    NSEntityDescription *entityDesctipion=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
    if ([cellManagedObject.entity isKindOfEntity:entityDesctipion]) {
        
        
        
        
        
        UIView *viewLongerTextLabelView =(UIView *)[cell viewWithTag:51];
        
        
        //        UIView *viewOneWithText=(UIView *)[cell viewWithTag:50];
        //        
        //        SCTableViewCell *lastNameCell=(SCTableViewCell *)[section cellAtIndex:3];
        //        UIView *lastNameViewWithText=(UIView *)[cell viewWithTag:50];
        //        
        //        if ([lastNameViewWithText isKindOfClass:[UITextField class]]) {
        //            UITextField *lastNameField =(UITextField *)lastNameViewWithText;
        //        }
        //        if ([viewOneWithText isKindOfClass:[UITextField class]]) {
        //            UITextField *firstNameField =(UITextField *)[firstNameCell viewWithTag:50];
        //        }
        //        
        //        
        
        
        
        //NSLog(@"viewlonger text label view is %@",[viewLongerTextLabelView class]);
        if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
        {
            //NSLog(@"first name");
            
            UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
            //NSLog(@"label tex is %@",firstNameLabel.text);
            
            ABRecordRef recordRef=personVCFromSelectionList_.displayedPerson;
            int aBRecordID=ABRecordGetRecordID((ABRecordRef)recordRef);
            if (aBRecordID &&[firstNameLabel.text isEqualToString:@"First Name:"]) 
            {
                CFStringRef recordRefFirstName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonFirstNameProperty);
                
                CFStringRef recordRefLastName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonLastNameProperty);
                
                CFStringRef recordRefPrefix=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonPrefixProperty);
                
                CFStringRef recordRefSuffix=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonSuffixProperty);
                
                CFStringRef recordRefMiddleName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonMiddleNameProperty);
                
                
                
                
                if (recordRefPrefix && CFStringGetLength(recordRefPrefix)>0) 
                {
                    [cell.boundObject setValue:(__bridge NSString*)recordRefPrefix forKey:@"prefix"];
                    
                }
                if (recordRefFirstName &&  CFStringGetLength(recordRefFirstName)>0) {                  
                    [cell.boundObject setValue:(__bridge NSString*)recordRefFirstName forKey:@"firstName"];
                }
                if (recordRefMiddleName && CFStringGetLength(recordRefMiddleName)>0) {    
                    [cell.boundObject setValue:(__bridge NSString*)recordRefMiddleName forKey:@"middleName"];
                }
                
                if (recordRefLastName && CFStringGetLength(recordRefLastName)>0) {
                    [cell.boundObject setValue:(__bridge NSString*)recordRefLastName forKey:@"lastName"];
                }
                if (recordRefSuffix && CFStringGetLength(recordRefSuffix)>0) {  
                    [cell.boundObject setValue:(__bridge NSString*)recordRefSuffix forKey:@"suffix"];
                }
                NSString *notesStr=[cell.boundObject valueForKey:@"notes"];
                
                //so it doesn't copy over some notes they have already written
                if (!notesStr.length) {
                    CFStringRef recordRefNotes=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonNoteProperty);
                    if (recordRefNotes && CFStringGetLength(recordRefNotes)>0) {  
                        [cell.boundObject setValue:(__bridge NSString*)recordRefNotes forKey:@"notes"];
                    }
                    
                    if (recordRefNotes) {
                        CFRelease(recordRefNotes);
                    }
                }
                
                if (recordRefPrefix) {
                    CFRelease(recordRefPrefix);
                    
                }
                
                if (recordRefFirstName) {
                    CFRelease(recordRefFirstName);
                }
                if (recordRefMiddleName) {
                    CFRelease(recordRefMiddleName);
                }
                
                if (recordRefLastName) {
                    CFRelease(recordRefLastName);
                }
                if (recordRefSuffix) {
                    CFRelease(recordRefSuffix);
                    
                }
                
                
                
                
                
                
                
                
                
                
                
                [cell.boundObject setValue:[NSNumber numberWithInt:aBRecordID ] forKey:@"aBRecordIdentifier"];
                
                
                
                
                [cell commitChanges];
                [currentDetailTableViewModel_ reloadBoundValues];
                [currentDetailTableViewModel_.modeledTableView reloadData];
                
            } 
        }
        
        
        if (personVCFromSelectionList_) {
            [personVCFromSelectionList_ dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
    
    
    //NSLog(@"selectButton Tapped");
}


-(IBAction)cancelAddNewAddressBookPerson:(id)sender{
    
    //NSLog(@"cancel button pressed");
    [personAddNewViewController_.navigationController dismissViewControllerAnimated:YES completion:^{
        
        currentDetailTableViewModel_.viewController.navigationController.delegate =nil;
    }];
    
   
    
}

-(void)resetABVariablesToNil{
    
    if (self.personViewController) {
        self.personViewController.view=nil;
        self.personViewController=nil;
    }
    if (self.personAddNewViewController) {
        self.personAddNewViewController.view=nil;
        self.personAddNewViewController=nil;
    }
    if ( self.personVCFromSelectionList) {
        self.personVCFromSelectionList.view=nil;
        self.personVCFromSelectionList=nil;
    }
    if (self.peoplePickerNavigationController) {
        self.peoplePickerNavigationController.view=nil;
        self.peoplePickerNavigationController=nil;;
        
    }
    
    existingPersonRecordID=-1;
    addExistingAfterPromptBool=FALSE;
}

//-(IBAction)doneButtonTappedInABPersonViewController:(id)sender{
//    
//    //NSLog(@"done button pressed");
//   
//
//    
//    bool didSave=NO;
//  
//    
//    //NSLog(@"displayed person is %@ and %@",personAddNewViewController_, personAddNewViewController_.displayedPerson);
//    existingPerson_=[addressBook_ personWithRecordRef:personAddNewViewController_.displayedPerson];
//    
//    didSave= [addressBook_ addRecord:(ABRecord *)existingPerson_];
//     //NSLog(@"didsave is equal to %i",didSave);
//   didSave= [addressBook_ save];
//    
//   
//  
//   //NSLog(@"didsave addressbook is %i",didSave);
//    
//    //NSLog(@"existing person properties description %@",[existingPerson_ description]);
//    //NSLog(@"existing person observation info%@",existingPerson_.observationInfo);
//    //NSLog(@"existing person class%@ ",  [existingPerson_ class]);
//    
//    //NSLog(@"existing person %@",[existingPerson_ accessibilityValue]);
//    //NSLog(@"existing person %@",[existingPerson_ dictionaryWithValuesForKeys:[NSArray array]]);
//    
//    
//    //NSLog(@"existing person observation info %@",[personAddNewViewController_ observationInfo]);
//    ABRecordRef recordRef=personAddNewViewController_.displayedPerson;             
//    //NSLog(@"existing person %@", recordRef);
//    int aBRecordID=existingPerson_.recordID;
//    //NSLog(@"abrecord id is %i  ",aBRecordID);
//    SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel sectionAtIndex:0];
//    SCTableViewCell *cell =(SCTableViewCell *)[section cellAtIndex:1];
//    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
//    
//    NSEntityDescription *entityDesctipion=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
//    if ([cellManagedObject.entity isKindOfEntity:entityDesctipion]) {
//        
//        
//        
//        
//        
//        UIView *viewLongerTextLabelView =(UIView *)[cell viewWithTag:51];
//        //NSLog(@"viewlonger text label view is %@",[viewLongerTextLabelView class]);
//        if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
//        {
//            //NSLog(@"first name");
//            
//            UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
//            //NSLog(@"label tex is %@",firstNameLabel.text);
//            
//            if (aBRecordID &&[firstNameLabel.text isEqualToString:@"First Name:"]) 
//            {
//                
//                
//                [cell.boundObject setValue:[NSNumber numberWithInt:aBRecordID ] forKey:@"aBRecordIdentifier"];
//                [cell commitChanges];
//                [currentDetailTableViewModel reloadBoundValues];
//                [currentDetailTableViewModel.modeledTableView reloadData];
//                
//            } 
//        }
//        
//        
//       
//    }
//    
//
//
//    
//    [personAddNewViewController_.navigationController dismissViewControllerAnimated:YES completion:^{
//        
//        currentDetailTableViewModel.viewController.navigationController.delegate =nil;
//        [self resetABVariablesToNil];
//    }];
//    
//    
//    
//}
-(void)changeABGroupNameTo:(NSString *)groupName  addNew:(BOOL)addNew{
    
    ABAddressBookRef addressBook;
    @try 
    {
        addressBook=nil;
        addressBook=ABAddressBookCreate();
        
        
    }
    
    @catch (NSException *exception) 
    {
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [appDelegate displayNotification:@"Not able to access address book" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
        return;
    }
    @finally 
    {
        ABRecordRef source=nil;
        int sourceID=[self defaultABSourceID];
        source=ABAddressBookGetSourceWithRecordID(addressBook, sourceID);
        ABRecordRef group;
        int groupIdentifier;
        
        CFArrayRef allGroupsInSource=ABAddressBookCopyArrayOfAllGroupsInSource(addressBook, source);
        int groupCount=CFArrayGetCount(allGroupsInSource);
        if (!groupName ||!groupName.length) {
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName]) {
                
                groupName=(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];  
                
                //        }
                if (!groupName ||!groupName.length) {
                    groupName=@"Clinicians";
                    if ([[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupName]) {
                        
                        [[NSUserDefaults standardUserDefaults] setValue:groupName forKeyPath:kPTTAddressBookGroupName];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                    }
                }
                
            }  
            
            
            
            if (!addNew) 
            {
                
                if ([[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupIdentifier]) 
                {
                    groupIdentifier=(NSInteger )[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
                    
                }
                
                if (!addNew&&groupIdentifier>-1)
                {
                    group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
                    
                }
                
                
                
                
                
                
                
                
                //should not ad new
              
                CFStringRef CFGroupNameCheck ;
                ABRecordRef groupInCheckNameArray;
                if (groupCount) 
                {
                    
                   
                    //NSLog(@"cggroups array %@",allGroupsInSource);
                    
                    
                    for (CFIndex i = 0; i < groupCount; i++) {
                        groupInCheckNameArray = CFArrayGetValueAtIndex(allGroupsInSource, i);
                        CFGroupNameCheck  = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);
                        
                        
                        //            CFComparisonResult result=  (CFComparisonResult) CFStringCompare (
                        //                                                                              (__bridge CFStringRef)groupName,
                        //                                                                              (CFStringRef) CFGroupNameCheck,
                        //                                                                              1
                        //                                                                              );
                        
                        
                        
                        NSString *checkNameStr=[NSString stringWithFormat:@"%@",(__bridge NSString*) CFGroupNameCheck];
                        
                        //NSLog(@"cfgroupname is %@",checkNameStr);
                        //NSLog(@"groupname Str is %@",groupName);
                        if ([checkNameStr isEqualToString:groupName]) {
                            group=groupInCheckNameArray;
                            groupIdentifier=ABRecordGetRecordID(group);
                            
                            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupIdentifier]) {
                                [[NSUserDefaults standardUserDefaults] setInteger:groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
                                [[NSUserDefaults standardUserDefaults]synchronize];
                                
                            }
                            
                            if (group) {
                                //NSLog(@"group is %@",group);
                            }
                            
                            else {
                                //NSLog(@"no group");
                            } 
                            break;
                        }
                        //            CFRelease(CFGroupsCheckNameArray); 
                        //            CFRelease(CFGroupNameCheck);
                        
                    }
                    if (allGroupsInSource) {
                        CFRelease(allGroupsInSource); 
                    }
                    
                    if (CFGroupNameCheck) {
                        CFRelease(CFGroupNameCheck);
                    }
                }
                
                
            }
            
        }
        
        
        
        
        NSNumber *groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
        
        if (!addNew && !group && groupIdentifier>0 && groupCount>0 && ![groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]]  && ![groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]]) {
            
            group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
            
        }
        
        if (!group ||addNew) {
            
            
            if (!addressBook) {
                
                return;
            }
            //        ABRecordRef CFAddressBookGroupRecord =  ABGroupCreate ();
            
            group=ABGroupCreateInSource(source);
            
            //        ABRecord *groupRecord=(ABRecord *)[group getRecordRef];
            
            //        //NSLog(@"group composite name is %@",groupRecord.compositeName);
            
            
            //        //NSLog(@"group record identifier is %i",groupRecord.recordID);
            
            bool didSetGroupName=FALSE;
            didSetGroupName= (bool) ABRecordSetValue (
                                                      group,
                                                      (ABPropertyID) kABGroupNameProperty,
                                                      (__bridge CFStringRef)groupName  ,
                                                      nil
                                                      );  
            
            ABAddressBookAddRecord((ABAddressBookRef) addressBook, (ABRecordRef) group, nil);
            
            BOOL wantToSaveChanges=TRUE;
            if (ABAddressBookHasUnsavedChanges(addressBook)) {
                
                if (wantToSaveChanges) {
                    bool didSave=FALSE;
                    didSave = ABAddressBookSave(addressBook, nil);
                    
//                    if (!didSave) {/* Handle error here. */  //NSLog(@"addressbook did not save");}
//                    else //NSLog(@"addresss book saved new group.");
                    
                } 
                else {
                    
                    ABAddressBookRevert(addressBook);
                    
                }
                
            }
            
            //        ABRecord *groupRecord=[[ABRecord alloc]initWithABRef:(CFTypeRef)kABGroupType ];
            
            //NSLog(@"group idenitifer is%i",ABRecordGetRecordID(group));
            
            //NSLog(@"group name is %@", (__bridge NSString *)ABRecordCopyValue(group, kABGroupNameProperty));
            
            
            
            
            
            groupIdentifier=ABRecordGetRecordID(group);
            
            [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
            
            [[NSUserDefaults standardUserDefaults] setValue:groupName forKey:kPTTAddressBookGroupName];  
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            if (group) {
                CFRelease(group);
            }
            
        } 
        else
            
        {
            
            BOOL wantToSaveChanges=TRUE;
            groupIdentifier=ABRecordGetRecordID(group);
            
            if (groupIdentifier>0) {
                
                [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
                
            }
            if (ABAddressBookHasUnsavedChanges(addressBook)) {
                
                if (wantToSaveChanges) {
                    bool didSave=FALSE;
                    didSave = ABAddressBookSave(addressBook, nil);
                    
                    if (!didSave) {/* Handle error here. */}
                    
                } 
                else {
                    
                    ABAddressBookRevert(addressBook);
                    
                }
                
                
                
            }
            
        }
        
        
               
        if (source) {
            CFRelease(source);
        }
    }
    //    [[NSUserDefaults standardUserDefaults]  setValue:(NSString *)groupName forKey:kPTTAddressBookGroupName];
    
    
    
    
    
}

-(IBAction)abGroupsDoneButtonTapped:(id)sender{
    
    
    //NSLog(@"done button pressed");
    //    SCTableViewModel *ownerTableViewModel=(SCTableViewModel *)self.ownerTableViewModel;
    
    
    //NSLog(@"currenct detail tag is %i",currentDetailTableViewModel_.tag);
    if (currentDetailTableViewModel_.tag=429 &&currentDetailTableViewModel_.sectionCount) {
        SCObjectSelectionSection *section=(SCObjectSelectionSection *)[currentDetailTableViewModel_ sectionAtIndex:0];
        NSMutableSet *mutableSet= (NSMutableSet *) abGroupObjectSelectionCell_.selectedItemsIndexes;
        mutableSet=section.selectedItemsIndexes;
        
       
        
        
    }
    if(tableModel_.viewController.navigationController)
	{
		// check if self is the rootViewController
        
        [tableModel_.viewController.navigationController popViewControllerAnimated:YES];
        
        
	}
	else
		[tableModel_.viewController dismissModalViewControllerAnimated:YES];
    

    
}

-(int )defaultABSourceID{
    
    BOOL iCloudEnabled=(BOOL)[[NSUserDefaults standardUserDefaults] valueForKey:@"icloud_preference"];
    
    int returnID=-1;
    int sourceID=-1;
    BOOL continueChecking=YES;
    
    ABAddressBookRef addressBook;
    addressBook=nil;
    
    addressBook=ABAddressBookCreate();
    
    CFArrayRef allSourcesArray=ABAddressBookCopyArrayOfAllSources(addressBook);
    ABRecordRef source=nil;
    int sourcesCount=0;
    
    if (allSourcesArray ) {
        sourcesCount= CFArrayGetCount(allSourcesArray);
    } 
    if (sourcesCount==0) {
        
        continueChecking=NO;
        returnID=-1 ;
    } 
    if (continueChecking&& allSourcesArray && sourcesCount==1) {
        
        source=CFArrayGetValueAtIndex(allSourcesArray, 0);
        ABRecordID sourceID=ABRecordGetRecordID(source);
        
        continueChecking=NO;
        returnID=sourceID;
        
        
    }
    
    
    int recordID=(int)[(NSNumber*)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookSourceIdentifier]
                       intValue];
    
    
    //NSLog(@"source record id is %i",recordID);
    if (continueChecking && recordID!=-1) {
        
        source=ABAddressBookGetSourceWithRecordID(addressBook, recordID);
        
        
        if (source) {
            continueChecking=NO;
            returnID=recordID;
        }
        
        //        }
        
        
    }
    if (continueChecking&& allSourcesArray && CFArrayGetCount(allSourcesArray) >1 &&  iCloudEnabled) {
        
        
        
        for (int i=0; i<sourcesCount ; i++){
            // Fetch the source type
            
            source=CFArrayGetValueAtIndex(allSourcesArray, i);
            CFNumberRef sourceType = ABRecordCopyValue(source, kABSourceTypeProperty);
            
            
            // Fetch the name associated with the source type
            NSString *sourceName = [self nameForSourceWithIdentifier:[(__bridge NSNumber*)sourceType intValue]];
            if (sourceType) {
                CFRelease(sourceType);
            }
            
            
            if ([sourceName isEqualToString: @"CardDAV server"])
            {
                sourceID=ABRecordGetRecordID(source);
                
                
                
                //               
                
                returnID=sourceID;
                continueChecking=NO;
                break;
            }
            
            
        }
        
        
    }
    
    if(continueChecking&& sourcesCount>1)
    {
        source= CFArrayGetValueAtIndex(allSourcesArray, 0);
        sourceID=ABRecordGetRecordID(source);
        returnID=sourceID;        
        
    }
    if (addressBook) {
        CFRelease(addressBook);
    }
    
    
    if (allSourcesArray) {
        CFRelease(allSourcesArray);
    }
    
    
    return returnID;
}


// Return the name associated with the given identifier
- (NSString *)nameForSourceWithIdentifier:(int)identifier
{
	switch (identifier)
	{
            
		case kABSourceTypeLocal:
			return @"On My Device";
			break;
		case kABSourceTypeExchange:
			return @"Exchange server";
			break;
		case kABSourceTypeExchangeGAL:
			return @"Exchange Global Address List";
			break;
		case kABSourceTypeMobileMe:
			return @"Mobile Me";
			break;
		case kABSourceTypeLDAP:
			return @"LDAP server";
			break;
		case kABSourceTypeCardDAV:
			return @"CardDAV server";
			break;
		case kABSourceTypeCardDAVSearch:
			return @"Searchable CardDAV server";
			break;
		default:
			break;
	}
	return nil;
}

@end
