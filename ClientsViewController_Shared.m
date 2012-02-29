//
//  ClientsViewController_Shared.m
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/26/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import "ClientsViewController_Shared.h"
#import "PTTAppDelegate.h"
#import "DemographicDetailViewController_Shared.h"
#import "ButtonCell.h"
#import "ClientEntity.h"
#import "EncryptedSCTextFieldCell.h"


@implementation ClientsViewController_Shared
@synthesize clientDef;


-(id)setupTheClientsViewModelUsingSTV{

managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMM dd, yyyy"];
    
    
    
    DemographicDetailViewController_Shared *demographicDetailViewController_Shared =[[DemographicDetailViewController_Shared alloc]init];
    
    [demographicDetailViewController_Shared setupTheDemographicView];

    
    //Create a class definition for Client entity
    
   
    
	self.clientDef = [SCClassDefinition definitionWithEntityName:@"ClientEntity" 
                                                      withManagedObjectContext:managedObjectContext 
                                                             withPropertyNames:[NSArray arrayWithObjects:@"clientIDCode", @"dateOfBirth", 
                                                                                @"initials",  @"demographicInfo", @"dateAdded",@"currentClient",@"phoneNumbers", @"logs", @"medicationHistory",   
                                                                @"notes",nil]];
	
    
    
   
    NSLog(@"client def entity description %@",self.clientDef.entity.description);
    
    SCPropertyDefinition *clientIdCodePropertyDef  =[self.clientDef propertyDefinitionWithName:@"clientIDCode"];
    
    clientIdCodePropertyDef.type=SCPropertyTypeCustom;
    clientIdCodePropertyDef.uiElementClass=[EncryptedSCTextFieldCell class];
    
    NSDictionary *encryptedTextFieldCellKeyBindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObject:@"clientIDCode"] forKeys:[NSArray arrayWithObject:@"1"]];
    

    clientIdCodePropertyDef.objectBindings=encryptedTextFieldCellKeyBindingsDictionary;
    clientIdCodePropertyDef.title=@"Client ID Code";
    clientIdCodePropertyDef.autoValidate=NO;
    \
    
    self.clientDef.titlePropertyName = @"clientIDCode";	
    self.clientDef.keyPropertyName= @"clientIDCode";
    
   
    
    SCPropertyDefinition *clientDateOfBirthPropertyDef = [self.clientDef propertyDefinitionWithName:@"dateOfBirth"];
	clientDateOfBirthPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                             datePickerMode:UIDatePickerModeDate 
                                                              displayDatePickerInDetailView:NO];
    SCPropertyDefinition *clientDateAddedPropertyDef = [self.clientDef propertyDefinitionWithName:@"dateAdded"];
	clientDateAddedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                             datePickerMode:UIDatePickerModeDate 
                                                              displayDatePickerInDetailView:NO];

    SCPropertyDefinition *currentClientPropertyDef = [self.clientDef propertyDefinitionWithName:@"currentClient"];
    currentClientPropertyDef.type = SCPropertyTypeSegmented;
	currentClientPropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
    
    SCPropertyDefinition *demographicProfilePropertyDef = [self.clientDef propertyDefinitionWithName:@"demographicInfo"];
    demographicProfilePropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:demographicDetailViewController_Shared.demographicProfileDef
                                                                                              allowAddingItems:TRUE
                                                                                            allowDeletingItems:TRUE
                                                                                              allowMovingItems:FALSE];
    SCPropertyDefinition *clientNotesPropertyDef = [self.clientDef propertyDefinitionWithName:@"notes"];
    clientNotesPropertyDef.type=SCPropertyTypeTextView;
    

    //Create a class definition for the phone NumberEntity
    SCClassDefinition *phoneDef = [SCClassDefinition definitionWithEntityName:@"PhoneEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"phoneName",@"phoneNumber", @"extention", nil]];
                                        
    //Do some property definition customization for the phone Entity defined in phoneDef
    
    //create an array of objects definition for the phoneNumber to-many relationship that with show up in a different view with a place holder element>.
    
    //Create the property definition for the phoneNumbers property
    SCPropertyDefinition *phoneNumbersPropertyDef = [self.clientDef propertyDefinitionWithName:@"phoneNumbers"];
    phoneNumbersPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:phoneDef allowAddingItems:TRUE
                                                                                      allowDeletingItems:TRUE
                                                                                        allowMovingItems:FALSE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add New Phone Number"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    
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
    
//    SCPropertyGroup *phoneGroup = [SCPropertyGroup groupWithHeaderTitle:@"Phone Number" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"phoneName",@"phoneNumber",@"extention" @"CallButton", nil]];
//    
//    // add the phone property group
//    [phoneDef.propertyGroups addGroup:phoneGroup];
    
    //Create a class definition for the logsEntity
    SCClassDefinition *logDef = [SCClassDefinition definitionWithEntityName:@"LogEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                          withPropertyNames:[NSArray arrayWithObjects:@"dateTime",
                                                                             @"notes",
                                                                              nil]];
    
    
    SCPropertyDefinition *logsPropertyDef = [self.clientDef propertyDefinitionWithName:@"logs"];
    logsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:logDef allowAddingItems:TRUE
                                                                                      allowDeletingItems:TRUE
                                                                                        allowMovingItems:FALSE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add New Log Entry"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];
    
    //Do some property definition customization for the Log Entity defined in logDef
    
    //do some customizing of the log notes, change it to "Number" to make it shorter
    SCPropertyDefinition *logNotesPropertyDef = [logDef propertyDefinitionWithName:@"notes"];
   
    logNotesPropertyDef.type=SCPropertyTypeTextView;
    logDef.titlePropertyName=@"dateTime;entryNotes";
    
    //Create the property definition for the dateTime property in the logDef class  definition
    SCPropertyDefinition *dateTimePropertyDef = [logDef propertyDefinitionWithName:@"dateTime"];
    
    //format the the date using a date formatter
    //define and initialize a date formatter
    NSDateFormatter *dateTimeDateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateTimeDateFormatter setDateFormat:@"ccc M/d/yy h:mm a"];
    //Set the date attributes in the dateTime property definition and make it so the date picker appears in the Same view.
    dateTimePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateTimeDateFormatter
                                                                   datePickerMode:UIDatePickerModeDateAndTime
                                                    displayDatePickerInDetailView:NO];
    

    
    
    
    
    //Create a class definition for the medication Entity
    SCClassDefinition *medicationDef = [SCClassDefinition definitionWithEntityName:@"MedicationEntity" 
                                                   withManagedObjectContext:managedObjectContext
                                                          withPropertyNames:[NSArray arrayWithObjects:@"drugName",@"dateStarted",  @"discontinued", @"symptomsTargeted",@"medLogs",
                                                                             @"notes",@"applNo", @"productNo",   
                                                                             nil]];
    
    
    
    
    
    
    
    NSInteger applNoIndex=(NSInteger)[medicationDef indexOfPropertyDefinitionWithName:@"applNo"];   
    
    [medicationDef removePropertyDefinitionAtIndex:applNoIndex];
    
    NSInteger productNoIndex=[medicationDef indexOfPropertyDefinitionWithName:@"productNo"];
    [medicationDef removePropertyDefinitionAtIndex:productNoIndex];
    
    
    SCClassDefinition *medicationReviewDef =[SCClassDefinition definitionWithEntityName:@"MedicationReviewEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects: @"logDate",@"prescriber",@"dosage",@"doseChange",@"sxChange",@"lastDose", @"adherance", @"nextReview", @"notes" , nil]];
    
    
    
    
    
    
    
    
    
    
    
    SCPropertyDefinition *medicationsPropertyDef = [self.clientDef propertyDefinitionWithName:@"medicationHistory"];
    medicationsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:medicationDef allowAddingItems:TRUE
                                                                              allowDeletingItems:TRUE
                                                                                allowMovingItems:FALSE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add New Medication Entry"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];
    
    //Do some property definition customization for the medication Entity defined in medicationDef
    
    //do some customizing of the medication notes
    SCPropertyDefinition *medicationNotesPropertyDef = [medicationDef propertyDefinitionWithName:@"notes"];
    
    medicationNotesPropertyDef.type=SCPropertyTypeTextView;
    medicationDef.titlePropertyName=@"drugName;dosage;dateStarted;discontinued";
    medicationDef.keyPropertyName=@"dateStarted";
    
   
    //format the the date using a date formatter
    //define and initialize a date formatter
    NSDateFormatter *medDateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [medDateFormatter setDateFormat:@"ccc M/d/yyyy"];
    //Set the date attributes in the dateTime property definition and make it so the date picker appears in the Same view.
   
    //Create the property definition for the dateStarted property in the medicationDef class  definition
    SCPropertyDefinition *dateStartedPropertyDef = [medicationDef propertyDefinitionWithName:@"dateStarted"];
    
    dateStartedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:medDateFormatter
                                                                    datePickerMode:UIDatePickerModeDate
                                                     displayDatePickerInDetailView:NO];
    
    
    //Create the property definition for the discontinued property in the medicationDef class  definition
    SCPropertyDefinition *discontinuedPropertyDef = [medicationDef propertyDefinitionWithName:@"discontinued"];
    
    discontinuedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:medDateFormatter
                                                                       datePickerMode:UIDatePickerModeDate
                                                        displayDatePickerInDetailView:NO];
    
    SCCustomPropertyDefinition *clearDiscontinuedButtonProperty = [SCCustomPropertyDefinition definitionWithName:@"clearDiscontinued" withuiElementClass:[ButtonCell class] withObjectBindings:nil];
    [medicationDef insertPropertyDefinition:clearDiscontinuedButtonProperty atIndex:3];
    
    
    
    SCPropertyDefinition *medLogsPropertyDef = [medicationDef propertyDefinitionWithName:@"medLogs"];
    medLogsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:medicationReviewDef allowAddingItems:TRUE
                                                                                     allowDeletingItems:TRUE
                                                                                       allowMovingItems:FALSE expandContentInCurrentView:FALSE placeholderuiElement:nil addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add New Medication Log Entry"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];
    
    //Do some property definition customization for the medication Entity defined in medicationDef
    
    //do some customizing of the medication notes
    SCPropertyDefinition *medicationReviewNotesPropertyDef = [medicationReviewDef propertyDefinitionWithName:@"notes"];
    
    medicationReviewNotesPropertyDef.type=SCPropertyTypeTextView;
    medicationReviewDef.keyPropertyName=@"logDate";
    
    //Create the property definition for the date property in the medicatioReviewnDef class  definition
    SCPropertyDefinition *medLogDatePropertyDef = [medicationReviewDef propertyDefinitionWithName:@"logDate"];
    
    medLogDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:medDateFormatter
                                                                       datePickerMode:UIDatePickerModeDate
                                                        displayDatePickerInDetailView:NO];
    
    //Create the property definition for the date property in the medicatioReviewnDef class  definition
    SCPropertyDefinition *medLogNextReviewDatePropertyDef = [medicationReviewDef propertyDefinitionWithName:@"nextReview"];
    
    medLogNextReviewDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateTimeDateFormatter
                                                                      datePickerMode:UIDatePickerModeDateAndTime
                                                       displayDatePickerInDetailView:NO];
    
    
    
    //Create the property definition for the change property in the medicationReview class
    SCPropertyDefinition *sxChangePropertyDef = [medicationReviewDef propertyDefinitionWithName:@"sxChange"];
    
    //set the property definition type to segmented
    sxChangePropertyDef.type = SCPropertyTypeSegmented;
    
    //set the segmented attributes for the change property definition 
    sxChangePropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Worse", @"Same", @"Imporved"   , nil]];
    
    //Create the property definition for the change property in the medicationReview class
    SCPropertyDefinition *doseChangePropertyDef = [medicationReviewDef propertyDefinitionWithName:@"doseChange"];
    
    //set the property definition type to segmented
    doseChangePropertyDef.type = SCPropertyTypeSegmented;
    
    //set the segmented attributes for the change property definition 
    doseChangePropertyDef.attributes = [SCSegmentedAttributes attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"None",@"Decrease", @"Increase"  , nil]];
    
    NSString *satisfactionDataCellNibName;
    if ([SCHelper is_iPad]) {
       satisfactionDataCellNibName= @"ScaleDataCell_iPad";
    }
    else
    {
     satisfactionDataCellNibName= @"ScaleDataCell_iPhone";   
    }
    NSDictionary *satisfactionLevelDataBindings = [NSDictionary 
                                              dictionaryWithObjects:[NSArray arrayWithObject:@"satisfaction"] 
                                              forKeys:[NSArray arrayWithObject:@"70"]]; // 1 is the control tag
	
    
    SCCustomPropertyDefinition *satisfactionLevelDataProperty = [SCCustomPropertyDefinition definitionWithName:@"satisfaction"
                                                                                     withuiElementNibName:satisfactionDataCellNibName
                                                                                       withObjectBindings:satisfactionLevelDataBindings];
    
    
    
    [medicationReviewDef addPropertyDefinition:satisfactionLevelDataProperty];
    
   
    
    
    
   
    SCPropertyDefinition *prescriberPropertyDef = [medicationReviewDef propertyDefinitionWithName:@"prescriber"];
    
   	prescriberPropertyDef.type = SCPropertyTypeObjectSelection;
    
    SCClassDefinition *prescriberDef =[SCClassDefinition definitionWithEntityName:@"ClinicianEntity" withManagedObjectContext:managedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"prefix",@"firstName",@"middleName", @"lastName",@"suffix",@"credentialInitials", nil]];
    prescriberDef.titlePropertyName=@"lastName;firstName";
    prescriberDef.titlePropertyNameDelimiter=@", ";
    prescriberDef.keyPropertyName=@"lastName";
    
    SCPropertyGroup *prescriberNameGroup =[SCPropertyGroup groupWithHeaderTitle:@"Prescriber Name" withFooterTitle:@"Select this prescriber under the Clinician tab to add or view more details." withPropertyNames:[NSArray arrayWithObjects:@"prefix",@"firstName",@"middleName", @"lastName",@"suffix",@"credentialInitials", nil]];
    
    SCObjectSelectionAttributes *prescriberSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:prescriberDef allowMultipleSelection:NO allowNoSelection:NO];
    prescriberSelectionAttribs.allowAddingItems = YES;
    prescriberSelectionAttribs.allowDeletingItems = YES;
    prescriberSelectionAttribs.allowMovingItems = YES;
    prescriberSelectionAttribs.allowEditingItems = YES;
    prescriberSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add prescribers)"];
    prescriberSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New prescriber"];
    prescriberPropertyDef.attributes = prescriberSelectionAttribs;
    
    
    [prescriberDef.propertyGroups addGroup:prescriberNameGroup];
    
    
    
    //Create a property definition for the adherance property.
    SCPropertyDefinition *adherancePropertyDef = [medicationReviewDef propertyDefinitionWithName:@"adherance"];
    
    //set the adherance property definition type to a selectiong Cell
    adherancePropertyDef.type = SCPropertyTypeSelection;
    
       
    //set the selection attributes and define the list of items to be selected
    adherancePropertyDef.attributes = [SCSelectionAttributes attributesWithItems:[NSArray arrayWithObjects:@"Refuses", @"Poor", @"Needs Assistance",@"Frequently Forgets",@"Adequate",@"Good",@"Excellent", nil] 
                                                            allowMultipleSelection:YES
                                                                  allowNoSelection:YES
                                                             autoDismissDetailView:NO hideDetailViewNavigationBar:NO];
    
    
    //define a property group
    SCPropertyGroup *followUpGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"doseChange",   @"sxChange",@"lastDose", @"adherance", @"satisfaction", nil]];
    
    // add the followup property group to the medication Review class. 
    [medicationReviewDef.propertyGroups addGroup:followUpGroup];
    
    SCPropertyGroup *notesGroup = [SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"notes"]];
    
    // add the followup property group to the behavioralObservationsDef class. 
    [medicationReviewDef.propertyGroups addGroup:notesGroup];
    
    SCPropertyGroup *clientInfoGroup = [SCPropertyGroup groupWithHeaderTitle:@"De-Identified Client Data" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"clientIDCode", @"dateOfBirth",@"initials",@"demographicInfo",@"dateAdded",@"currentClient",@"phoneNumbers", @"logs",@"medicationHistory",  @"notes", nil]];
    
    

    
    [self.clientDef.propertyGroups addGroup:clientInfoGroup];

