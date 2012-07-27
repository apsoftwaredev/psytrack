//
//  TeachingViewController.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "PresentationsViewController.h"
#import "PTTAppDelegate.h"
#import "EncryptedSCTextViewCell.h"
#import "TotalHoursAndMinutesCell.h"

@interface PresentationsViewController ()

@end

@implementation PresentationsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateFormatter setDateFormat:@"M/d/yyyy"];

    NSManagedObjectContext *managedObjectContext=appDelegate.managedObjectContext;
    SCEntityDefinition *presentationDef=[SCEntityDefinition definitionWithEntityName:@"PresentationEntity" managedObjectContext:managedObjectContext propertyNamesString:@"title;topics;hours;notes;deliveries;publications;logs;conferences;forums"];
    
    presentationDef.titlePropertyName=@"title";
    presentationDef.keyPropertyName=@"title";
    
    SCEntityDefinition *presentationDeliveredDef=[SCEntityDefinition definitionWithEntityName:@"PresentationDeliveredEntity" managedObjectContext:managedObjectContext propertyNamesString:@"audience;audienceSize;date;notes"];
    presentationDeliveredDef.titlePropertyName=@"date";
    presentationDeliveredDef.keyPropertyName=@"date";
    
    SCEntityDefinition *publicationDef=[SCEntityDefinition definitionWithEntityName:@"PublicationEntity" managedObjectContext:managedObjectContext propertyNamesString:@"authors;datePublished;notes;pageNumbers;publicationTitle;publisher;volume"];
    
    
    SCEntityDefinition *logDef=[SCEntityDefinition definitionWithEntityName:@"LogEntity" managedObjectContext:managedObjectContext propertyNamesString:@"dateTime;notes"];
    
    SCEntityDefinition *conferenceDef=[SCEntityDefinition definitionWithEntityName:@"ConferenceEntity" managedObjectContext:managedObjectContext propertyNamesString:@"title;attendenceSize; startDate;endDate;hours;notableSpeakers;notableTopics;notes;hostingOrganizations;logs"];
    
    conferenceDef.keyPropertyName=@"title";
    
    SCEntityDefinition *forumDef=[SCEntityDefinition definitionWithEntityName:@"ForumEntity" managedObjectContext:managedObjectContext propertyNamesString:@"forumName;dateStarted;dateEnded;notes;size;topics"];
    
    forumDef.keyPropertyName=@"forumName";
    
    SCEntityDefinition *topicDef=[SCEntityDefinition definitionWithEntityName:@"TopicEntity" managedObjectContext:managedObjectContext propertyNamesString:@"topic;notes"];
    
    topicDef.keyPropertyName=@"topic";
    
    SCEntityDefinition *hostingOrganizationDef=[SCEntityDefinition definitionWithEntityName:@"OrganizationEntity" managedObjectContext:managedObjectContext propertyNamesString:@"name;size;notes"];
    
    
    SCPropertyDefinition *presentationNotesPropertyDef=[presentationDef propertyDefinitionWithName:@"notes"];
    presentationNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *presentationTitlePropertyDef=[presentationDef propertyDefinitionWithName:@"title"];
    presentationTitlePropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *hostingOrganizationNotesPropertyDef=[hostingOrganizationDef propertyDefinitionWithName:@"notes"];
    hostingOrganizationNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *hostingOrganizationNamePropertyDef=[hostingOrganizationDef propertyDefinitionWithName:@"name"];
    hostingOrganizationNamePropertyDef.type=SCPropertyTypeTextView;
    
    
    SCPropertyDefinition *topicPropertyDef=[topicDef propertyDefinitionWithName:@"topic"];
    topicPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *topicNotesPropertyDef=[topicDef propertyDefinitionWithName:@"notes"];
    topicNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
