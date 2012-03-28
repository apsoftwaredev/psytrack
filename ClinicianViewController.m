/*
 *  ClinicianViewController.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 6/19/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ClinicianViewController.h"
#import "PTTAppDelegate.h"
#import "ButtonCell.h"
#import "CliniciansViewController_Shared.h"






@implementation ClinicianViewController

@synthesize searchBar;

@synthesize totalCliniciansLabel;





#pragma mark -
#pragma mark View lifecycle

-(id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(ClinicianSelectionCell*)objectSelectionCell sendingViewController:(UIViewController *)viewController filterByPrescriber:(BOOL)prescriberFilter{
    
    self=[super initWithNibName:nibName bundle:bundle];
    
    filterByPrescriber=prescriberFilter;
    isInDetailSubview=detailSubview;
    clinicianObjectSelectionCell=objectSelectionCell;
    
    sendingViewController=viewController;
    
    
    return self;
    
} 



-(void)viewDidUnload{
    [super viewDidUnload];
   
    
   
 
  self.totalCliniciansLabel=nil;
    
    
}
-(IBAction)reloadTableViewData:(id)sender{
    
    [self.tableModel reloadBoundValues ];
    [self.tableView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Gracefully handle reloading the view controller after a memory warning
//    tableModel = (SCArrayOfObjectsModel *)[[SCModelCenter sharedModelCenter] modelForViewController:self];
//    if(tableModel)
//    {
//        [tableModel replaceModeledTableViewWith:self.tableView];
//        return;
//    }
//    
//    existingPersonRecordID=-1;
//    
//    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
   
	// Get managedObjectContext from application delegate
//    CliniciansViewController_Shared *clinicianViewController_Shared =[[CliniciansViewController_Shared alloc]init];
//    [clinicianViewController_Shared setupTheCliniciansViewUsingSTV];
//    
//    
    
    if (isInDetailSubview) {
        
        NSPredicate *prescriberFilter=nil;
        if (filterByPrescriber) {
            prescriberFilter=[NSPredicate predicateWithFormat:@"isPrescriber ==%@",[NSNumber numberWithBool: YES]];
            
            
            NSString *scopeTitleAtOne= (NSString *)[self.searchBar.scopeButtonTitles objectAtIndex:1];
            
            scopeTitleAtOne=@"Prescribers";
            
            
            self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"All Clinicians",@"Prescribers",@"At Current Site",nil];
            
        }
        
        self.tableModel=  [[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView withViewController:self withEntityClassDefinition:self.clinicianDef usingPredicate:prescriberFilter useSCSelectionSection:YES];
        
        [self.searchBar setSelectedScopeButtonIndex:1];
        tableModel_.allowDeletingItems=FALSE;
        tableModel_.autoSelectNewItemCell=TRUE;
        
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
        
        
        UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped)];
        [buttons addObject:doneButton];
        
        // create a spacer
        UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
        [buttons addObject:editButton];
        
        [self editButtonItem];
        
        
        // create a standard "add" button
        UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:NULL];
        addButton.style = UIBarButtonItemStyleBordered;
        [buttons addObject:addButton];
        
        
        
        // stick the buttons in the toolbar
        self.navigationItem.rightBarButtonItems=buttons;
        self.tableModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:1];
        self.tableModel.addButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:2];
        
        UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped)];
        
        self.navigationItem.leftBarButtonItem=cancelButton;
        
        
    }
    else
    {
        
        self.tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self
                                                 withEntityClassDefinition:self.clinicianDef usingPredicate:nil useSCSelectionSection:FALSE];	
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.tableModel.editButtonItem = self.navigationItem.leftBarButtonItem;
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
        self.navigationItem.rightBarButtonItem = addButton;
        self.tableModel.addButtonItem = self.navigationItem.rightBarButtonItem;
        
    }
     
    
    // Instantiate the tabel model
//	self.tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self withEntityClassDefinition:self.clinicianDef];	
//    
    
    tableModel_.searchBar = self.searchBar;
	tableModel_.searchPropertyName = @"firstName;lastName";
//    tableModel_.addButtonItem = self.navigationItem.rightBarButtonItem;
//    tableModel_.editButtonItem = self.navigationItem.leftBarButtonItem;
    tableModel_.allowMovingItems=TRUE;
    
    if (![SCHelper is_iPad]) {
        tableModel_.autoAssignDelegateForDetailModels=TRUE;
        tableModel_.autoAssignDataSourceForDetailModels=TRUE;
        self.tableView.backgroundColor=[UIColor clearColor];
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
        self.navigationItem.rightBarButtonItem = addButton; 
        tableModel_.addButtonItem=self.navigationItem.rightBarButtonItem;
       
    }
    
    
     [self updateClinicianTotalLabel];
    
    tableModel_.autoSortSections = TRUE;
    
	tableModel_.sectionIndexTitles = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
    
   
    if([SCHelper is_iPad]){
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    }

    


    [(PTTAppDelegate *)[UIApplication sharedApplication].delegate application:[UIApplication sharedApplication]
                                               willChangeStatusBarOrientation:[[UIApplication sharedApplication] statusBarOrientation]
                                                                     duration:5];
   
       
   
}


-(void)cancelButtonTapped{
    
    NSLog(@"cancel button Tapped");
    
    NSLog(@"parent controller %@",[super parentViewController]);
    
    if(self.navigationController)
	{
		// check if self is the rootViewController
		if([self.navigationController.viewControllers objectAtIndex:0] == self)
		{
			[self dismissModalViewControllerAnimated:YES];
		}
		else
			[self.navigationController popViewControllerAnimated:YES];
	}
	else
		[self dismissModalViewControllerAnimated:YES];
    
    
}



-(void)doneButtonTapped{
    
    NSLog(@"done Button tapped");
    if (isInDetailSubview) {
        SCTableViewSection *section=(SCTableViewSection *)[tableModel_ sectionAtIndex:0];
        NSLog(@"section class is %@",[section class]);
        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
            SCObjectSelectionSection *objectsSelectionSection=(SCObjectSelectionSection*)section;
            
            //            NSLog(@"test valie changed at index with cell index selected %i",[objectsSelectionSection.selectedItemIndex integerValue]) ;
            //            if (clientObjectSelectionCell) {
            
            //                NSLog(@"objectsSelectionSection.selectedItemsIndexes.count %i",objectsSelectionSection.items.count);
            
            //                if ([objectsSelectionSection.selectedItemIndex integerValue]>=0&&[objectsSelectionSection.selectedItemIndex integerValue]<=objectsSelectionSection.items.count) {
            //                    
            NSIndexPath *cellIndexPath=objectsSelectionSection.selectedCellIndexPath;
            
            SCTableViewCell *cell=(SCTableViewCell *)[tableModel_ cellAtIndexPath:cellIndexPath];
            NSLog(@"cell bound object in clients view controller at done %@",cell.boundObject);
            
            
            
            NSLog(@"selected item index%@",objectsSelectionSection.selectedItemIndex);
            
            if (objectsSelectionSection.cellCount>0) {
                if (currentlySelectedClinician) {
                    clinicianObjectSelectionCell.clinicianObject=currentlySelectedClinician ;
                    [clinicianObjectSelectionCell  doneButtonTappedInDetailView:currentlySelectedClinician withValue:TRUE];
                    
                    
                }
                
            }          
            
            
            
            
            //            }
            
            //                    clientObjectSelectionCell.hasChangedClients=TRUE;
            //                }
            //                else{
            //                
            //                    [clientObjectSelectionCell doneButtonTappedInDetailView:nil withValue:NO];
            //                
            //                }
            
            
            [self cancelButtonTapped];
            
        } 
    }
    //        else
    //        {
    //            clientObjectSelectionCell.items=[NSArray array];
    //            [clientObjectSelectionCell doneButtonTappedInDetailView:nil withValue:NO];
    //        }
    //
    //        
    //        if(self.navigationController)
    //        {
    //            // check if self is the rootViewController
    //            if([self.navigationController.viewControllers objectAtIndex:0] == self)
    //            {
    //                [self dismissModalViewControllerAnimated:YES];
    //            }
    //            else
    //                [self.navigationController popViewControllerAnimated:YES];
    //        }
    //        else
    //            [self dismissModalViewControllerAnimated:YES];
    //        
    //    }
    //
    
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
    if (tableViewModel.tag==0&&[section isKindOfClass:[SCObjectSelectionSection class]]) {
        
        //        SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection *)section;
        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        
        currentlySelectedClinician=(ClinicianEntity *)cell.boundObject;
        NSLog(@"currently selected client is %@",currentlySelectedClinician);
    }
    NSLog(@"table model class %@",[tableViewModel class]);
    if ([tableViewModel isKindOfClass:[SCArrayOfObjectsModel class]]) {
        SCArrayOfObjectsModel *arrayOfObjectsModel=(SCArrayOfObjectsModel *)tableViewModel;
        
        [arrayOfObjectsModel dispatchSelectRowAtIndexPathEvent:indexPath];
        return;
    }
    
    if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
        SCObjectSelectionSection *selectionSection=(SCObjectSelectionSection *)section;
        
        [selectionSection dispatchSelectRowAtIndexPathEvent:indexPath];
        return;
    }
    if ([section isKindOfClass:[SCArrayOfObjectsSection class]]) {
        SCArrayOfObjectsSection *selectionSection=(SCArrayOfObjectsSection *)section;
        
        [selectionSection dispatchSelectRowAtIndexPathEvent:indexPath];
        
    }
    NSLog(@"section class %@",[section class]);
    
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    [super tableViewModel:tableViewModel willConfigureCell:cell forRowAtIndexPath:indexPath];

    
    if (tableViewModel.tag==0) {
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
       
        SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection*)section;
        //            int objectSelectionSectionItemsCount=(NSInteger ) objectSelectionSection.cellCount;
        
        
        
        if ([cell.boundObject isEqual:currentlySelectedClinician]) {
            NSLog(@"currently selected client is %@",currentlySelectedClinician);
            NSLog(@"cell bound object is %@",cell.boundObject);
            NSLog(@"they are equal section cell count is %i", section.cellCount);
            //            [objectSelectionSection setSelectedCellIndexPath:indexPath];
            [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:currentlySelectedClinician]]];
            
        }
        //        [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:currentlySelectedClient]]];
        
        
        
        //            [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:(NSInteger)[objectSelectionSection.items indexOfObject:managedObject]]]; 
        
        NSLog(@"index integer of object %i",[objectSelectionSection.items indexOfObject:currentlySelectedClinician]);
        
            
        }
        
    }


}
//#pragma mark -
//#pragma mark SCTableViewModelDataSource methods
//
//- (NSString *)tableViewModel:(SCArrayOfItemsModel *)tableViewModel sectionHeaderTitleForItem:(NSObject *)item AtIndex:(NSUInteger)index
//{
//	// Cast not technically neccessary, done just for clarity
//	NSManagedObject *managedObject = (NSManagedObject *)item;
//	
//	NSString *objectName = (NSString *)[managedObject valueForKey:@"lastName"];
//	
//	// Return first charcter of objectName
//	return [[objectName substringToIndex:1] uppercaseString];
//}

#pragma mark -
#pragma SCTableViewModelDelegate methods

-(void)tableViewModelSearchBarCancelButtonClicked:(SCArrayOfItemsModel *)tableViewModel{


    [self updateClinicianTotalLabel];

}

- (void)tableViewModel:(SCArrayOfItemsModel *)tableViewModel
searchBarSelectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{

    NSLog(@"scope changed");
    if([tableViewModel isKindOfClass:[SCArrayOfObjectsModel class]])
    {
        SCArrayOfObjectsModel *objectsModel = (SCArrayOfObjectsModel *)tableViewModel;
    
        
        [self.searchBar setSelectedScopeButtonIndex:selectedScope];
        
        switch (selectedScope) {
            case 1: //All
            {
                NSPredicate *scopeFilter=nil;
                
                if (filterByPrescriber) {
                    scopeFilter=[NSPredicate predicateWithFormat:@"isPrescriber ==%@",[NSNumber numberWithBool: YES]];
                }
                else
                {
                    scopeFilter= [NSPredicate predicateWithFormat:@"myCurrentSupervisor == %i OR myPastSupervisor==%i", TRUE, TRUE];
                    
                }
                objectsModel.itemsPredicate = scopeFilter;
                
                    
                NSLog(@"case 1");
            }
                break;
            case 2: //Female
                objectsModel.itemsPredicate = [NSPredicate predicateWithFormat:@"atMyCurrentSite == %i OR myInformation==%i", TRUE, TRUE];
                
                NSLog(@"case 2");
                break;                
  
            default:
                 objectsModel.itemsPredicate = nil;
                NSLog(@"case default");
                
                break;
        }
        [objectsModel reloadBoundValues];
        [objectsModel.modeledTableView reloadData];   
        
        [self updateClinicianTotalLabel];
    }
}




//- (void)tableViewModel:(SCTableViewModel *) tableViewModel willConfigureCell:(SCTableViewCell *) cell forRowAtIndexPath:(NSIndexPath *) indexPath
//{
//  
//    if (tableViewModel.tag==0) 
//    {
//    
//            cell.backgroundColor=[UIColor whiteColor];
//            cell.height= 50;
//        
//        
//    }
//    if (tableViewModel.tag==1) 
//    {
//
//            UIView *viewShorterTextLabelView =(UIView *)[cell viewWithTag:35];
//            UIView *viewLongerTextLabelView =(UIView *)[cell viewWithTag:51];
//           
//           
//            switch (cell.tag) 
//            {
//                case 0:
//                    if ([viewShorterTextLabelView isKindOfClass:[UILabel class]]) 
//                    {
//                        NSLog(@"prefix");
//                        UILabel *titleLabel =(UILabel *)viewShorterTextLabelView;
//                        
//                        titleLabel.text=@"Prefix:";
//                    }
//                    break;
//                case 1:
//                    if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
//                    {
//                        NSLog(@"first name");
//                       
//                        UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
//                        firstNameLabel.text=@"First Name:";  
//                    }
//                    break;
//                    
//                case 2:
//                    if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
//                    {
//                        NSLog(@"middle name");
//                        
//                        UILabel *middleNameLabel =(UILabel *)viewLongerTextLabelView;
//                        middleNameLabel.text=@"Middle Name:";
//                    } 
//                    break;
//                    
//                case 3:
//                    if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
//                    {
//                       
//                        NSLog(@"last name");
//                        UILabel *lastNameLabel =(UILabel *)viewLongerTextLabelView;
//                        lastNameLabel.text=@"Last Name:";
//
//                    } 
//                    break;
//                case 4:
//                    if ([viewShorterTextLabelView isKindOfClass:[UILabel class]]) 
//                    {
//                       
//                        NSLog(@"suffix");
//                       UILabel *suffixLabel =(UILabel *)viewShorterTextLabelView;
//                        suffixLabel.text=@"Suffix:";
//                    } 
//                    break;
//                    
//                case 5:
//                    if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
//                    {
//                        
//                        NSLog(@"credential Intials");
//                        UILabel *credentialInitialsLabel =(UILabel *)viewLongerTextLabelView;
//                        credentialInitialsLabel.text=@"Credential Initials:";
//                    } 
//                    break;
//                    
//               
//                case 8:
//                    if ([cell  isKindOfClass:[ButtonCell class]]) 
//                    {
//                        
//                        
//                            
//                            
//                      
//                          int addressBookRecordIdentifier=(int )[(NSNumber *)[cell.boundObject valueForKey:@"aBRecordIdentifier"]intValue]; 
//                            
//                            NSLog(@"addressbook identifier is %i",addressBookRecordIdentifier);
//                            NSLog(@"addressbook Identifier %@", cell.boundObject);
//                            NSString *buttonText;
//                        
//                        
//                        
//                        if (addressBookRecordIdentifier!=-1 && ![self checkIfRecordIDInAddressBook:addressBookRecordIdentifier]) {
//                            addressBookRecordIdentifier=-1;
//                            [cell.boundObject setValue:[NSNumber numberWithInt:-1 ]forKey:@"aBRecordIdentifier"];
//                        }
//                        
//                        
//                        
//                        if (addressBookRecordIdentifier!=-1) {
//                                buttonText=[NSString stringWithString:@"Edit Address Book Record"];
//                                
//                                
//                          
//                                                                           
//                           
//
//                                
//                                                                
//                            }
//                            else 
//                            {
//                                buttonText=[NSString stringWithString:@"Add to Address Book"];
//                            }
//                            
//                            
//                            ButtonCell *buttonCell=(ButtonCell *)cell;
//                            UIView *view=[buttonCell viewWithTag:300];
//                        NSLog(@"view class is %@",[view.superclass class]);
//                            if ([view.superclass isSubclassOfClass:[UIButton class]]) {
//                                UIButton *button=(UIButton *)view;
//                                [button setTitle:buttonText forState:UIControlStateNormal];
//                                [button addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
//                                [button setEnabled:[tableViewModel valuesAreValid]];
//                           
//                            }
//                        } 
//                    break;
//
//                
//                case 9:
//                    //this is the root table
//                    
//                    
//                { 
//                   
//                    int addressBookRecordIdentifier=(int )[(NSNumber *)[cell.boundObject valueForKey:@"aBRecordIdentifier"]intValue]; 
//                    
//                    NSLog(@"addressbook identifier is %i",addressBookRecordIdentifier);
//                    NSLog(@"addressbook Identifier %@", cell.boundObject);
//                    NSString *buttonText;
//                    
//                    
//                    if (addressBookRecordIdentifier!=-1 && ![self checkIfRecordIDInAddressBook:addressBookRecordIdentifier]) {
//                        addressBookRecordIdentifier=-1;
//                        [cell.boundObject setValue:[NSNumber numberWithInt:-1 ]forKey:@"aBRecordIdentifier"];
//                    }
//                    
//                    
//                    
//                    if (addressBookRecordIdentifier!=-1) {
//                        buttonText=[NSString stringWithString:@"Remove Address Book Link"];
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                    }
//                    else 
//                    {
//                        buttonText=[NSString stringWithString:@"Look Up In Address Book"];
//                    }
//                    
//                    
//                    ButtonCell *buttonCell=(ButtonCell *)cell;
//                    UIView *view=[buttonCell viewWithTag:300];
//                    NSLog(@"view class is %@",[view.superclass class]);
//                    if ([view.superclass isSubclassOfClass:[UIButton class]]) {
//                        UIButton *button=(UIButton *)view;
//                        [button setTitle:buttonText forState:UIControlStateNormal];
//                        [button addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
//                       
//                        
//                    }
//                }  
//                
//                    break;
//
//                
//                
//                default:
//                    break;
//            }
//        }
//    if (tableViewModel.tag==2) 
//    {
//        UIView *buttonView =[cell viewWithTag:300];
//        if ([buttonView isKindOfClass:[UIButton class]]) 
//        {
//            UIButton *button=(UIButton *)buttonView;
//            [cell setBackgroundColor:[UIColor clearColor]];
//            switch (cell.tag) 
//            {
//                case 0:
//                
//                    {    
//                        NSLog(@"cell tag is %i",3);
//                        [button setTitle:@"Look Up In Address book" forState:UIControlStateNormal];
//                        
//                                   
//                    }
//       
//                    break;
//                case 1:
//                    
//                {    
//                    NSLog(@"cell tag is %i",4);
//                    [button setTitle:@"Add Or Edit in Address Book" forState:UIControlStateNormal];
//                    
//                }
//                                    
//                    break;     
//                default:
//                    break;
//            }
//        }
//    }
//    if (tableViewModel.tag==4) 
//    {
//      
//          
////                UIView *viewOne = [cell viewWithTag:51];
////                UIView *viewSendReports =[cell viewWithTag:40];
//                UIView *sliderView = [cell viewWithTag:14];
//                UIView *scaleView = [cell viewWithTag:70];
//                
//                switch (cell.tag) 
//                {
////                    case 0:
////                        
////                        if([viewOne isKindOfClass:[UILabel class]])
////                        {   
////                            UILabel *emailDesclabel = (UILabel *)viewOne;
////                            emailDesclabel.text=@"Email Description";
////                            
////                        }
////                        break;
//                    case 1:
//                        
////                        if ([viewOne isKindOfClass:[UILabel class]]) 
////                        {
////                            
////                            UILabel *emailLabel =(UILabel *)viewOne;
////                            emailLabel.text=@"Email Address:";
////                            
////                            UITextField *emailAddressField =(UITextField *)[cell viewWithTag:50];
////                            
////                            emailAddressField.keyboardType=UIKeyboardTypeEmailAddress;
////                            emailAddressField.autocapitalizationType=UITextAutocapitalizationTypeNone;
////                            
////                        }
//                        
//                        if ([scaleView isKindOfClass:[UISegmentedControl class]]) 
//                        {
//                            
//                            UILabel *fluencyLevelLabel =(UILabel *)[cell viewWithTag:71];
//                            fluencyLevelLabel.text=@"Fluency Level:";
//                            
//                        }
//                        
//                        break;
//                        
////                    case 2:
////                        if ([viewSendReports isKindOfClass:[UISwitch class]]) 
////                        {
////                            
////                            UILabel *emailLabel =(UILabel *)[cell viewWithTag:41];
////                            emailLabel.text=@"Send Reports:";  
////                            
////                        }
////                        
////                        break;
////                        
//                        
//                        
//                    case 3:
//                        
//                        
//                        if([sliderView isKindOfClass:[UISlider class]])
//                        {
//                            UISlider *sliderOne = (UISlider *)sliderView;
//                            UILabel *slabel = (UILabel *)[cell viewWithTag:10];
//                            
//                            slabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
//                            UIImage *sliderLeftTrackImage = [[UIImage imageNamed: @"sliderbackground-gray.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
//                            UIImage *sliderRightTrackImage = [[UIImage imageNamed: @"sliderbackground.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
//                            [sliderOne setMinimumTrackImage: sliderLeftTrackImage forState: UIControlStateNormal];
//                            [sliderOne setMaximumTrackImage: sliderRightTrackImage forState: UIControlStateNormal];
//                            [sliderOne setMinimumValue:-1.0];
//                            [sliderOne setMaximumValue:0];
//                            
//                        }
//                        break;
//                    case 4:
//                        
//                        if([sliderView isKindOfClass:[UISlider class]])
//                        {
//                            
//                            UISlider *sliderTwo = (UISlider *)sliderView;
//                            
//                            UILabel *slabelTwo = (UILabel *)[cell viewWithTag:10];
//                            UIImage *sliderTwoLeftTrackImage = [[UIImage imageNamed: @"sliderbackground.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
//                            UIImage *sliderTwoRightTrackImage = [[UIImage imageNamed: @"sliderbackground-gray.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
//                            [sliderTwo setMinimumTrackImage: sliderTwoLeftTrackImage forState: UIControlStateNormal];
//                            [sliderTwo setMaximumTrackImage: sliderTwoRightTrackImage forState: UIControlStateNormal];
//                            
//                            slabelTwo.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];        
//                            [sliderTwo setMinimumValue:0.0];
//                            [sliderTwo setMaximumValue: 1.0];
//                            
//                        }
//                        
//                
//                        break;
//                
//                    default:
//                        break;
//            
//
//                }
//    }
//
//  
//
//}
//



//- (void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillAppearForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel
//{
//    if (tableViewModel.tag==0) {
//        currentDetailTableViewModel_=detailTableViewModel;
//    }
//     
//
//   
//   
//}



//-(void)tableViewModel:(SCTableViewModel *)tableViewModel willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
//{
//    NSLog(@"table bies slkjd %i", tableViewModel.tag);
//    SCTableViewCell *cell =tableViewModel.activeCell;
//    deletePressedOnce=NO;
//    switch (tableViewModel.tag) {
//        case 1:
//        {
//                    
//            if (cell.tag==8 &&[cell isKindOfClass:[ButtonCell class]]&&![tableViewModel valuesAreValid]) {
//                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//                [appDelegate displayNotification:@"Add First and Last Name Before Adding to Address Book" forDuration:3.0 location:kPTTScreenLocationTop inView:tableViewModel.modeledTableView.superview];
//                
//            }
//            UITextField *view =(UITextField *)[cell viewWithTag:50];
//            
//            [view becomeFirstResponder];
//            [view resignFirstResponder]; 
//            
//            
//            
//            
//            
//        }
//            break;
//     case 3:    
//        {
//            UIView *textViewView=(UIView *)[cell viewWithTag:80];
//            if ([textViewView isKindOfClass:[UITextView class]]) {
//                UITextView *textView=(UITextView *)textViewView;
//                [textView becomeFirstResponder];
//                [textView resignFirstResponder];
//            }
//            
//        }
//        default:
//            break;
//    }
//
//}
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
//        NSLog(@"name values %@, %@, %@, %@, %@, %@", self.nameTitle, self.firstName, self.middleName, self.lastName,self.suffix, self.credentialIntitials );
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
//     NSLog(@"name values %@",fullName  );
//      
//    
//
//    return fullName;
//        
//        
// 
//
//}
 

//- (void)tableViewModel:(SCTableViewModel *)tableViewModel 
//       willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    SCTableViewSection *section =[tableViewModel sectionAtIndex:0];
//           
//    NSLog(@"section header title %@", section.headerTitle);
//    NSLog(@"table model tag is %i", tableViewModel.tag);
//   
//     
//    switch (tableViewModel.tag) {
//        case 0:
//           //this is the root table
//            
//           
//        {
//            NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
//            
//            ClinicianEntity *clinicianObject=(ClinicianEntity *)cellManagedObject;
//        
//            cell.textLabel.text=clinicianObject.combinedName;
//                    
//            
//           
//            
//            NSLog(@"cellManagedObject%@",clinicianObject.combinedName);
//                
//        }
//
//            break;
//                   
//        case 3:
//            //this is a third level table
//        {
//             NSManagedObject *managedObject = (NSManagedObject *)cell.boundObject;
//            
//            //identify the if the cell has a managedObject
//            if (managedObject) {
//                
//               
//            
//                  //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
//                if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
//                 
//               
//                    //identify the Languages Spoken table
//                   if ([managedObject.entity.name isEqualToString:@"LanguageSpokenEntity"]) {
//                       NSLog(@"the managed object entity is Languag spoken Entity");
//                       //get the value of the primaryLangugage attribute
//                       NSNumber *primaryLanguageNumber=(NSNumber *)[managedObject valueForKey:@"primaryLanguage"];
//                       
//                                                               
//                       NSLog(@"primary alanguage %@",  primaryLanguageNumber);
//                       //if the primaryLanguage selection is Yes
//                       if (primaryLanguageNumber==[NSNumber numberWithInteger:0]) {
//                           //get the language
//                           NSString *languageString =cell.textLabel.text;
//                           //add (Primary) after the language
//                           languageString=[languageString stringByAppendingString:@" (Primary)"];
//                           //set the cell textlable text to the languageString -the language with (Primary) after it 
//                           cell.textLabel.text=languageString;
//                           //change the text color to red
//                            cell.textLabel.textColor=[UIColor redColor];
//                        }
//                    }
//                }
//            }
//        }
//            
//      
//            break;
//        
//        case 4:
//            //this is a fourth level detail view
//            if (cell.tag==3)
//            {
//                    NSLog(@"cell tag is %i", cell.tag);
//                    UIView *viewOne = [cell viewWithTag:14];
//                    
//                    if([viewOne isKindOfClass:[UISlider class]])
//                    {
//                        UISlider *sliderOne = (UISlider *)viewOne;
//                        UILabel *slabel = (UILabel *)[cell viewWithTag:10];
//                        NSLog(@"detail will appear for row at index path label text%@",slabel.text);
//                        
//                        NSLog(@"bound value is %f", sliderOne.value);
//                        slabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
//                        
//                        
//                        
//                        
//                    }     
//
//            }
//            if (cell.tag==4)
//            {
//                NSLog(@"cell tag is ");
//                    UIView *viewTwo = [cell viewWithTag:14];
//                    if([viewTwo isKindOfClass:[UISlider class]])
//                    {
//                        
//                        
//                        NSLog(@"cell tag is %i", cell.tag);
//                        
//                        
//                        UISlider *sliderTwo = (UISlider *)viewTwo;
//                        UILabel *slabelTwo = (UILabel *)[cell viewWithTag:10];
//                        
//                        
//                        slabelTwo.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
//                    }
//
//                    
//                    
//              
//            }
//            
//            break;
//        default:
//            break;
//    }
//    
//    
//    
//        
//    
//    
//
//}


//-(void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
    //    
//    
//    
//}

//-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillAppearForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
//    if (tableViewModel.tag==0) {
//         currentDetailTableViewModel=detailTableViewModel;
//    }
    
//
//
//    if (tableViewModel.tag==1) {
//       
//        [self fullName:nil tableViewModel:tableViewModel cell:nil getNameValues:YES];
//    }
//    
//    NSLog(@"detail table view model%i",detailTableViewModel.tag);
//    if (tableViewModel.tag==0 ) {
//        SCTableViewCell *cell =(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
//        
//        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
//        
//        ClinicianEntity *clinicianObject=(ClinicianEntity *)cellManagedObject;
//        NSLog(@"my information is %@",clinicianObject.myInformation);
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
//    
//
//}


//- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSInteger)index
//{
// 
//    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
//   
//    NSLog(@"tableview model tag is %i",tableViewModel.tag);
//    NSLog(@"tableview model view controller is%@ ",[tableViewModel.viewController class]);
//    NSLog(@"index is %i",index);
//    NSLog(@"tabelmodel section count is %i",tableViewModel.sectionCount);
//    if (tableViewModel.tag==1 ) {
//        NSLog(@"section index is %i",index);
//        if (index==6) {
//            NSLog(@"cells in section is %i",section.cellCount);
//            
//            
//            
//            SCTableViewSection *sectionOne=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
//            SCTableViewCell *sectionOneClicianCell=(SCTableViewCell *)[sectionOne cellAtIndex:0];
//            NSManagedObject *cellManagedObject=(NSManagedObject *)sectionOneClicianCell.boundObject;
//            
//            if ([cellManagedObject isKindOfClass:[ClinicianEntity class]]) {
//                ClinicianEntity *clinicianObject=(ClinicianEntity *)cellManagedObject;
//                
//                
//                NSLog(@"my information is %@",clinicianObject.myInformation);
//                if ([clinicianObject.myInformation isEqualToNumber:[NSNumber numberWithBool:YES]]) {
//                    
//                    [tableViewModel removeSectionAtIndex:1];
//                    [tableViewModel removeSectionAtIndex:4];
//                    
//                }
//                
//            }
//            
//            
//            
//        }
//    }
//    
//
//    [self setSectionHeaderColorWithSection:(SCTableViewSection *)section color:[UIColor whiteColor]];
//    
////    if(section.headerTitle !=nil)
////    {
////       
////        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
////        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
////        
////      
////        headerLabel.backgroundColor = [UIColor clearColor];
////        headerLabel.textColor = [UIColor whiteColor];
////        headerLabel.text=section.headerTitle;
////        [containerView addSubview:headerLabel];
////
////        section.headerView = containerView;
////      
////
////
////    }
////  
//
//    
//}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel didRemoveRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (tableViewModel.tag==0) {
    
        [self updateClinicianTotalLabel];
        
    }
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel didRemoveSectionAtIndex:(NSInteger)index{

    if (tableViewModel.tag==0) {
        
        [self updateClinicianTotalLabel];
        
    }

   
}

-(void)updateClinicianTotalLabel{

 
    if (tableModel_.tag==0) 
    {
        int cellCount=0;
        if (tableModel_.sectionCount >0){
            
            for (int i=0; i<tableModel_.sectionCount; i++) {
                SCTableViewSection *section=(SCTableViewSection *)[tableModel_ sectionAtIndex:i];
                cellCount=cellCount+section.cellCount;
                
            }
            
            
        }
        if (cellCount==0)
        {
            self.totalCliniciansLabel.text=@"Tap + To Add Clinicians";
        }
        else
        {
            self.totalCliniciansLabel.text=[NSString stringWithFormat:@"Total Clinicians: %i", cellCount];
        }
        
    }
    
    



}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel didInsertRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (tableViewModel.tag==0) {
        
        [self updateClinicianTotalLabel];
        
    }

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
////                    valid=[self validateEmail:emailField.text];
////                    
////                    NSLog(@"testing email address");
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
//    NSLog(@"table view model is alkjlaksjdfkj %i", tableViewModel.tag);
//    
//    if (tableViewModel.tag==1){
// 
//        
//        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
//       SCControlCell *firstNameCell =(SCControlCell *)[section cellAtIndex:1];
//        SCControlCell *lastNameCell =(SCControlCell *)[section cellAtIndex:3];
//         
//        NSLog(@"last Name cell tag is %i", lastNameCell.tag);
//        UITextField *lastNameField =(UITextField *)[lastNameCell viewWithTag:50];
//        UITextField *firstNameField =(UITextField *)[firstNameCell viewWithTag:50];
//        NSLog(@"first name field %@",firstNameField.text);
//        NSLog(@"last name field %@",lastNameField.text);
//        
//        if ( firstNameField.text.length && lastNameField.text.length) {
//                    
//            valid=TRUE;
//            NSLog(@"first or last name is valid");
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
//   
//   
//     
//      
//    return valid;
//}




//- (void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)IndexPath
//{
//    SCTableViewCell *cell = [tableViewModel cellAtIndexPath:IndexPath];
//    
//    
//    if (tableViewModel.tag==1) {
//        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
//        SCTableViewCell *buttonTableViewCell=(SCTableViewCell *)[section cellAtIndex:8];
//        if ([buttonTableViewCell isKindOfClass:[ButtonCell class]]) {
//          ButtonCell * buttonCell =(ButtonCell *)buttonTableViewCell;
//            
//            UIButton *button=(UIButton *)[buttonCell viewWithTag:300];
//        
//            [button setEnabled:[tableViewModel valuesAreValid]];
//        }
//        
//        
//        
//    }
//    
//    
//
//    
//    
//    if (tableViewModel.tag==4){
//        if (cell.tag==3)
//        {
//            UIView *viewOne = [cell viewWithTag:14];
//           
//            if([viewOne isKindOfClass:[UISlider class]])
//            {
//                UISlider *sliderOne = (UISlider *)viewOne;
//                UILabel *sOnelabel = (UILabel *)[cell viewWithTag:10];
//                
//                sOnelabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
//            }
//        }  
//        if (cell.tag==4)
//        {        
//            UIView *viewTwo =[cell viewWithTag:14];
//            if([viewTwo isKindOfClass:[UISlider class]])
//                {    
//                   UISlider *sliderTwo = (UISlider *)viewTwo;
//                    UILabel *sTwolabel = (UILabel *)[cell viewWithTag:10];
//                    
//                    sTwolabel.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
//                }
//
//        
//       
//       }
// 
//    }
//}


    
//-(void) tableViewModel:(SCTableViewModel *)tableViewModel customButtonTapped:(UIButton *)button forRowWithIndexPath:(NSIndexPath *)indexPath{
//  
//    SCTableViewSection *section =[tableViewModel sectionAtIndex:indexPath.section];
//    SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
//    NSLog(@"custom button tapped");
//    
//    
//    if (tableViewModel.tag==1) {
//        NSLog(@"table model tag is %i",2);
//        NSLog(@"the cell tag is %i",cell.tag);
//        switch (cell.tag)
//        {
////            case 0:
////            {
////                NSLog(@"cell tag is %i",0);
////                
////
////               
////             
////                
//////                NSManagedObject *managedObject =nil;
//////                NSLog(@"the managed object is %@", 
//////                      tableModel.items);   
////              
////                
////               
////                
//////                NSLog(@"the managed object is %@", 
////////                    self.presentedViewController.parentViewController );
//////                
//////                NSLog(@"the managed object context is %@", managedObjectContext);
////////                [self showPeoplePickerController];
////                
////                
////
////                break;
////            }
////                
////                
////            case 1:
////            {
////                NSLog(@"cell tag is %i",1);
//////                [self showPersonViewController ];   
////                break;
////            }    
////                
////            case 2:
////            {
////                NSLog(@"cell tag is %i",2);
////                
//////                [self showNewPersonViewController];
////                
////                
////                break;
////            }    
//            case 8:
//            {
//                NSLog(@"cell tag is %i",2);
//                if ([cell isKindOfClass:[ButtonCell class]]) {
//              
//                
//                
//                    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
//                    
//                    NSEntityDescription *entityDesctipion=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
//                    if ([cellManagedObject.entity isKindOfEntity:entityDesctipion]) {
//                        clinician=nil;
//                        clinician=(ClinicianEntity *) cellManagedObject;
//                        
//                
////                        SCTableViewCell *cellAtOne=(SCTableViewCell *)[section cellAtIndex:1];
////                       
////                        UIView *viewLongerTextLabelView =(UIView *)[cellAtOne viewWithTag:51];
////                       NSLog(@"viewlonger text label view is %@",[viewLongerTextLabelView class]);
////                        if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
////                        {
////                            NSLog(@"first name");
////                            
////                            UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
////                            NSLog(@"label tex is %@",firstNameLabel.text);
////                            if ([firstNameLabel.text isEqualToString:@"First Name:"]) {
////                                [cellAtOne commitChanges];
////                            } 
////                        }
////
////                        SCTableViewCell *cellAtThree=(SCTableViewCell *)[section cellAtIndex:3];
////                        
////                        UIView *lastNameLabelView =(UIView *)[cellAtThree viewWithTag:51];
////                        
////                        if ([lastNameLabelView isKindOfClass:[UILabel class]]) 
////                        {
////                            NSLog(@"last Name");
////                            
////                            UILabel *lastNameLabel =(UILabel *)lastNameLabelView;
////                             NSLog(@"label last nametex is %@",lastNameLabel.text);
////                            if ([lastNameLabel.text isEqualToString:@"Last Name:"]) {
////                                [cellAtThree commitChanges];
////                            } 
////                        }
//                       
//                            
//                        
////                        cellManagedObject=(NSManagedObject *)cell.boundObject;
////                        clinician=(ClinicianEntity *) cellManagedObject;
//                        
//                        
//                        NSLog(@"clinician %@",clinician);
//                        for (NSInteger i=0; i<tableViewModel.sectionCount;i++) {
//                            SCTableViewSection *sectionAtIndex=(SCTableViewSection *)[tableViewModel sectionAtIndex:i];
//                            
//                            [sectionAtIndex commitCellChanges];
//                        }
//
//                        [self evaluateWhichABViewControllerToShow];
//                        
//                    }
//                   
//                
//                    
//                }
//                break;
//            }    
//            case 9:
//            {   NSLog(@"cell tag is %i",2);
//                if ([cell isKindOfClass:[ButtonCell class]]) {
//                    
//                    
//                    
//                    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
//                    
//                    NSEntityDescription *entityDesctipion=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
//                    if ([cellManagedObject.entity isKindOfEntity:entityDesctipion]) {   
//                      
//                        
//                        
//                        int addressBookRecordIdentifier=(int )[(NSNumber *)[cell.boundObject valueForKey:@"aBRecordIdentifier"]intValue]; 
//                        
//                        NSLog(@"addressbook identifier is %i",addressBookRecordIdentifier);
//                        NSLog(@"addressbook Identifier %@", cell.boundObject);
//                    
//                        
//                        
//                        
//                        
//                        if (addressBookRecordIdentifier!=-1) {
//                            
//                            
//                            existingPersonRecordID=-1;
//                            [cellManagedObject setNilValueForKey:@"aBRecordIdentifier"];
//                            [cell commitChanges];
//                            [currentDetailTableViewModel reloadBoundValues];
//                            [currentDetailTableViewModel.modeledTableView reloadData];
//                          
//                          
//                            
//                            
//                        }
//                        else
//                        {
//                        
//                            [self showPeoplePickerController];
//                        
//                        
//                        }
//                      
//                      
//                        
//                    }
//                    
//                    
//                    
//                }
//                break;
//            }    
//
//            default:
//                break;
//        }
//        
//        
//        
//        
//    }
//    
//    
//    if (tableViewModel.tag==4) {
//  
//        SCTextFieldCell *phoneNumberCell =(SCTextFieldCell *) [section cellAtIndex:1];
//        NSLog(@"custom button tapped");
//        if (phoneNumberCell.textField.text.length) {
//            
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call Phone Number:" message:phoneNumberCell.textField.text
//                                                       delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//        
//        alert.tag=1;
//     
//     
//       
//        [alert show];
// 
//     
//    }
//    }
//}

//-(void)tableViewModelDidEndEditing:(SCTableViewModel *)tableViewModel{
//
//
//    deletePressedOnce=NO;
//
//}
-(BOOL)tableViewModel:(SCTableViewModel *)tableViewModel willRemoveRowAtIndexPath:(NSIndexPath *)indexPath{

    SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
  NSLog(@"delete sender is activated %@",cell.boundObject);
    BOOL myInformation=(BOOL)[(NSNumber *)[cell.boundObject valueForKey:@"myInformation"]boolValue];
    if (myInformation) {
        PTTAppDelegate *appdelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        UIView *notificationSuperView;
       
                  
       
    
        
        if (!deletePressedOnce) {
            
            [appdelegate displayNotification:@"Can't Delete Your Own Record. Press Delete again to clear your information." forDuration:3.5 location:kPTTScreenLocationTop inView:notificationSuperView];
            
            deletePressedOnce=YES;
        }
        else
        {
            
            NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
            ClinicianEntity *clinicianObject=(ClinicianEntity *)cellManagedObject;
            
            NSEntityDescription *entityDescription=(NSEntityDescription *) clinicianObject.entity;
            
            
            NSArray *boundObjectKeys=(NSArray *)[entityDescription attributesByName] ;
         NSLog(@"client entity keys %@",boundObjectKeys);
            for (id attribute in boundObjectKeys){
                BOOL setNil=YES;
                if ([attribute isEqualToString:@"firstName"]) {
                    [clinicianObject setValue:@"Enter Your" forKey:attribute];
                    setNil=NO;
                }
                if ([attribute isEqualToString:@"lastName"]) {
                    [clinicianObject setValue:@"Name Here" forKey:attribute];
                    setNil=NO;
                }
                
                if (setNil && ![attribute isEqualToString:@"myInformation"]&&![attribute isEqualToString:@"atMyCurrentSite"]&&![attribute isEqualToString:@"order"]) {
                    [cellManagedObject setValue:nil forKey:attribute];
                      NSLog(@"attribute %@",attribute);
                }
          
            }
            
            
            NSArray *relationshipsByName=(NSArray *)[entityDescription relationshipsByName] ;
            NSLog(@"client entity keys %@",relationshipsByName);
            
            for (id relationship in relationshipsByName){
             
                
                
         
                    [clinicianObject setValue:nil forKey:relationship];
                    NSLog(@"set nil value for relationship %@",relationship);
              
                
            }
            
            
            [tableViewModel reloadBoundValues];
            [tableViewModel.modeledTableView reloadData];
            [appdelegate displayNotification:@"My Personal Information Cleared" forDuration:3.0 location:kPTTScreenLocationTop inView:notificationSuperView];
            deletePressedOnce=NO;
            NSLog(@"client entity keys after %@",cellManagedObject);
        }
       
        return NO;
    }
    
    return YES;
}
    
//-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillDisappearForSectionAtIndex:(NSUInteger)index{
//    if (tableViewModel.tag==0) {
//        self.currentDetailTableViewModel=nil;
//        [self resetABVariablesToNil];
//    }
//
// 
//
//
//
//
//} 
//-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewDidDisappearForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (tableViewModel.tag==0) {
//        currentDetailTableViewModel=nil;
//        [self resetABVariablesToNil];
//    }
//
//}



//-(BOOL)checkIfRecordIDInAddressBook:(int)recordID{
//    
//    ABAddressBookRef addressBook;
//    addressBook=nil;
//    addressBook=ABAddressBookCreate();
//    
//    BOOL exists=NO;
//    if (recordID>0) {
//        
//        ABRecordRef person=(ABRecordRef ) ABAddressBookGetPersonWithRecordID(addressBook, recordID);
//        
//        if (person) {
//            exists=YES;
//            CFRelease(person);
//        } 
//        
//        
//    }
//    
//   
//    
//    return exists;
//    
//}
//

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
#pragma mark Show all contacts
// Called when users tap "Display Picker" in the application. Displays a list of contacts and allows users to select a contact from that list.
// The application only shows the phone, email, and birthdate information of the selected contact.



//
//-(void)showPeoplePickerController
//{
//   
//	
//    ABPeoplePickerNavigationController *peoplePicker=[[ABPeoplePickerNavigationController alloc]init];
//   
//    peoplePicker.peoplePickerDelegate = self;
//	// Display only a person's phone, email, and birthdate
//	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty], 
//                               [NSNumber numberWithInt:kABPersonEmailProperty],
//                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
//	
//	
//	peoplePicker.displayedProperties = displayedItems;
//	// Show the picker 
//
//    
//    
//    [peoplePicker setPeoplePickerDelegate:self];
//    
//
//	// Display only a person's phone, email, and birthdate
////	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty], 
////                               [NSNumber numberWithInt:kABPersonEmailProperty],
////                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
//	
//    
//    
////	abToDisplay.peoplePicker.displayedProperties=displayedItems;
//	// Show the picker 
//   
//   
//	[currentDetailTableViewModel.viewController.navigationController presentModalViewController:peoplePicker animated:YES];
//    
//	
//}
//
//
//#pragma mark Display and edit a person
//// Called when users tap "Display and Edit Contact" in the application. Searches for a contact named "Appleseed" in 
//// in the address book. Displays and allows editing of all information associated with that contact if
//// the search is successful. Shows an alert, otherwise.
//
//
// -(void)evaluateWhichABViewControllerToShow
//{
//	// Fetch the address book 
////	ABAddressBookRef addressBook = ABAddressBookCreate();
// 
//    
//    ABAddressBookRef addressBook;
//    addressBook=nil;
//    addressBook=ABAddressBookCreate();
////    
////    
////
////    // Search for the person named "Appleseed" in the address book
////	
////    
//   
//    
//    
//    NSString *groupName=(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];
//    int groupIdentifier=(NSInteger )[(NSNumber *)[[NSUserDefaults standardUserDefaults]valueForKey:kPTTAddressBookGroupIdentifier]intValue];
//    
//    BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults] boolForKey:kPTAutoAddClinicianToGroup];
//   
//    NSLog(@"group Name %@",groupName);
////    
////    
//    
//   existingPersonRecordID=[(NSNumber *)clinician.aBRecordIdentifier intValue];
//    if (existingPersonRecordID!=-1&&![self checkIfRecordIDInAddressBook:(int)existingPersonRecordID]) {
//        existingPersonRecordID=-1;
//        
//        
//    }
////    NSLog(@"clinicianrecord identifier is %i",clinicianRecordIdentifier);
//  
//        
//   
////   ABRecordRef existingPersonRef=ABAddressBookGetPersonWithRecordID((ABAddressBookRef )addressBook, clinicianRecordIdentifier);
//// 
////     }
////    
////    NSLog(@"existingPerson_ record id %@",existingPersonRef);
//    
//    if (!groupName.length) {
//        groupName=@"Clinicians";
//        [[NSUserDefaults standardUserDefaults] setValue:groupName forKeyPath:kPTTAddressBookGroupName];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }  
//    
//    ABRecordRef group;
//    group=nil;
//    if (groupIdentifier>-1) {
//       group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
//   
//    }
//
//    if (!group && autoAddClinicianToGroup) {
//        
//        [self changeABGroupNameTo:groupName addNew:NO];
//        
//        groupIdentifier=(NSInteger )[(NSNumber *)[[NSUserDefaults standardUserDefaults]valueForKey:kPTTAddressBookGroupIdentifier]intValue];
//        
//        if (groupIdentifier>-1) {
//            group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
//            
//        }
//
//        
//        
//        //        ABRecordRef CFAddressBookGroupRecord =  ABGroupCreate ();
//        
////        group=ABGroupCreate();
////        
////        //        ABRecord *groupRecord=(ABRecord *)[group getRecordRef];
////        
////        //        NSLog(@"group composite name is %@",groupRecord.compositeName);
////       
////        bool didSetGroupName=FALSE;
////        didSetGroupName= (bool) ABRecordSetValue (
////                              group,
////                               (ABPropertyID) kABGroupNameProperty,
////                               (__bridge CFStringRef)groupName  ,
////                              nil
////                               );  
////        //        NSLog(@"group record identifier is %i",groupRecord.recordID);
////      
////        BOOL wantToSaveChanges=TRUE;
////        if (ABAddressBookHasUnsavedChanges(addressBook)) {
////            
////            if (wantToSaveChanges) 
////            {
////                bool didSave=FALSE;
////                didSave = ABAddressBookSave(addressBook, nil);
////                
////                if (!didSave) {/* Handle error here. */}
////           
////            } 
////            else 
////            {
////                
////                ABAddressBookRevert(addressBook);
////                
////            }
////            
////        }
//        
//        //        ABRecord *groupRecord=[[ABRecord alloc]initWithABRef:(CFTypeRef)kABGroupType ];
//        
////        NSLog(@"group idenitifer is%i",ABRecordGetRecordID(group));
////        
////        NSLog(@"group name is %@", (__bridge NSString *)ABRecordCopyValue(group, kABGroupNameProperty));
////        
////        
////        [[NSUserDefaults standardUserDefaults] setInteger:(NSInteger )ABRecordGetRecordID(group) forKey:kPTTAddressBookGroupIdentifier];
////        
////        [[NSUserDefaults standardUserDefaults]synchronize];
//        
//    }
//
//    if (existingPersonRecordID==-1) {
//       
//        CFStringRef name=(__bridge CFStringRef)[NSString stringWithFormat:@"%@ %@",clinician.firstName, clinician.lastName];
//        
//       CFArrayRef peopleWithNameArray= ABAddressBookCopyPeopleWithName((ABAddressBookRef) addressBook, (CFStringRef) name);
//            
//      
//        NSLog(@" people with name array %@",peopleWithNameArray);
//       
//        int peopleCount=CFArrayGetCount((CFArrayRef) peopleWithNameArray);
//        if (peopleCount==1  && !addExistingAfterPromptBool  ) {
//           
//            
//          ABRecordRef  existingPersonRef=CFArrayGetValueAtIndex(peopleWithNameArray, 0);
//            
//            existingPersonRecordID=ABRecordGetRecordID(existingPersonRef);
//            CFStringRef CFFirstName=ABRecordCopyValue((ABRecordRef) existingPersonRef, kABPersonFirstNameProperty);
//            
//            CFStringRef CFLastName=ABRecordCopyValue((ABRecordRef) existingPersonRef, kABPersonLastNameProperty);
//            
//            NSString *firstName=(__bridge_transfer NSString *)CFFirstName;
//            
//            NSString *lastName=(__bridge_transfer NSString *)CFLastName;
//            
//            CFRelease(CFFirstName);
//            CFRelease(CFLastName);
//
//            
//            NSString *compositeName=[NSString stringWithFormat:@"%@ %@", firstName, lastName]; 
//             NSString *alertMessage=[NSString stringWithFormat:@"Existing entry for %@ in the Address Book. Would you like to link this clinician to the existing Address Book entry?",compositeName];
//                
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Existing Contact With Name" message:alertMessage
//                                                           delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Link to Existing", @"Create New", nil];
//            
//            alert.tag=kAlertTagFoundExistingPersonWithName;
//                NSLog(@"composite name is %@",compositeName);
//            NSLog(@"alert message is %@",alertMessage);
//           
//            [alert show];
////            CFRelease(name);
////            CFRelease(peopleWithNameArray);
//            
////            [self showUnknownPersonViewControllerWithABRecordRef:(ABRecordRef)person.recordRef];
//            
//        }
//        else if(peopleCount>1 && !addExistingAfterPromptBool)
//        {
//           ABRecordRef  existingPersonRef=CFArrayGetValueAtIndex(peopleWithNameArray, 0);
//           
//            CFStringRef CFFirstName=ABRecordCopyValue((ABRecordRef) existingPersonRef, kABPersonFirstNameProperty);
//            
//            CFStringRef CFLastName=ABRecordCopyValue((ABRecordRef) existingPersonRef, kABPersonLastNameProperty);
//            
//            NSString *firstName=(__bridge_transfer NSString *)CFFirstName;
//            
//            NSString *lastName=(__bridge_transfer NSString *)CFLastName;
//            
//            CFRelease(CFFirstName);
//            CFRelease(CFLastName);
//
//            
//            NSString *compositeName=[NSString stringWithFormat:@"%@ %@", firstName, lastName];  
//            NSString *alertMessage=[NSString stringWithFormat:@"Existing entries for %@ in the Address Book. Would you like to select an existing Address Book entry for this clinician?",compositeName];
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Existing Contacts With Name" message:alertMessage
//                                                           delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Choose Existing", @"Create New", nil];
//            
//            alert.tag=kAlertTagFoundExistingPeopleWithName;
//            
//            
//            [alert show];
//        }
//        else
//        
//        {
//         
//        
//          ABRecordRef  existingPersonRef=ABPersonCreate();
//       
//    //    ABPerson *person=(ABPerson *)personRecord;
//            
//        
//        NSLog(@"clinician first name is %@ and Clnician last name is %@",clinician.firstName,clinician.lastName);
//        
//            if (clinician.firstName.length) {
//                ABRecordSetValue(existingPersonRef, kABPersonFirstNameProperty, (__bridge CFStringRef) clinician.firstName, nil) ; 
//            }
//            if (clinician.lastName.length) {
//                ABRecordSetValue(existingPersonRef, kABPersonLastNameProperty, (__bridge CFStringRef) clinician.lastName, nil) ; 
//            }
//            if (clinician.prefix.length) {
//                ABRecordSetValue(existingPersonRef, kABPersonPrefixProperty, (__bridge CFStringRef) clinician.prefix, nil) ; 
//            }
//            if (clinician.middleName.length) {
//                ABRecordSetValue(existingPersonRef, kABPersonMiddleNameProperty, (__bridge CFStringRef) clinician.middleName, nil) ; 
//            }
//            
//            if (clinician.suffix.length) {
//                ABRecordSetValue(existingPersonRef, kABPersonSuffixProperty, (__bridge CFStringRef) clinician.suffix, nil) ; 
//            }
//            
//            if (clinician.notes.length) {
//                ABRecordSetValue(existingPersonRef, kABPersonNoteProperty, (__bridge CFStringRef) clinician.notes, nil) ;
//            }
//     
//           
//            [personAddNewViewController_ setAddressBook:addressBook];
//            self.personAddNewViewController=[[ABNewPersonViewController alloc]init];;
//            if (autoAddClinicianToGroup &&group) {
//                 NSLog(@"group issdfsdf %@",group);
//                 personAddNewViewController_.parentGroup=group;
//            }
//           
//            personAddNewViewController_.newPersonViewDelegate=self;
//            [personAddNewViewController_ setDisplayedPerson:existingPersonRef];
//            
//            personAddNewViewController_.view.tag=837;
//    
////           [personAddNewViewController_ setAddressBook:addressBook];
////            personAddNewViewController_=[[ABNewPersonViewController alloc]init];;
////            personAddNewViewController_.parentGroup=group;
////            personAddNewViewController_.newPersonViewDelegate=self;
////            [personAddNewViewController_ setDisplayedPerson:existingPersonRef];
////            
////            personAddNewViewController_.view.tag=900;
////            currentDetailTableViewModel.viewController.navigationController.delegate =self ;
//            
//           
//            
//            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:personAddNewViewController_];	
//            
//            navController.delegate=self;
//            [[currentDetailTableViewModel.viewController navigationController] presentModalViewController:navController animated:YES];
//            
//            addExistingAfterPromptBool=FALSE;
////            [currentDetailTableViewModel.viewController.navigationController presentModalViewController:personToAddViewController animated:YES ];
//        
//            
//        }
////        CFRelease(group);
//    }
//    else
//    
//    {
//        NSLog(@"existing record id is %i",existingPersonRecordID);
//    
//        [self showPersonViewControllerForRecordID:(int)existingPersonRecordID];
//    
//    }
//    
//   
//
//}
//
//
//
////        ABRecordID CFRecordID= (ABRecordID) ABRecordGetRecordID (
////                                                                 (ABRecordRef) CFAddressBookGroupRecord
////                                                                 );
//        
////        recordIdentifier=(__bridge NSString)CFRecordID;
//        
////        NSLog(@"record identifier is %i",CFRecordID);
////        CFErrorRef error = NULL;
////        
////
////          bool didSet;
////            
////          didSet= (bool)  ABRecordSetValue ((ABRecordRef) CFAddressBookGroupRecord,
////                                             (ABPropertyID) kABGroupNameProperty,
////                                             (__bridge CFTypeRef) groupName,
////                                             &error
////                                             );
////        
////        group se
////            
////        NSLog(@"abrecrod didset value is %i",didSet);
////            NSLog(@"group record %@",CFAddressBookGroupRecord);
////        
////         NSLog(@" record id is %i",CFRecordID);
////        
////       
////       didSet= (bool) ABAddressBookAddRecord (
////                                     (ABAddressBookRef) addressBook,
////                                     (ABRecordRef) CFAddressBookGroupRecord,
////                                    &error
////                                     );
////        
////        
////        NSLog(@"address book add record didset value is %i",didSet);
////         NSLog(@" record id is %i",CFRecordID);
////        
////        CFRecordID= (ABRecordID) ABRecordGetRecordID (
////                                                      (ABRecordRef) CFAddressBookGroupRecord
////                                                      );
////        
////        
////        NSLog(@" record id is %i",CFRecordID);
////       
////        if (ABAddressBookHasUnsavedChanges(addressBook)) {
////            
////            bool didSave;
////                didSave = (bool) ABAddressBookSave(addressBook, &error);
////                
////                if (didSave) {
////                    NSLog(@"did save is %i",didSave);
////                    
////                    
////                    NSLog(@" record id is %i",CFRecordID);
////                    CFRecordID= (ABRecordID) ABRecordGetRecordID (
////                                                                  (ABRecordRef) CFAddressBookGroupRecord
////                                                                  );
////                    
////                    
////                    NSLog(@" record id is %i",CFRecordID);
////                    
////                    groupIdentifier=(ABRecordID)CFRecordID;
////                    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInteger:groupIdentifier] forKeyPath:@"addressBookGroupIdentifier"];
////                    [[NSUserDefaults standardUserDefaults] synchronize];
////                
////        
////                } 
////                else 
////                {
////                    /* Handle error here. */
////               
////                    
////                }
////            
////        }
////        
////     
////        
////        
////        
////       
////    }  
////
////    
////            
//////        bool didSet;
//////        
//////        
//////        
//////        didSet = ABRecordSetValue(aRecord, kABPersonFirstNameProperty, CFSTR("Katie"), &anError);
////        
//////        if (!didSet) {/* Handle error here. */}
//////        
//////        
//////        
//////    }
//////    else {
//////    ABRecordRef CFAddressBookGroupRecord =   (ABRecordRef ) ABAddressBookGetGroupWithRecordID (
//////                                                       (ABAddressBookRef )addressBook,
//////                                                      (ABRecordID ) recordIdentifier
//////                                                       );
//////    }
////    
////   CFArrayRef CFGroupsArray= (CFArrayRef) ABAddressBookCopyArrayOfAllGroups (
////                                                  (ABAddressBookRef) addressBook
////                                                  );
////    
////    
////    NSArray *groupsArray=(__bridge NSArray*)CFGroupsArray;
////    
////    
////    NSLog(@"groups array %@",groupsArray);
//    
////    if (![groupsArray containsObject:grou) {
////        <#statements#>
////    }
////    ABRecordRef ABGroupCreate (
////                               void
////                               );
//       
////    bool wantToSaveChanges = YES;
////    
////    bool didSave;
////    
////    CFErrorRef error = NULL;
//    
//    
//    
//   
//    
//    
//    
//  
//    
//    
//    
//    
//    
////    CFStringRef CFShortFullName=(__bridge CFStringRef)[firstName stringByAppendingFormat:@" %@",lastName];
////    CFStringRef CFAddressBookRecordIdentifier=(__bridge CFStringRef)recordIdentifier;
////    NSArray *people = (__bridge NSArray *) ABAddressBookCopyArrayOfAllPeople(addressBook);
//    
////CFArrayRef CFPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
////
////CFMutableArrayRef CFPeopleMutable = CFArrayCreateMutableCopy(
////                                                           
////                                                           kCFAllocatorDefault,
////                                                           
////                                                           CFArrayGetCount(CFPeople),
////                                                           
////                                                           CFPeople
////                                                           
////                                                           );
////CFArraySortValues(
////                  
////                  CFPeopleMutable,
////                  
////                  CFRangeMake(0, CFArrayGetCount(CFPeopleMutable)),
////                  
////                  (CFComparatorFunction) ABPersonComparePeopleByName,
////                  
////                  (void*) ABPersonGetSortOrdering()
////                  
////                  );
////
////
////NSMutableArray *peopleMutable= (__bridge NSMutableArray*) CFPeopleMutable;
////NSLog(@"people mutable is %@",peopleMutable);
////NSString *predicateString = [NSString stringWithFormat:@"[SELF] contains %",CFShortFullName];
////    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:predicateString];
////    NSArray *names = [peopleMutable filteredArrayUsingPredicate:searchPredicate];
////    NSLog(@"names are %@", names);
////	 CFArrayRef *CFPeopleWithName = (CFArrayRef *)ABRecordCopyCompositeName( CFShortFullName);
////    NSArray *nsPeopleWithCompositeArray=(NSArray *)CFPeopleWithName;
////
////    
////  
////    // Display "Appleseed" information if found in the address book 
////	if ([names count]>0)
////	{
////        ABPersonViewController *picker = [[ABPersonViewController alloc] init] ;
////		picker.personViewDelegate = self;
////      ABRecordRef record = (__bridge ABRecordRef)[names objectAtIndex:0];
////        if (record !=nil) {
////          
////            picker.displayedPerson=record;
////        }
////        else
////        {
////        ABRecordRef person = (__bridge ABRecordRef)[nsPeopleWithCompositeArray objectAtIndex:0];
////        picker.displayedPerson = person;
////		}
////      
////        // Allow users to edit the person’s information
////		picker.allowsEditing = YES;
////		[self.navigationController pushViewController:picker animated:YES];
////	}
////	else 
////	{
////		if (firstName.length && lastName.length)
////        {
////        [self showUnknownPersonViewController];
////        }
////        else
////        {
////            [self showNewPersonViewController];
////        }
////        
////        
////        
////        if (ABAddressBookHasUnsavedChanges(addressBook)) {
////            
////            if (wantToSaveChanges) {
////                
////                didSave = ABAddressBookSave(addressBook, &error);
////                
////                if (!didSave) {/* Handle error here. */}
////                
////            } else {
////                
////                ABAddressBookRevert(addressBook);
////                
////            }
////            
////        }
////        
////        
////        
////        CFRelease(addressBook);
////        
////        // Show an alert if "Appleseed" is not in Contacts
//////		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
//////														message:@"Could not find Appleseed in the Contacts application" 
//////													   delegate:nil 
//////											  cancelButtonTitle:@"Cancel" 
//////											  otherButtonTitles:nil];
//////		[alert show];
//////		[alert release];
////	}
////	
//
////}
//
//
////#pragma mark Create a new person
////// Called when users tap "Create New Contact" in the application. Allows users to create a new contact.
////-(void)showNewPersonViewControllerForClinician:(ABRecordRef )clinician
////{
////    
////	ABNewPersonViewController *picker = [[ABNewPersonViewController alloc] init];
////	picker.newPersonViewDelegate = self;
////	picker.displayedPerson =clinician;
////	
////    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:picker];
////	[self presentModalViewController:navigation animated:YES];
////
////
////
////}
////
////
////
////
////#pragma mark Add data to an existing person
////// Called when users tap "Edit Unknown Contact" in the application. 
////
////-(void)showUnknownPersonViewControllerWithABRecordRef:(ABRecordRef )recordRef
////{
////            
////    if (recordRef) {
////  
////        ABUnknownPersonViewController *picker = [[ABUnknownPersonViewController alloc] init];
////                picker.unknownPersonViewDelegate = self;
////                picker.displayedPerson = recordRef;
////                picker.allowsAddingToAddressBook = YES;
////                picker.allowsActions = YES;
////                
////        NSString *compositeName=(__bridge NSString *)ABRecordCopyCompositeName((ABRecordRef) recordRef);
////                picker.title = @"picker Title";
////                picker.message = [NSString stringWithFormat: @"Existing Entry for %@ in Address Book",compositeName];
////                
////        
//////        UINavigationController *currentNavigationController=(UINavigationController*)currentDetailTableViewModel.viewController.navigationController;
////                [currentDetailTableViewModel.viewController.navigationController pushViewController:picker animated:YES];
////        
////
////        }
////        else 
////        {
////            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
////                                                            message:@"Could not create unknown user" 
////                                                           delegate:nil 
////                                                  cancelButtonTitle:@"Cancel"
////                                                  otherButtonTitles:nil];
////            [alert show];
////        }
////}
////	
//	
//
//
//
//
//
//
////-(void)createpsyTrackAddressBook {
////    ABAddressBookRef addressBook;
////    
////    bool wantToSaveChanges = YES;
////    
////    bool didSave;
////    
////    CFErrorRef error = NULL;
////    
////    
////    
////    addressBook = ABAddressBookCreate();
////    
////    
////    
////    /* ... Work with the address book. ... */
////    
////    
////    
////    if (ABAddressBookHasUnsavedChanges(addressBook)) {
////        
////        if (wantToSaveChanges) {
////            
////            didSave = ABAddressBookSave(addressBook, &error);
////            
////            if (!didSave) {/* Handle error here. */}
////            
////        } else {
////            
////            ABAddressBookRevert(addressBook);
////            
////        }
////        
////    }
////    
////    
////    
////    CFRelease(addressBook);
////    
////}
//
//
//#pragma mark Display and edit a person
//// Called when users tap "Display and Edit Contact" in the application. Searches for a contact named "Appleseed" in 
//// in the address book. Displays and allows editing of all information associated with that contact if
//// the search is successful. Shows an alert, otherwise.
////-(void)showPersonViewControllerForABRecordRef:(ABRecordRef)recordRef;
////{
////	
////    if (recordRef) {
////   
////		
////    
////      
////        
////        ABPersonViewController *personViewController=[[ABPersonViewController alloc]init];;
////        personViewController.personViewDelegate = self;
////		personViewController.displayedPerson = existingPersonRef;
////        
////        personViewController.allowsEditing=YES;
////        personViewController.view.tag=837;
////          [currentDetailTableViewModel.viewController.navigationController setDelegate:self];
////        [currentDetailTableViewModel.viewController.navigationController pushViewController:personViewController animated:YES];
////        
////        
//////        picker.personViewDelegate = self;
//////		picker.displayedPerson = recordRef;
//////		// Allow users to edit the person’s information
//////		picker.allowsEditing = YES;
////		
////	}
////	
////	
////}
//
//
//-(void)showPersonViewControllerForRecordID:(int)recordID
//{
//	
//    
//    if (recordID) {
//        
//		ABAddressBookRef addressBook =ABAddressBookCreate();
//        ABRecordRef existingPerson=ABAddressBookGetPersonWithRecordID(addressBook, recordID);
//        
//        
//        ABPersonViewController *personViewController=[[ABPersonViewController alloc]init];;
//        personViewController.personViewDelegate = self;
//		personViewController.displayedPerson = existingPerson;
//        
//        personViewController.allowsEditing=YES;
//        personViewController.view.tag=837;
//        [currentDetailTableViewModel.viewController.navigationController setDelegate:self];
//        [currentDetailTableViewModel.viewController.navigationController pushViewController:personViewController animated:YES];
//        
//        
//        //        picker.personViewDelegate = self;
//        //		picker.displayedPerson = recordRef;
//        //		// Allow users to edit the person’s information
//        //		picker.allowsEditing = YES;
//    
//		
//	}
//	
//	
//}
//
//
//
//
//
//-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
//
//
//    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
//
//
//}
//#pragma mark ABPeoplePickerNavigationControllerDelegate methods
//// Displays the information of a selected person
//- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
//{
//   
//       
//    // stick the buttons in the toolbar
//    
//    NSLog(@"people picker view controllers are %@",peoplePicker.viewControllers); 
//    
//    UIViewController *membersViewController=(UIViewController *)[peoplePicker.viewControllers objectAtIndex:1];
//    
//    NSLog(@"modal view controler is %@",membersViewController.modalViewController);
//    
//    membersViewController.navigationController.delegate=self;
//    
//    NSLog(@"members view controller navigation controller viewcontrollers are %@",membersViewController.navigationController.viewControllers);
//   
//    
//    for (UIViewController *viewController in membersViewController.navigationController.viewControllers) {
//        viewController.view.tag=789;
//    }
////    peoplePicker.viewControllers.navigationItem.rightBarButtonItems=buttons;
//    
////    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
//    return YES;
//}
//
//
//-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//
//NSLog(@"will show view controller %@",viewController);
//    
//    
//    NSLog(@"will show view controller %@",viewController);
//    if (viewController.view.tag==837) {
//        
//        
//        UITableView *personViewTableView=(UITableView *)[viewController.view.subviews objectAtIndex:0];
//
//        if ([SCHelper is_iPad]) {
//            [personViewTableView setBackgroundView:nil];
//            [personViewTableView setBackgroundView:[[UIView alloc] init]];
//        }
//       
//     
//        [personViewTableView setBackgroundColor:UIColor.clearColor]; 
//        
//        [viewController.navigationController setDelegate:nil];
//        
//        
//    }
//
//    
////    if (viewController.view.tag==900) {
////        NSLog(@"view controller tag is 900 and class is %@",[viewController class]);
////        
////        if ([viewController isKindOfClass:[ABNewPersonViewController class]]) {
////           
////            personAddNewViewController_=(ABNewPersonViewController *) viewController;
////            viewController.navigationItem.leftBarButtonItem=nil;
////            UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc]
////                                             initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAddNewAddressBookPerson:)];
////            cancelButton.style = UIBarButtonItemStyleBordered;
////            
////                        
////            viewController.navigationItem.leftBarButtonItem=cancelButton;
////            
////            
////            viewController.navigationItem.rightBarButtonItem=nil;
////            
////            UIBarButtonItem* doneButton = [[UIBarButtonItem alloc]
////                                           initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTappedInABPersonViewController:)];
////            doneButton.style = UIBarButtonItemStyleBordered;
////
////            viewController.navigationItem.rightBarButtonItem=doneButton;
////            viewController.view.tag=0;
////            
////        }
////        
////        
////    }
//    
//    if ([viewController isKindOfClass:[ABPersonViewController class]]&& viewController.view.tag!=837 ) {
//     personVCFromSelectionList_  = (ABPersonViewController *)viewController;
//        
//    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
//    // create a spacer
////    UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
////                                   initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
//        
//     
//    
//    // create a standard "add" button
//    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc]
//                                  initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTappedInABPersonViewController:)];
//    cancelButton.style = UIBarButtonItemStyleBordered;
//    [buttons addObject:cancelButton];
//        
//        UIBarButtonItem *selectButton=[[UIBarButtonItem alloc]initWithTitle:@"Select" style:UIBarButtonItemStylePlain target:self action:@selector(selectButtonTappedInABPersonController:)];
//        [buttons addObject:selectButton];
//        
//    
//        NSLog(@"child view controllers are %@",viewController.view.subviews);
//        UITableView *personViewTableView=(UITableView *)[viewController.view.subviews objectAtIndex:0];
////        [personViewTableView setBackgroundView:nil];
////        [personViewTableView setBackgroundView:[[UIView alloc] init]];
//        [personViewTableView setBackgroundColor:UIColor.clearColor]; 
//        viewController.navigationItem.rightBarButtonItems=buttons;
//        
//
//    viewController.navigationItem.rightBarButtonItems=buttons;
//        
//    }
//}
//
//// Does not allow users to perform default actions such as dialing a phone number, when they select a person property.
//- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person 
//								property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
//{
//	
//    return YES;
//}
//
//
//
//
//#pragma mark ABPersonViewControllerDelegate methods
//// Does not allow users to perform default actions such as dialing a phone number, when they select a contact property.
//- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
//					property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue
//{
//	return NO;
//}
//
//
//#pragma mark ABNewPersonViewControllerDelegate methods
//// Dismisses the new-person view controller. 
//
//- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
//{    
//    
//        
//    
//   
//    
//    if (person) {
//       ABAddressBookRef addressBookRef=personAddNewViewController_.addressBook;
//       
//        BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults] boolForKey:kPTAutoAddClinicianToGroup];
//         bool didSave=NO;
//        if (autoAddClinicianToGroup) 
//        {
//          
//            int groupIdentifier=[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
//            
//                if (groupIdentifier==-1) {
//                
//                    [self changeABGroupNameTo:nil addNew:YES];
//                
//                }
//                
//                groupIdentifier=[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
//                
//
//                if (groupIdentifier>-1) 
//                {
//                  
//                    ABRecordRef group= ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBookRef, (ABRecordID) groupIdentifier);
//                    
//                    ABGroupAddMember(group, person, nil);
//                        didSave=( bool )  ABAddressBookAddRecord(addressBookRef, group, nil);
//                         NSLog(@"group is %@",group);
//                }
//        }
//        else 
//        {
//           
//           didSave=(bool) ABAddressBookAddRecord(addressBookRef, person, nil);
//        }
//                
//               
//                
//                
//                
//            BOOL wantToSaveChanges=YES;
//               
//                
//               
//                NSLog(@"did save group add member %i ",didSave); 
//                
//
//                if (ABAddressBookHasUnsavedChanges(addressBookRef)) {
//                    
//                    if (wantToSaveChanges) {
//                        
//                        didSave = ABAddressBookSave(addressBookRef, nil);
//                        
//                        if (!didSave) 
//                        {
//                            /* Handle error here. */
//                        }
//                        
//                    } 
//                    else 
//                    {
//                        
//                        ABAddressBookRevert(addressBookRef);
//                        
//                    }
//                    
//                }
//            
//    
////        if ([addressBook_ hasUnsavedChanges]) {
////            NSLog(@"displayed person is %@ and %@",personAddNewViewController_, personAddNewViewController_.displayedPerson);
////            existingPerson_=[addressBook personWithRecordRef:personAddNewViewController_.displayedPerson];
////            
////            didSave= [addressBook addRecord:(ABRecord *)existingPerson_];
////            NSLog(@"didsave is equal to %i",didSave);
////            didSave= [addressBook save];
////            
////
////        }
//       
//    
////    NSLog(@"didsave addressbook is %i",didSave);
//    
//   
//    ABRecordRef recordRef=personAddNewViewController_.displayedPerson;             
//    NSLog(@"existing person %@", recordRef);
//    int aBRecordID=ABRecordGetRecordID((ABRecordRef) recordRef);
//    NSLog(@"abrecord id is %i  ",aBRecordID);
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
//        NSLog(@"viewlonger text label view is %@",[viewLongerTextLabelView class]);
//        if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
//        {
//            NSLog(@"first name");
//            
//            UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
//            NSLog(@"label tex is %@",firstNameLabel.text);
//            
//            if (aBRecordID &&[firstNameLabel.text isEqualToString:@"First Name:"]) 
//            {
//                
//                
//                
//                        CFStringRef recordRefFirstName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonFirstNameProperty);
//                        
//                        CFStringRef recordRefLastName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonLastNameProperty);
//                        
//                        CFStringRef recordRefPrefix=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonPrefixProperty);
//                        
//                        CFStringRef recordRefSuffix=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonSuffixProperty);
//                        
//                        CFStringRef recordRefMiddleName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonMiddleNameProperty);
//                        
//                        
//                if (recordRefPrefix && CFStringGetLength(recordRefPrefix)>0) 
//                {
//                    [cell.boundObject setValue:(__bridge NSString*)recordRefPrefix forKey:@"prefix"];
//                    
//                }
//                if (recordRefFirstName &&  CFStringGetLength(recordRefFirstName)>0) {                  
//                    [cell.boundObject setValue:(__bridge NSString*)recordRefFirstName forKey:@"firstName"];
//                }
//                if (recordRefMiddleName && CFStringGetLength(recordRefMiddleName)>0) {    
//                    [cell.boundObject setValue:(__bridge NSString*)recordRefMiddleName forKey:@"middleName"];
//                }
//                
//                if (recordRefLastName && CFStringGetLength(recordRefLastName)>0) {
//                    [cell.boundObject setValue:(__bridge NSString*)recordRefLastName forKey:@"lastName"];
//                }
//                if (recordRefSuffix && CFStringGetLength(recordRefSuffix)>0) {  
//                    [cell.boundObject setValue:(__bridge NSString*)recordRefSuffix forKey:@"suffix"];
//                }
//                NSString *notesStr=[cell.boundObject valueForKey:@"notes"];
//                
//                //so it doesn't copy over some notes they have already written
//                if (!notesStr.length) {
//                    CFStringRef recordRefNotes=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonNoteProperty);
//                    if (recordRefNotes && CFStringGetLength(recordRefNotes)>0) {  
//                        [cell.boundObject setValue:(__bridge NSString*)recordRefNotes forKey:@"notes"];
//                    }
//                    
//                    if (recordRefNotes) {
//                        CFRelease(recordRefNotes);
//                    }
//                }
//
//
//                
//                        
//                        if (recordRefPrefix) {
//                            CFRelease(recordRefPrefix);
//                            
//                        }
//                        
//                        if (recordRefFirstName) {
//                            CFRelease(recordRefFirstName);
//                        }
//                        if (recordRefMiddleName) {
//                            CFRelease(recordRefMiddleName);
//                        }
//                        
//                        if (recordRefLastName) {
//                            CFRelease(recordRefLastName);
//                        }
//                        if (recordRefSuffix) {
//                            CFRelease(recordRefSuffix);
//                            
//                        }
//               
//                
//                
//                
//                
//                [cellManagedObject setValue:[NSNumber numberWithInt:aBRecordID ] forKey:@"aBRecordIdentifier"];
//                [cell commitChanges];
//                [currentDetailTableViewModel reloadBoundValues];
//                [currentDetailTableViewModel.modeledTableView reloadData];
//                clinician=(ClinicianEntity *) cellManagedObject;
//                
//            } 
//        }
//        
//        
//        
//    }
//        CFRelease(recordRef);
//        
//    }
//    else
//    {
//        NSLog(@"cancel button pressed");
//    }
//  
//   
//    existingPersonRecordID =-1;
//    [personAddNewViewController_.navigationController dismissViewControllerAnimated:YES completion:nil];
//    
////    CFRelease(person);
//    
//    
//    
//    
//    
//    
//    
//    
//    
////    [newPersonViewController dismissViewControllerAnimated:YES completion:nil];
////        NSLog(@"person record %@",newPersonViewController.navigationItem.leftBarButtonItem;
//    
//   
//        
// 
////        [addressBook addRecord:existingPerson];
////        [addressBook save];
////        [group addMember:(ABPerson *)existingPerson_];
////        
////        if ([addressBook hasUnsavedChanges]) {
////            [addressBook save];
////        }
////        
////        ABRecordID recordID=(ABRecordID )existingPerson_.recordID;
////
////        
////        NSLog(@"person identifier is %i", recordID);
////            existingPerson_=(ABPerson *)[addressBook personWithRecordID:recordID];
////            [clinician setValue:[NSNumber numberWithInt:recordID] forKey:@"aBRecordIdentifier"];        
////            NSLog(@"person to display is %@",existingPerson_.recordRef);
////            SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel sectionAtIndex:0];
////            SCTableViewCell *cell =(SCTableViewCell *)[section cellAtIndex:1];
////            NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
////            
////            NSEntityDescription *entityDesctipion=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
////            if ([cellManagedObject.entity isKindOfEntity:entityDesctipion]) {
////                
////                
////                
////                
////                
////                UIView *viewLongerTextLabelView =(UIView *)[cell viewWithTag:51];
////                NSLog(@"viewlonger text label view is %@",[viewLongerTextLabelView class]);
////                if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
////                {
////                    NSLog(@"first name");
////                    
////                    UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
////                    NSLog(@"label tex is %@",firstNameLabel.text);
////                    
////                    if (recordID &&[firstNameLabel.text isEqualToString:@"First Name:"]) {
////                        
////                        
////                        [cell.boundObject setValue:[NSNumber numberWithInt:recordID ] forKey:@"aBRecordIdentifier"];
////                        [cell commitChanges];
////                        [currentDetailTableViewModel reloadBoundValues];
////                        [currentDetailTableViewModel.modeledTableView reloadData];
////                        
////                    } 
////                }
////                
////                
////                
////                
////            }
////	[self dismissModalViewControllerAnimated:YES];
//}
//
//
////#pragma mark ABUnknownPersonViewControllerDelegate methods
////// Dismisses the picker when users are done creating a contact or adding the displayed person properties to an existing contact. 
////- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person
////{
////	
////    
////  [unknownPersonView dismissViewControllerAnimated:YES completion:^{
////      
////      [self showPersonViewControllerForABRecordRef:person];
////  }];
////   
////    
////   
////}
//
//
//// Does not allow users to perform default actions such as emailing a contact, when they select a contact property.
//- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
//						   property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
//{
//	return NO;
//}
//
//#pragma mark -
//#pragma mark - UIAlertViewDelegate
//
//- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//	// use "buttonIndex" to decide your action
//    
//   
//    
//    if (actionSheet.tag==kAlertTagFoundExistingPersonWithName) {
//        switch (buttonIndex) {
//            case 0:
//                NSLog(@"zero index");
//                // on main thread in delegate method -alertView:clickedButtonAtIndex:
//                // (do something with choosen buttonIndex)
//             
//                
//                
//                break;
//            case 1:
//            {
//                NSLog(@"one index");
//                
//                SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel sectionAtIndex:0];
//                SCTableViewCell *cell =(SCTableViewCell *)[section cellAtIndex:1];
//                NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
//                
//                NSEntityDescription *entityDesctipion=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
//                if ([cellManagedObject.entity isKindOfEntity:entityDesctipion]) {
//                   
//                    
//                                      
//                   
//                    
//                    UIView *viewLongerTextLabelView =(UIView *)[cell viewWithTag:51];
//                    NSLog(@"viewlonger text label view is %@",[viewLongerTextLabelView class]);
//                    if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
//                    {
//                        NSLog(@"first name");
//                        
//                        UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
//                        NSLog(@"label tex is %@",firstNameLabel.text);
//                        
//                        
//                                   
//                        NSLog(@"existing person %i", existingPersonRecordID);
//                        if (existingPersonRecordID!=-1) {
//                           
//                            
//                            
////                            int aBRecordID=ABRecordGetRecordID((ABRecordRef) existingPersonRef);
//                            
//                            if ([firstNameLabel.text isEqualToString:@"First Name:"]) {
//                                
//                                
//                                [cell.boundObject setValue:[NSNumber numberWithInt:existingPersonRecordID ] forKey:@"aBRecordIdentifier"];
//                                [cell commitChanges];
//                                [currentDetailTableViewModel reloadBoundValues];
//                                [currentDetailTableViewModel.modeledTableView reloadData];
//                                
//                            } 
//
//                        }
//                                           }
//
//                
//                
//                [self showPersonViewControllerForRecordID:(int)existingPersonRecordID];
//                }
//            }
//                break;
//            case 2:
//                NSLog(@"two index");
//                [self resetABVariablesToNil];
//                addExistingAfterPromptBool=TRUE;
//                [self evaluateWhichABViewControllerToShow];
//                
//                break;
//            default:
//                break;
//               
//        }
//         return;
//    }
//    if (actionSheet.tag==kAlertTagFoundExistingPeopleWithName) {
//        switch (buttonIndex) {
//            case 0:
//                NSLog(@"zero index");
//                // on main thread in delegate method -alertView:clickedButtonAtIndex:
//                // (do something with choosen buttonIndex)
//                
//                
//                
//                break;
//            case 1:
//            {
////                NSLog(@"one index");
////                ABAddressBook *aBtoFilter=[[ABAddressBook alloc]init];
////                
////                NSArray *arrayWithAllPeople=[aBtoFilter allPeople];
////                
////                NSLog(@"array with all people is %@",arrayWithAllPeople);
////                NSArray *arrayWithCompositeName=[aBtoFilter allPeopleWithName:existingPerson.compositeName];
////               
////                
////               NSLog(@"array with all people with composite name is %@",arrayWithCompositeName);
////                
////                
////                for (ABPerson *personInArray in arrayWithAllPeople) {
////                    
////                     NSLog(@"person composite name is %@",personInArray.compositeName);
////                    if (![personInArray.firstName isEqualToString:existingPerson.firstName]||![personInArray.lastName isEqualToString:existingPerson.lastName]) {
////                     NSLog(@"person composite name to remove is %@",personInArray.compositeName);
////                         [aBtoFilter removeRecord:(ABRecord *)personInArray];
////                        
////                    }    
////                   
////                    
////                }
////                NSLog(@"abtofilter all people %@",[aBtoFilter allPeople]);
//                                    
//                    [self showPeoplePickerController];
//               
//            }
//                break;
//            case 2:
//                NSLog(@"two index");
//                
//                [self resetABVariablesToNil];
//                addExistingAfterPromptBool=TRUE;
//                [self evaluateWhichABViewControllerToShow];
//                
//                
//                break;
//            default:
//                break;
//        }
//    }
//
//	//
//}
//
//-(IBAction)cancelButtonTappedInABPersonViewController:(id)sender{
//    
//NSLog(@"cancel button clicked");
//    NSLog(@"sender class is %@",[sender class]);
//    if (personVCFromSelectionList_) {
//        [personVCFromSelectionList_ dismissViewControllerAnimated:YES completion:nil];
//    }
//
//
//}
//
//-(IBAction)selectButtonTappedInABPersonController:(id)sender{
//    
//    
//    
//    
//    
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
//        
//        
//        //        UIView *viewOneWithText=(UIView *)[cell viewWithTag:50];
//        //        
//        //        SCTableViewCell *lastNameCell=(SCTableViewCell *)[section cellAtIndex:3];
//        //        UIView *lastNameViewWithText=(UIView *)[cell viewWithTag:50];
//        //        
//        //        if ([lastNameViewWithText isKindOfClass:[UITextField class]]) {
//        //            UITextField *lastNameField =(UITextField *)lastNameViewWithText;
//        //        }
//        //        if ([viewOneWithText isKindOfClass:[UITextField class]]) {
//        //            UITextField *firstNameField =(UITextField *)[firstNameCell viewWithTag:50];
//        //        }
//        //        
//        //        
//        
//        
//        
//        NSLog(@"viewlonger text label view is %@",[viewLongerTextLabelView class]);
//        if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
//        {
//            NSLog(@"first name");
//            
//            UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
//            NSLog(@"label tex is %@",firstNameLabel.text);
//            
//            ABRecordRef recordRef=personVCFromSelectionList_.displayedPerson;
//            int aBRecordID=ABRecordGetRecordID((ABRecordRef)recordRef);
//            if (aBRecordID &&[firstNameLabel.text isEqualToString:@"First Name:"]) 
//            {
//                CFStringRef recordRefFirstName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonFirstNameProperty);
//                
//                CFStringRef recordRefLastName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonLastNameProperty);
//                
//                CFStringRef recordRefPrefix=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonPrefixProperty);
//                
//                CFStringRef recordRefSuffix=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonSuffixProperty);
//                
//                CFStringRef recordRefMiddleName=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonMiddleNameProperty);
//                
//                
//                
//                if (recordRefPrefix && CFStringGetLength(recordRefPrefix)>0) 
//                {
//                    [cell.boundObject setValue:(__bridge NSString*)recordRefPrefix forKey:@"prefix"];
//                    
//                }
//                if (recordRefFirstName &&  CFStringGetLength(recordRefFirstName)>0) {                  
//                    [cell.boundObject setValue:(__bridge NSString*)recordRefFirstName forKey:@"firstName"];
//                }
//                if (recordRefMiddleName && CFStringGetLength(recordRefMiddleName)>0) {    
//                    [cell.boundObject setValue:(__bridge NSString*)recordRefMiddleName forKey:@"middleName"];
//                }
//                
//                if (recordRefLastName && CFStringGetLength(recordRefLastName)>0) {
//                    [cell.boundObject setValue:(__bridge NSString*)recordRefLastName forKey:@"lastName"];
//                }
//                if (recordRefSuffix && CFStringGetLength(recordRefSuffix)>0) {  
//                    [cell.boundObject setValue:(__bridge NSString*)recordRefSuffix forKey:@"suffix"];
//                }
//                NSString *notesStr=[cell.boundObject valueForKey:@"notes"];
//                
//                //so it doesn't copy over some notes they have already written
//                if (!notesStr.length) {
//                    CFStringRef recordRefNotes=ABRecordCopyValue((ABRecordRef) recordRef,( ABPropertyID) kABPersonNoteProperty);
//                    if (recordRefNotes && CFStringGetLength(recordRefNotes)>0) {  
//                        [cell.boundObject setValue:(__bridge NSString*)recordRefNotes forKey:@"notes"];
//                    }
//                    
//                    if (recordRefNotes) {
//                        CFRelease(recordRefNotes);
//                    }
//                }
//                if (recordRefPrefix) {
//                    CFRelease(recordRefPrefix);
//                    
//                }
//                
//                if (recordRefFirstName) {
//                    CFRelease(recordRefFirstName);
//                }
//                if (recordRefMiddleName) {
//                    CFRelease(recordRefMiddleName);
//                }
//                
//                if (recordRefLastName) {
//                    CFRelease(recordRefLastName);
//                }
//                if (recordRefSuffix) {
//                    CFRelease(recordRefSuffix);
//                    
//                }
//                
//              
//                
//
//                
//                
//                
//                
//                
//                
//                
//                [cell.boundObject setValue:[NSNumber numberWithInt:aBRecordID ] forKey:@"aBRecordIdentifier"];
//                
//                
//                
//                
//                [cell commitChanges];
//                [currentDetailTableViewModel reloadBoundValues];
//                [currentDetailTableViewModel.modeledTableView reloadData];
//                
//            } 
//        }
//        
//        
//        if (personVCFromSelectionList_) {
//            [personVCFromSelectionList_ dismissViewControllerAnimated:YES completion:nil];
//        }
//        
//    }
//    
//    
//    NSLog(@"selectButton Tapped");
//}
//
//
//-(IBAction)cancelAddNewAddressBookPerson:(id)sender{
//
//    NSLog(@"cancel button pressed");
//   [personAddNewViewController_.navigationController dismissViewControllerAnimated:YES completion:^{
//        
//    currentDetailTableViewModel.viewController.navigationController.delegate =nil;
//    }];
//
//
//
//}
//
//-(void)resetABVariablesToNil{
//
//    if (personAddNewViewController) {
//         personAddNewViewController_=nil;
//    }
//    if ( personVCFromSelectionList_) {
//         personVCFromSelectionList_=nil;
//    }
//   
//
//    existingPersonRecordID=-1;
//    addExistingAfterPromptBool=FALSE;
//}
//
////-(IBAction)doneButtonTappedInABPersonViewController:(id)sender{
////    
////    NSLog(@"done button pressed");
////   
////
////    
////    bool didSave=NO;
////  
////    
////    NSLog(@"displayed person is %@ and %@",personAddNewViewController_, personAddNewViewController_.displayedPerson);
////    existingPerson_=[addressBook_ personWithRecordRef:personAddNewViewController_.displayedPerson];
////    
////    didSave= [addressBook_ addRecord:(ABRecord *)existingPerson_];
////     NSLog(@"didsave is equal to %i",didSave);
////   didSave= [addressBook_ save];
////    
////   
////  
////   NSLog(@"didsave addressbook is %i",didSave);
////    
////    NSLog(@"existing person properties description %@",[existingPerson_ description]);
////    NSLog(@"existing person observation info%@",existingPerson_.observationInfo);
////    NSLog(@"existing person class%@ ",  [existingPerson_ class]);
////    
////    NSLog(@"existing person %@",[existingPerson_ accessibilityValue]);
////    NSLog(@"existing person %@",[existingPerson_ dictionaryWithValuesForKeys:[NSArray array]]);
////    
////    
////    NSLog(@"existing person observation info %@",[personAddNewViewController_ observationInfo]);
////    ABRecordRef recordRef=personAddNewViewController_.displayedPerson;             
////    NSLog(@"existing person %@", recordRef);
////    int aBRecordID=existingPerson_.recordID;
////    NSLog(@"abrecord id is %i  ",aBRecordID);
////    SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel sectionAtIndex:0];
////    SCTableViewCell *cell =(SCTableViewCell *)[section cellAtIndex:1];
////    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
////    
////    NSEntityDescription *entityDesctipion=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext];
////    if ([cellManagedObject.entity isKindOfEntity:entityDesctipion]) {
////        
////        
////        
////        
////        
////        UIView *viewLongerTextLabelView =(UIView *)[cell viewWithTag:51];
////        NSLog(@"viewlonger text label view is %@",[viewLongerTextLabelView class]);
////        if ([viewLongerTextLabelView isKindOfClass:[UILabel class]]) 
////        {
////            NSLog(@"first name");
////            
////            UILabel *firstNameLabel =(UILabel *)viewLongerTextLabelView;
////            NSLog(@"label tex is %@",firstNameLabel.text);
////            
////            if (aBRecordID &&[firstNameLabel.text isEqualToString:@"First Name:"]) 
////            {
////                
////                
////                [cell.boundObject setValue:[NSNumber numberWithInt:aBRecordID ] forKey:@"aBRecordIdentifier"];
////                [cell commitChanges];
////                [currentDetailTableViewModel reloadBoundValues];
////                [currentDetailTableViewModel.modeledTableView reloadData];
////                
////            } 
////        }
////        
////        
////       
////    }
////    
////
////
////    
////    [personAddNewViewController_.navigationController dismissViewControllerAnimated:YES completion:^{
////        
////        currentDetailTableViewModel.viewController.navigationController.delegate =nil;
////        [self resetABVariablesToNil];
////    }];
////    
////    
////    
////}
//-(void)changeABGroupNameTo:(NSString *)groupName  addNew:(BOOL)addNew{
//    
//    ABAddressBookRef addressBook;
//    @try 
//    {
//        
//       
//        addressBook=nil;
//        addressBook=ABAddressBookCreate();
//        
//        
//    }
//    
//    @catch (NSException *exception) 
//    {
//        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//        
//        
//        [appDelegate displayNotification:@"Not able to access address book" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
//        return;
//    }
//    @finally 
//    {
//        
//        ABRecordRef group;
//        int groupIdentifier;
//        int groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
//        if (!groupName ||!groupName.length) {
//            
//            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName]) {
//                
//                groupName=(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];  
//                
//                //        }
//                if (!groupName ||!groupName.length) {
//                    groupName=@"Clinicians";
//                    if ([[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupName]) {
//                        
//                        [[NSUserDefaults standardUserDefaults] setValue:groupName forKeyPath:kPTTAddressBookGroupName];
//                        [[NSUserDefaults standardUserDefaults] synchronize];
//                        
//                    }
//                }
//                
//            }  
//            
//            
//            
//            if (!addNew) 
//            {
//                
//                if ([[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupIdentifier]) 
//                {
//                    groupIdentifier=(NSInteger )[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
//                    
//                }
//                
//                if (!addNew&&groupIdentifier>-1)
//                {
//                    group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
//                    
//                }
//                
//                
//                
//                
//                
//                
//                
//                
//                //should not ad new
//                CFArrayRef CFGroupsCheckNameArray;
//                CFStringRef CFGroupNameCheck ;
//                ABRecordRef groupInCheckNameArray;
//                if (groupCount) 
//                {
//                    
//                    CFGroupsCheckNameArray= (CFArrayRef )ABAddressBookCopyArrayOfAllGroups((ABAddressBookRef) addressBook);
//                    NSLog(@"cggroups array %@",CFGroupsCheckNameArray);
//                    
//                    
//                    for (CFIndex i = 0; i < groupCount; i++) {
//                        groupInCheckNameArray = CFArrayGetValueAtIndex(CFGroupsCheckNameArray, i);
//                        CFGroupNameCheck  = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);
//                        
//                        
//                        //            CFComparisonResult result=  (CFComparisonResult) CFStringCompare (
//                        //                                                                              (__bridge CFStringRef)groupName,
//                        //                                                                              (CFStringRef) CFGroupNameCheck,
//                        //                                                                              1
//                        //                                                                              );
//                        
//                        
//                        
//                        NSString *checkNameStr=[NSString stringWithFormat:@"%@",(__bridge NSString*) CFGroupNameCheck];
//                        
//                        NSLog(@"cfgroupname is %@",checkNameStr);
//                        NSLog(@"groupname Str is %@",groupName);
//                        if ([checkNameStr isEqualToString:groupName]) {
//                            group=groupInCheckNameArray;
//                            groupIdentifier=ABRecordGetRecordID(group);
//                            
//                            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupIdentifier]) {
//                                [[NSUserDefaults standardUserDefaults] setInteger:groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
//                                [[NSUserDefaults standardUserDefaults]synchronize];
//                                
//                            }
//                            
//                            if (group) {
//                                NSLog(@"group is %@",group);
//                            }
//                            
//                            else {
//                                NSLog(@"no group");
//                            } 
//                            break;
//                        }
//                        //            CFRelease(CFGroupsCheckNameArray); 
//                        //            CFRelease(CFGroupNameCheck);
//                        
//                    }
//                    if (CFGroupsCheckNameArray) {
//                        CFRelease(CFGroupsCheckNameArray); 
//                    }
//                    
//                    if (CFGroupNameCheck) {
//                        CFRelease(CFGroupNameCheck);
//                    }
//                }
//                
//                
//            }
//            
//        }
//        
//        
//        
//        
//        NSNumber *groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
//        
//        if (!addNew && !group && groupIdentifier>0 && groupCount>0 && ![groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]]  && ![groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]]) {
//            
//            group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
//            
//        }
//        
//        if (!group ||addNew) {
//            
//            
//            if (!addressBook) {
//                
//                return;
//            }
//            //        ABRecordRef CFAddressBookGroupRecord =  ABGroupCreate ();
//            
//            group=ABGroupCreate();
//            
//            //        ABRecord *groupRecord=(ABRecord *)[group getRecordRef];
//            
//            //        NSLog(@"group composite name is %@",groupRecord.compositeName);
//            
//            
//            //        NSLog(@"group record identifier is %i",groupRecord.recordID);
//            
//            bool didSetGroupName=FALSE;
//            didSetGroupName= (bool) ABRecordSetValue (
//                                                      group,
//                                                      (ABPropertyID) kABGroupNameProperty,
//                                                      (__bridge CFStringRef)groupName  ,
//                                                      nil
//                                                      );  
//            
//            ABAddressBookAddRecord((ABAddressBookRef) addressBook, (ABRecordRef) group, nil);
//            
//            BOOL wantToSaveChanges=TRUE;
//            if (ABAddressBookHasUnsavedChanges(addressBook)) {
//                
//                if (wantToSaveChanges) {
//                    bool didSave=FALSE;
//                    didSave = ABAddressBookSave(addressBook, nil);
//                    
//                    if (!didSave) {/* Handle error here. */  NSLog(@"addressbook did not save");}
//                    else NSLog(@"addresss book saved new group.");
//                    
//                } 
//                else {
//                    
//                    ABAddressBookRevert(addressBook);
//                    
//                }
//                
//            }
//            
//            //        ABRecord *groupRecord=[[ABRecord alloc]initWithABRef:(CFTypeRef)kABGroupType ];
//            
//            NSLog(@"group idenitifer is%i",ABRecordGetRecordID(group));
//            
//            NSLog(@"group name is %@", (__bridge NSString *)ABRecordCopyValue(group, kABGroupNameProperty));
//            
//            
//            
//            
//            
//            groupIdentifier=ABRecordGetRecordID(group);
//            
//            [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
//            
//            [[NSUserDefaults standardUserDefaults] setValue:groupName forKey:kPTTAddressBookGroupName];  
//            
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//            //        CFRelease(group);
//        } 
//        else
//            
//        {
//            
//            BOOL wantToSaveChanges=TRUE;
//            groupIdentifier=ABRecordGetRecordID(group);
//            
//            if (groupIdentifier>0) {
//                
//                [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
//                
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                
//            }
//            if (ABAddressBookHasUnsavedChanges(addressBook)) {
//                
//                if (wantToSaveChanges) {
//                    bool didSave=FALSE;
//                    didSave = ABAddressBookSave(addressBook, nil);
//                    
//                    if (!didSave) {/* Handle error here. */}
//                    
//                } 
//                else {
//                    
//                    ABAddressBookRevert(addressBook);
//                    
//                }
//                
//                
//                
//            }
//            
//        }
//        
//        
//       
//        
//        
//    }
//    //    [[NSUserDefaults standardUserDefaults]  setValue:(NSString *)groupName forKey:kPTTAddressBookGroupName];
//    
//
//    
//    
//}


@end

