/*
 *  ClinicianRootViewController_iPad.m
 *  psyTrack Clinician Tools
 *  Version: 1.05
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
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

      
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc] init]];
    [self.view setBackgroundColor:appDelegate.window.backgroundColor];
//      
//  self.tableViewModel.delegate=self;
   


//    objectsModel.delegate=self;

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

   
    NSString *imageNameStr=nil;
    if ([SCUtilities is_iPad]) {
        imageNameStr=@"ipad-menubar-full.png";
    }
    else{
        
        imageNameStr=@"menubar.png";
    }
    
    UIImage *menueBarImage=[UIImage imageNamed:imageNameStr];
    [self.searchBar setBackgroundImage:menueBarImage];
    [self.searchBar setScopeBarBackgroundImage:menueBarImage];
    
    
    cliniciansBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Clinicians" style:UIBarButtonItemStylePlain target:self action:@selector(displayPopover:)];
    
   
    objectsModel.modelActions.didRefresh = ^(SCTableViewModel *tableModel)
    {
        [self putAddAndClinicianButtonsOnDetailViewController];
        [self updateClinicianTotalLabel];
    };


    self.tableViewModel = objectsModel;
    
   
       
   
}


-(void)viewDidUnload{
    [super viewDidUnload];
    
//    self.tableModel=nil;
    
    
    
    
    
//    CFRelease(addressBook);
//    CFRelease(existingPersonRef);
  
    
    
    currentDetailTableViewModel_=nil;
    
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
//
//   
//    if (tableViewModel.tag==0||tableViewModel.tag==1) {
////        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
//         
////        if (cell.tag<) {
////            UIView *viewLong =[cell viewWithTag:51];
////            if ([viewLong isKindOfClass:[UILabel class]]) {
////                
////                UILabel *lastNameLabel =(UILabel *)viewLong;
////                if ([lastNameLabel.text isEqualToString:@"Last Name:"]) {
////                    UITextField *lastNameField=(UITextField *)[cell viewWithTag:50];
////                    NSString *lastNameStr=lastNameField.text;
////                    if (lastNameStr.length) {
////                        
//                        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:[tableViewModel.masterModel indexPathForCell:currentTableViewCell].section];
////                        unsigned short lastNameFirstChar=[lastNameStr characterAtIndex:0];
////                        if ((unsigned short)[section.headerTitle characterAtIndex:0]!=(unsigned short)lastNameFirstChar) {
//            
//        
//        
        SCTableViewCell *cell=nil;
        if (indexPath.row !=NSNotFound) {
           cell =(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        }  
        
    SCTableViewSection *sectionAtIndexPathThatChanged=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
        if (!addingClinician && tableViewModel.tag==1&&((cell&&indexPath.section==0&&![cell isKindOfClass:[SCArrayOfObjectsCell class]]&&![cell isKindOfClass:[SCObjectCell class]]&&![cell isKindOfClass:[SCObjectSelectionCell class]])||(indexPath.section==1 &&sectionAtIndexPathThatChanged.cellCount==3))) {
            
            for (NSInteger i=0; i<tableViewModel.sectionCount; i++) {
                SCTableViewSection *sectionAtIndex=[tableViewModel sectionAtIndex:i];
                [sectionAtIndex commitCellChanges];
            }
            
            
//            if (!self.searchBar.selectedScopeButtonIndex==0) {
//                [self.searchBar setSelectedScopeButtonIndex:0];
//                objectsModel.dataFetchOptions.filterPredicate=nil;
//            }
            [tableViewModel.masterModel reloadBoundValues];
            [tableViewModel.masterModel.modeledTableView reloadData];
            
        }
//
//                     
//
//    }
//
//
}




-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillDismissForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableModel.tag==0) {
        addingClinician=NO;
    
       
       
    }


}


- (void)tableViewModel:(SCTableViewModel *)tableViewModel didLayoutSubviewsForCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[SCNumericTextFieldCell class]])
    {
        SCNumericTextFieldCell *numericCell=(SCNumericTextFieldCell *)cell;
        
        
        [numericCell.textLabel sizeToFit];
        numericCell.textField.textAlignment=UITextAlignmentRight;
        numericCell.textField.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin ;
        //       CGRect textFieldFrame=numericCell.textField.textInputView.frame;
        //        textFieldFrame.size.width=50;
        
        
    }
}

- (void)tableViewModel:(SCTableViewModel *) tableViewModel willConfigureCell:(SCTableViewCell *) cell forRowAtIndexPath:(NSIndexPath *) indexPath
{
    
    
    
    
    if (tableViewModel.tag==1||tableViewModel.tag==0) 
        
        
    {
        UIView *viewShort =[cell viewWithTag:35];
        UIView *viewLong =[cell viewWithTag:51];
        switch (cell.tag) {
            case 0:
                if ([viewShort isKindOfClass:[UILabel class]]) 
                {
                    
                    UILabel *titleLabel =(UILabel *)viewShort;
                    titleLabel.text=@"Prefix:";
                    tableViewModel.tag=1;
                    
                    
                }
                break;
            case 1:
                if ([viewLong isKindOfClass:[UILabel class]]) {
                    
                    UILabel *firstNameLabel =(UILabel *)viewLong;
                    firstNameLabel.text=@"First Name:";
                    cell.commitChangesLive=YES;
                    
                }
                break;
                
            case 2:
                if ([viewLong isKindOfClass:[UILabel class]]) {
                    
                    UILabel *middleNameLabel =(UILabel *)viewLong;
                    middleNameLabel.text=@"Middle Name:";
                } 
                break;
                
            case 3:
                if ([viewLong isKindOfClass:[UILabel class]]) {
                    
                    UILabel *lastNameLabel =(UILabel *)viewLong;
                    lastNameLabel.text=@"Last Name:";
                    
                } 
                break;
            case 4:
                if ([viewLong isKindOfClass:[UILabel class]]) {
                    
                    UILabel *suffixLabel =(UILabel *)viewLong;
                    suffixLabel.text=@"Suffix:";
                } 
                break;
                
                
                
            case 8:
                if ([cell  isKindOfClass:[AddViewABLinkButtonCell class]]) 
                {
                    
                    
                    
                    AddViewABLinkButtonCell *addViewButtonCell=(AddViewABLinkButtonCell *)cell;
                    
                    int addressBookRecordIdentifier=(int )[(NSNumber *)[cell.boundObject valueForKey:@"aBRecordIdentifier"]intValue]; 
                    
                    ABAddressBookRef addressBook=ABAddressBookCreate();
                    if (addressBookRecordIdentifier!=-1 && ![self checkIfRecordIDInAddressBook:addressBookRecordIdentifier addressBook:(ABAddressBookRef)addressBook]) {
                        addressBookRecordIdentifier=-1;
                        [cell.boundObject setValue:[NSNumber numberWithInt:-1 ]forKey:@"aBRecordIdentifier"];
                    }
                    CFRelease(addressBook);
                    
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

-(NSArray *)tableViewModel:(SCArrayOfItemsModel *)tableModel customSearchResultForSearchText:(NSString *)searchText autoSearchResults:(NSArray *)autoSearchResults{

    [tableModel dismissAllDetailViewsWithCommit:YES];

    [self putAddAndClinicianButtonsOnDetailViewController];
    return autoSearchResults;


}

-(void)putAddAndClinicianButtonsOnDetailViewController{


    self.tableViewModel.detailViewController.navigationItem.rightBarButtonItem=objectsModel.addButtonItem;
    
    
    
    
    self.tableViewModel.detailViewController.navigationItem.leftBarButtonItem= cliniciansBarButtonItem;
    


}
- (void)tableViewModel:(SCArrayOfItemsModel *)tableViewModel
searchBarSelectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{

    self.searchBar.text=nil;
    [tableViewModel dismissAllDetailViewsWithCommit:YES];
    
      [super tableViewModel:tableViewModel searchBarSelectedScopeButtonIndexDidChange:selectedScope];

    [self putAddAndClinicianButtonsOnDetailViewController];


}



- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
    
    
   
    
    if ((tableViewModel.tag==0||tableViewModel.tag==1 )&&[tableViewModel.viewController isKindOfClass:[CliniciansDetailViewController_iPad class]]) 
    {
        
       
        if (index==0) {
            currentDetailTableViewModel_=tableViewModel;
             tableViewModel.tag=1;
        }
        
        
    }
    [super tableViewModel:tableViewModel didAddSectionAtIndex:index];
    
//    if (index==6) {
//        
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
//            
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
//            
//            
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

//-(BOOL)tableViewModel:(SCTableViewModel *)tableViewModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    BOOL valid = TRUE;
//    
////    SCTableViewCell *cell = [tableViewModel cellAtIndexPath:indexPath];
//    
//    
//    
////    if (tableViewModel.tag==4) {
////        UILabel *emaiLabel=(UILabel *)[cell viewWithTag:51];
////        if (emaiLabel.text==@"Email Address:")
////        {
////            UITextField *emailField=(UITextField *)[cell viewWithTag:50];
////            
////            if(emailField.text.length){
////                valid=[self validateEmail:emailField.text];
////                
////                
////            }
////            else
////            {
////                valid=FALSE;
////            }
////        }
////        
////        
////        
////    }
//    
//    
//    
//    
//    if (tableViewModel.tag==1||tableViewModel.tag==0){
//        
//        
//        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
//        
//        SCTextFieldCell *lastNameCell =(SCTextFieldCell *)[section cellAtIndex:3];
//        SCTextFieldCell *firstNameCell =(SCTextFieldCell *)[section cellAtIndex:1];
//        
//        UITextField *lastNameField =(UITextField *)[lastNameCell viewWithTag:50];
//        UITextField *firstNameField =(UITextField *)[firstNameCell viewWithTag:50];
//        
//        
//        
//        if ( firstNameField.text.length && lastNameField.text.length) {
//            
//            valid=TRUE;
//            
//            
//        }
//        else
//        {
//            valid=FALSE;
//        }
//    }
//    
//    
//    
////    SCObjectSection *objectSection = (SCObjectSection *)[tableViewModel sectionAtIndex:0];
////    SCTextFieldCell *zipFieldCell = (SCTextFieldCell *)[objectSection cellForPropertyName:@"zipCode"];
//    if (tableViewModel.tag==3&& tableViewModel.sectionCount){
//        
//        
//        
//        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
//        
//        if (section.cellCount>1) {
//            SCTableViewCell *notesCell =(SCTableViewCell *)[section cellAtIndex:1];
//            NSManagedObject *notesManagedObject=(NSManagedObject *)notesCell.boundObject;
//            
//            
//            if ( notesManagedObject &&[notesManagedObject respondsToSelector:@selector(entity)]&& [notesManagedObject.entity.name isEqualToString:@"LogEntity"]&&[notesCell isKindOfClass:[EncryptedSCTextViewCell class]]) {
//                EncryptedSCTextViewCell *encryptedNoteCell=(EncryptedSCTextViewCell *)notesCell;
//                
//                if (encryptedNoteCell.textView.text.length) 
//                {
//                    valid=TRUE;
//                }
//                else 
//                {
//                    valid=FALSE;
//                }
//                
//            }
//            
//            
//        }
//        
//        
//    }
//
//    if (tableViewModel.tag==4&& tableViewModel.sectionCount){
//        
//        
//        
//        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
//        
//        if (section.cellCount>3) 
//        {
//            SCTableViewCell *cellFrom=(SCTableViewCell *)[section cellAtIndex:0];
//            SCTableViewCell *cellTo=(SCTableViewCell *)[section cellAtIndex:1];
//            SCTableViewCell *cellArrivedDate=(SCTableViewCell *)[section cellAtIndex:2];
//            NSManagedObject *cellManagedObject=(NSManagedObject *)cellFrom.boundObject;
//              
//            
//            if (cellManagedObject &&[cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"MigrationHistoryEntity"]&&[cellFrom isKindOfClass:[EncryptedSCTextViewCell class]]) {
//                
//                EncryptedSCTextViewCell *encryptedFrom=(EncryptedSCTextViewCell *)cellFrom;
//                EncryptedSCTextViewCell *encryptedTo=(EncryptedSCTextViewCell *)cellTo;
//                
//                
//                SCDateCell *arrivedDateCell=(SCDateCell *)cellArrivedDate;
//                
//                if (encryptedFrom.textView.text.length && encryptedTo.textView.text.length &&arrivedDateCell.label.text.length) {
//                    valid=YES;
//                }
//                else {
//                    valid=NO;
//                }
//                
//            }
//        }        
//    }
//    
//
//   
//    
//    return valid;
//}




-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    [super tableViewModel:tableViewModel detailModelCreatedForRowAtIndexPath:indexPath detailTableViewModel:detailTableViewModel];
    if (tableViewModel.tag==0 && ![detailTableViewModel.viewController isKindOfClass:[CliniciansDetailViewController_iPad class]]) {
        addingClinician=YES;
    }

}


-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)index detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    
    if (tableViewModel.tag==0) {
        addingClinician=YES;
    }
    detailTableViewModel.tag=tableViewModel.tag+1;
    
    
  
}
-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath  withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{

    
    [super tableViewModel:tableModel detailViewWillPresentForRowAtIndexPath:indexPath withDetailTableViewModel:detailTableViewModel];
 
   
    if (detailTableViewModel.tag==1 && indexPath.row!=NSNotFound) {
        [self putAddAndClinicianButtonsOnDetailViewController];
        
    }
    
    
    if (tableModel.tag==0 && indexPath.row==NSNotFound) {
        addingClinician=YES;
    }
   

            
//        UIViewController *logoViewController=[[LogoBackgroundViewController alloc]initWithNibName:@"LogoBackgroundViewController" bundle:[NSBundle mainBundle] ]; 
        
        

    
    

    

//[logoViewController loadView ];
//[detailTableViewModel.modeledTableView setBackgroundView:logoViewController.view ];


}



-(IBAction)displayPopover:(id)sender{

    
    CliniciansDetailViewController_iPad *cliniciansDetailViewController_iPad=(CliniciansDetailViewController_iPad *)self.tableViewModel.detailViewController;
    
    [cliniciansDetailViewController_iPad.popoverController presentPopoverFromBarButtonItem:self.splitViewController.navigationItem.leftBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    


    


}

- (NSString *)tableViewModel:(SCArrayOfItemsModel *)tableViewModel sectionHeaderTitleForItem:(NSObject *)item AtIndex:(NSUInteger)index
{
	// Cast not technically neccessary, done just for clarity
	NSManagedObject *managedObject = (NSManagedObject *)item;
	
	NSString *objectName = (NSString *)[managedObject valueForKey:@"lastName"];
	
	// Return first charcter of objectName
	return [[objectName substringToIndex:1] uppercaseString];
}




-(BOOL)checkIfRecordIDInAddressBook:(int)recordID addressBook:(ABAddressBookRef )addressBook{
    
    addressBook=nil;
    if (!addressBook) {
        addressBook=ABAddressBookCreate();
    }
    BOOL exists=NO;
    if (addressBook) {
    
    ABRecordRef person=nil;
    
    if (recordID>0) {
        
        
        person=(ABRecordRef ) ABAddressBookGetPersonWithRecordID(addressBook, recordID);
        if (person) {
            exists=YES;
        } 
        
        
    }
  
    
    } 
    
    if (addressBook) {
        CFRelease(addressBook);
    } 
    
    return exists;
    
}


@end
