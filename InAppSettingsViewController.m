/*
 *  InAppSettingsViewController.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 2/1/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "InAppSettingsViewController.h"
#import "PTTAppDelegate.h"
#import "MySource.h"
#import "ClinicianEntity.h"
#import "CliniciansRootViewController_iPad.h"
#import "ClinicianViewController.h"
@interface InAppSettingsViewController ()

@end

@implementation InAppSettingsViewController
@synthesize eventsList,eventStore,eventViewController,psyTrackCalendar;

#pragma mark -
#pragma mark LifeCycle


- (void) didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    [appDelegate displayMemoryWarning];

    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Gracefully handle reloading the view controller after a memory warning
    tableModel = (SCArrayOfObjectsModel *)[[SCModelCenter sharedModelCenter] modelForViewController:self];
    if(tableModel)
    {
        [tableModel replaceModeledTableViewWith:self.tableView];
        return;
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
        
        
    }
 
    @try {
        ABAddressBookRef addressBook=ABAddressBookCreate();
       
  
   

	
	
	//Display all groups available in the Address Book
	
    
//    int CFGroupCount = ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
//    CFArrayRef groups  = ABAddressBookCopyArrayOfAllGroups((ABAddressBookRef) addressBook);
//    
//    for(CFIndex i = 0;i<CFGroupCount;i++)
//    {
//        ABRecordRef ref = CFArrayGetValueAtIndex(groups, i);
//
//    
//     bool   didRemove=NO;
//      didRemove =  (bool)   ABAddressBookRemoveRecord((ABAddressBookRef) addressBook, (ABRecordRef) ref, nil);
//        
//    }
//    
//    BOOL wantToSaveChanges=TRUE;
//    if (ABAddressBookHasUnsavedChanges(addressBook)) {
//        
//        if (wantToSaveChanges) {
//            bool didSave=FALSE;
//            didSave = ABAddressBookSave(addressBook, nil);
//            
//            if (!didSave) {/* Handle error here. */  NSLog(@"addressbook did not save");}
//            else NSLog(@"addressbook saved");
//        } 
//        else {
//            NSLog(@"address book revert becaus no changes");
//            ABAddressBookRevert(addressBook);
//            
//        }
//        
//    }

//    
    
    self.eventStore = [[EKEventStore alloc] init];
    
	self.eventsList = [[NSMutableArray alloc] initWithArray:0];

    
    SCLabelCell *defaultCalendarLabelCell=[[SCLabelCell alloc]initWithText:@"Calendar" withBoundKey:@"default_Calendar" withLabelTextValue:(NSString *)[(EKCalendar *)[self defaultCalendarName] title]];
    defaultCalendarLabelCell.tag=0;
    
    SCTextFieldCell *defaultCalendarNameTextFieldCell=[[SCTextFieldCell alloc]initWithText:@"Name" withPlaceholder:@"Calendar Name" withBoundKey:@"calendar_name" withTextFieldTextValue:(NSString *)psyTrackCalendar.title]; 
    
    defaultCalendarNameTextFieldCell.tag=1;
    
     SCTextFieldCell *defaultCalendarLocationCell=[[SCTextFieldCell alloc]initWithText:@"Location" withPlaceholder:@"Default Location" withBoundKey:@"location_name" withTextFieldTextValue:(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:@"calander_location"]]; 
    
    defaultCalendarLocationCell.tag=2;
    
    
    SCTableViewSection *defaultCalendarSection=[SCTableViewSection sectionWithHeaderTitle:@"Default Calendar Settings"];
    [defaultCalendarSection addCell:defaultCalendarLabelCell];
    [defaultCalendarSection addCell:defaultCalendarNameTextFieldCell]; 
    [defaultCalendarSection addCell:defaultCalendarLocationCell];
    
   
  
    int groupIdentifier=[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
    NSString *groupName=[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];
    NSLog(@"group identifier is %i",groupIdentifier);
   
    int groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
        BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults] boolForKey:kPTAutoAddClinicianToGroup];
    
    
    if ((groupIdentifier==-1||groupIdentifier==0||!groupCount)&&autoAddClinicianToGroup) {
        
        [ self changeABGroupNameTo:(NSString *)groupName addNew:NO checkExisting:YES];
        
        
    }
    
    groupIdentifier=[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
 NSLog(@"group identifier is after add new is %i",groupIdentifier);
  
    
    groupArray=[self addressBookGroupsArray];
    
    NSNumber *selectedItemIndexNumber = (NSNumber *)[dictionaryArrayOfStringsIndexForGroupIdentifierKey objectForKey:[[NSNumber numberWithInt:groupIdentifier]stringValue]];
   
    
    SCSelectionCell *defaultABGroupSelectionCell=[[SCSelectionCell alloc]initWithText:@"Group" withBoundKey:@"aBGroup" withSelectedIndexValue:selectedItemIndexNumber withItems:groupArray]; 
    
    
    
    defaultABGroupSelectionCell.allowMultipleSelection=NO;
    defaultABGroupSelectionCell.allowAddingItems=NO;
    defaultABGroupSelectionCell.allowDeletingItems=NO;
    defaultABGroupSelectionCell.allowMovingItems=NO;
    defaultABGroupSelectionCell.allowNoSelection=NO;
    defaultABGroupSelectionCell.autoDismissDetailView=YES;
    defaultABGroupSelectionCell.tag=3;
    defaultABGroupSelectionCell.delegate=self;
    
//    NSString *groupName=[(NSString *)[NSUserDefaults standardUserDefaults]valueForKey:kAddressBookGroupName];
    
    
    // Add a custom property that represents a custom cells for the email address and description defined TextFieldAndLableCell.xib
	
    //create the dictionary with the data bindings
    NSDictionary *groupNameDataBindings = [NSDictionary 
                                          dictionaryWithObjects:[NSArray arrayWithObjects:@"groupNameString",@"autoAddClinicianToGroup",nil] 
                                          forKeys:[NSArray arrayWithObjects:@"1",@"2",nil ]]; // 1 is the control tag
	
    //create the custom property definition
//    SCCustomPropertyDefinition *nameDataProperty = [SCCustomPropertyDefinition definitionWithName:@"GroupNameData"
//                                                                                 withuiElementNibName:@"TextFieldWithUpdateButtonCell"
//                                                                                   withObjectBindings:groupNameDataBindings];
//	
    

    SCControlCell *groupNameUpdateCell = [SCControlCell cellWithText:nil withKeyBindings:groupNameDataBindings withNibName:@"ABGroupNameChangeCell"];
	
    
    groupNameUpdateCell.delegate=self;
    
    groupNameUpdateCell.tag=4;
//    SCTextFieldCell *defaultABGroupNameTextFieldCell=[[SCTextFieldCell alloc]initWithText:@"Name" withPlaceholder:@"Group Name" withBoundKey:@"group_name" withTextFieldTextValue:groupName]; 
//    
//    defaultABGroupNameTextFieldCell.tag=4;
//    defaultABGroupNameTextFieldCell.delegate=self;
    
    SCTableViewSection *defaultABGroupSection=[SCTableViewSection sectionWithHeaderTitle:@"Default Address Book Group Settings"];
    
    
    [defaultABGroupSection addCell:defaultABGroupSelectionCell];
//    [defaultABGroupSection addCell:defaultABGroupNameTextFieldCell]; 
    [defaultABGroupSection addCell:groupNameUpdateCell];
    
    
    // Initialize tableModel
    tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self];
    
    [tableModel addSection:defaultCalendarSection];
    [tableModel addSection:defaultABGroupSection]; 
        
    }

