/*
 *  ClientRootViewController_iPad.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/24/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ClientsRootViewController_iPad.h"
#import "ClientsDetailViewController_iPad.h"
#import "ClientsViewController_Shared.h"

#import "PTTAppDelegate.h"
#import "ButtonCell.h"
#import "EncryptedSCTextViewCell.h"
#import "EncryptedSCTextFieldCell.h"
#import "DrugNameObjectSelectionCell.h"

@implementation ClientsRootViewController_iPad
//@synthesize clientsDetailViewController_iPad=_clientsDetailViewController_iPad;

@synthesize managedObjectContext=_managedObjectContext;
//@synthesize tableView=_tableView;
@synthesize searchBar;
//@synthesize tableModel;



#pragma mark -
#pragma mark View lifecycle


-(void)viewDidUnload{

    [super viewDidUnload];
    
//    self.tableModel=nil;

}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
////    // Set up the edit and add buttons.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    
//  
    
    // Get managedObjectContext from application delegate
    demographicDetailViewController_Shared =[[DemographicDetailViewController_Shared alloc]init];
    
    [demographicDetailViewController_Shared setupTheDemographicView];
       
    
    
    
    //begin paste
    
    clientsViewController_Shared =[[ClientsViewController_Shared alloc]init];

	
  
    
    [clientsViewController_Shared setupTheClientsViewModelUsingSTV];       

    objectsModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView entityDefinition:clientsViewController_Shared.clientDef];
    if ([SCUtilities is_iPad]) {
        self.navigationBarType = SCNavigationBarTypeEditLeft;
    }
    else {
        self.navigationBarType = SCNavigationBarTypeAddRightEditLeft;
    }
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    objectsModel.editButtonItem = self.navigationItem.leftBarButtonItem;
    //        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    //        self.navigationItem.rightBarButtonItem = addButton;
    objectsModel.addButtonItem = self.navigationItem.rightBarButtonItem;
    objectsModel.autoAssignDelegateForDetailModels=TRUE;
    objectsModel.autoAssignDataSourceForDetailModels=TRUE;
    if (![SCUtilities is_iPad]) {
        
        self.tableView.backgroundColor=[UIColor clearColor];
        //            UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
        //            self.navigationItem.rightBarButtonItem = addButton; 
        
        
        objectsModel.addButtonItem=self.navigationItem.rightBarButtonItem;
        
        
        
    }
    
    
   
    //     objectsModel.autoSortSections = TRUE;
    //        self.clinicianDef.keyPropertyName=@"firstName";
       



// Instantiate the tabel model
//	self.tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self withEntityClassDefinition:self.clinicianDef];	
//    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc] init]];

[self.view setBackgroundColor:[UIColor colorWithRed:0.317586 green:0.623853 blue:0.77796 alpha:1.0]];


    objectsModel.searchBar = self.searchBar;
    objectsModel.addButtonItem = self.addButton;



// Replace the default model with the new objectsModel
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"drugName Matches %@",@"a"];
objectsModel.enablePullToRefresh = TRUE;
objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];


//    SCCoreDataFetchOptions *dataFetchOptions=[[SCCoreDataFetchOptions alloc]initWithSortKey:@"firstName" sortAscending:YES filterPredicate:nil];


//    dataFetchOptions.batchStartingOffset=10;
//    dataFetchOptions.batchSize=10;
//    
//    
//    objectsModel.dataFetchOptions=dataFetchOptions;
    objectsModel.addButtonItem=objectsModel.detailViewController.navigationItem.rightBarButtonItem;
    
//    objectsModel.addButtonItem = self.addButton;
	objectsModel.itemsAccessoryType = UITableViewCellAccessoryNone;
    objectsModel.detailViewControllerOptions.modalPresentationStyle = UIModalPresentationPageSheet;
    objectsModel.detailViewController=self.tableViewModel.detailViewController;
    ClientsDetailViewController_iPad *clientDetailViewController=(ClientsDetailViewController_iPad *)objectsModel.detailViewController;
    
    clientDetailViewController.navigationBarType=SCNavigationBarTypeAddRight;
    
    objectsModel.addButtonItem=clientDetailViewController.navigationItem.rightBarButtonItem;
    //    self.tableView.backgroundColor=[UIColor clearColor]; // Make the table view application backgound color (turquose)
    
    //    self.tableView.backgroundColor=[UIColor colorWithRed:0.317586 green:0.623853 blue:0.77796 alpha:1.0]; // Make the table view application backgound color (turquose)
    
    self.tableViewModel = objectsModel;
//        
}


  


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.    
    return YES;
}


//
//#pragma mark -
//#pragma mark SCTableViewModelDataSource methods
//
//// Return a custom detail model that will be used instead of Sensible TableView's auto generated one
//- (SCTableViewModel *)tableViewModel:(SCTableViewModel *)tableViewModel
//customDetailTableViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	
//    
//    SCArrayOfObjectsModel *detailModel = [SCArrayOfObjectsModel tableViewModelWithTableView:self.clientsDetailViewController_iPad.tableView
//                                                                         withViewController:self.clientsDetailViewController_iPad];
//    detailModel.delegate=self;
//    
//    
//   
//    
//	return detailModel;
//}




//-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
////    
////    
//    if (tableViewModel.tag==0) {
//        
//        
//        detailTableViewModel.tag=2;
//        
//    }
//    else{
//        detailTableViewModel.tag=tableViewModel.tag+1;
//    }
//    
//    if(detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
//        
//
//    [detailTableViewModel.modeledTableView setBackgroundView:nil];
//    [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
//    [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; 
//    }
//    detailTableViewModel.delegate=self;
//    //NSLog(@"detail model created for row at index path detailtable model tag is %i", detailTableViewModel.tag);
//}
//


- (NSString *)tableViewModel:(SCArrayOfItemsModel *)tableViewModel sectionHeaderTitleForItem:(NSObject *)item AtIndex:(NSUInteger)index
{
    if (tableViewModel.tag==0) {
   
	// Cast not technically neccessary, done just for clarity
	NSManagedObject *managedObject = (NSManagedObject *)item;
	
	NSString *objectName = (NSString *)[managedObject valueForKey:@"clientIDCode"];
	
	// Return first charcter of objectName
	return [[objectName substringToIndex:1] uppercaseString];
    }
    else {
        return nil;
    }
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillPresentForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
//    if(detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
//        
//        
//        [detailTableViewModel.modeledTableView setBackgroundView:nil];
//        [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
//        [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; 
//    }
    //NSLog(@"tabel veiw modoel %i",tableViewModel.tag);
    
    if (tableViewModel.tag==4 ) {
        
        //this is so the second section will not appear if it is the second log, because that info does not pertain
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:index];
        //NSLog(@"section cell count is %i",section.cellCount);
        //NSLog(@"detailtableview model sectioncount %i",detailTableViewModel.sectionCount);
//        BOOL sectionContainsMedLog=FALSE;
        
        if (tableViewModel.sectionCount) {
//            SCTableViewSection *detailSectionZero=(SCTableViewSection *)[tableViewModel sectionAtIndex:0]
            ;
//            if (detailSectionZero.cellCount) {
//                
//                SCTableViewCell *cellZeroSectionZero=(SCTableViewCell *)[detailSectionZero cellAtIndex:0];
//                NSManagedObject *cellManagedObject=(NSManagedObject *)cellZeroSectionZero.boundObject;
////                
//                if (cellManagedObject&& [cellManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"])
//                {
//                    sectionContainsMedLog=TRUE;
//                }
//                
//            }
            SCTableViewCell *cell=tableViewModel.activeCell;
            
            
                
            
            
        
            if (!cell ||([section indexForCell:cell]==0)) {
                
                SCTableViewSection *detailSectionZero=(SCTableViewSection *)[detailTableViewModel sectionAtIndex:0];
                SCTableViewCell *cellZeroSectionZero=(SCTableViewCell *)[detailSectionZero cellAtIndex:0];
                
                
                
                NSManagedObject *cellManagedObject=(NSManagedObject *)cellZeroSectionZero.boundObject;
                //NSLog(@"cell managed object entity is %@",cellManagedObject.entity.name);
                //NSLog(@"cell  class is %@",[cellZeroSectionZero class]);
                if (cellManagedObject &&[cellManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"] && detailTableViewModel.sectionCount>2) {
                    
                    [detailTableViewModel removeSectionAtIndex:1];
                    
                    
                }
                else {
//                    [detailTableViewModel.modeledTableView reloadData];
                }
            }
        }  
    }       
    

}

-(void) tableViewModel:(SCTableViewModel *)tableViewModel customButtonTapped:(UIButton *)button forRowWithIndexPath:(NSIndexPath *)indexPath{
    
    
    //NSLog(@"custom button tapped");
    
    
    
    
    
    if (tableViewModel.tag==3) {
        SCTableViewSection *section =[tableViewModel sectionAtIndex:indexPath.section];
        SCTableViewCell *cell=(SCTableViewCell *)[section cellAtIndex:0];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        if (cellManagedObject &&[cellManagedObject.entity.name isEqualToString:@"PhoneEntity"]&&section.cellCount>1){
            
            SCTextFieldCell *phoneNumberCell =(SCTextFieldCell *) [section cellAtIndex:1];
            //NSLog(@"custom button tapped");
            if (phoneNumberCell.textField.text.length) {
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call Phone Number:" message:phoneNumberCell.textField.text
                                                               delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                
                alert.tag=1;
                
                
                
                [alert show];
                
                
            }
        }
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// use "buttonIndex" to decide your action
	//
    
    if (alertView.tag==1) {
        
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel:" stringByAppendingString:alertView.message]]];
        }
    }
    
}



-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    UIColor *backgroundColor=nil;
    if(indexPath.row==NSNotFound|| tableModel.tag>0)
    {
        backgroundColor=(UIColor *)(UIView *)[(UIWindow *)appDelegate.window viewWithTag:5].backgroundColor;
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
    

//    if (tableModel.tag==4&&tableModel.sectionCount ) {
//        //            SCTableViewSection *detailSectionZero=(SCTableViewSection *)[tableViewModel sectionAtIndex:0]
////        ;
//        //            if (detailSectionZero.cellCount) {
//        //                
//        //                SCTableViewCell *cellZeroSectionZero=(SCTableViewCell *)[detailSectionZero cellAtIndex:0];
//        //                NSManagedObject *cellManagedObject=(NSManagedObject *)cellZeroSectionZero.boundObject;
//        ////                
//        //                if (cellManagedObject&& [cellManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"])
//        //                {
//        //                    sectionContainsMedLog=TRUE;
//        //                }
//        //                
//        //            }
//        SCTableViewCell *cell=nil;
//        if (indexPath.row!=NSNotFound) {
//            cell=[tableModel cellAtIndexPath:indexPath];
//        }
//      
//        
//        
//        
//        
//        
//        SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:0];
//        
//        //NSLog(@"index of cell is %i",[section indexForCell:cell]);
//        if ((!cell &&section.cellCount==1) ||(indexPath.row==0)) {
//            
//            SCTableViewSection *detailSectionZero=(SCTableViewSection *)[detailTableViewModel sectionAtIndex:0];
//            
//            if (detailSectionZero.cellCount) {
//              
//            SCTableViewCell *cellZeroSectionZero=(SCTableViewCell *)[detailSectionZero cellAtIndex:0];
//            
//            
//            
//            NSManagedObject *cellManagedObject=(NSManagedObject *)cellZeroSectionZero.boundObject;
//
//                NSLog(@"cell  class is %@",[cellZeroSectionZero class]);
//                
//                if ([cellManagedObject respondsToSelector:@selector(entity)]) {
//               
//                
//                    if (cellManagedObject &&[cellManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"]&&detailTableViewModel.sectionCount>2 ) {
//                        
//                        SCTableViewSection *sectionOne=(SCTableViewSection *)[detailTableViewModel sectionAtIndex:1];
//                        
//                        [sectionOne removeAllCells];
//                        [detailTableViewModel removeSectionAtIndex:1];
//                        
//                        
//                    }
//                    else {
//        //                [detailTableViewModel.modeledTableView reloadData];
//                    }
//                }
//            }
//        }
//    }  
//      

    
   
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)index detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    //NSLog(@"detail model created for row at index");
    
//    
    detailTableViewModel.tag=tableViewModel.tag+1;
    
    
    detailTableViewModel.delegate=self;
    
    if(detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
        

    [detailTableViewModel.modeledTableView setBackgroundView:nil];
    [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
    [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; 
    }
    //NSLog(@"detail model created for row at index detailtable model tag is %i", detailTableViewModel.tag);
    
    
    
}



//-(void)tableViewModelSearchBarCancelButtonClicked:(SCArrayOfItemsModel *)tableViewModel{
//    
//    
//    if (isInDetailSubview) {
//        
//        
//       
//        
//        
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//        
//        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClientEntity" inManagedObjectContext:managedObjectContext];
//        [fetchRequest setEntity:entity];
//        
//        NSError *error = nil;
//        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
//        if (fetchedObjects == nil) {
//            //NSLog(@"no items");
//        }
//        
//        
//        NSMutableSet *mutableSet=[NSMutableSet setWithArray:fetchedObjects];
//        
//        
//        
//        for(id obj in alreadySelectedClients) { 
//            if(obj!=clientCurrentlySelectedInReferringDetailview)
//                [mutableSet removeObject:obj];
//            
//        }
//        
//        //NSLog(@"clientobject selection itemset %@",mutableSet);
//            [tableViewModel removeSectionAtIndex:0];
//        
//        SCObjectSelectionSection *objectSelectionSection=[SCObjectSelectionSection sectionWithHeaderTitle:nil withItemsSet:mutableSet withClassDefinition:clientsViewController_Shared.clientDef];
//        
//      objectSelectionSection.itemsPredicate = [NSPredicate predicateWithFormat:@"currentClient == %@",[NSNumber numberWithInteger: 0]];
//    
//        objectSelectionSection.autoSelectNewItemCell=YES;
//        objectSelectionSection.allowMultipleSelection = NO;
//        objectSelectionSection.allowNoSelection = NO;
//        objectSelectionSection.maximumSelections = 1;
//        objectSelectionSection.allowAddingItems = YES;
//        objectSelectionSection.allowDeletingItems = NO;
//        objectSelectionSection.allowMovingItems = YES;
//        objectSelectionSection.allowEditDetailView = YES;
//        
//        [tableViewModel addSection:objectSelectionSection];
//        
//        [self updateClientsTotalLabel];
//        NSInteger currentlySelectedItemIndex= (NSInteger )[objectSelectionSection.items indexOfObject:clientCurrentlySelectedInReferringDetailview];
//        if ((currentlySelectedItemIndex>=0)&&(currentlySelectedItemIndex<=(objectSelectionSection.itemsSet.count+1))) {
//             objectSelectionSection.selectedItemIndex=(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:clientCurrentlySelectedInReferringDetailview]];
//        }
//        
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
//    
//    
//    
//}

//- (SCCustomCell *)tableViewModel:(SCTableViewModel *)tableViewModel
//	  customCellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
//    SCObjectSelectionCell *selectionCell=[[SCObjectSelectionCell alloc]initWithText:cell.textLabel.text withBoundObject:cell.boundObject withSelectedObjectPropertyName:@"propertyName" withItems:nil withItemsClassDefintion:clientsViewController_Shared.clientDef];
//    
//
//    return selectionCell;
//}



- (void)tableViewModel:(SCTableViewModel *) tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *) indexPath
{
    //NSLog(@"table view model tag is %i",tableViewModel.tag);
    //NSLog(@"tableviewmodel tag is %i",tableViewModel.tag);

        
    //NSLog(@"table view model tag is %i",tableViewModel.tag);
    //NSLog(@"tableviewmodel tag is %i",tableViewModel.tag);
    
    SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
    switch (tableViewModel.tag) {
        case 0:
        {
            
           if( [cell isKindOfClass:[SCDateCell class]]) {
                SCDateCell *dateCell=(SCDateCell *)cell;
                [dateCell.datePicker setMaximumDate:[NSDate date]];
                //NSLog(@"date cell date is%@ ",dateCell.datePicker.date);
                
            }

            
                        
        }
            break;
        case 1:
        {
            if ([cell isKindOfClass:[SCDateCell class]]) {
                SCDateCell *dateCell=(SCDateCell *)cell;
                [dateCell.datePicker setMaximumDate:[NSDate date]];
                //NSLog(@"date cell date is%@ ",dateCell.datePicker.date);
                
            }
            
        }
            break;
        case 3:
        {
            if (section.cellCount&&cell.boundObject) {
                
                
                NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
                
                if (cellManagedObject&&[cellManagedObject respondsToSelector:@selector(entity)]) {
                
                    if ([cellManagedObject.entity.name isEqualToString:@"PhoneEntity"]  ) 
                    
                {
                    if ( ![SCUtilities is_iPad] &&[cell isKindOfClass:[ButtonCell class]]) 
                    {
                        UIButton *button=(UIButton *)[cell viewWithTag:300];
                        [button setTitle:@"Call Number" forState:UIControlStateNormal];
                        break;
                    }
                    
                    //NSLog(@"cell kind of class is %@",cell.class);
                    if ( [cell isKindOfClass:[EncryptedSCTextFieldCell class]]) 
                    {
                        EncryptedSCTextFieldCell *encryptedTextFieldCell=(EncryptedSCTextFieldCell *)cell;
                        
                        UITextField *textField=(UITextField *)encryptedTextFieldCell.textField;
                        
                        textField.keyboardType=UIKeyboardTypeNumberPad;
                        break; 
                    }
                    
                    if ( [cell isKindOfClass:[SCTextFieldCell class]]) 
                    {
                        SCTextFieldCell *textFieldCell=(SCTextFieldCell *)cell;
                        
                        textFieldCell.textField.keyboardType=UIKeyboardTypeNumberPad;
                        break; 
                    }
                   
                }
                
                
                if ([cellManagedObject.entity.name isEqualToString:@"VitalsEntity"] &&cell.tag>2 &&[cell isKindOfClass:[SCNumericTextFieldCell class]]) 
                    
                {
                    
                    SCNumericTextFieldCell *textFieldCell=(SCNumericTextFieldCell *)cell;
                    
                    textFieldCell.textField.keyboardType=UIKeyboardTypeNumberPad;
                    break;
                }
                }}
        }
           
            break;
        case 4:
        {
            
            
            if (section.cellCount&&cell.boundObject) {
                NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
                
                if (cellManagedObject&&[cellManagedObject respondsToSelector:@selector(entity)]) {
              
               
                if ([cellManagedObject.entity.name isEqualToString:@"AdditionalVariableEntity"])
                    {
                    UIView *sliderView = [cell viewWithTag:14];
                    
                    if(cell.tag==3&&[sliderView isKindOfClass:[UISlider class]])
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
                        break;
                    }
                    
                    if(cell.tag==4&&[sliderView isKindOfClass:[UISlider class]])
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
                        break;
                    } 
                break;
                }
                //NSLog(@"entity name is %@",cellManagedObject.entity.name);
                if (cell.tag==1 && cellManagedObject &&[cellManagedObject.entity.name isEqualToString:@"LanguageSpokenEntity"])
                {
                    
                    UIView *scaleView = [cell viewWithTag:70];
                    if ([scaleView isKindOfClass:[UISegmentedControl class]]) {
                        
                        UILabel *fluencyLevelLabel =(UILabel *)[cell viewWithTag:71];
                        fluencyLevelLabel.text=@"Fluency Level:";
                        break;
                    }
                    break;
                }
            }
        
            
        }
        }
            break;
            
        case 5:
        {
            if (section.cellCount>0&&cell.boundObject) {
                
                NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
                
                if (cellManagedObject&&[cellManagedObject respondsToSelector:@selector(entity)]) { 
                //NSLog(@"entity name is %@",cellManagedObject.entity.name);
                    if (cell.tag==1 && [cell isKindOfClass:[SCCustomCell class]]&& [cellManagedObject.entity.name isEqualToString:@"AdditionalSymptomEntity"])
                    {
                        
                        UIView *scaleView = [cell viewWithTag:70];
                        if ([scaleView isKindOfClass:[UISegmentedControl class]]) {
                            
                            UILabel *fluencyLevelLabel =(UILabel *)[cell viewWithTag:71];
                            fluencyLevelLabel.text=@"Severity Level:";
                            
                        }
                    }
                
            }
            
            
            if (cell.tag==5&& tableViewModel.sectionCount >2) {
                
                //NSLog(@"cell tag is %i",cell.tag);
                //NSLog(@"cell text is %@",cell.textLabel.text);
                
                SCTableViewSection *followUpSection=(SCTableViewSection *)[tableViewModel sectionAtIndex:1];
                if (followUpSection.cellCount>0) {
                                SCTableViewCell *cellOne=(SCTableViewCell *)[followUpSection cellAtIndex:0];        
                NSManagedObject *cellManagedObject=(NSManagedObject *)cellOne.boundObject;
                //NSLog(@"cell managed object entity is %@",cellManagedObject.entity.name);
                //NSLog(@"cell  class is %@",[cellOne class]);
                if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"]) {
                    
                    
                    if ([cell isKindOfClass:[SCCustomCell class]]) 
                    {
                        UIView *scaleView = [cell viewWithTag:70];
                        if ([scaleView isKindOfClass:[UISegmentedControl class]]) 
                        {
                            
                            UILabel *satisfactionLevelLabel =(UILabel *)[cell viewWithTag:71];
                            satisfactionLevelLabel.text=@"Satisfaction With Drug:";
                            break; 
                        }
                        
                        
                    }
                    
                    
                    break;
                }
                
                    
                }

                
            }
            } 
        }
            break;
            
        default:
            break;
    }
    
}




- (void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)IndexPath
{
    SCTableViewCell *cell = [tableViewModel cellAtIndexPath:IndexPath];
    
    
    if ((tableViewModel.tag==1 ||tableViewModel.tag==0) &&cell.tag==1) {
        
        if ([cell isKindOfClass:[SCDateCell class]]) {
            SCDateCell *dateCell=(SCDateCell *)cell;
            
            if (dateCell.datePicker.date){
                
                [self addWechlerAgeCellToSection:[tableViewModel sectionAtIndex:0]];
                
            }
        }
    }
    if (tableViewModel.tag==3&&[cell isKindOfClass:[DrugNameObjectSelectionCell class]]) {
        DrugNameObjectSelectionCell *drugNameObjectSelectionCell=(DrugNameObjectSelectionCell *)cell;
        
        if (drugNameObjectSelectionCell.drugProduct) {
            SCTableViewCell *drugNameCell=(SCTableViewCell*)[tableViewModel cellAfterCell:cell rewind:NO];
            
            if ([drugNameCell isKindOfClass:[SCTextFieldCell class]] ) {
                SCTextFieldCell *textFieldCell=(SCTextFieldCell *)drugNameCell;
                textFieldCell.textField.text=drugNameObjectSelectionCell.drugProduct.drugName;
                
            }
            
        }
        
    }
    
    if (tableViewModel.tag==4){
        
        UIView *viewOne = [cell viewWithTag:14];
        switch (cell.tag) {
            case 3:
                
                
                
                if([viewOne isKindOfClass:[UISlider class]])
                {
                    UISlider *sliderOne = (UISlider *)viewOne;
                    UILabel *sOnelabel = (UILabel *)[cell viewWithTag:10];
                    
                    sOnelabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
                }
                
                break;
                
            case 4:
                
                
                if([viewOne isKindOfClass:[UISlider class]])
                {    
                    UISlider *sliderTwo = (UISlider *)viewOne;
                    UILabel *sTwolabel = (UILabel *)[cell viewWithTag:10];
                    
                    sTwolabel.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
                }
                
                
                
                
                
                
            default:
                break;
        }
    }
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    //NSLog(@"table bies slkjd %i", tableViewModel.tag);
    SCTableViewCell *cell =tableViewModel.activeCell;
    
    switch (tableViewModel.tag) {
        case 1:
        {
            
            UITextField *view =(UITextField *)[cell viewWithTag:3];
            
            [view becomeFirstResponder];
            [view resignFirstResponder];  
        }
            break;
        case 3:    
        {
            UIView *textViewView=(UIView *)[cell viewWithTag:80];
            if ([textViewView isKindOfClass:[UITextView class]]) {
                UITextView *textView=(UITextView *)textViewView;
                [textView becomeFirstResponder];
                [textView resignFirstResponder];
            }
            
        }
        default:
            break;
    }
    
}


- (void)tableViewModel:(SCTableViewModel *)tableViewModel 
       willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTableViewSection *section =[tableViewModel sectionAtIndex:0];
    
    //NSLog(@"section header title %@", section.headerTitle);
    //NSLog(@"table model tag is %i", tableViewModel.tag);
    NSManagedObject *managedObject = (NSManagedObject *)cell.boundObject;
    
    switch (tableViewModel.tag) {
            
        
    
            
        case 1:
            if (cell.tag==1) {
                
                if ([cell isKindOfClass:[SCDateCell class]]) {
                    SCDateCell *dateCell=(SCDateCell *)cell;
                    
                    if (dateCell.datePicker.date){
                        
                        [self addWechlerAgeCellToSection:[tableViewModel sectionAtIndex:0]];
                        
                    }
                }
            }
            
            break;
            
        case 2:
        {
            
            //identify the if the cell has a managedObject
            if (managedObject &&[managedObject respondsToSelector:@selector(entity)]) {
                
                
                
                //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
                if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
                    
                    //NSLog(@"entity name is %@",managedObject.entity.name);
                    //identify the Languages Spoken table
                    if ([managedObject.entity.name isEqualToString:@"LogEntity"]) {
                        //define and initialize a date formatter
                        NSDateFormatter *dateTimeDateFormatter = [[NSDateFormatter alloc] init];
                        
                        //set the date format
                        [dateTimeDateFormatter setDateFormat:@"ccc M/d/yy h:mm a"];
                        
                        NSDate *logDate=[managedObject valueForKey:@"dateTime"];
                        NSString *notes=[managedObject valueForKey:@"notes"];
                        
                        cell.textLabel.text=[NSString stringWithFormat:@"%@: %@",[dateTimeDateFormatter stringFromDate:logDate],notes];
                        return;
                    }
                    
                    if ([managedObject.entity.name isEqualToString:@"MedicationEntity"]) {
                        //define and initialize a date formatter
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        
                        //set the date format
                        [dateFormatter setDateFormat:@"M/d/yyyy"];
                        
                        NSDate *startedDate=[managedObject valueForKey:@"dateStarted"];
                        NSDate *discontinued=[managedObject valueForKey:@"discontinued"];
                        NSString *drugName=[managedObject valueForKey:@"drugName"];
                        //                        NSString *notes=[managedObject valueForKey:@"notes"];
                        
                        NSString *labelString=[NSString string];
                        if (drugName.length) {
                            labelString=drugName;
                        }
                        if (startedDate) {
                            
                            NSString *startedDateStr=[dateFormatter stringFromDate:startedDate];
                            if (labelString.length && startedDateStr.length) {
                                labelString=[labelString stringByAppendingFormat:@"; started: %@",startedDateStr];
                            }
                            
                        }
                        if (discontinued) 
                        {
                            
                            NSString *discontinueddDateStr=[dateFormatter stringFromDate:discontinued];
                            if (labelString.length && discontinueddDateStr.length) {
                                labelString=[labelString stringByAppendingFormat:@"; discontinued: %@",discontinueddDateStr];
                            }
                            
                        }
                        else {
                            cell.textLabel.textColor=[UIColor blueColor];
                        }
                        cell.textLabel.text=labelString;
                        return;
                    }
                    
                    if ([managedObject.entity.name isEqualToString:@"VitalsEntity"]) {
                        //NSLog(@"the managed object entity is Vitals Entity");
                        
                        
                        NSDate *dateTaken=(NSDate *)[cell.boundObject valueForKey:@"dateTaken"];
                        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                        
                        [dateFormatter setDateFormat:@"ccc M/d/yy h:mm a"];
                        
                        
                        NSString *dateTakenStr=[dateFormatter stringFromDate:dateTaken];
                        NSNumber *systolic=[cell.boundObject valueForKey:@"systolicPressure"];
                        NSNumber *diastolic=[cell.boundObject valueForKey:@"diastolicPressure"];
                        NSNumber *heartRate=[cell.boundObject valueForKey:@"heartRate"];    
                        NSNumber *temperature=[cell.boundObject valueForKey:@"temperature"];
                        
                        NSString *labelText=[NSString string];
                        if (dateTakenStr.length &&systolic&& diastolic) {
                            
                            labelText=[dateTakenStr stringByAppendingFormat:@": %@/%@",[systolic stringValue],[diastolic stringValue]];
                            
                        }
                        else if(dateTakenStr.length){
                            labelText=dateTakenStr;
                        }
                        
                        if (labelText.length&&heartRate) {
                            labelText=[labelText stringByAppendingFormat:@"; %@ bpm",[heartRate stringValue]];
                        }
                        if (labelText.length&&temperature) {
                            labelText=[labelText stringByAppendingFormat:@"; %@\u00B0",[temperature stringValue]];
                        }
                        
                        
                        cell.textLabel.text=labelText;
                        //change the text color to red
                        
                        return;
                        
                    }

                }
            }
        } 
            break;

        case 3:
            //this is a third level table
            
            
            
            //identify the if the cell has a managedObject
            if (managedObject && [managedObject respondsToSelector:@selector(entity)]) {
                
                
                
                //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
                if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
                    
                    
                    //identify the Languages Spoken table
                    if ([managedObject.entity.name isEqualToString:@"LanguageSpokenEntity"]) {
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
                        return;
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
                    return;

                    }
            
                }
                
            }
            
            
            break;
            
        case 4:
            //this is a fourth level detail view
            
            if (cell.tag==3) {
                
                //NSLog(@"cell tag is %i", cell.tag);
                UIView *viewOne = [cell viewWithTag:14];
                
                if([viewOne isKindOfClass:[UISlider class]])
                {
                    UISlider *sliderOne = (UISlider *)viewOne;
                    UILabel *slabel = (UILabel *)[cell viewWithTag:10];
                    //NSLog(@"detail will appear for row at index path label text%@",slabel.text);
                    
                    //NSLog(@"bound value is %f", sliderOne.value);
                    slabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
                    
                    
                    return;
                    
                }     
            }
            if (cell.tag==4){
                //NSLog(@"cell tag is ");
                UIView *viewTwo = [cell viewWithTag:14];
                if([viewTwo isKindOfClass:[UISlider class]])
                {
                    
                    
                    //NSLog(@"cell tag is %i", cell.tag);
                    
                    
                    UISlider *sliderTwo = (UISlider *)viewTwo;
                    UILabel *slabelTwo = (UILabel *)[cell viewWithTag:10];
                    
                    
                    slabelTwo.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
                }
                
                
                return;
                
            }
            //identify the if the cell has a managedObject
            if (managedObject && [managedObject respondsToSelector:@selector(entity)]) {
                
                
                
                //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
                if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
                    
                    //NSLog(@"entity name is %@",managedObject.entity.name);
                    //identify the Languages Spoken table
                    if ([managedObject.entity.name isEqualToString:@"MedicationReviewEntity"]) {
                        //define and initialize a date formatter
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        
                        //set the date format
                        [dateFormatter setDateFormat:@"M/d/yy"];
                        
                        NSInteger doseChange=(NSInteger )[(NSNumber *)[cell.boundObject valueForKey:@"doseChange"] integerValue];
                        
                        NSString *doseChangeString;
                        switch (doseChange) {
                            case 0:
                                doseChangeString=[NSString stringWithString:@"No Change"];
                                break;
                            case 1:
                                doseChangeString=[NSString stringWithString:@"Decrease to"];
                                break;  
                            case 2:
                                doseChangeString=[NSString stringWithString:@"Increase to"];
                                break;
                                
                            default:
                                break;
                        }
                        NSString *notes=(NSString *)[cell.boundObject valueForKey:@"notes"];
                        NSDate *logDate=(NSDate *)[cell.boundObject valueForKey:@"logDate"];
                        NSString *dosage=(NSString *)[cell.boundObject valueForKey:@"dosage"];
                        if (doseChangeString &&doseChangeString.length) {
                            cell.textLabel.text=[NSString stringWithFormat:@"%@: %@ %@",[dateFormatter stringFromDate:logDate],doseChangeString,dosage];
                        }
                        else
                        {
                            
                            cell.textLabel.text=[NSString stringWithFormat:@"%@: %@",[dateFormatter stringFromDate:logDate],dosage];
                        }
                        
                        if (notes &&notes.length) {
                            cell.textLabel.text=[cell.textLabel.text stringByAppendingFormat:@", %@",notes];
                        }
                        
                    }
                }
            }
            
            
            
            break;
        default:
            break;
    }
    
    
    
    
    
    
    
}

- (void)tableViewModel:(SCArrayOfItemsModel *)tableViewModel
searchBarSelectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
    //NSLog(@"scope changed");
    if([tableViewModel isKindOfClass:[SCArrayOfObjectsModel class]])
    {
//        SCArrayOfObjectsModel *objectsModel = (SCArrayOfObjectsModel *)tableViewModel;
        //        if (objectsModel.sectionCount>0) {
        //       SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
        //        
        //        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
        //            SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection*)section;
        //            
        //                
        //               
        //                SCTableViewCell *cell=(SCTableViewCell *)[objectsModel cellAtIndexPath: objectSelectionSection.selectedCellIndexPath];
        //                
        //                
        //                currentlySelectedClient= (ClientEntity *) cell.boundObject;
        //                
        //                
        //                
        //            
        //            
        //            
        //        }
        //        }
        
        [self.searchBar setSelectedScopeButtonIndex:selectedScope];
        
        switch (selectedScope) {
            case 0: //current
//                objectsModel.itemsPredicate = [NSPredicate predicateWithFormat:@"currentClient == %@",[NSNumber numberWithInteger: 0]];
                //NSLog(@"case 1");
                break;
                
            default:
//                objectsModel.itemsPredicate = nil;
                //NSLog(@"case default");
                
                break;
        }
        
        
//        [tableViewModel reloadBoundValues];
//        
//        
//        [tableViewModel.modeledTableView reloadData];
        
     
        //         if (objectsModel.sectionCount>0) {
        //        if (isInDetailSubview) {
        //        
        //        if (currentlySelectedClient) {
        //           SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
        //            if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
        //                
        //            
        //                SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection*)section;
        //                
        //
        //                
        //                [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:currentlySelectedClient]]];
        //                
        //                
        //            }
        //            
        //        }
        //        
        //            
        //        }
        
        //    }
    }
}


- (void)tableViewModel:(SCTableViewModel *)tableModel didAddSectionAtIndex:(NSUInteger)index
{
    
    SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:index];
    if ([section.headerTitle isEqualToString:@"De-Identified Client Data"]) {
        tableModel.tag=1;
    }
    
    
   
    if (tableModel.tag==1 &&index==0 &&section.cellCount>3) {
        [section insertCell:[SCLabelCell cellWithText:@"Age"] atIndex:2];
        [section insertCell:[SCLabelCell cellWithText:@"Wechsler Age"] atIndex:3];
        
        
        
        
    }
    //    if (tableViewModel.tag==0) {
    //       
    //        
    //        //NSLog(@"test%@", section.class);
    //        
    //        if (searchBar.text.length !=searchStringLength) {
    //            
    //            if ([section isKindOfClass:[SCArrayOfObjectsSection class]]) {
    //                //NSLog(@"test");
    //                
    //               
    //                SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)section;
    //                SCObjectSelectionSection *objectsSelectionSection=[[SCObjectSelectionSection alloc]initWithHeaderTitle:nil withItemsSet:arrayOfObjectsSection.itemsSet withClassDefinition:clientsViewController_Shared.clientDef];
    //                
    //                 searchStringLength=searchBar.text.length;
    //                reloadTableView=TRUE;
    //                section=nil;
    //                
    //                section=(SCObjectSelectionSection*) objectsSelectionSection;
    //                [tableViewModel addSection:section ];
    //                tableViewModel.delegate=self;
    //                //NSLog(@"section %@",[section class]);
    //                
    //                    
    //            }
    //               
    //               
    //            
    //            
    //            
    //        }
    //        else if(reloadTableView==TRUE)
    //                {
    //                
    //                    reloadTableView=FALSE;
    //                
    //                }
    //
    //    }
    if (tableModel.tag==3 &&index==0) {
        
        
        if (section.cellCount>1) {
            SCTableViewCell *cellOne=(SCTableViewCell *)[section cellAtIndex:1];
            
            NSManagedObject *cellOneBoundObject=(NSManagedObject *)cellOne.boundObject;
            
            //NSLog(@"section bound object entity is %@",cellOneBoundObject);
            //NSLog(@"section bound object entity name is %@",cellOneBoundObject.entity.name);
            if (cellOneBoundObject &&[cellOneBoundObject respondsToSelector:@selector(entity)] &&[cellOneBoundObject.entity.name isEqualToString:@"MedicationEntity"]) {
            
                
                section.footerTitle=@"Select the drug then add the current dosage in the Med Logs section.";
            }

            
        }
    }
    
    if(section.footerTitle !=nil)
    {
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 550, 100)];
        UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 550, 100)];
        footerLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        footerLabel.numberOfLines=6;
        footerLabel.lineBreakMode=UILineBreakModeWordWrap;
        footerLabel.backgroundColor = [UIColor clearColor];
        footerLabel.textColor = [UIColor whiteColor];
        footerLabel.tag=60;
        footerLabel.text=section.footerTitle;
        footerLabel.textAlignment=UITextAlignmentCenter;
        section.footerHeight=(CGFloat)100;
        [containerView addSubview:footerLabel];
        //        [footerLabel sizeToFit];
        section.footerView = containerView;
        
    }

    
    //NSLog(@"tablemodel data source %@",[section class]);
    
    //NSLog(@"did add section at index header title is %@",section.headerTitle);
    
    if(section.headerTitle !=nil)
    {
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
        
        headerLabel.text = section.headerTitle;
        headerLabel.textColor = [UIColor whiteColor];
        
        headerLabel.backgroundColor = [UIColor clearColor];
        
        
        [containerView addSubview:headerLabel];
        section.headerView = containerView;
        
        
    }
    
    
    
    
}




//-(void)tableViewModel:(SCTableViewModel *)tableViewModel didInsertRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//    if (tableViewModel.tag==0) {
//        //NSLog(@"did iset row for index path");
//   
//       
//            if(isInDetailSubview)
//            {
//                SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
//                NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
//                NSMutableArray *mutableArray=(NSMutableArray *)[NSMutableArray arrayWithArray:clientObjectSelectionCell.items];
//                [mutableArray addObject:cellManagedObject];
//                
//                clientObjectSelectionCell.items=mutableArray;
//            }
//            
//    }
//        
//        
//        
//        
//
//    
//}
//


//
//-(void)tableViewModel:(SCTableViewModel *)tableViewModel didRemoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//    if (tableViewModel.tag==0)
//    {
//        
//        if(isInDetailSubview){
//            SCObjectSelectionSection *section=(SCObjectSelectionSection *)[tableModel sectionAtIndex:0];
//            if (section.itemsSet.count<1)
//            {
//                self.totalClientsLabel.text=@"Tap + To Add Clients";
//            }
//            else
//            {
//                self.totalClientsLabel.text=[NSString stringWithFormat:@"Clients Available: %i", section.itemsSet.count ];
//            }
//            
//        }
//        else
//        {
//        
//            NSFetchRequest *totalClients =[NSFetchRequest fetchRequestWithEntityName:@"ClientEntity"];
//            NSInteger clientCount=(NSInteger )[managedObjectContext countForFetchRequest:totalClients error:nil]-1;
//            
//            
//            if (clientCount<1)
//            {
//                self.totalClientsLabel.text=@"Tap + To Add Clients";
//            }
//            else
//            {
//                self.totalClientsLabel.text=[NSString stringWithFormat:@"Total Clients: %i", clientCount ];
//            }
//            
//            }
//    }
//    
//}
//
//
//
//-(void)updateClientsTotalLabel{
//    
//    if(isInDetailSubview){
//        SCObjectSelectionSection *section=(SCObjectSelectionSection *)[tableModel sectionAtIndex:0];
//        if (section.itemsSet.count<1)
//        {
//            self.totalClientsLabel.text=@"Tap + To Add Clients";
//        }
//        else
//        {
//            self.totalClientsLabel.text=[NSString stringWithFormat:@"Clients Available: %i", section.itemsSet.count ];
//            
//        }
//    
//    }
//    else
//    {
//        NSFetchRequest *totalClients =[NSFetchRequest fetchRequestWithEntityName:@"ClientEntity"];
//        NSInteger clientCount=(NSInteger )[managedObjectContext countForFetchRequest:totalClients error:nil];
//        
//        
//        if (clientCount<1)
//        {
//            self.totalClientsLabel.text=@"Tap + To Add Clients";
//        }
//        else
//        {
//            self.totalClientsLabel.text=[NSString stringWithFormat:@"Total Clients: %i", clientCount ];
//        }
//        
//    
//    } 
//    
//}

-(BOOL)checkStringIsNumber:(NSString *)str{
    BOOL valid=YES;
    NSNumberFormatter *numberFormatter =[[NSNumberFormatter alloc] init];
    NSString *numberStr=[str stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSNumber *number=[numberFormatter numberFromString:numberStr];
    if (numberStr.length && [numberStr floatValue]<1000000 &&number) {
        valid=YES;
        
        if ([str rangeOfString:@"Number"].location != NSNotFound) {
            NSScanner* scan = [NSScanner scannerWithString:numberStr]; 
            int val;         
            
            valid=[scan scanInt:&val] && [scan isAtEnd];
            
            
        }
        
        
    } 
    
    return valid;
    
}

-(BOOL)tableViewModel:(SCTableViewModel *)tableViewModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath{

    BOOL valid = TRUE;
    
  
    
    
    //NSLog(@"table view model is alkjlaksjdfkj %i", tableViewModel.tag);
    
    if (tableViewModel.tag==1&&tableViewModel.sectionCount){
        
        
        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
        if (section.cellCount) {
            
            
            SCTableViewCell *clientIDCodeCell =(SCTableViewCell *)[section cellAtIndex:0];
            
            
            if ([clientIDCodeCell isKindOfClass:[EncryptedSCTextFieldCell class]]) {
                EncryptedSCTextFieldCell *clientIDCodeEncryptedCell =(EncryptedSCTextFieldCell *)clientIDCodeCell;
                
                if ( clientIDCodeEncryptedCell.textField.text.length ) {
                    
                    valid=TRUE;
                    //NSLog(@"first or last name is valid");
                    
                }
                else
                {
                    valid=FALSE;
                }
                
            }
            
            
            
        }
    }

    if (tableViewModel.tag==3&& tableViewModel.sectionCount){
        
        
        
        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
        
        if (section.cellCount>1) {
            SCTableViewCell *notesCell =(SCTableViewCell *)[section cellAtIndex:1];
            NSManagedObject *notesManagedObject=(NSManagedObject *)notesCell.boundObject;
            
            if (notesManagedObject && [notesManagedObject respondsToSelector:@selector(entity)]) {
            
                if ([ notesManagedObject.entity.name   isEqualToString:@"LogEntity"]&&[notesCell isKindOfClass:[EncryptedSCTextViewCell class]]) {
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
            
    
                //here it is not the notes cell
                if ([notesManagedObject.entity.name isEqualToString:@"MedicationEntity"]&&[notesCell isKindOfClass:[SCTextFieldCell class]]) {
                    SCTextFieldCell *drugNameCell=(SCTextFieldCell *)notesCell;
                    
                    if (drugNameCell.textField.text.length) 
                    {
                        valid=TRUE;
                    }
                    else 
                    {
                        valid=FALSE;
                    }
                    
                }
            
                if ([notesManagedObject.entity.name isEqualToString:@"PhoneEntity"]&&[notesCell isKindOfClass:[EncryptedSCTextFieldCell class]]) {
                    EncryptedSCTextFieldCell *phoneNumberCell=(EncryptedSCTextFieldCell *)notesCell;
                    
                    if (phoneNumberCell.textField.text.length) 
                    {
                        valid=TRUE;
                        valid=[self checkStringIsNumber:(NSString *)phoneNumberCell.textField.text];
                    }
                    else 
                    {
                        valid=FALSE;
                    }
                    
                }
            
            }
        
            
            
            if (section.cellCount>6) 
            {
                SCTableViewCell *cellSystolic=(SCTableViewCell *)[section cellAtIndex:3];
                SCTableViewCell *cellDiastolic=(SCTableViewCell *)[section cellAtIndex:4];
                SCTableViewCell *cellHeartRate=(SCTableViewCell *)[section cellAtIndex:5];
                SCTableViewCell *cellTemperature=(SCTableViewCell *)[section cellAtIndex:6];
                NSManagedObject *cellManagedObject=(NSManagedObject *)cellSystolic.boundObject;
                //NSLog(@"cell managed object entity name is %@",cellManagedObject.entity.name);  
                
                if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"VitalsEntity"]) {
                    
                    
                                       
                    
                    
                    
                    
                    
                    SCTextFieldCell *cellSystolicTF=(SCTextFieldCell *)cellSystolic;
                    SCTextFieldCell *cellDiastolicTF=(SCTextFieldCell *)cellDiastolic;
                    SCTextFieldCell *cellHeartRateTF=(SCTextFieldCell *)cellHeartRate;
                    SCTextFieldCell *cellTemperatureTF=(SCTextFieldCell *)cellTemperature;
                    
                    NSNumberFormatter *numberFormatter =[[NSNumberFormatter alloc] init];;
                    
                    NSNumber *systolicNumber=[numberFormatter numberFromString:cellSystolicTF.textField.text];
                    NSNumber *diastolicNumber=[numberFormatter numberFromString:cellDiastolicTF.textField.text];
                    NSNumber *heartRateNumber=[numberFormatter numberFromString:cellHeartRateTF.textField.text];
                    NSNumber *temperatureNumber=[numberFormatter numberFromString:cellTemperatureTF.textField.text];
                    
                    
                    
                    if (cellSystolicTF.textField.text.length && [cellSystolicTF.textField.text integerValue]<500 &&systolicNumber) {
                        valid=YES;
                    }
                    else if (cellSystolicTF.textField.text.length||(cellSystolicTF.textField.text.length&&!systolicNumber)){
                        valid=NO;
                    }
                    if (cellDiastolicTF.textField.text.length && [cellDiastolicTF.textField.text integerValue]<500 &&diastolicNumber) {
                        valid=YES;
                    }
                    else if(cellDiastolicTF.textField.text.length||(cellDiastolicTF.textField.text.length&&!diastolicNumber)){
                        valid=NO;
                    }
                    if (cellHeartRateTF.textField.text.length && [cellHeartRateTF.textField.text integerValue]<500 &&heartRateNumber) {
                        valid=YES;
                    }
                    else if(cellHeartRateTF.textField.text.length ||(cellHeartRateTF.textField.text.length&&!heartRateNumber)){
                        valid=NO;
                    }
                    
                    if (cellTemperatureTF.textField.text.length && [cellTemperatureTF.textField.text integerValue]< 130 &&temperatureNumber) {
                        valid=YES;
                    }
                    else if(cellTemperatureTF.textField.text.length ||(!temperatureNumber && cellTemperatureTF.textField.text.length)){
                        valid=NO;
                    }
                    
                    
                    
                }
            }        

            
            
            
            
            
        }
    }
    if (tableViewModel.tag==5&& tableViewModel.sectionCount){
        
        
        
        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
        
        if (section.cellCount>0) {
            SCTableViewCell *firstCell =(SCTableViewCell *)[section cellAtIndex:0];
            NSManagedObject *firstCellManagedObject=(NSManagedObject *)firstCell.boundObject;
            
            //NSLog(@"first cell class is %@",[firstCell class]);
            
            if (firstCellManagedObject &&[firstCellManagedObject respondsToSelector:@selector(entity)]&&[firstCellManagedObject.entity.name isEqualToString:@"AdditionalSymptomEntity"]&&[firstCell isKindOfClass:[SCObjectSelectionCell class]]) {
                SCObjectSelectionCell *symptomCell=(SCObjectSelectionCell *)firstCell;
                
                if (symptomCell.label.text.length) 
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
            
            if (cellManagedObject &&  [cellManagedObject respondsToSelector:@selector(entity)]&& [cellManagedObject.entity.name  isEqualToString:@"MigrationHistoryEntity"]&&[cellFrom isKindOfClass:[EncryptedSCTextViewCell class]]) {
                
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

-(void)addWechlerAgeCellToSection:(SCTableViewSection *)section {
    
    
    if (section.cellCount>3) {
   
    SCLabelCell *actualAgeCell=(SCLabelCell*)[section cellAtIndex:2];
    SCLabelCell *wechslerAgeCell=(SCLabelCell*)[section cellAtIndex:3];
    SCDateCell *birthdateCell=(SCDateCell *)[section cellAtIndex:1];
    
    actualAgeCell.label.text=[clientsViewController_Shared calculateActualAgeWithBirthdate:birthdateCell.datePicker.date];
    wechslerAgeCell.label.text=[clientsViewController_Shared calculateWechslerAgeWithBirthdate:birthdateCell.datePicker.date];
    }
}



@end