//    self.clientDef.orderAttributeName=@"order";
    

    return self;


}



-(NSString *)calculateWechslerAgeWithBirthdate:(NSDate *)birthdate{

    
    NSDate *now=[NSDate date];
    NSDateFormatter *dayFormater=[[NSDateFormatter alloc]init];
    [dayFormater setDateFormat:@"d"];
    
    NSDateFormatter *monthFormater=[[NSDateFormatter alloc]init];
    [monthFormater setDateFormat:@"M"];
    
    NSDateFormatter *yearFormater=[[NSDateFormatter alloc]init];
    [yearFormater setDateFormat:@"Y"];
    
    NSLog(@"date years %@, months%@, days %@",[yearFormater stringFromDate:birthdate],[monthFormater stringFromDate:birthdate],[dayFormater stringFromDate:birthdate]);
    
    int nowYear, nowMonth, nowDay;
    
    nowYear=[[yearFormater stringFromDate:now]intValue];
    
    nowMonth=[[monthFormater stringFromDate:now]intValue];
    
    nowDay=[[dayFormater stringFromDate:now]intValue];
    
    int birthYear, birthMonth, birthDay;
    
    birthYear=[[yearFormater stringFromDate:birthdate]intValue];
    
    birthMonth=[[monthFormater stringFromDate:birthdate]intValue];
    
    birthDay=[[dayFormater stringFromDate:birthdate]intValue];
    
    int difYear,difMonth,difDay;
    if (birthDay >nowDay) {
        
        difDay=(nowDay+30)-birthDay;
        
        if (nowMonth>=birthMonth) {
             difMonth=(nowMonth-1)-birthMonth;
        
        }
        else
        {
            difMonth=((nowMonth+12)-1)-birthMonth;
            nowYear=nowYear-1;
        }
       
        
        
    }
    else
    {
        difDay=nowDay-birthDay;
        if (nowMonth>=birthMonth) {
            difMonth=nowMonth-birthMonth;
            
        }
        else
        {
            difMonth=(nowMonth+12)-birthMonth;
            nowYear=nowYear-1;
        }
    }
    
    difYear=nowYear-birthYear;
    
    NSString *age =[NSString stringWithFormat:@"%iy %im %id",difYear,difMonth,difDay];
    



    return age;
}