@catch (NSException *exception) {
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    [appDelegate displayNotification:@"Problem Connecting to the Address Book Occured" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
}
@finally {
    
}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.eventStore=nil;
    self.psyTrackCalendar=nil;
    self.eventsList=nil;
    self.eventViewController=nil;
    
    
   tableModel=nil;
 
	

 
   dictionaryABGroupIdentifierValueForArrayOfStringsIndexKey=nil;
   dictionaryArrayOfStringsIndexForGroupIdentifierKey=nil;
    groupArray =nil;
//    CFRelease(addressBook);

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark -
#pragma mark calander settings
// Set the calendar edited by EKEventEditViewController to our chosen calendar - the default calendar.
//- (ABGroup *)defaultAddressBookGroup{
//    ABGroup *group;
//
////    NSString *addressBookIdentifier=[[NSUserDefaults standardUserDefaults] valueForKey:@"AddressBookIdentifier"];
////    NSInteger ABGroupIdentifier=[[NSUserDefaults standardUserDefaults] integerForKey:@"AddressBookGroupIdentifier"];
////
////    
////    ABAddressBook *addressBook=[[ABAddressBook alloc]init];
////    
////    
//
//
//
//    return group;
//}

// Set the calendar edited by EKEventEditViewController to our chosen calendar - the default calendar.
- (EKCalendar *)defaultCalendarName{
	
    
    // Get the default calendar from store.
    //    settingsDictionary=(NSDictionary *)[(PTTAppDelegate *)[UIApplication sharedApplication].delegate settingsPlistDictionary];
    NSString *defaultCalendarIdentifier=[[NSUserDefaults standardUserDefaults] valueForKey:@"defaultCalendarIdentifier"];
	
    
    
    
    
    
    // find local source
    EKSource *mySource = nil;
  
    
    BOOL iCloudEnabled=(BOOL)[[NSUserDefaults standardUserDefaults] valueForKey:@"icloud_preference"];
  
    if (iCloudEnabled) {
        for (EKSource *source in eventStore.sources){
            
            if ([source.title isEqualToString: @"iCloud"])
            {
                mySource = source;
//                NSLog(@"cloud source type is %@",source.sourceType);
                
                break;
            }
            
            
        }
        
        
    }
     
    if (!mySource) {
        
       
        
        for (EKSource *source in eventStore.sources){
            
            if (source.sourceType==EKSourceTypeLocal)
            {
                mySource = source;
                
                break;
            }
        }
        
    }
    
   
    
    
    if (mySource) 
    {
        NSString *defaultCalendarName=[[NSUserDefaults standardUserDefaults] valueForKey:@"calendar_name"];
        //        NSSet *calendars=(NSSet *)[localSource calendars];
        if (defaultCalendarIdentifier.length) 
        {
            
            
            self.psyTrackCalendar =[self.eventStore calendarWithIdentifier:defaultCalendarIdentifier]; 
                mySource =psyTrackCalendar.source;

           
        }
       
        if (!self.psyTrackCalendar) 
      
        {
            
            self.psyTrackCalendar = [EKCalendar calendarWithEventStore:self.eventStore];
            
            [[NSUserDefaults standardUserDefaults] setValue:psyTrackCalendar.calendarIdentifier forKey:@"defaultCalendarIdentifier"];
            [[NSUserDefaults standardUserDefaults] synchronize];
             self.psyTrackCalendar.source = mySource;
            
        }
        
        if (defaultCalendarName.length) {
            self.psyTrackCalendar.title =defaultCalendarName;
        }
        
        else 
        {
            
            self.psyTrackCalendar.title=@"Client Appointments";
        }
       
        
        
    }
    
    
    
    NSLog(@"cal id = %@", self.psyTrackCalendar.calendarIdentifier);
    
    NSError *error;
    
    if (![self.eventStore saveCalendar:self.psyTrackCalendar commit:YES error:&error ]) 
    {
        NSLog(@"something didn't go right");
    }
    else
    {
        NSLog(@"saved calendar");
        [[NSUserDefaults standardUserDefaults]setValue:psyTrackCalendar.calendarIdentifier forKey:@"defaultCalendarIdentifier"];
        //                 NSSet *calendars=(NSSet *)[localSource calendars];
        //                    for(id obj in calendars) { 
        //                    if([obj isKindOfClass:[EKCalendar class]]){
        //                        EKCalendar *calendar=(EKCalendar *)obj;
        //                        if ([calendar.calendarIdentifier isEqualToString:self.psyTrackCalendar.calendarIdentifier]) {
        //                            self.psyTrackCalendar=(EKCalendar *)calendar;
        //                          
        //                            break;
        //                        }
        
        
        //                    }
        
    }
    
    
    //            self.psyTrackCalendar =(EKCalendar *)localSource cal
    
    
    
    
    
    
    
    if (self.psyTrackCalendar) 
    {
        NSLog(@"self %@",self.psyTrackCalendar);
    }
    
    
    
 
    
  
	return  self.psyTrackCalendar;


}

#pragma mark -
#pragma mark EKCalendarChooserDelegate methods

-(void)calendarChooserDidCancel:(EKCalendarChooser *)calendarChooser{
    
    
    
    [calendarChooser dismissModalViewControllerAnimated:YES];
    
    
    
    
    
}




-(void)calendarChooserSelectionDidChange:(EKCalendarChooser *)calendarChooser{
    
    
    NSArray *calendarArray=[calendarChooser.selectedCalendars allObjects];
    if (calendarArray.count>0) {
        self.psyTrackCalendar=(EKCalendar *)[calendarArray objectAtIndex:0];
        NSString *calendarName=(NSString *)[self.psyTrackCalendar title];
        NSString *calenderIdentifier=self.psyTrackCalendar.calendarIdentifier;
        [[NSUserDefaults standardUserDefaults] setValue:calenderIdentifier forKey:@"defaultCalendarIdentifier"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        if (tableModel.sectionCount) {
            SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:0];
            if (section.cellCount>1) {
                SCTableViewCell *firstCell=(SCTableViewCell *)[section cellAtIndex:0];
                SCTableViewCell *secondCell=(SCTableViewCell *)[section cellAtIndex:1];
                
                if ([firstCell isKindOfClass:[SCLabelCell class]]) {
                    SCLabelCell *calenderLabelCell=(SCLabelCell *)firstCell;
                    [calenderLabelCell.label setText:calendarName];
                    
                    
                }
                if ([secondCell isKindOfClass:[SCTextFieldCell class]]) {
                    SCTextFieldCell *calenderNameTextFieldCell=(SCTextFieldCell *)secondCell;
                    [calenderNameTextFieldCell.textField setText:calendarName];
                    
                    
                }
                
                
                
            }
        }
    }
    
    
    [calendarChooser dismissModalViewControllerAnimated:YES];
    
    
}


#pragma mark -
#pragma mark configuring cells and sections
- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSInteger)index
{
    
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
    
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

-(void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{ 


    if (indexPath.section==1 && cell.tag==4) {
        SCTableViewSection *section=(SCTableViewSection*)[tableViewModel sectionAtIndex:1];
       NSString *groupName=[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];
        BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
        if ([cell isKindOfClass:[SCControlCell class]]) {
//            SCControlCell *controllCell=(SCControlCell *)cell;
            
            UITextField *textField=(UITextField *)[cell viewWithTag:1];
            SCSelectionCell *selectionCell=(SCSelectionCell *)[section cellAtIndex:0];
            textField.font=selectionCell.label.font;
            textField.textColor=selectionCell.label.textColor;
            NSLog(@"group name is %@", groupName);
            [tableViewModel.modelKeyValues setValue:groupName forKey:@"groupNameString"];
            [tableViewModel.modelKeyValues setValue:[NSNumber numberWithBool:autoAddClinicianToGroup] forKey:@"autoAddClinicianToGroup"];
        }
        
    
    }








}


#pragma mark -
#pragma mark SCTableViewModelDelegate methods

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillAppearForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{

    if([SCHelper is_iPad]){
        
        if (detailTableViewModel.modeledTableView.backgroundColor!=[UIColor clearColor]) {
            [detailTableViewModel.modeledTableView setBackgroundView:nil];
            [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
            [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; 
        }
        // Make the table view transparent
    }



}
- (void)tableViewModel:(SCTableViewModel *)tableViewModel customButtonTapped:(UIButton *)button forRowWithIndexPath:(NSIndexPath *)indexPath
{
//	SCTableViewCell *cell = [tableViewModel cellAtIndexPath:indexPath];
	
	// Get the object associated with the cell
//	NSManagedObject *managedObject = (NSManagedObject *)cell.boundObject;
    ABAddressBookRef addressBook;
    @try {
        addressBook =ABAddressBookCreate();
    }
    @catch (NSException *exception) {
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate displayNotification:@"Error Connecting to Address Book Occurred" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
        return;
    }
    @finally {
    
    
	
	switch (button.tag)
	{
		case 301:
        {
            NSString *groupNameString = (NSString *)[tableViewModel.modelKeyValues valueForKey:@"groupNameString"];
			NSLog(@"button 301 pressed group name string is %@ ",groupNameString);
             NSString *currentNameString=[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];
            
            if (groupNameString && groupNameString.length && ![groupNameString isEqualToString:currentNameString]) {
           
            [[NSUserDefaults standardUserDefaults]setValue:groupNameString forKey:kPTTAddressBookGroupName];
            SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:1];
            SCSelectionCell *aBGroupSelectionCell=(SCSelectionCell *)[section cellAtIndex:0];
            
            NSNumber *selectedIndex=(NSNumber *)[aBGroupSelectionCell selectedItemIndex];
            
            
            
            int groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
            
            NSNumber *groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
            
            if ([groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]]||[groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]]||!groupCount) {
                
               [ self changeABGroupNameTo:nil addNew:YES checkExisting:NO];
                
                
            }

            
            if ([selectedIndex isEqualToNumber:[NSNumber numberWithInt:-1]]) {
                NSLog(@"nothing selected");
                
               
          
                selectedIndex=nil;
                
                selectedIndex=(NSNumber *)[ dictionaryArrayOfStringsIndexForGroupIdentifierKey valueForKey:[groupIdentifierNumber stringValue]];
                
                
                [aBGroupSelectionCell setSelectedItemIndex:selectedIndex];
                
            
                
                
            }
            
           
            groupArray=[self addressBookGroupsArray];
            groupCount=groupArray.count;
            if (groupCount) {
                groupIdentifierNumber=[dictionaryABGroupIdentifierValueForArrayOfStringsIndexKey valueForKey:(NSString *)[selectedIndex stringValue]];
            
               
                
                int groupIdentifierInt=[groupIdentifierNumber intValue];
                
                ABRecordRef CFGroupRecord=(ABRecordRef)ABAddressBookGetGroupWithRecordID((ABAddressBookRef )addressBook, (ABRecordID)groupIdentifierInt);
            
            
                ABRecordSetValue((ABRecordRef) CFGroupRecord, (ABPropertyID) kABGroupNameProperty, (__bridge  CFStringRef)groupNameString, nil);
                
        
                BOOL wantToSaveChanges=TRUE;
                if (ABAddressBookHasUnsavedChanges(addressBook)) {
                    
                    if (wantToSaveChanges) {
                        bool didSave=FALSE;
                        didSave = ABAddressBookSave(addressBook, nil);
                        
                        if (!didSave) {/* Handle error here. */  NSLog(@"addressbook did not save");}
                        else NSLog(@"addressbook saved");
                    } 
                    else {
                        NSLog(@"address book revert becaus no changes");
                        ABAddressBookRevert(addressBook);
                        
                    }
                    
                }
                
                NSMutableArray *mutableArray=[[NSMutableArray alloc]initWithArray:aBGroupSelectionCell.items] ;
                
                NSString *selectedItemString=(NSString *)[mutableArray objectAtIndex:[selectedIndex integerValue]];
                
            NSLog(@"selected item string %@",selectedItemString);
            [mutableArray removeObjectAtIndex:[selectedIndex intValue]];
            [mutableArray insertObject:groupNameString atIndex:[selectedIndex intValue]];
            NSArray *itemsArray=[NSArray arrayWithArray:mutableArray];
                
            
            NSLog(@"items array is %@",itemsArray);
            selectedItemString=groupNameString;
                NSLog(@"group name string is %@",selectedItemString);
                aBGroupSelectionCell.items=itemsArray;
        
            aBGroupSelectionCell.label.text=groupNameString;
                NSLog(@"group names are %@",aBGroupSelectionCell.items);
                
//                CFRelease(CFGroupRecord);
                
            
            }
            }
        }
            break;
        case 302:
        {
            NSString *groupNameString = (NSString *)[tableViewModel.modelKeyValues valueForKey:@"groupNameString"];
			
            
            NSLog(@"button add pressed group name string is %@ ",groupNameString);
            
            if (groupNameString && groupNameString.length ) {
                
                [[NSUserDefaults standardUserDefaults]setValue:groupNameString forKey:kPTTAddressBookGroupName];
                SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:1];
                SCSelectionCell *aBGroupSelectionCell=(SCSelectionCell *)[section cellAtIndex:0];
                
                NSNumber *selectedIndex=nil;
                
                BOOL   autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
                
//                int groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
                
//                
                
//                BOOL addNew=TRUE;
                
//                if (addNew||[groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]]||[groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]]||!groupCount) {
                    
                
                [[NSUserDefaults standardUserDefaults]setBool:TRUE forKey:kPTAutoAddClinicianToGroup];
                    
                [ self changeABGroupNameTo:groupNameString addNew:YES checkExisting:NO];
                
                [[NSUserDefaults standardUserDefaults] setBool:autoAddClinicianToGroup forKey:kPTAutoAddClinicianToGroup];
                    
//                }
//                groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
                
                groupArray=[self addressBookGroupsArray];
                
              int  groupCount=groupArray.count;
                
               
                   
                    
                    
                    
                                        
                    
                    
             
                
                
               
               
                if (groupCount) {
//                   NSNumber * groupIdentifierNumber=[dictionaryABGroupIdentifierValueForArrayOfStringsIndexKey valueForKey:(NSString *)[selectedIndex stringValue]];
//                    
                    
                    
//                    int groupIdentifierInt=[groupIdentifierNumber intValue];
                    
//                    ABRecordRef CFGroupRecord=(ABRecordRef)ABAddressBookGetGroupWithRecordID((ABAddressBookRef )addressBook, (ABRecordID)groupIdentifierInt);
////                    
//                    
//                    ABRecordSetValue((ABRecordRef) CFGroupRecord, (ABPropertyID) kABGroupNameProperty, (__bridge  CFStringRef)groupNameString, nil);
                    
                    
//                    BOOL wantToSaveChanges=TRUE;
//                    if (ABAddressBookHasUnsavedChanges(addressBook)) {
//                        
//                        if (wantToSaveChanges) {
//                            bool didSave=FALSE;
//                            didSave = ABAddressBookSave(addressBook, nil);
//                            
//                            if (!didSave) {/* Handle error here. */  NSLog(@"addressbook did not save");}
//                            else NSLog(@"addressbook saved");
//                        } 
//                        else {
//                            NSLog(@"address book revert becaus no changes");
//                            ABAddressBookRevert(addressBook);
//                            
//                        }
//                        
//                    }
                    NSNumber *groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
                    aBGroupSelectionCell.items=groupArray;
                    selectedIndex=nil;
                    
                    selectedIndex=(NSNumber *)[ dictionaryArrayOfStringsIndexForGroupIdentifierKey valueForKey:[groupIdentifierNumber stringValue]];
                    
                    if (selectedIndex!=nil) {
                        [aBGroupSelectionCell setSelectedItemIndex:selectedIndex];
                    }
                    
                    

                    aBGroupSelectionCell.label.text=groupNameString;
                    NSLog(@"group names are %@",aBGroupSelectionCell.items);
                    NSLog(@"selected item index is %i",[selectedIndex intValue]);
                }
            }
        }
            
			break;
		case 303:
        {
           
            ABPeoplePickerNavigationController *peoplePicker=[[ABPeoplePickerNavigationController alloc]init];
            
            peoplePicker.peoplePickerDelegate = self;
            // Display only a person's phone, email, and birthdate
            NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty], 
                                       [NSNumber numberWithInt:kABPersonEmailProperty],
                                       [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
            
            
            peoplePicker.displayedProperties = displayedItems;
            // Show the picker 
            
            
            peoplePicker.addressBook=addressBook;
         
            [peoplePicker shouldAutorotateToInterfaceOrientation:YES];
            [peoplePicker setEditing:YES];
            
            [peoplePicker setPeoplePickerDelegate:self];
            
            
            // Display only a person's phone, email, and birthdate
            //	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty], 
            //                               [NSNumber numberWithInt:kABPersonEmailProperty],
            //                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
            
            
            
            //	abToDisplay.peoplePicker.displayedProperties=displayedItems;
            // Show the picker 
            
            
            [tableViewModel.viewController.navigationController presentModalViewController:peoplePicker animated:YES];
            

            
        
        }
            break;
            
        case 304:
        {
            NSString *groupNameString = (NSString *)[tableViewModel.modelKeyValues valueForKey:@"groupNameString"];
			NSLog(@"button 304 pressed group name string is %@ ",groupNameString);
//            
            
            ABAddressBookRef addressBook=ABAddressBookCreate();
            
//            BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
            
            int groupIdentifier=[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
            
            if (groupIdentifier!=-1) {
            
            
                int CFGroupCount = ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
            
                if ( CFGroupCount >0) {
                    
                    
                   
                    ABRecordRef group=(ABRecordRef)ABAddressBookGetGroupWithRecordID(addressBook, groupIdentifier);
                   
                
                    if (group) {
                        
                        
                        CFStringRef groupName=ABRecordCopyValue(group, kABGroupNameProperty);
                        NSString *alertMessage=[NSString stringWithFormat:@"Do you wish to delete the %@ group from the address book?", (__bridge NSString *)groupName];
                        UIAlertView *deleteConfirmAlert=[[UIAlertView alloc]initWithTitle:@"Remove Group From Address Book" message:alertMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes, Delete it", nil];
                        deleteConfirmAlert.tag=1;
                        [deleteConfirmAlert show];
//                      
                        CFRelease(group);
                    }
                
                  
                    
//                CFArrayRef groups  = ABAddressBookCopyArrayOfAllGroups((ABAddressBookRef) addressBook);
            //    
            //    for(CFIndex i = 0;i<CFGroupCount;i++)
            //    {
            //        ABRecordRef ref = CFArrayGetValueAtIndex(groups, i);
            //
            //    
            //     bool   didRemove=NO;
            //      didRemove =  (bool)   ABAddressBookRemoveRecord((ABAddressBookRef) addressBook, (ABRecordRef) ref, nil);
            //        
            //    }
            //    
            //    BOOL wantToSaveChanges=TRUE;
            //    if (ABAddressBookHasUnsavedChanges(addressBook)) {
            //        
            //        if (wantToSaveChanges) {
            //            bool didSave=FALSE;
            //            didSave = ABAddressBookSave(addressBook, nil);
            //            
            //            if (!didSave) {/* Handle error here. */  NSLog(@"addressbook did not save");}
            //            else NSLog(@"addressbook saved");
            //        } 
            //        else {
            //            NSLog(@"address book revert becaus no changes");
            //            ABAddressBookRevert(addressBook);
            //            
            //        }
            //        
            //    }
                }
                
            }
        }    
     
            break;
        case 305:
        {
            NSString *groupNameString = (NSString *)[tableViewModel.modelKeyValues valueForKey:@"groupNameString"];
			NSLog(@"button 305 pressed group name string is %@ ",groupNameString);
            
            int groupIdentifier=[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
            
            if (groupIdentifier!=-1) {
                
                
                int CFGroupCount = ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                
                if (CFGroupCount>0) {
                    
                    
                    
                    ABRecordRef group=(ABRecordRef)ABAddressBookGetGroupWithRecordID(addressBook, groupIdentifier);
                    CFArrayRef groupMembers;
                    groupMembers=nil;
                    
                    if (group) {
                        groupMembers =(CFArrayRef )ABGroupCopyArrayOfAllMembers(group);
                    }
                  
                    int groupMembersCount=0;
                    
                    if (groupMembers) {
                        groupMembersCount= CFArrayGetCount(groupMembers);
                    }
                    
                    
                    if (group && groupMembers &&groupMembersCount>0) {
                        
                        
                        CFStringRef groupName=ABRecordCopyValue(group, kABGroupNameProperty);
                        NSString *alertMessage;
                        if (groupMembersCount==1) {
                            alertMessage= [NSString stringWithFormat:@"Do you wish to import %i contact from the Address Book %@ group?",groupMembersCount, (__bridge NSString *)groupName];
                        }
                        else {
                            alertMessage= [NSString stringWithFormat:@"Do you wish to import %i contacts from the Address Book %@ group?",groupMembersCount, (__bridge NSString *)groupName];
                        }
                       
                        UIAlertView *deleteConfirmAlert=[[UIAlertView alloc]initWithTitle:@"Import Contacts" message:alertMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
                        deleteConfirmAlert.tag=2;
                        [deleteConfirmAlert show];
                        
                        
                    
                        //                        
                    }
                    else {
                        
                        
                        
                        [appDelegate displayNotification:@"This group does not have any members to import." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
                        
                    }
                    
                    if (group) {
                        CFRelease(group);
                    }
                    if (groupMembers) {
                        CFRelease(groupMembers);
                    }
                }
                else {
                    [appDelegate displayNotification:@"Unable to find Group. Must specify an existing Address Book group with members to import." forDuration:4.0 location:kPTTScreenLocationTop inView:nil];
                }
                
            }
            
//            NSString *currentNameString=[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];
            
            
            
        }    
            break;  
    }

}    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag==1) 
    {
    if (buttonIndex==1) {
        ABAddressBookRef addressBook=ABAddressBookCreate();
        
//        BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
        
        int groupIdentifier=[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
        
        if (groupIdentifier!=-1) 
        {
            
            
            int CFGroupCount = ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
            
            if ( CFGroupCount >0) {
                
                
                
                ABRecordRef group=(ABRecordRef)ABAddressBookGetGroupWithRecordID(addressBook, groupIdentifier);
                bool   didRemove=NO;
                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                if (group) {

        
        
        
                    didRemove =  (bool)   ABAddressBookRemoveRecord((ABAddressBookRef) addressBook, (ABRecordRef) group, nil);
                    
                    
                    BOOL wantToSaveChanges=TRUE;
                    bool didSave=FALSE;
                    if (ABAddressBookHasUnsavedChanges(addressBook)) {
                        
                        if (wantToSaveChanges) {
                            
                            didSave = ABAddressBookSave(addressBook, nil);
                            
                            if (!didSave) {/* Handle error here. */  NSLog(@"addressbook did not save");}
                            else NSLog(@"addressbook saved");
                        } 
                        else {
                            NSLog(@"address book revert becaus no changes");
                            ABAddressBookRevert(addressBook);
                            
                        }
                        
                    }
                    
                    
                    if (!didRemove ||!didSave) {
                        
                        

                        [appDelegate displayNotification:@"Not able to remove the group" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
                    }
                    else 
                    {
                        [appDelegate displayNotification:@"Group Successfully Removed" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
                        
                        [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:kPTTAddressBookGroupName];
                        [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:kPTTAddressBookGroupIdentifier];
                        [[NSUserDefaults standardUserDefaults ]synchronize];
                        
                        SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:1];
                        
                        SCSelectionCell *selectionCell=(SCSelectionCell*)[section cellAtIndex:0];
                        
                        
                        
                        selectionCell.label.text=@"";
                        
                        SCTableViewCell *controlCell=(SCTableViewCell *)[section cellAtIndex:1];
                        
                        UITextField *textField=(UITextField *)[controlCell viewWithTag:1];
                        textField.text=@"";
                        
                        [tableModel.modelKeyValues setValue:@"" forKey:@"groupNameString"];
                       [ tableModel.modelKeyValues setValue:[NSNumber numberWithBool:FALSE] forKey:@"autoAddClinicianToGroup"];
                        [[NSUserDefaults standardUserDefaults]setBool:FALSE forKey:kPTAutoAddClinicianToGroup];
                        [controlCell reloadBoundValue];
                        
                        NSMutableArray *mutableArray=[NSMutableArray arrayWithArray:selectionCell.items];
                        if ([selectionCell.selectedItemIndex integerValue]<selectionCell.items.count) {
                            [mutableArray removeObjectAtIndex:[selectionCell.selectedItemIndex integerValue]];
                            selectionCell.selectedItemIndex=[NSNumber numberWithInt:-1];
                            selectionCell.items=mutableArray;

                        }
                                                
                    }
   
                }
                else 
                {
                    [appDelegate displayNotification:@"Group not available to delete." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
                }
                
            }
           
        }
        if (addressBook) {
            CFRelease(addressBook);
        }
        NSLog(@"button index is %i", buttonIndex);
        
    }
    else {
        NSLog(@"button index is %i", buttonIndex);
    }

    }
    
    else if (alertView.tag==2){
        
        NSLog(@"button index is %i", buttonIndex);

        if (buttonIndex==1) {
            [self importAllContactsInGroup];
        }
    }

}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
    
    if (tableViewModel.tag==0)
        
    {
        
        if (indexPath.section==0) {
            
            switch (cell.tag) {
                case 0:
                {
                    EKCalendarChooser *calendarChooser=[[EKCalendarChooser alloc]initWithSelectionStyle:EKCalendarChooserSelectionStyleSingle displayStyle:EKCalendarChooserDisplayAllCalendars eventStore:self.eventStore];
                    
                    calendarChooser.showsCancelButton=YES;
                    NSMutableSet *set=[NSMutableSet setWithObject:self.psyTrackCalendar];
                    
                    [calendarChooser setSelectedCalendars:set];
                    
                    [calendarChooser setDelegate:self];
                    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:calendarChooser];	
                    
                    
                    [[self navigationController] presentModalViewController:navController animated:YES];
                    
                    
                    
                    
                }
                    
                case 2:
                {
                    
                    
                    
                }
                    
                    break;
                    
                default:
                    break;
            }
        }
        if (indexPath.section==1) {
            
            switch (cell.tag) {
                    //                    case 3:
                    //                    {
                    //                        if ([cell isKindOfClass:[SCSelectionCell class]]) {
                    //                            SCSelectionCell *selectionCell=(SCSelectionCell *)cell;
                    //                            
                    //                            selectionCell.items=[self addressBookGroupsArray];
                    //                            
                    //                        }                        
                    //                        
                    //                        
                    //                    }
                    
                case 2:
                {
                    
                    
                    
                }
                    
                    break;
                    
                default:
                    break;
            }
        }
        
    }
    
    
}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableViewModel.tag==0)
        
    {
        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        
        
        switch (cell.tag) {
            case 1:
            {
                
                if ([cell isKindOfClass:[SCTextFieldCell class]]) {
                    SCTextFieldCell *calendarNameTextFieldCell=(SCTextFieldCell *)cell;
                    UITextField *caladnerNameTextField=(UITextField *) calendarNameTextFieldCell.textField;
                    
                    [self.psyTrackCalendar setTitle:(NSString *)caladnerNameTextField.text]; 
                    
                    NSError *error;
                    
                    if (![self.eventStore saveCalendar:self.psyTrackCalendar commit:YES error:&error ]) 
                    {
                        NSLog(@"something didn't go right");
                    }
                    else
                    {
                        NSLog(@"saved calendar");
                        NSString *calenderIdentifier=self.psyTrackCalendar.calendarIdentifier;
                        [[NSUserDefaults standardUserDefaults] setValue:calenderIdentifier forKey:@"defaultCalendarIdentifier"];
                        [[NSUserDefaults standardUserDefaults] setValue:psyTrackCalendar.title forKey:@"calendar_name"];
                        
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        
                        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
                        SCTableViewCell *firstCalendarCell=(SCTableViewCell *)[section cellAtIndex:0];
                        
                        if ([firstCalendarCell isKindOfClass:[SCLabelCell class]]) {
                            SCLabelCell * calendarSelectionLabelCell=(SCLabelCell *)firstCalendarCell;
                            
                            [calendarSelectionLabelCell.label setText:[self.psyTrackCalendar title] ];
                            
                        }
                        
                        
                        //                 NSSet *calendars=(NSSet *)[localSource calendars];
                        //                    for(id obj in calendars) { 
                        //                    if([obj isKindOfClass:[EKCalendar class]]){
                        //                        EKCalendar *calendar=(EKCalendar *)obj;
                        //                        if ([calendar.calendarIdentifier isEqualToString:self.psyTrackCalendar.calendarIdentifier]) {
                        //                            self.psyTrackCalendar=(EKCalendar *)calendar;
                        //                          
                        //                            break;
                        //                        }
                        
                        
                        //                    }
                        
                    }
                    
                    
                    
                    
                    
                }
                
                
            }
                break;
            case 2:
            {
                
                if ([cell isKindOfClass:[SCTextFieldCell class]]) {
                    SCTextFieldCell *calendarLocationTextFieldCell=(SCTextFieldCell *)cell;
                    UITextField *caladnerLocationTextField=(UITextField *) calendarLocationTextFieldCell.textField;
                    
                    NSLog(@"location text%@",caladnerLocationTextField.text);
                    [[NSUserDefaults standardUserDefaults] setValue:caladnerLocationTextField.text forKey:@"calander_location"];
                    
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                }
                
            }
                break;
                
            case 3:
            {
                @try {
                    ABAddressBookRef addressBook=ABAddressBookCreate();
                
                    
                
                if ([cell isKindOfClass:[SCSelectionCell class]]) {
                    SCSelectionCell *selectionCell=(SCSelectionCell *)cell;
                    
                    int groupIdentifier;
                    if ([selectionCell selectedItemIndex]) {
                        
                        
                        groupIdentifier=(int)[(NSNumber *)[dictionaryABGroupIdentifierValueForArrayOfStringsIndexKey objectForKey:[[selectionCell selectedItemIndex]stringValue]]intValue];
                        
                        NSLog(@"group strings index is keys are%@",[dictionaryABGroupIdentifierValueForArrayOfStringsIndexKey allKeys]);
                        
                        NSLog(@"group identifiers keys are %@",[dictionaryArrayOfStringsIndexForGroupIdentifierKey allKeys]);
                        [[NSUserDefaults standardUserDefaults] setInteger:groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
                        
                        
                        
                        
                        
                        
                        
                        int groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
                        
                        if (!groupCount) {[self changeABGroupNameTo:(NSString *)[NSString string] addNew:YES checkExisting:NO];}
                        
                        groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
                        
                        if (groupCount) {
                            
                            NSLog(@"group identifier %i",groupIdentifier);
                            NSLog(@"address book %@", addressBook);
                    
                            
                            ABRecordRef group;
//                            NSLog(@"group is %@",group);

                             group=(ABRecordRef)ABAddressBookGetGroupWithRecordID((ABAddressBookRef )addressBook, (ABRecordID)groupIdentifier);
                            
                            if (group) {
                            CFStringRef chosenGroupName=(CFStringRef) ABRecordCopyValue((ABRecordRef) group, (ABPropertyID) kABGroupNameProperty);
                            
                                
                                                            NSLog(@"group name set is %@",(__bridge NSString *)chosenGroupName);
                            
                            [[NSUserDefaults standardUserDefaults] setValue:(__bridge NSString *)chosenGroupName forKey:kPTTAddressBookGroupName];
                            
                            
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            
                            [tableViewModel.modelKeyValues setValue:(__bridge NSString *)chosenGroupName forKey:@"groupNameString"];
                            
                            SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:1];
                            SCTableViewCell *groupNameCell=(SCTableViewCell *)[section cellAtIndex:1];
                            UITextField *textField=(UITextField *)[groupNameCell viewWithTag:1];
                            textField.text=(__bridge NSString *)chosenGroupName;
                                CFRelease(chosenGroupName); 
                                CFRelease(group);

                            }

                            
                            
                        }
                    }
                    
                    
                }
                }
                @catch (NSException *exception) {
                    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                    
                    [appDelegate displayNotification:@"Problem Connecting to Address Book Occured" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
                }
                
                @finally {
                    
                }  
                 
            }
                break;
            case 4:
            {
                if ([cell isKindOfClass:[SCControlCell class]]) {
                
                
                NSLog(@"value changed for auto add is %i", [(NSNumber *)[tableViewModel.modelKeyValues valueForKey:@"autoAddClinicianToGroup"]boolValue]);
                    BOOL autoAddClinicianToGroup=(BOOL)[(NSNumber *)[tableViewModel.modelKeyValues valueForKey:@"autoAddClinicianToGroup"]boolValue];
                    
                    BOOL autoAddCliniciansAlreadySet=[[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
                    
                    //so it runs only if the switch has changed.
                    if (autoAddClinicianToGroup!=autoAddCliniciansAlreadySet) {
                    
                    [[NSUserDefaults standardUserDefaults] setBool:autoAddClinicianToGroup forKey:kPTAutoAddClinicianToGroup];
                    
                    
                    if (autoAddClinicianToGroup) {
                        
                         NSString *groupNameString = (NSString *)[tableViewModel.modelKeyValues valueForKey:@"groupNameString"];
                        
                         [[NSUserDefaults standardUserDefaults] setBool:autoAddClinicianToGroup forKey:kPTAutoAddClinicianToGroup];
                       
                        [self changeABGroupNameTo:groupNameString addNew:NO checkExisting:YES];
                        
                        [self  tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath];
                        [cell reloadBoundValue];
                       [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:kPTAutoAddClinicianToGroup];
                        
                        groupArray=[self addressBookGroupsArray];
                        
                        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:kPTAutoAddClinicianToGroup];
                       
                        
                        
                        int  groupCount=groupArray.count;
                        
                        
                        
                        
                        
                        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:1];
                        SCSelectionCell *aBGroupSelectionCell=(SCSelectionCell *)[section cellAtIndex:0];

                        NSNumber *selectedIndex=nil;
                        
                        
                        
                        
                        
                        
                        
                        if (groupCount) {
                            //                   NSNumber * groupIdentifierNumber=[dictionaryABGroupIdentifierValueForArrayOfStringsIndexKey valueForKey:(NSString *)[selectedIndex stringValue]];
                            //                    
                            
                            
                            //                    int groupIdentifierInt=[groupIdentifierNumber intValue];
                            
                            //                    ABRecordRef CFGroupRecord=(ABRecordRef)ABAddressBookGetGroupWithRecordID((ABAddressBookRef )addressBook, (ABRecordID)groupIdentifierInt);
                            ////                    
                            //                    
                            //                    ABRecordSetValue((ABRecordRef) CFGroupRecord, (ABPropertyID) kABGroupNameProperty, (__bridge  CFStringRef)groupNameString, nil);
                            
                            
                            //                    BOOL wantToSaveChanges=TRUE;
                            //                    if (ABAddressBookHasUnsavedChanges(addressBook)) {
                            //                        
                            //                        if (wantToSaveChanges) {
                            //                            bool didSave=FALSE;
                            //                            didSave = ABAddressBookSave(addressBook, nil);
                            //                            
                            //                            if (!didSave) {/* Handle error here. */  NSLog(@"addressbook did not save");}
                            //                            else NSLog(@"addressbook saved");
                            //                        } 
                            //                        else {
                            //                            NSLog(@"address book revert becaus no changes");
                            //                            ABAddressBookRevert(addressBook);
                            //                            
                            //                        }
                            //                        
                            //                    }
                            NSNumber *groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
                            aBGroupSelectionCell.items=groupArray;
                            selectedIndex=nil;
                            
                            selectedIndex=(NSNumber *)[ dictionaryArrayOfStringsIndexForGroupIdentifierKey valueForKey:[groupIdentifierNumber stringValue]];
                            
                            if (selectedIndex!=nil) {
                                [aBGroupSelectionCell setSelectedItemIndex:selectedIndex];
                            }
                            
                            
                            NSString *groupNameString = (NSString *)[tableViewModel.modelKeyValues valueForKey:@"groupNameString"];
                            aBGroupSelectionCell.label.text=groupNameString;
                            NSLog(@"group names are %@",aBGroupSelectionCell.items);
                            NSLog(@"selected item index is %i",[selectedIndex intValue]);
                        }

                        
                    }
                    
                    
                    
                    //                        
                    //                        [[NSUserDefaults standardUserDefaults]synchronize];
                
                }
                
                //                if ([cell isKindOfClass:[SCTextFieldCell class]]) {
                //                   
                //                      
                //                    SCTextFieldCell *groupNameTextFieldCell=(SCTextFieldCell *)cell;
                //                    UITextField *groupNameTextField=(UITextField *) groupNameTextFieldCell.textField;
                //                  
                //                    NSLog(@"groupName Field text%@",groupNameTextField.text);
                //                   
                //                        
                //                   
                //                                        
                //                    
                //                    SCTableViewSection *section=(SCTableViewSection*)[tableViewModel sectionAtIndex:1];
                //                    SCSelectionCell *groupSelectionCell=(SCSelectionCell *)[section cellAtIndex:0];
                //                    
                //                    if ([groupSelectionCell.selectedItemIndex intValue] <[groupSelectionCell.items count]) {
                //                        
                //                        [[NSUserDefaults standardUserDefaults] setValue:groupNameTextField.text forKey:kAddressBookGroupName];
                //                        
                //                        [[NSUserDefaults standardUserDefaults]synchronize];
                //                        
                //                        [self changeABGroupNameTo:(NSString *)groupNameTextField.text];
                //                        if ( [groupSelectionCell.selectedItemIndex intValue]< groupSelectionCell.items.count &&[groupSelectionCell.selectedItemIndex intValue]>-1) {
                //                            
                //                        
                //                        NSString *groupNameInStringsArray=(NSString *)[groupSelectionCell.items objectAtIndex: [groupSelectionCell.selectedItemIndex intValue] ];
                //                        NSLog(@"group name in strig array is %@",groupNameInStringsArray);
                //                        
                //                        groupNameInStringsArray =[[NSUserDefaults standardUserDefaults] valueForKey:kAddressBookGroupName];
                //                        groupSelectionCell.label.text=groupNameTextField.text;
                //                        }
                ////                        int groupIdentifier=[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
                ////                        if (groupIdentifier!=-1) {
                ////                        groupSelectionCell.items=[self addressBookGroupsArray];
                ////                        }
                //
                //                    }
                //                                      
                //                    //                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[tableViewModel indexPathForCell:groupSelectionCell]] withRowAnimation:(UITableViewRowAnimation)UITableViewRowAnimationRight];
                //                    
                //                }         
                [[NSUserDefaults standardUserDefaults]synchronize];
                }
            }
                break;    
                
            default:
                break;
        }
    }
    
}


#pragma mark -
#pragma mark PeoplePicker delegate methods
-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{


    [peoplePicker dismissViewControllerAnimated:YES completion:nil];

}


- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{

    return YES;
  
  

}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{

    return YES;


}



//-(void)tableViewModel:(SCTableViewModel *)tableViewModel didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
//    
//    NSLog(@"cell tag is %i",cell.tag);
//    if (indexPath.section==1 && cell.tag==4) {
//           
//    SCTableViewSection *section=(SCTableViewSection*)[tableViewModel sectionAtIndex:1];
//    SCTextFieldCell *groupNameTextFieldCell=(SCTextFieldCell *)[section cellAtIndex:1];
//    UITextField *groupNameTextField=(UITextField *) groupNameTextFieldCell.textField;
//
//    [self changeABGroupNameTo:(NSString *)groupNameTextField.text];
//    SCSelectionCell *groupSelectionCell=(SCSelectionCell *)[section cellAtIndex:0];
//    groupSelectionCell.items=[self addressBookGroupsArray];
//    
//    
//    
//    }
//    [detailTableViewModel reloadBoundValues];
//
//    [detailTableViewModel.modeledTableView reloadData];
//
//
//
//}


#pragma mark -
#pragma mark additonal Methods for working with address book
-(NSArray *)addressBookGroupsArray{

    ABAddressBookRef addressBook;
    @try {
        
        addressBook=ABAddressBookCreate();        
        
    }
    @catch (NSException *exception) {
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [appDelegate displayNotification:@"Not able to access Address Book" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
        return nil;
    }
    @finally 
    {
        BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
        ABRecordRef group=nil;
       
        int groupIdentifier=-1;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName])
        {
            
         groupIdentifier=(NSInteger )[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
        }
            
        if (groupIdentifier>0) {
        
            
          group=  ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
            
        }
           
            
            
            
            
        CFStringRef CFGroupName;
                
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName]) {
            
            CFGroupName=(__bridge CFStringRef)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];  
            
        }
        else {
            @try {
                 NSString *userDefaultName=[PTTAppDelegate retrieveFromUserDefaults:@"abgroup_name"];
            
                
                CFGroupName=(__bridge_retained  CFStringRef)userDefaultName;
            
            }
            @catch (NSException *exception) {
                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                

                [appDelegate displayNotification:@"Unable to access addressbook settings" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
            }
            @finally {
            
            }
           
            
        }
        
        
        
        
        if (!CFStringGetLength(CFGroupName) && autoAddClinicianToGroup) {
            NSString *clinicians=@"Clinicians";
            CFGroupName=(__bridge CFStringRef)clinicians;
            [[NSUserDefaults standardUserDefaults] setValue:(__bridge NSString*)CFGroupName forKeyPath:kPTTAddressBookGroupName];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
                
           NSLog(@"group name is %@",CFGroupName);   
            //check to see if the group name exists already
            int groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
            CFArrayRef CFGroupsCheckNameArray;
            CFStringRef CFGroupNameCheck ;
            ABRecordRef groupInCheckNameArray;
            if (groupCount&&!group ) {
                
                CFGroupsCheckNameArray= (CFArrayRef )ABAddressBookCopyArrayOfAllGroups((ABAddressBookRef) addressBook);
                NSLog(@"cggroups array %@",CFGroupsCheckNameArray);
                
                
                for (CFIndex i = 0; i < groupCount; i++) {
                    groupInCheckNameArray = CFArrayGetValueAtIndex(CFGroupsCheckNameArray, i);
                    CFGroupNameCheck  = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);
                    
                    
                    CFComparisonResult result=  (CFComparisonResult) CFStringCompare (
                                                                                      ( CFStringRef)CFGroupName,
                                                                                      (CFStringRef) CFGroupNameCheck,
                                                                                      1
                                                                                      );
                    
                    NSLog(@"result is %ld and %d",result,kCFCompareEqualTo);
                    if (result==0) {
                        group=groupInCheckNameArray;
                        break;
                    }
//                    CFRelease(CFGroupsCheckNameArray); 
//                    CFRelease(CFGroupNameCheck);
                    
                    NSLog(@"group is %@",group);
                    
                }
            }
            
        
        

    
    
    
    
     
    NSMutableArray *allGroups;
      
    
    
      
    if (!group) {
        
    
        
        [self changeABGroupNameTo:(__bridge NSString*) CFGroupName addNew:YES checkExisting:NO];
        groupIdentifier=(NSInteger )[(NSNumber *)[[NSUserDefaults standardUserDefaults]valueForKey:kPTTAddressBookGroupIdentifier]intValue];
        group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
        
//        //        ABRecordRef CFAddressBookGroupRecord =  ABGroupCreate ();
//        
//        group=ABGroupCreate();
//        
//        //        ABRecord *groupRecord=(ABRecord *)[group getRecordRef];
//        
//        //        NSLog(@"group composite name is %@",groupRecord.compositeName);
//        
//        bool didSetGroupName=FALSE;
//        didSetGroupName= (bool) ABRecordSetValue (
//                                                  group,
//                                                  (ABPropertyID) kABGroupNameProperty,
//                                                  (__bridge CFStringRef)groupName  ,
//                                                  nil
//                                                  );  
//        //        NSLog(@"group record identifier is %i",groupRecord.recordID);
//        
//        BOOL wantToSaveChanges=TRUE;
//        if (ABAddressBookHasUnsavedChanges(addressBook)) {
//            
//            if (wantToSaveChanges) {
//                bool didSave=FALSE;
//                didSave = ABAddressBookSave(addressBook, nil);
//                
//                if (!didSave) {/* Handle error here. */}
//                
//            } 
//            else {
//                
//                ABAddressBookRevert(addressBook);
//                
//            }
//            
//        }
//        
//        //        ABRecord *groupRecord=[[ABRecord alloc]initWithABRef:(CFTypeRef)kABGroupType ];
//        
//        NSLog(@"group idenitifer is%i",ABRecordGetRecordID(group));
//
//        NSLog(@"group name is %@", (__bridge NSString *)ABRecordCopyValue(group, kABGroupNameProperty));
//        groupIdentifier=ABRecordGetRecordID(group);
//        
//        
//        [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
//        
//        [[NSUserDefaults standardUserDefaults]synchronize];
//            
//            
        
    } 
    // Get the ABSource object that contains this new group
    
   
      
    NSNumber *groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
    
    if ([groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]]||[groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]]||!groupCount) {
        
        [ self changeABGroupNameTo:nil addNew:YES checkExisting:NO];
        
        
    }
    
    
    
     groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
    if (groupCount) {
   
           CFArrayRef CFGroupsArray= (CFArrayRef )ABAddressBookCopyArrayOfAllGroups((ABAddressBookRef) addressBook);
       NSLog(@"cggroups array %@",(__bridge NSArray *) CFGroupsArray);
        
        if (CFGroupsArray) {
        
      
        dictionaryABGroupIdentifierValueForArrayOfStringsIndexKey=[[NSMutableDictionary alloc]init];
        dictionaryArrayOfStringsIndexForGroupIdentifierKey=[[NSMutableDictionary alloc]init];
            allGroups = [[NSMutableArray alloc] init];
            
            ABRecordRef groupInCFArray;
//            CFStringRef CFGroupName ;
            for (CFIndex i = 0; i < groupCount; i++) {
               
                groupInCFArray = CFArrayGetValueAtIndex(CFGroupsArray, i);
                CFGroupName  = ABRecordCopyValue(groupInCFArray, kABGroupNameProperty);
                int CFGroupID=ABRecordGetRecordID((ABRecordRef) groupInCFArray);
                        
                [allGroups addObject:(__bridge NSString*)CFGroupName];
                NSDictionary *dicStringIndexValueForGroupIdendifierKey=[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:i] forKey:[[NSNumber numberWithInt:CFGroupID]stringValue]];
                
                NSDictionary *dicGroupIdendifierValueForStringIndexKey=[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:CFGroupID] forKey:[[NSNumber numberWithInt:i]stringValue]];
                
              [dictionaryABGroupIdentifierValueForArrayOfStringsIndexKey addEntriesFromDictionary:dicGroupIdendifierValueForStringIndexKey];
              [ dictionaryArrayOfStringsIndexForGroupIdentifierKey addEntriesFromDictionary:dicStringIndexValueForGroupIdendifierKey];
               
               
             
            }     
         
            
            NSLog(@"array of group names %@",allGroups);
            CFRelease(CFGroupsArray);
    //        CFRelease(CFGroupName);
            
        }
    
    }
        if (group) {
            CFRelease(group);
        }
