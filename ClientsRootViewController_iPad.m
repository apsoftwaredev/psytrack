/*
 *  ClientViewController_iPad.m
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

@implementation ClientsRootViewController_iPad
@synthesize clientsDetailViewController_iPad=_clientsDetailViewController_iPad;

@synthesize managedObjectContext=_managedObjectContext;
@synthesize tableView=_tableView;
@synthesize searchBar;
@synthesize tableModel;



#pragma mark -
#pragma mark View lifecycle


-(void)viewDidUnload{

    [super viewDidUnload];
    
    self.tableModel=nil;

}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tableModel = (SCArrayOfObjectsModel *)[[SCModelCenter sharedModelCenter] modelForViewController:self];
    if(tableModel)
    {
        [self.tableModel replaceModeledTableViewWith:self.tableView];
        return;
    }
    
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
  
    
    // Get managedObjectContext from application delegate
    demographicDetailViewController_Shared =[[DemographicDetailViewController_Shared alloc]init];
    
    [demographicDetailViewController_Shared setupTheDemographicView];
       
    
    
    
    //begin paste
    
    clientsViewController_Shared =[[ClientsViewController_Shared alloc]init];

	
  
    
    [clientsViewController_Shared setupTheClientsViewModelUsingSTV];       

    
    
     NSPredicate *currentClientsPredicate=[NSPredicate predicateWithFormat:@"currentClient == %@",[NSNumber numberWithInteger: 0]];
    
    
   self.tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self
                                             withEntityClassDefinition:clientsViewController_Shared.clientDef usingPredicate:currentClientsPredicate];	
  


    
   	
    
    self.tableModel.searchBar = self.searchBar;
	self.tableModel.searchPropertyName = @"clientIDCode;notes";
    
    self.tableModel.editButtonItem = self.navigationItem.leftBarButtonItem;
//    tableModel.autoAssignDelegateForDetailModels=TRUE;
//    tableModel.autoAssignDataSourceForDetailModels=TRUE;
    self.tableModel.allowMovingItems=TRUE;
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc] init]];
    self.tableView.backgroundColor=[UIColor colorWithRed:0.317586 green:0.623853 blue:0.77796 alpha:1.0]; // Make the table view application backgound color (turquose)
    
    
//    tableModel.autoSortSections = TRUE;  
    self.tableModel.sectionIndexTitles = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];

    self.tableModel.delegate=self;
    

    
//        
}

    


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.    
    return YES;
}



#pragma mark -
#pragma mark SCTableViewModelDataSource methods

// Return a custom detail model that will be used instead of Sensible TableView's auto generated one
- (SCTableViewModel *)tableViewModel:(SCTableViewModel *)tableViewModel
customDetailTableViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    
    SCArrayOfObjectsModel *detailModel = [SCArrayOfObjectsModel tableViewModelWithTableView:self.clientsDetailViewController_iPad.tableView
                                                                         withViewController:self.clientsDetailViewController_iPad];
    detailModel.delegate=self;
    
    
   
    
	return detailModel;
}




-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
//    
//    
    if (tableViewModel.tag==0) {
        
        
        detailTableViewModel.tag=2;
        
    }
    else{
        detailTableViewModel.tag=tableViewModel.tag+1;
    }
    
    if(detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
        

    [detailTableViewModel.modeledTableView setBackgroundView:nil];
    [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
    [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; 
    }
    detailTableViewModel.delegate=self;
    NSLog(@"detail model created for row at index path detailtable model tag is %i", detailTableViewModel.tag);
}
//


- (NSString *)tableViewModel:(SCArrayOfItemsModel *)tableViewModel sectionHeaderTitleForItem:(NSObject *)item AtIndex:(NSUInteger)index
{
	// Cast not technically neccessary, done just for clarity
	NSManagedObject *managedObject = (NSManagedObject *)item;
	
	NSString *objectName = (NSString *)[managedObject valueForKey:@"clientIDCode"];
	
	// Return first charcter of objectName
	return [[objectName substringToIndex:1] uppercaseString];
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillAppearForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    if(detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
        

    [detailTableViewModel.modeledTableView setBackgroundView:nil];
    [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
    [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; 


    }
}

-(void) tableViewModel:(SCTableViewModel *)tableViewModel customButtonTapped:(UIButton *)button forRowWithIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"custom button tapped");
    
    
    
    
    
    if (tableViewModel.tag==3) {
        SCTableViewSection *section =[tableViewModel sectionAtIndex:indexPath.section];
        SCTableViewCell *cell=(SCTableViewCell *)[section cellAtIndex:0];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        if ([cellManagedObject.entity.name isEqualToString:@"PhoneEntity"]){
            
            SCTextFieldCell *phoneNumberCell =(SCTextFieldCell *) [section cellAtIndex:1];
            NSLog(@"custom button tapped");
            if (phoneNumberCell.textField.text.length) {
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call Phone Number:" message:phoneNumberCell.textField.text
                                                               delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                
                alert.tag=1;
                
                
                
                [alert show];
                
                
            }
        }
    }
    if (tableViewModel.tag==3) {
        SCTableViewSection *section =[tableViewModel sectionAtIndex:indexPath.section];
        SCTableViewCell *cell=(SCTableViewCell *)[section cellAtIndex:0];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        if ([cellManagedObject.entity.name isEqualToString:@"MedicationEntity"]){
            
            SCDateCell *discontinuedCell =(SCDateCell *) [section cellAtIndex:2];
            
            
            NSLog(@"custom button tapped discontinued cell text is %@",discontinuedCell.textLabel.text);
            NSLog(@"key bindings value is %@",[discontinuedCell.keyBindings valueForKey:@"discontinued"]);
            NSLog(@"tabel model key bindings value is");
            
            if (discontinuedCell.label.text.length) {
                
                [discontinuedCell.boundObject setNilValueForKey:@"discontinued"];
                [discontinuedCell reloadBoundValue]; 
                
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



-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillAppearForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{

    if(detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
        

    [detailTableViewModel.modeledTableView setBackgroundView:nil];
    [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
    [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; 
    }
    NSLog(@"tabel veiw modoel %i",tableViewModel.tag);
    
//    if (tableViewModel.tag==4 ) {
//        
//        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
//        NSLog(@"section cell count is %i",section.cellCount);
//        NSLog(@"detailtableview model sectioncount %i",detailTableViewModel.sectionCount);
//        BOOL sectionContainsMedLog=FALSE;
//        
//        if (detailTableViewModel.sectionCount) {
//            SCTableViewSection *detailSectionZero=(SCTableViewSection *)[detailTableViewModel sectionAtIndex:0]
//            ;
//            if (detailSectionZero.cellCount) {
//            
//                SCTableViewCell *cellZeroSectionZero=(SCTableViewCell *)[detailSectionZero cellAtIndex:0];
//                NSManagedObject *cellManagedObject=(NSManagedObject *)cellZeroSectionZero.boundObject;
//                
//                if (cellManagedObject&& [cellManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"])
//                {
//                    sectionContainsMedLog=TRUE;
//                }
//                
//            }
//        
//        
//            if (sectionContainsMedLog && section.cellCount>1 && detailTableViewModel.sectionCount) {
//                
//                SCTableViewSection *detailSectionZero=(SCTableViewSection *)[detailTableViewModel sectionAtIndex:0];
//                SCTableViewCell *cellZeroSectionZero=(SCTableViewCell *)[detailSectionZero cellAtIndex:0];
//                
//                
//                
//                NSManagedObject *cellManagedObject=(NSManagedObject *)cellZeroSectionZero.boundObject;
//                NSLog(@"cell managed object entity is %@",cellManagedObject.entity.name);
//                NSLog(@"cell  class is %@",[cellZeroSectionZero class]);
//                if (cellManagedObject &&[cellManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"]&&detailTableViewModel.sectionCount>2) {
//                    
//                    [detailTableViewModel removeSectionAtIndex:1];
//                    
//                    
//                }
//                
//            }
//        }  
//    }       
    


}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)index detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    NSLog(@"detail model created for row at index");
    
//    
    detailTableViewModel.tag=tableViewModel.tag+1;
    
    
    detailTableViewModel.delegate=self;
    
    if(detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
        

    [detailTableViewModel.modeledTableView setBackgroundView:nil];
    [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
    [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; 
    }
    NSLog(@"detail model created for row at index detailtable model tag is %i", detailTableViewModel.tag);
    
    if (tableViewModel.tag==4 ) {
        
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:index];
        NSLog(@"section cell count is %i",section.cellCount);
        NSLog(@"detailtableview model sectioncount %i",detailTableViewModel.sectionCount);
        BOOL sectionContainsMedLog=FALSE;
        
        if (detailTableViewModel.sectionCount) {
            SCTableViewSection *detailSectionZero=(SCTableViewSection *)[detailTableViewModel sectionAtIndex:0]
            ;
            if (detailSectionZero.cellCount) {
                
                SCTableViewCell *cellZeroSectionZero=(SCTableViewCell *)[detailSectionZero cellAtIndex:0];
                NSManagedObject *cellManagedObject=(NSManagedObject *)cellZeroSectionZero.boundObject;
                
                if (cellManagedObject&& [cellManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"])
                {
                    sectionContainsMedLog=TRUE;
                }
                
            }
            
            
            if (sectionContainsMedLog && section.cellCount>1 && detailTableViewModel.sectionCount) {
                
                SCTableViewSection *detailSectionZero=(SCTableViewSection *)[detailTableViewModel sectionAtIndex:0];
                SCTableViewCell *cellZeroSectionZero=(SCTableViewCell *)[detailSectionZero cellAtIndex:0];
                
                
                
                NSManagedObject *cellManagedObject=(NSManagedObject *)cellZeroSectionZero.boundObject;
                NSLog(@"cell managed object entity is %@",cellManagedObject.entity.name);
                NSLog(@"cell  class is %@",[cellZeroSectionZero class]);
                if (cellManagedObject &&[cellManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"]&&detailTableViewModel.sectionCount>2) {
                    
                    [detailTableViewModel removeSectionAtIndex:1];
                    
                    
                }
                
            }
        }  
    }       

    
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
//            NSLog(@"no items");
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
//        NSLog(@"clientobject selection itemset %@",mutableSet);
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

//- (SCControlCell *)tableViewModel:(SCTableViewModel *)tableViewModel
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
    NSLog(@"table view model tag is %i",tableViewModel.tag);
    NSLog(@"tableviewmodel tag is %i",tableViewModel.tag);

        
    NSLog(@"table view model tag is %i",tableViewModel.tag);
    NSLog(@"tableviewmodel tag is %i",tableViewModel.tag);
    
    SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
    switch (tableViewModel.tag) {
        case 0:
        {
            
           if( [cell isKindOfClass:[SCDateCell class]]) {
                SCDateCell *dateCell=(SCDateCell *)cell;
                [dateCell.datePicker setMaximumDate:[NSDate date]];
                NSLog(@"date cell date is%@ ",dateCell.datePicker.date);
                
            }

            
                        
        }
            break;
        case 1:
        {
            if ([cell isKindOfClass:[SCDateCell class]]) {
                SCDateCell *dateCell=(SCDateCell *)cell;
                [dateCell.datePicker setMaximumDate:[NSDate date]];
                NSLog(@"date cell date is%@ ",dateCell.datePicker.date);
                
            }
            
        }
            break;
        case 3:
        {
            if (section.cellCount&&cell.boundObject) {
                
                
                NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
                if (cellManagedObject &&[cellManagedObject.entity.name isEqualToString:@"PhoneEntity"]  ) 
                    
                {
                    if ( ![SCHelper is_iPad] &&[cell isKindOfClass:[ButtonCell class]]) 
                    {
                        UIButton *button=(UIButton *)[cell viewWithTag:300];
                        [button setTitle:@"Call Number" forState:UIControlStateNormal];
                        
                    }
                    
                    NSLog(@"cell kind of class is %@",cell.class);
                    if ( [cell isKindOfClass:[EncryptedSCTextFieldCell class]]) 
                    {
                        EncryptedSCTextFieldCell *encryptedTextFieldCell=(EncryptedSCTextFieldCell *)cell;
                        
                        UITextField *textField=(UITextField *)encryptedTextFieldCell.textField;
                        
                        textField.keyboardType=UIKeyboardTypeNumberPad;
                        
                    }
                    
                    if ( [cell isKindOfClass:[SCTextFieldCell class]]) 
                    {
                        SCTextFieldCell *textFieldCell=(SCTextFieldCell *)cell;
                        
                        textFieldCell.textField.keyboardType=UIKeyboardTypeNumberPad;
                        
                    }
                    
                }
                
                if (cell.tag==3&&cellManagedObject &&[cellManagedObject.entity.name isEqualToString:@"MedicationEntity"] && [cell isKindOfClass:[ButtonCell class]]) 
                    
                {
                    
                    UIButton *button=(UIButton *)[cell viewWithTag:300];
                    [button setTitle:@"Clear Discontinued Date" forState:UIControlStateNormal];
                }
                NSLog(@"cell kind of class is %@",cell.class);
                if (cellManagedObject &&[cellManagedObject.entity.name isEqualToString:@"VitalsEntity"] &&cell.tag>2 &&[cell isKindOfClass:[SCNumericTextFieldCell class]]) 
                    
                {
                    
                    SCNumericTextFieldCell *textFieldCell=(SCNumericTextFieldCell *)cell;
                    
                    textFieldCell.textField.keyboardType=UIKeyboardTypeNumberPad;
                    
                }
            }
        }
            break;
            break;
        case 4:
        {
            
            
            if (section.cellCount) {
                SCTableViewCell *cellOne=(SCTableViewCell *)[section cellAtIndex:0];
                NSManagedObject *cellManagedObject=(NSManagedObject *)cellOne.boundObject;
                if (cellManagedObject &&[cellManagedObject.entity.name isEqualToString:@"AdditionalVariableEntity"])
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
                        
                    }  
                }
                NSLog(@"entity name is %@",cellManagedObject.entity.name);
                if (cell.tag==1 && cellManagedObject &&[cellManagedObject.entity.name isEqualToString:@"LanguageSpokenEntity"])
                {
                    
                    UIView *scaleView = [cell viewWithTag:70];
                    if ([scaleView isKindOfClass:[UISegmentedControl class]]) {
                        
                        UILabel *fluencyLevelLabel =(UILabel *)[cell viewWithTag:71];
                        fluencyLevelLabel.text=@"Fluency Level:";
                        
                    }
                }
            }
            
        }
            break;
            
        case 5:
        {
            if (cell.tag==4&& tableViewModel.sectionCount >2) {
                
                NSLog(@"cell tag is %i",cell.tag);
                NSLog(@"cell text is %@",cell.textLabel.text);
                
                SCTableViewSection *followUpSection=(SCTableViewSection *)[tableViewModel sectionAtIndex:1];
                SCTableViewCell *cellOne=(SCTableViewCell *)[followUpSection cellAtIndex:0];        
                NSManagedObject *cellManagedObject=(NSManagedObject *)cellOne.boundObject;
                NSLog(@"cell managed object entity is %@",cellManagedObject.entity.name);
                NSLog(@"cell  class is %@",[cellOne class]);
                if (cellManagedObject &&[cellManagedObject.entity.name isEqualToString:@"MedicationReviewEntity"]) {
                    
                    
                    if ([cell isKindOfClass:[SCControlCell class]]) 
                    {
                        UIView *scaleView = [cell viewWithTag:70];
                        if ([scaleView isKindOfClass:[UISegmentedControl class]]) 
                        {
                            
                            UILabel *satisfactionLevelLabel =(UILabel *)[cell viewWithTag:71];
                            satisfactionLevelLabel.text=@"Satisfaction With Drug:";
                            
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
    NSLog(@"table bies slkjd %i", tableViewModel.tag);
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
    
    NSLog(@"section header title %@", section.headerTitle);
    NSLog(@"table model tag is %i", tableViewModel.tag);
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
            if (managedObject) {
                
                
                
                //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
                if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
                    
                    NSLog(@"entity name is %@",managedObject.entity.name);
                    //identify the Languages Spoken table
                    if ([managedObject.entity.name isEqualToString:@"LogEntity"]) {
                        //define and initialize a date formatter
                        NSDateFormatter *dateTimeDateFormatter = [[NSDateFormatter alloc] init];
                        
                        //set the date format
                        [dateTimeDateFormatter setDateFormat:@"ccc M/d/yy h:mm a"];
                        
                        NSDate *logDate=[managedObject valueForKey:@"dateTime"];
                        NSString *notes=[managedObject valueForKey:@"notes"];
                        
                        cell.textLabel.text=[NSString stringWithFormat:@"%@: %@",[dateTimeDateFormatter stringFromDate:logDate],notes];
                    }
                    if ([managedObject.entity.name isEqualToString:@"VitalsEntity"]) {
                        NSLog(@"the managed object entity is Vitals Entity");
                        
                        
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
                        
                        
                        
                    }

                }
            }
        } 
            break;

        case 3:
            //this is a third level table
            
            
            
            //identify the if the cell has a managedObject
            if (managedObject) {
                
                
                
                //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
                if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
                    
                    
                    //identify the Languages Spoken table
                    if ([managedObject.entity.name isEqualToString:@"LanguageSpokenEntity"]) {
                        NSLog(@"the managed object entity is Languag spoken Entity");
                        //get the value of the primaryLangugage attribute
                        NSNumber *primaryLanguageNumber=(NSNumber *)[managedObject valueForKey:@"primaryLanguage"];
                        
                        
                        NSLog(@"primary alanguage %@",  primaryLanguageNumber);
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
                    
                  
                if ([managedObject.entity.name isEqualToString:@"MigrationHistoryEntity"]) {
                        NSLog(@"the managed object entity is Migration History Entity");
                        
                        
                        NSDate *arrivedDate=(NSDate *)[cell.boundObject valueForKey:@"arrivedDate"];
                        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                        
                        [dateFormatter setDateFormat:@"M/YYYY"];
                        
                        
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
            
            if (cell.tag==3) {
                
                NSLog(@"cell tag is %i", cell.tag);
                UIView *viewOne = [cell viewWithTag:14];
                
                if([viewOne isKindOfClass:[UISlider class]])
                {
                    UISlider *sliderOne = (UISlider *)viewOne;
                    UILabel *slabel = (UILabel *)[cell viewWithTag:10];
                    NSLog(@"detail will appear for row at index path label text%@",slabel.text);
                    
                    NSLog(@"bound value is %f", sliderOne.value);
                    slabel.text = [NSString stringWithFormat:@"Slider One (-1 to 0) Value: %.2f", sliderOne.value];
                    
                    
                    
                    
                }     
            }
            if (cell.tag==4){
                NSLog(@"cell tag is ");
                UIView *viewTwo = [cell viewWithTag:14];
                if([viewTwo isKindOfClass:[UISlider class]])
                {
                    
                    
                    NSLog(@"cell tag is %i", cell.tag);
                    
                    
                    UISlider *sliderTwo = (UISlider *)viewTwo;
                    UILabel *slabelTwo = (UILabel *)[cell viewWithTag:10];
                    
                    
                    slabelTwo.text = [NSString stringWithFormat:@"Slider Two (0 to 1) Value: %.2f", sliderTwo.value];
                }
                
                
                
                
            }
            //identify the if the cell has a managedObject
            if (managedObject) {
                
                
                
                //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
                if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
                    
                    NSLog(@"entity name is %@",managedObject.entity.name);
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
    
    NSLog(@"scope changed");
    if([tableViewModel isKindOfClass:[SCArrayOfObjectsModel class]])
    {
        SCArrayOfObjectsModel *objectsModel = (SCArrayOfObjectsModel *)tableViewModel;
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
                objectsModel.itemsPredicate = [NSPredicate predicateWithFormat:@"currentClient == %@",[NSNumber numberWithInteger: 0]];
                NSLog(@"case 1");
                break;
                
            default:
                objectsModel.itemsPredicate = nil;
                NSLog(@"case default");
                
                break;
        }
        
        
        [tableViewModel reloadBoundValues];
        
        
        [tableViewModel.modeledTableView reloadData];
        
     
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


- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSInteger)index
{
    
    SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:index];
    if ([section.headerTitle isEqualToString:@"De-Identified Client Data"]) {
        tableViewModel.tag=1;
    }
    
    
   
    if (tableViewModel.tag==1 &&index==0) {
        [section insertCell:[SCLabelCell cellWithText:@"Age"] atIndex:2];
        [section insertCell:[SCLabelCell cellWithText:@"Wechsler Age"] atIndex:3];
        
        
        
        
    }
    //    if (tableViewModel.tag==0) {
    //       
    //        
    //        NSLog(@"test%@", section.class);
    //        
    //        if (searchBar.text.length !=searchStringLength) {
    //            
    //            if ([section isKindOfClass:[SCArrayOfObjectsSection class]]) {
    //                NSLog(@"test");
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
    //                NSLog(@"section %@",[section class]);
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
    
    NSLog(@"tablemodel data source %@",[section class]);
    
    NSLog(@"did add section at index header title is %@",section.headerTitle);
    
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
//        NSLog(@"did iset row for index path");
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

-(BOOL)tableViewModel:(SCTableViewModel *)tableViewModel valueIsValidForRowAtIndexPath:(NSIndexPath *)indexPath{

    BOOL valid = TRUE;
    
  
    
    
    NSLog(@"table view model is alkjlaksjdfkj %i", tableViewModel.tag);
    
    if (tableViewModel.tag==1){
        
        
        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
        SCControlCell *clientIDCodeCell =(SCControlCell *)[section cellAtIndex:0];
        
        
        
        UITextField *clientIDCodeField =(UITextField *)[clientIDCodeCell viewWithTag:1];
        
        NSLog(@"texxt field text is %@",clientIDCodeField.text);
        if ( clientIDCodeField.text.length ) {
            
            valid=TRUE;
            NSLog(@"first or last name is valid");
            
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
            
            
            if ([notesManagedObject.entity.name isEqualToString:@"LogEntity"]&&[notesCell isKindOfClass:[EncryptedSCTextViewCell class]]) {
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
            NSLog(@"cell managed object entity name is %@",cellManagedObject.entity.name);  
            
            if ([cellManagedObject.entity.name isEqualToString:@"MigrationHistoryEntity"]&&[cellFrom isKindOfClass:[EncryptedSCTextViewCell class]]) {
                
                EncryptedSCTextViewCell *encryptedFrom=(EncryptedSCTextViewCell *)cellFrom;
                EncryptedSCTextViewCell *encryptedTo=(EncryptedSCTextViewCell *)cellTo;
                
                NSLog(@"arrived date cell class is %@",[cellArrivedDate class]);
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
    
    if (tableViewModel.tag==3&& tableViewModel.sectionCount){
        
        
        
        SCTableViewSection *section=[tableViewModel sectionAtIndex:0];
        
        if (section.cellCount>6) 
        {
            SCTableViewCell *cellSystolic=(SCTableViewCell *)[section cellAtIndex:3];
            SCTableViewCell *cellDiastolic=(SCTableViewCell *)[section cellAtIndex:4];
            SCTableViewCell *cellHeartRate=(SCTableViewCell *)[section cellAtIndex:5];
            SCTableViewCell *cellTemperature=(SCTableViewCell *)[section cellAtIndex:6];
            NSManagedObject *cellManagedObject=(NSManagedObject *)cellSystolic.boundObject;
            NSLog(@"cell managed object entity name is %@",cellManagedObject.entity.name);  
            
            if ([cellManagedObject.entity.name isEqualToString:@"VitalsEntity"]) {
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
    
    
    return valid;






}

-(void)addWechlerAgeCellToSection:(SCTableViewSection *)section {
    
    
    
    SCLabelCell *actualAgeCell=(SCLabelCell*)[section cellAtIndex:2];
    SCLabelCell *wechslerAgeCell=(SCLabelCell*)[section cellAtIndex:3];
    SCDateCell *birthdateCell=(SCDateCell *)[section cellAtIndex:1];
    
    actualAgeCell.label.text=[clientsViewController_Shared calculateActualAgeWithBirthdate:birthdateCell.datePicker.date];
    wechslerAgeCell.label.text=[clientsViewController_Shared calculateWechslerAgeWithBirthdate:birthdateCell.datePicker.date];
    
}

#pragma mark -
#pragma button actions

- (void)addButtonTapped
{
    [tableModel dispatchAddNewItemEvent];
}


@end