-(NSString *)calculateActualAgeWithBirthdate:(NSDate *)birthdate{


    NSDate *now =[NSDate date];
    
//    NSTimeInterval ageInterval=[birthdate timeIntervalSinceNow];
    
    //define a gregorian calandar
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
   
    //define the calandar unit flags
    NSUInteger unitFlags = NSDayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
     
    //define the date components
    NSDateComponents *dateComponents = [gregorianCalendar components:unitFlags
                                                                              fromDate:birthdate
                                                                                toDate:now
                                                                               options:0];
    
    int day, month, year;
    day=[dateComponents day];
    month=[dateComponents month];
    year=[dateComponents year];
 
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];

    [dateFormatter setDateFormat:@"M"];
    int dateMonth=[[dateFormatter stringFromDate:birthdate]intValue];
    if (dateMonth==4||dateMonth==6||dateMonth==9||dateMonth==11) {
        day=day-1;
    }
    if(dateMonth==2){
    
        day=day-3;
        [dateFormatter setDateFormat:@"Y"];
        int yearDiff=[[dateFormatter stringFromDate:birthdate]intValue];
        if (((yearDiff % 4 == 0) && (yearDiff % 100 != 0)) || (yearDiff % 400 == 0)) {
            [dateFormatter setDateFormat:@"Md"];
            if ([[dateFormatter stringFromDate:birthdate]intValue]==229) {
                day=day-1;
            }
            day=day+1; //leap year
           
        }
        
                
        
    }
    
    [dateFormatter setDateFormat:@"d"];
    int dateDiff=[[dateFormatter stringFromDate:birthdate]intValue];
    int nowDay=[[dateFormatter stringFromDate:now]intValue];
    if (dateDiff==nowDay) {
        
        day=0;
        
    }
    else if (dateDiff< nowDay)
    {
        
        day=nowDay-dateDiff;
    }


    
    return [NSString stringWithFormat:@"%iy %im %id", year,month,day];
}