//        if (addressBook) {
//            CFRelease(addressBook);
//        }
        return allGroups;
    }
}


-(void)changeABGroupNameTo:(NSString *)groupName  addNew:(BOOL)addNew checkExisting:(BOOL)checkExisting{
    
    ABAddressBookRef addressBook;
    @try 
    {
   
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
   
        ABRecordRef group=nil;
        int groupIdentifier;
       int groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
        BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
        if ((!groupName ||!groupName.length||checkExisting)&&autoAddClinicianToGroup) {
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName]) {
                
                if (!checkExisting) {
                
                    groupName=(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];  
                    
                }
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
    CFArrayRef CFGroupsCheckNameArray=nil;
    CFStringRef CFGroupNameCheck =nil;
    ABRecordRef groupInCheckNameArray=nil;
    if (groupCount) 
    {
        
        CFGroupsCheckNameArray= (CFArrayRef )ABAddressBookCopyArrayOfAllGroups((ABAddressBookRef) addressBook);
        NSLog(@"cggroups array %@",CFGroupsCheckNameArray);
        
        
        for (CFIndex i = 0; i < groupCount; i++) {
            groupInCheckNameArray = CFArrayGetValueAtIndex(CFGroupsCheckNameArray, i);
            CFGroupNameCheck  = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);
            
            
//            CFComparisonResult result=  (CFComparisonResult) CFStringCompare (
//                                                                              (__bridge CFStringRef)groupName,
//                                                                              (CFStringRef) CFGroupNameCheck,
//                                                                              1
//                                                                              );
            
            
            
            NSString *checkNameStr=[NSString stringWithFormat:@"%@",(__bridge NSString*) CFGroupNameCheck];
            
           NSLog(@"cfgroupname is %@",checkNameStr);
            NSLog(@"groupname Str is %@",groupName);
            if ([checkNameStr isEqualToString:groupName]) {
                group=groupInCheckNameArray;
                groupIdentifier=ABRecordGetRecordID(group);
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupIdentifier]) {
                     [[NSUserDefaults standardUserDefaults] setInteger:groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
                     [[NSUserDefaults standardUserDefaults]synchronize];
                    
                }
               
                if (group) {
                    NSLog(@"group is %@",group);
                }
                
                else {
                    NSLog(@"no group");
                } 
                break;
            }
//            CFRelease(CFGroupsCheckNameArray); 
//            CFRelease(CFGroupNameCheck);
            
        }
     if (CFGroupsCheckNameArray) {
            CFRelease(CFGroupsCheckNameArray); 
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
    
    if ((!group ||addNew) && autoAddClinicianToGroup) {
        
               
        if (!addressBook) {
            
            return;
        }
        //        ABRecordRef CFAddressBookGroupRecord =  ABGroupCreate ();
        
        group=ABGroupCreate();
        
        //        ABRecord *groupRecord=(ABRecord *)[group getRecordRef];
        
        //        NSLog(@"group composite name is %@",groupRecord.compositeName);
        
        
        //        NSLog(@"group record identifier is %i",groupRecord.recordID);
        
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
                
                if (!didSave) {/* Handle error here. */  NSLog(@"addressbook did not save");}
                else NSLog(@"addresss book saved new group.");
                
            } 
            else {
                
                ABAddressBookRevert(addressBook);
                
            }
            
        }
       
        //        ABRecord *groupRecord=[[ABRecord alloc]initWithABRef:(CFTypeRef)kABGroupType ];
        
        NSLog(@"group idenitifer is%i",ABRecordGetRecordID(group));
        
        NSLog(@"group name is %@", (__bridge NSString *)ABRecordCopyValue(group, kABGroupNameProperty));
        
        
        
        
        
        groupIdentifier=ABRecordGetRecordID(group);
       
            [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
            
           [[NSUserDefaults standardUserDefaults] setValue:groupName forKey:kPTTAddressBookGroupName];  
        
        [[NSUserDefaults standardUserDefaults]synchronize];
       
//        CFRelease(group);
    } 
    else
    
    {
    
        BOOL wantToSaveChanges=TRUE;
       
        if (group) {
            groupIdentifier=ABRecordGetRecordID(group);
        }
        
        
        if (groupIdentifier>-1) {
      
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
     
   
                
    
    }
//    [[NSUserDefaults standardUserDefaults]  setValue:(NSString *)groupName forKey:kPTTAddressBookGroupName];
    
   

  
    
}



-(void)importAllContactsInGroup{


    ABAddressBookRef addressBook;
    addressBook=nil;
    addressBook=ABAddressBookCreate();
    
    int groupIdentifier=[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
    
    ABRecordRef group=nil;
    if (groupIdentifier>-1) {
        group=(ABRecordRef )ABAddressBookGetGroupWithRecordID(addressBook, groupIdentifier);
    }
    
    
    if (addressBook && group) {
        CFArrayRef allPeopleInGroup=(CFArrayRef ) ABGroupCopyArrayOfAllMembers(group);
        
        int peopleInGroupCount=CFArrayGetCount(allPeopleInGroup);
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
       
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];

        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if (fetchedObjects == nil) {
            //error handler
        }

    
        
        if (peopleInGroupCount>0) {
            ABRecordRef  recordRef;
            
            CFStringRef recordRefFirstName;
            
            CFStringRef recordRefLastName;
            
            CFStringRef recordRefPrefix;
            
            CFStringRef recordRefSuffix;
            
            CFStringRef recordRefMiddleName;
            
            CFStringRef recordRefNotes;
            
            int personID;;
            NSPredicate *checkIfRecordIDExists;
            NSArray *filteredArray;
            int numberImported=0;
            for (int i=0; i<peopleInGroupCount; i++) {
                recordRef=nil;
                
                recordRefFirstName=nil;
                
                recordRefLastName=nil;
                
                recordRefPrefix=nil;
                
                recordRefSuffix=nil;
                
                recordRefMiddleName=nil;
                
                recordRefNotes=nil;
                
                
                checkIfRecordIDExists=nil;
                filteredArray=nil; 
                recordRef=CFArrayGetValueAtIndex(allPeopleInGroup, i);
                
                recordRefFirstName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonFirstNameProperty);
                
                recordRefLastName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonLastNameProperty);
                
                recordRefPrefix=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonPrefixProperty);
                
                recordRefSuffix=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonSuffixProperty);
                
                recordRefMiddleName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonMiddleNameProperty);
                
                recordRefNotes=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonNoteProperty);
                
                 personID=(int)ABRecordGetRecordID(recordRef);
                checkIfRecordIDExists=[NSPredicate predicateWithFormat:@"aBRecordIdentifier == %@",[NSNumber numberWithInt:personID]];
                
                
                
               filteredArray= [fetchedObjects filteredArrayUsingPredicate:checkIfRecordIDExists];
                
                if (filteredArray.count==0 &&CFStringGetLength(recordRefFirstName)>0&&CFStringGetLength(recordRefLastName)>0) 
                {
                    
                    ClinicianEntity *clinician=[[ClinicianEntity alloc]initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
                    
                    if (recordRefPrefix && CFStringGetLength(recordRefPrefix)>0) 
                    {
                        [clinician setValue:(__bridge NSString*)recordRefPrefix forKey:@"prefix"];
                        
                    }
                    if (recordRefFirstName &&  CFStringGetLength(recordRefFirstName)>0) {                  
                        [clinician setValue:(__bridge NSString*)recordRefFirstName forKey:@"firstName"];
                    }
                    if (recordRefMiddleName && CFStringGetLength(recordRefMiddleName)>0) {    
                       [ clinician setValue:(__bridge NSString*)recordRefMiddleName forKey:@"middleName"];
                    }
                    
                    if (recordRefLastName && CFStringGetLength(recordRefLastName)>0) {
                        [clinician setValue:(__bridge NSString*)recordRefLastName forKey:@"lastName"];
                    }
                    if (recordRefSuffix && CFStringGetLength(recordRefSuffix)>0) {  
                        [clinician setValue:(__bridge NSString*)recordRefSuffix forKey:@"suffix"];
                    }
                        
                        
                    if (recordRefNotes && CFStringGetLength(recordRefNotes)>0) {  
                            [clinician setValue:(__bridge NSString*)recordRefNotes forKey:@"notes"];
                    }
                    
                    if (personID ) {  
                        [clinician setValue:[NSNumber numberWithInt:personID] forKey:@"aBRecordIdentifier"];
                    }
                    
                    
                    
                    numberImported++;
              
                }
               
                if (recordRefNotes) {
                    CFRelease(recordRefNotes);
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
            }
                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                
                if ([managedObjectContext hasChanges]) {
                    [appDelegate saveContext];
                }
                
                 int numberIgnored=peopleInGroupCount-numberImported;
                NSString *messageStr;
               
                
                if (peopleInGroupCount==numberIgnored) {
                    if (peopleInGroupCount==1) {
                        messageStr =[NSString stringWithFormat:@"The contact was not imported because it already exists in the database."] ;
                    }
                    else {
                         messageStr =[NSString stringWithFormat:@"The contacts were not imported because they already exist in the database."] ;
                    }
                }
                else 
                {
                    if (numberImported==1) 
                    {
                        messageStr =[NSString stringWithFormat:@"Imported %i contact.",numberImported] ;
                    }else 
                    {
                         messageStr =[NSString stringWithFormat:@"Imported %i contacts.",numberImported] ;
                    }
                   
                    
                    if (numberIgnored>0) {
                        
                        if (numberIgnored==1) {
                            messageStr=[messageStr stringByAppendingString:[NSString stringWithFormat:@" The contact was not imported because it already exists in the database"]];
                        }
                        else {
                            messageStr=[messageStr stringByAppendingString:[NSString stringWithFormat:@" %i contacts were not imported because they already exist in the database",numberIgnored]];
                        }
                        
                    }
                }
               
                
                
                
                
                if ([SCHelper is_iPad]) {
                    if (appDelegate.cliniciansRootViewController_iPad &&appDelegate.cliniciansRootViewController_iPad.tableModel) {
                        [appDelegate.cliniciansRootViewController_iPad.tableModel reloadBoundValues];
                        [appDelegate.cliniciansRootViewController_iPad.tableView reloadData];
                        
                        
                    }
                }
                else {
                    if (appDelegate.clinicianViewController &&appDelegate.clinicianViewController.tableModel) {
                        [appDelegate.clinicianViewController.tableModel reloadBoundValues];
                        [appDelegate.clinicianViewController.tableView reloadData];
                    }
                }
                
                
                
                [appDelegate displayNotification:messageStr forDuration:6.0 location:kPTTScreenLocationTop inView:nil];
            }
            

                
                

                
                
        if (allPeopleInGroup) {
            CFRelease(allPeopleInGroup);
        }  
            
        
        
        
    }

if (addressBook) {
    CFRelease(addressBook);
}

}

















@end
