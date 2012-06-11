/*
 *  ClinicianRootViewController_iPad.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/9/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "CliniciansRootViewController_iPad.h"

#import "LogoBackgroundViewController.h"
#import "PTTAppDelegate.h"
#import "ButtonCell.h"
#import "ClinicianEntity.h"
#import "TrainTrackViewController.h"
#import "EncryptedSCTextViewCell.h"
#import "CliniciansDetailViewController_iPad.h"

#import "CliniciansViewController_Shared.h"
#import "LookupRemoveLinkButtonCell.h"
#import "AddViewABLinkButtonCell.h"
@implementation CliniciansRootViewController_iPad
//@synthesize cliniciansDetailViewController_iPad=__cliniciansDetailViewController_iPad;




#pragma mark -
#pragma mark View lifecycle and setting up table model

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarType = SCNavigationBarTypeEditLeft;
    
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
//    [self.popoverController.contentViewController.view setBackgroundColor:];
    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
   
    
    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
      
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc] init]];
       
//      
//  self.tableViewModel.delegate=self;
   


   

    objectsModel.addButtonItem=objectsModel.detailViewController.navigationItem.rightBarButtonItem;
    
    objectsModel.addButtonItem = self.addButton;
	objectsModel.itemsAccessoryType = UITableViewCellAccessoryNone;
    objectsModel.detailViewControllerOptions.modalPresentationStyle = UIModalPresentationPageSheet;
    objectsModel.detailViewController=self.tableViewModel.detailViewController;
    CliniciansDetailViewController_iPad *clinicianDetailViewController=(CliniciansDetailViewController_iPad *)objectsModel.detailViewController;
    
    clinicianDetailViewController.navigationBarType=SCNavigationBarTypeAddRight;
    
    objectsModel.addButtonItem=clinicianDetailViewController.navigationItem.rightBarButtonItem;
//    self.tableView.backgroundColor=[UIColor clearColor]; // Make the table view application backgound color (turquose)
  
//    self.tableView.backgroundColor=[UIColor colorWithRed:0.317586 green:0.623853 blue:0.77796 alpha:1.0]; // Make the table view application backgound color (turquose)

   
    UIImage *menueBarImage=[UIImage imageNamed:@"ipad-menubar-left.png"];
    [self.searchBar setBackgroundImage:menueBarImage];
    [self.searchBar setScopeBarBackgroundImage:menueBarImage];
    
    
    
    
    self.tableViewModel = objectsModel;
    
    
  
   
   
}



-(void)viewDidUnload{
    [super viewDidUnload];
    
//    self.tableModel=nil;
    
    
    
    
    
//    CFRelease(addressBook);
//    CFRelease(existingPersonRef);
    if (currentDetailTableViewModel_) {
        self.currentDetailTableViewModel=nil;
    }
    
    
    
    
    if (personVCFromSelectionList) {
        self.personVCFromSelectionList=nil;
    }
    if (personAddNewViewController) {
        self.personAddNewViewController=nil;
    }


}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  
        return YES;
  
}


#pragma mark -
#pragma SCTableViewModelDelegate methodds


-(void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableViewModel:tableViewModel valueChangedForRowAtIndexPath:indexPath];
       
   
    if (tableViewModel.tag==0||tableViewModel.tag==1) {
//        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
         //NSLog(@"cell class is %@",cell.class);
//        if (cell.tag<) {
//            UIView *viewLong =[cell viewWithTag:51];
//            if ([viewLong isKindOfClass:[UILabel class]]) {
//                //NSLog(@"last name");
//                UILabel *lastNameLabel =(UILabel *)viewLong;
//                if ([lastNameLabel.text isEqualToString:@"Last Name:"]) {
//                    UITextField *lastNameField=(UITextField *)[cell viewWithTag:50];
//                    NSString *lastNameStr=lastNameField.text;
//                    if (lastNameStr.length) {
//                        //NSLog(@"current cell superview is %@",[self.tableViewModel indexPathForCell:currentTableViewCell]);
                        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:[tableViewModel.masterModel indexPathForCell:currentTableViewCell].section];
//                        unsigned short lastNameFirstChar=[lastNameStr characterAtIndex:0];
//                        if ((unsigned short)[section.headerTitle characterAtIndex:0]!=(unsigned short)lastNameFirstChar) {
            
        //NSLog(@"they arent equal");
        
        SCTableViewCell *cell=nil;
        if (indexPath.row !=NSNotFound) {
           cell =(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        }  
        NSLog(@"selection cell %@",[cell class]);
        
        if (!addingClinician && tableViewModel.tag==1&&cell&&indexPath.section==0&&![cell isKindOfClass:[SCArrayOfObjectsCell class]]&&![cell isKindOfClass:[SCObjectCell class]]&&![cell isKindOfClass:[SCObjectSelectionCell class]]) {
            [section commitCellChanges];
            [tableViewModel.masterModel reloadBoundValues];
            [tableViewModel.masterModel.modeledTableView reloadData];
            

        }
                                                    
                     

    }
//NSLog(@"did end editing row");

}
-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillDismissForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableModel.tag==0) {
        addingClinician=NO;
        
    }


}

- (void)tableViewModel:(SCTableViewModel *) tableViewModel willConfigureCell:(SCTableViewCell *) cell forRowAtIndexPath:(NSIndexPath *) indexPath
{
    //NSLog(@"table view model tag is %i", tableViewModel.tag);
    
    
    
    if (tableViewModel.tag==1||tableViewModel.tag==0) 
        
        
    {
        UIView *viewShort =[cell viewWithTag:35];
        UIView *viewLong =[cell viewWithTag:51];
        switch (cell.tag) {
            case 0:
                if ([viewShort isKindOfClass:[UILabel class]]) 
                {
                    //NSLog(@"prefix");
                    UILabel *titleLabel =(UILabel *)viewShort;
                    titleLabel.text=@"Prefix:";
                    tableViewModel.tag=1;
                    
                    
                }
                break;
            case 1:
                if ([viewLong isKindOfClass:[UILabel class]]) {
                    //NSLog(@"first name");
                    UILabel *firstNameLabel =(UILabel *)viewLong;
                    firstNameLabel.text=@"First Name:";  
                }
                break;
                
            case 2:
                if ([viewLong isKindOfClass:[UILabel class]]) {
                    //NSLog(@"middle name");
                    UILabel *middleNameLabel =(UILabel *)viewLong;
                    middleNameLabel.text=@"Middle Name:";
                } 
                break;
                
            case 3:
                if ([viewLong isKindOfClass:[UILabel class]]) {
                    //NSLog(@"last name");
                    UILabel *lastNameLabel =(UILabel *)viewLong;
                    lastNameLabel.text=@"Last Name:";
                    
                } 
                break;
            case 4:
                if ([viewLong isKindOfClass:[UILabel class]]) {
                    //NSLog(@"suffix");
                    UILabel *suffixLabel =(UILabel *)viewLong;
                    suffixLabel.text=@"Suffix:";
                } 
                break;
                
                
                
            case 8:
                if ([cell  isKindOfClass:[AddViewABLinkButtonCell class]]) 
                {
                    
                    
                    
                    AddViewABLinkButtonCell *addViewButtonCell=(AddViewABLinkButtonCell *)cell;
                    
                    int addressBookRecordIdentifier=(int )[(NSNumber *)[cell.boundObject valueForKey:@"aBRecordIdentifier"]intValue]; 
                    
                    
                    if (addressBookRecordIdentifier!=-1 && ![self checkIfRecordIDInAddressBook:addressBookRecordIdentifier]) {
                        addressBookRecordIdentifier=-1;
                        [cell.boundObject setValue:[NSNumber numberWithInt:-1 ]forKey:@"aBRecordIdentifier"];
                    }
                    
                    
                    if (addressBookRecordIdentifier!=-1) {
                        
                        [addViewButtonCell toggleButtonsWithButtonOneHidden:YES];
                        
                    }
                    else 
                    {
                        [addViewButtonCell toggleButtonsWithButtonOneHidden:NO];
                    }
                    
                    
                    
                } 
                break;
                
                
            case 9:
                //this is the root table
                
                
            { 
                if ([cell isKindOfClass:[LookupRemoveLinkButtonCell class]]) {
                    
                    int addressBookRecordIdentifier=(int )[(NSNumber *)[cell.boundObject valueForKey:@"aBRecordIdentifier"]intValue]; 
                    
                    //NSLog(@"addressbook identifier is %i",addressBookRecordIdentifier);
                    //NSLog(@"addressbook Identifier %@", cell.boundObject);
                    //                NSString *buttonText;
                    
                    
                    LookupRemoveLinkButtonCell *addViewButtonCell=(LookupRemoveLinkButtonCell *)cell;
                    
                    
                    
                    
                    if (addressBookRecordIdentifier!=-1) {
                        
                        [addViewButtonCell toggleButtonsWithButtonOneHidden:YES];
                        
                    }
                    else 
                    {
                        [addViewButtonCell toggleButtonsWithButtonOneHidden:NO];
                    }
                    
                    
                    
                } 
                
                
            }  
                
                break;
                
               
            default:
                break;
        }
        
    }
    if (tableViewModel.tag==4) 
        
        
    {
//        UIView *viewOne = [cell viewWithTag:51];
//        UIView *viewSendReports =[cell viewWithTag:40];
        UIView *sliderView = [cell viewWithTag:14];
        UIView *scaleView = [cell viewWithTag:70];
        switch (cell.tag) {
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
                
                
//                if ([viewOne isKindOfClass:[UILabel class]]) {
//                    
//                    UILabel *emailLabel =(UILabel *)viewOne;
//                    emailLabel.text=@"Email Address:";
//                    
//                    UITextField *emailAddressField =(UITextField *)[cell viewWithTag:3];
//                    
//                    emailAddressField.keyboardType=UIKeyboardTypeEmailAddress;
//                    emailAddressField.autocapitalizationType=UITextAutocapitalizationTypeNone;
//                    
//                }
                
                if ([scaleView isKindOfClass:[UISegmentedControl class]]) {
                    
                    UILabel *fluencyLevelLabel =(UILabel *)[cell viewWithTag:71];
                    fluencyLevelLabel.text=@"Fluency Level:";
                    
                }
                
                break;
                
//            case 2:
//                if ([viewSendReports isKindOfClass:[UISwitch class]]) {
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
        }
        
    }
    
    
    
    
    
    
}

- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
    //NSLog(@"tableview model tag is %i",tableViewModel.tag);
    //NSLog(@"tableview model view controller is%@ ",[tableViewModel.viewController class]);
   //NSLog(@"index is %i",index);
    //NSLog(@"tabelmodel section count is %i",tableViewModel.sectionCount);
    if ((tableViewModel.tag==0||tableViewModel.tag==1 )&&[tableViewModel.viewController isKindOfClass:[CliniciansDetailViewController_iPad class]]) 
    {
        //NSLog(@"section index is %i",index);
       
        if (index==0) {
            self.currentDetailTableViewModel=tableViewModel;
             tableViewModel.tag=1;
        }
        
        
    }
    [super tableViewModel:tableViewModel didAddSectionAtIndex:index];
    
//    if (index==6) {
//        //NSLog(@"cells in section is %i",section.cellCount);
//        
//        
//        
//        SCTableViewSection *sectionOne=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
//        SCTableViewCell *sectionOneClicianCell=(SCTableViewCell *)[sectionOne cellAtIndex:0];
//        NSManagedObject *cellManagedObject=(NSManagedObject *)sectionOneClicianCell.boundObject;
//        
//        if ([cellManagedObject isKindOfClass:[ClinicianEntity class]]) {
//            ClinicianEntity *clinicianObject=(ClinicianEntity *)cellManagedObject;
//            
//            
//            //NSLog(@"my information is %@",clinicianObject.myInformation);
//            if ([clinicianObject.myInformation isEqualToNumber:[NSNumber numberWithBool:YES]]) {
//                
//                [tableViewModel removeSectionAtIndex:1];
//                [tableViewModel removeSectionAtIndex:4];
//                
//            }
//            
//            //                NSArray *addressBookGroupsArray=[NSArray arrayWithArray:[ self addressBookGroupsArray]];
//            //                
//            
//            
//            
//            //NSLog(@"client abrecordidntifier %i",[clinicianObject.aBRecordIdentifier intValue]);
//            //NSLog(@"client abrecordidentifier %@",clinicianObject.aBRecordIdentifier);
//            self.abGroupObjectSelectionCell=[[ABGroupSelectionCell alloc]initWithClinician:(ClinicianEntity *)clinicianObject];    
//            
//            abGroupObjectSelectionCell_.tag=429;
//            
//            [sectionOne addCell:abGroupObjectSelectionCell_];
//        }
//        
//        
//        
//    }
    
 [self setSectionHeaderColorWithSection:(SCTableViewSection *)section color:[UIColor whiteColor]]; 
    
    
}

-(BOOL)tableViewModel:(SCTableViewModel *)tableViewModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL valid = TRUE;
    
//    SCTableViewCell *cell = [tableViewModel cellAtIndexPath:indexPath];
    
    
    
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
    
    if (tableViewModel.tag==1||tableViewModel.tag==0){
        
        
        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
        
        SCTextFieldCell *lastNameCell =(SCTextFieldCell *)[section cellAtIndex:3];
        SCTextFieldCell *firstNameCell =(SCTextFieldCell *)[section cellAtIndex:1];
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
    
    
    
//    SCObjectSection *objectSection = (SCObjectSection *)[tableViewModel sectionAtIndex:0];
//    SCTextFieldCell *zipFieldCell = (SCTextFieldCell *)[objectSection cellForPropertyName:@"zipCode"];
    if (tableViewModel.tag==3&& tableViewModel.sectionCount){
        
        
        
        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
        
        if (section.cellCount>1) {
            SCTableViewCell *notesCell =(SCTableViewCell *)[section cellAtIndex:1];
            NSManagedObject *notesManagedObject=(NSManagedObject *)notesCell.boundObject;
            
            
            if ( notesManagedObject &&[notesManagedObject respondsToSelector:@selector(entity)]&& [notesManagedObject.entity.name isEqualToString:@"LogEntity"]&&[notesCell isKindOfClass:[EncryptedSCTextViewCell class]]) {
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
            
            if (cellManagedObject &&[cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"MigrationHistoryEntity"]&&[cellFrom isKindOfClass:[EncryptedSCTextViewCell class]]) {
                
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




-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    [super tableViewModel:tableViewModel detailModelCreatedForRowAtIndexPath:indexPath detailTableViewModel:detailTableViewModel];
    if (tableViewModel.tag==0 && ![detailTableViewModel.viewController isKindOfClass:[CliniciansDetailViewController_iPad class]]) {
        addingClinician=YES;
    }

    detailTableViewModel.theme=[SCTheme themeWithPath:@"ClearBackgroundTheme.sct"];

}


-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)index detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    //NSLog(@"detail model created for row at index");
    
    if (tableViewModel.tag==0) {
        addingClinician=YES;
    }
    detailTableViewModel.tag=tableViewModel.tag+1;
    
    
//    detailTableViewModel.delegate=self;
    if(detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
//        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        detailTableViewModel.theme = [SCTheme themeWithPath:@"ClearBackgroundTheme.sct"];
        
        

    }
    //NSLog(@"detail model created for row at index detailtable model tag is %i", detailTableViewModel.tag);
    
}
-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath  withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{

    
    [super tableViewModel:tableModel detailViewWillPresentForRowAtIndexPath:indexPath withDetailTableViewModel:detailTableViewModel];
 
    if (tableModel.tag==0 && indexPath.row==NSNotFound) {
        addingClinician=YES;
    }
   

            
//        UIViewController *logoViewController=[[LogoBackgroundViewController alloc]initWithNibName:@"LogoBackgroundViewController" bundle:[NSBundle mainBundle] ]; 
        
        

    
    

    

//[logoViewController loadView ];
//[detailTableViewModel.modeledTableView setBackgroundView:logoViewController.view ];


}

- (NSString *)tableViewModel:(SCArrayOfItemsModel *)tableViewModel sectionHeaderTitleForItem:(NSObject *)item AtIndex:(NSUInteger)index
{
	// Cast not technically neccessary, done just for clarity
	NSManagedObject *managedObject = (NSManagedObject *)item;
	
	NSString *objectName = (NSString *)[managedObject valueForKey:@"lastName"];
	
	// Return first charcter of objectName
	return [[objectName substringToIndex:1] uppercaseString];
}




-(BOOL)checkIfRecordIDInAddressBook:(int)recordID{
    
    
    ABAddressBookRef addressBook;
    addressBook=nil;
    addressBook=ABAddressBookCreate();

    ABRecordRef person=nil;
    BOOL exists=NO;
    if (recordID>0) {
        
        
        person=(ABRecordRef ) ABAddressBookGetPersonWithRecordID(addressBook, recordID);
        if (person) {
            exists=YES;
        } 
        
        
    }
  
    if (addressBook) {
        CFRelease(addressBook);
    } 
    
    
    return exists;
    
}


@end