-(NSString *)calculateWechslerAgeWithBirthdate:(NSDate *)birthdate toDate:(NSDate *)toDate{
    
    if (!toDate) {
        toDate=[NSDate date];
    }
    if (birthdate==NULL){
    
        return [NSString stringWithString:@"no birthdate"];
    
    }
 
    NSDateFormatter *dayFormater=[[NSDateFormatter alloc]init];
    [dayFormater setDateFormat:@"d"];
    
    NSDateFormatter *monthFormater=[[NSDateFormatter alloc]init];
    [monthFormater setDateFormat:@"M"];
    
    NSDateFormatter *yearFormater=[[NSDateFormatter alloc]init];
    [yearFormater setDateFormat:@"Y"];
    
    NSLog(@"date years %@, months%@, days %@",[yearFormater stringFromDate:birthdate],[monthFormater stringFromDate:birthdate],[dayFormater stringFromDate:birthdate]);
    
    int toYear, toMonth, toDateDay;
    
    toYear=[[yearFormater stringFromDate:toDate]intValue];
    
    toMonth=[[monthFormater stringFromDate:toDate]intValue];
    
    toDateDay=[[dayFormater stringFromDate:toDate]intValue];
    
    int birthYear, birthMonth, birthDay;
    
    birthYear=[[yearFormater stringFromDate:birthdate]intValue];
    
    birthMonth=[[monthFormater stringFromDate:birthdate]intValue];
    
    birthDay=[[dayFormater stringFromDate:birthdate]intValue];
    
    int difYear,difMonth,difDay;
    if (birthDay >toDateDay) {
        
        difDay=(toDateDay+30)-birthDay;
        
        if (toMonth>=birthMonth) {
            difMonth=(toMonth-1)-birthMonth;
            
        }
        else
        {
            difMonth=((toMonth+12)-1)-birthMonth;
            toYear=toYear-1;
        }
        
        
        
    }
    else
    {
        difDay=toDateDay-birthDay;
        if (toMonth>=birthMonth) {
            difMonth=toMonth-birthMonth;
            
        }
        else
        {
            difMonth=(toMonth+12)-birthMonth;
            toYear=toYear-1;
        }
    }
    
       
    difYear=toYear-birthYear;
   
    
    if (difMonth<0) {
        difYear=difYear-1;
        difMonth=12+difMonth;
        
    }
    if (difYear<0) {
        difYear=0;
        difMonth=0;
        difDay=0;
    }
    
    if (difDay<0&&difDay==0&&difYear==0) {
        difDay=0;
    }
    
    NSString *age =[NSString stringWithFormat:@"%iy %im %id",difYear,difMonth,difDay];
    
    
    
    
    return age;
}