//    SCPropertyDefinition *forumHostingOrganizationsPropertyDef=[forumDef propertyDefinitionWithName:@"hostingOrganizations"];
    
    
//    forumHostingOrganizationsPropertyDef.type=SCPropertyTypeObjectSelection;
//    
//    forumHostingOrganizationsPropertyDef.attributes=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:hostingOrganizationDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:YES];
    
    
    SCPropertyDefinition *forumEndDatePropertyDef = [forumDef propertyDefinitionWithName:@"dateEnded"];
	forumEndDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                             datePickerMode:UIDatePickerModeDate 
                                                              displayDatePickerInDetailView:NO];
    
    
    SCPropertyDefinition *forumStartDatePropertyDef = [forumDef propertyDefinitionWithName:@"dateStarted"];
	forumStartDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                               datePickerMode:UIDatePickerModeDate 
                                                                displayDatePickerInDetailView:NO];
    SCPropertyDefinition *forumNotesPropertyDef = [forumDef propertyDefinitionWithName:@"notes"];
	
	forumNotesPropertyDef.type = SCPropertyTypeTextView;
    
    SCPropertyDefinition *forumNotableTopicsPropertyDef = [forumDef propertyDefinitionWithName:@"topics"];
	
	forumNotableTopicsPropertyDef.type = SCPropertyTypeTextView;	
    
    
   
    
    
    SCPropertyDefinition *forumNamePropertyDef = [forumDef propertyDefinitionWithName:@"forumName"];
	
	forumNamePropertyDef.type = SCPropertyTypeTextView;	
    

    
    //end
    
    
    SCPropertyDefinition *conferenceHostingOrganizationsPropertyDef=[conferenceDef propertyDefinitionWithName:@"hostingOrganizations"];
    
    
    conferenceHostingOrganizationsPropertyDef.type=SCPropertyTypeObjectSelection;
    
    conferenceHostingOrganizationsPropertyDef.attributes=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:hostingOrganizationDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:YES];
    
    
    SCPropertyDefinition *conferenceEndDatePropertyDef = [conferenceDef propertyDefinitionWithName:@"endDate"];
	conferenceEndDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                               datePickerMode:UIDatePickerModeDate 
                                                                displayDatePickerInDetailView:NO];
    
    
    SCPropertyDefinition *conferenceStartDatePropertyDef = [conferenceDef propertyDefinitionWithName:@"startDate"];
	conferenceStartDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                         datePickerMode:UIDatePickerModeDate 
                                                          displayDatePickerInDetailView:NO];
    SCPropertyDefinition *conferenceNotesPropertyDef = [conferenceDef propertyDefinitionWithName:@"notes"];
	
	conferenceNotesPropertyDef.type = SCPropertyTypeTextView;
    
    SCPropertyDefinition *conferenceNotableTopicsPropertyDef = [conferenceDef propertyDefinitionWithName:@"notableTopics"];
	
	conferenceNotableTopicsPropertyDef.type = SCPropertyTypeTextView;	
    

    SCPropertyDefinition *conferenceNotableSpeakersPropertyDef = [conferenceDef propertyDefinitionWithName:@"notableSpeakers"];
	
	conferenceNotableSpeakersPropertyDef.type = SCPropertyTypeTextView;	
    
    
    SCPropertyDefinition *conferenceTitlePropertyDef = [conferenceDef propertyDefinitionWithName:@"title"];
	
	conferenceTitlePropertyDef.type = SCPropertyTypeTextView;	
    
    
    //set the order attributes name defined in the Publication Entity    
    publicationDef.orderAttributeName=@"order";
    publicationDef.titlePropertyName=@"publicationTitle;datePublished";
    SCEntityDefinition *publicationTypeDef = [SCEntityDefinition definitionWithEntityName:@"PublicationTypeEntity" 
                                                                     managedObjectContext:managedObjectContext
                                                                            propertyNames:[NSArray arrayWithObjects: @"publicationType",
                                                                                           nil]];
    
    
    //set the order attributes name defined in the Publication Type Entity      
    publicationTypeDef.orderAttributeName=@"order";
    SCPropertyDefinition *publicationTypePropertyDef = [publicationDef propertyDefinitionWithName:@"publicationType"];
    
	publicationTypePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *publicationSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:publicationTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
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
    

    
    SCPropertyDefinition *topicsPropertyDef=[presentationDef propertyDefinitionWithName:@"topics"];
    
    
    topicsPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    topicsPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:topicDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add topics"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];
    

    
    
    
    SCPropertyDefinition *presentationDeliveredNotesPropertyDef=[presentationDeliveredDef propertyDefinitionWithName:@"notes"];
    presentationDeliveredNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    SCPropertyDefinition *presentationDeliveredDatePropertyDef=[presentationDeliveredDef propertyDefinitionWithName:@"date"];
    
    
    
      //Set the date attributes in the dateTime property definition and make it so the date picker appears in the Same view.
    presentationDeliveredDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                    datePickerMode:UIDatePickerModeDate
                                                     displayDatePickerInDetailView:NO];
    
    

    
    
    SCPropertyDefinition *forumsPropertyDef=[presentationDef propertyDefinitionWithName:@"forums"];
    
    
    forumsPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    forumsPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:forumDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add forums"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:NO];
    

    
    
    //create the dictionary with the data bindings
    NSDictionary *lengthDataBindings = [NSDictionary 
                                       dictionaryWithObjects:[NSArray arrayWithObjects:@"length",nil] 
                                       forKeys:[NSArray arrayWithObjects:@"1",nil ]];
    
    
   
        
        //create the custom property definition
        SCCustomPropertyDefinition *lengthDataProperty = [SCCustomPropertyDefinition definitionWithName:@"LengthData"
                                                                                                 uiElementNibName:@"TotalHoursAndMinutesCell" objectBindings:lengthDataBindings];
        
        lengthDataProperty.title=@"Length Hrs";
        //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
        lengthDataProperty.autoValidate=FALSE;
        
        
        [presentationDef addPropertyDefinition:lengthDataProperty];
        
    
    
    SCPropertyDefinition *conferencesPropertyDef=[presentationDef propertyDefinitionWithName:@"conferences"];
    
   
    conferencesPropertyDef.type=SCPropertyTypeObjectSelection;
    
    conferencesPropertyDef.attributes=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:conferenceDef usingPredicate:nil allowMultipleSelection:YES allowNoSelection:YES];
    
     SCPropertyDefinition *presentationDeliveredPropertyDef=[presentationDef propertyDefinitionWithName:@"deliveries"];
    presentationDeliveredPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    presentationDeliveredPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:presentationDeliveredDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add Presentation Deliveries"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];
    
    SCPropertyDefinition *publicationsPropertyDef=[presentationDef propertyDefinitionWithName:@"publications"];
    
    publicationsPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    publicationsPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:publicationDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add publications"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];
    
    
    SCPropertyDefinition *conferenceLogPropertyDef=[conferenceDef propertyDefinitionWithName:@"logs"];
    
    conferenceLogPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    conferenceLogPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:logDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add Logs"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];
    
    SCPropertyDefinition *logPropertyDef=[presentationDef propertyDefinitionWithName:@"logs"];
    
    logPropertyDef.type=SCPropertyTypeArrayOfObjects;
    
    logPropertyDef.attributes=[SCArrayOfObjectsAttributes attributesWithObjectDefinition:logDef allowAddingItems:YES allowDeletingItems:YES allowMovingItems:YES expandContentInCurrentView:NO placeholderuiElement:[SCTableViewCell cellWithText:@"Add Logs"] addNewObjectuiElement:nil addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];
    
    //Do some property definition customization for the Log Entity defined in logDef
    
    //do some customizing of the log notes, change it to "Number" to make it shorter
    SCPropertyDefinition *logNotesPropertyDef = [logDef propertyDefinitionWithName:@"notes"];
    
    logNotesPropertyDef.title = @"Notes";
    
    
    logNotesPropertyDef.type=SCPropertyTypeCustom;
    logNotesPropertyDef.uiElementClass=[EncryptedSCTextViewCell class];
    
    NSDictionary *encryLogNotesTVCellKeyBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"notes",@"keyString",@"Notes",@"notes",nil] forKeys:[NSArray arrayWithObjects:@"1",@"32", @"33",@"34",nil]];
    
    
    logNotesPropertyDef.objectBindings=encryLogNotesTVCellKeyBindingsDic;
    //    phoneNumberPropertyDef.title=@"Phone Number";
    logNotesPropertyDef.autoValidate=NO;
    
    
    
    
    
    logDef.titlePropertyName=@"dateTime;notes";
    
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
    
    

    
    
    objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:presentationDef];
    
    
    if(![SCUtilities is_iPad]){
        
        self.tableView.backgroundView=nil;
        UIView *newView=[[UIView alloc]init];
        [self.tableView setBackgroundView:newView];
        
    
    }
    self.tableView.backgroundColor=[UIColor clearColor];
    presentationDef.titlePropertyName=@"title";
    presentationDef.keyPropertyName=@"title";
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    NSLog(@"self.navigationItem.rightBarButtonItems are %@",self.buttonsToolbar.items);
    
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Presentations";
    

    
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
@end