-(NSString *)calculateActualAgeWithBirthdate:(NSDate *)birthdate toDate:(NSDate *)toDate{
    
    if (!toDate) {
        toDate=[NSDate date];
    }
    if (birthdate==NULL){
       
        return [NSString stringWithFormat:@"no birthdate"];
    }
    
    //    NSTimeInterval ageInterval=[birthdate timeIntervalSinceNow];
    
    //define a gregorian calandar
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //define the calandar unit flags
    NSUInteger unitFlags = NSDayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    //define the date components
    NSDateComponents *dateComponents = [gregorianCalendar components:unitFlags
                                                            fromDate:birthdate
                                                              toDate:toDate
                                                             options:0];
    
    int day, month, year;
    day=[dateComponents day];
    month=[dateComponents month];
    year=[dateComponents year];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"M"];
    int dateMonth=[[dateFormatter stringFromDate:birthdate]intValue];
    if (dateMonth==4||dateMonth==6||dateMonth==9||dateMonth==11) {
        day=day-1;
    }
    if(dateMonth==2){
        
        day=day-3;
        [dateFormatter setDateFormat:@"Y"];
        int yearDiff=[[dateFormatter stringFromDate:birthdate]intValue];
        if (((yearDiff % 4 == 0) && (yearDiff % 100 != 0)) || (yearDiff % 400 == 0)) {
            [dateFormatter setDateFormat:@"Md"];
            if ([[dateFormatter stringFromDate:birthdate]intValue]==229) {
                day=day-1;
            }
            day=day+1; //leap year
            
        }
        
        
        
    }
    
    [dateFormatter setDateFormat:@"d"];
    int dateDiff=[[dateFormatter stringFromDate:birthdate]intValue];
    int toDateDay=[[dateFormatter stringFromDate:toDate]intValue];
    if (dateDiff==toDateDay) {
        
        day=0;
        
    }
    else if (dateDiff< toDateDay)
    {
        
        day=toDateDay-dateDiff;
    }
    
    if (year<0) {
        year=0;
        month=0;
        day=0;
    }
    if (day<0&&month==0&&year==0) {
        day=0;
    }
    return [NSString stringWithFormat:@"%iy %im %id", year,month,day];
}

@end
