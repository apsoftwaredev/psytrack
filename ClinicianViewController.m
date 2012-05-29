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

#import "SCArrayOfObjectsModel+CoreData+SelectionSection.h"




@implementation ClinicianViewController

@synthesize searchBar;

@synthesize totalCliniciansLabel;





#pragma mark -
#pragma mark View lifecycle

-(id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(ClinicianSelectionCell*)objectSelectionCell sendingViewController:(UIViewController *)viewController withPredicate:(NSPredicate *)startPredicate  usePrescriber:(BOOL)usePresciberBool allowMultipleSelection:(BOOL)allowMultiSelect{
    
    self=[super initWithNibName:nibName bundle:bundle];
    
    filterByPrescriber=usePresciberBool;
    filterPredicate=startPredicate;
    isInDetailSubview=detailSubview;
    clinicianObjectSelectionCell=objectSelectionCell;
    currentlySelectedClinician=clinicianObjectSelectionCell.clinicianObject;
    sendingViewController=viewController;
    allowMultipleSelection=allowMultiSelect;
    
    return self;
    
} 



-(void)viewDidUnload{
    [super viewDidUnload];
   
    
    totalCliniciansLabel=nil;
    
   
    filterByPrescriber=NO;
    isInDetailSubview=NO;
    clinicianObjectSelectionCell=nil;
   sendingViewController=nil;
 ;
    currentlySelectedClinician=nil;
    currentlySelectedCliniciansArray=nil;
    filterPredicate=nil;
  
 
  self.totalCliniciansLabel=nil;
    
    
}
-(IBAction)reloadTableViewData:(id)sender{
    
    [self.tableViewModel reloadBoundValues ];
    [self.tableView reloadData];
    
}


   
//    
//   
//    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        
//        [self.tableView setBackgroundView:nil];
//        [self.tableView setBackgroundView:[[UIView alloc] init]];
//        [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
//        
//        
//    }
//    
//    
//    //    [self.tableView reloadData];
//    //    [self.tableView reloadData];
//    
//}

- (void)viewDidLoad {
        [super viewDidLoad];
   


    
   
    if (isInDetailSubview) {
        objectsModel = [[SCArrayOfObjectsModel_UseSelectionSection alloc] initWithTableView:self.tableView entityDefinition:self.clinicianDef]; 
        objectsModel.tag=0;
        objectsModel.delegate=self;
       PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
            [self.view setBackgroundColor:appDelegate.window.backgroundColor];
            // Set the view controller's theme
        
        
        if ([SCUtilities is_iPad]) {
            
            
            [objectsModel.modeledTableView setBackgroundView:nil];
            UIView *view=[[UIView alloc]init];
            [objectsModel.modeledTableView setBackgroundView:view];
        }
        
        [objectsModel.modeledTableView setBackgroundColor:appDelegate.window.backgroundColor];
        objectsModel.theme = [SCTheme themeWithPath:@"ClearBackgroundTheme.sct"];

        
       

        if (filterPredicate) {
            [self.searchBar setSelectedScopeButtonIndex:1];
        }

        objectsModel.autoAssignDelegateForDetailModels=YES;
        objectsModel.allowDeletingItems=FALSE;
        objectsModel.autoSelectNewItemCell=TRUE;
        
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
        
        
        UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTappedInDetailSubView)];
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
        objectsModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:1];
        objectsModel.addButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:2];

        UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped)];
        
        self.navigationItem.leftBarButtonItem=cancelButton;
        
        if (filterByPrescriber) {
//            NSString *scopeTitleAtOne= (NSString *)[self.searchBar.scopeButtonTitles objectAtIndex:1];
//            
//            scopeTitleAtOne=@"Prescribers";
            
            
            self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"All Clinicians",@"Prescribers",@"At Current Site",nil];
        }

        
        
    }
    else
    {
                
//        self.tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self
//                                                 withEntityClassDefinition:self.clinicianDef usingPredicate:nil useSCSelectionSection:FALSE];	
        
//        self.tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView
//                                                 entityDefinition:self.clinicianDef];
       objectsModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView entityDefinition:self.clinicianDef]; 
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
     
        
    objectsModel.sectionIndexTitles = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
//     objectsModel.autoSortSections = TRUE;
//        self.clinicianDef.keyPropertyName=@"firstName";
        self.clinicianDef.titlePropertyName = @"firstName;lastName";
    
    }
     
    
    
	objectsModel.searchPropertyName = @"firstName;lastName";

    objectsModel.allowMovingItems=TRUE;
    
    
	objectsModel.searchBar = self.searchBar;
    objectsModel.addButtonItem = self.addButton;
    
	
    
    // Replace the default model with the new objectsModel
    //    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"drugName Matches %@",@"a"];
    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    
    

    
    
     [self updateClinicianTotalLabel];
    
   
    
	    

   
    if([SCUtilities is_iPad]){
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    }
    else {
        self.tableViewModel=objectsModel;
    }

    


    [(PTTAppDelegate *)[UIApplication sharedApplication].delegate application:[UIApplication sharedApplication]
                                               willChangeStatusBarOrientation:[[UIApplication sharedApplication] statusBarOrientation]
                                                                     duration:5];
    if (isInDetailSubview) {
        [self.tableViewModel reloadBoundValues];
        [self.tableViewModel.modeledTableView reloadData];  

    }
    
}
#pragma mark -
#pragma mark SCTableViewModelDataSource methods

- (NSString *)tableViewModel:(SCArrayOfItemsModel *)tableViewModel sectionHeaderTitleForItem:(NSObject *)item AtIndex:(NSUInteger)index
{
    if (!isInDetailSubview) {
   
       	// Cast not technically neccessary, done just for clarity
        NSManagedObject *managedObject = (NSManagedObject *)item;
        
        NSString *objectName = (NSString *)[managedObject valueForKey:@"lastName"];
        
        // Return first charcter of objectName
        return [[objectName substringToIndex:1] uppercaseString];
        
    
    }
    else {
        return nil;
    }

}
  

-(void)viewDidAppear:(BOOL)animated{

    if ( self.selectMyInformationOnLoad) {
        [self selectMyInformation];
        
        self.selectMyInformationOnLoad=NO;
        
        
    }


}
-(void)selectMyInformation{


  
    NSInteger sectionCount=self.tableViewModel.sectionCount;
    
    
    for (int i=0; i< sectionCount; i++) {
        
        SCTableViewSection *section=(SCTableViewSection *)[self.tableViewModel sectionAtIndex:i];
        BOOL foundMyInformation=NO;
        if ([section isKindOfClass:[SCArrayOfObjectsSection class]]) {
            SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection*)section;
            
            for (int p=0; p< arrayOfObjectsSection.cellCount; p++) {
                SCTableViewCell *cell=(SCTableViewCell *)[section cellAtIndex:p];
                
                NSManagedObject *cellManagedObject=(NSManagedObject *) cell.boundObject;
                
                
                if (cellManagedObject &&[cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"ClinicianEntity"]) {
                    
                    BOOL myInformation=[(NSNumber *)[cellManagedObject valueForKey:@"myInformation"]boolValue];
                    
                    if (myInformation) {
                        [self.tableViewModel setActiveCell:cell];
                        
                        [arrayOfObjectsSection dispatchEventSelectRowAtIndexPath:[self.tableViewModel indexPathForCell:cell]];
                        foundMyInformation=YES;
                        break;
                        
                    }
                    
                }
                
                
            }
            
            
        }
        if (foundMyInformation) {
            break;
        }
    }
    
    









}

-(void)cancelButtonTapped{
    
    //NSLog(@"cancel button Tapped");
    
    //NSLog(@"parent controller %@",[super parentViewController]);
    
   
    
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
    
     [self viewDidUnload];
}



-(void)doneButtonTappedInDetailSubView{
    
    //NSLog(@"done Button tapped");
    if (isInDetailSubview &&objectsModel.sectionCount) {
        SCTableViewSection *section=(SCTableViewSection *)[objectsModel sectionAtIndex:0];
        //NSLog(@"section class is %@",[section class]);
//        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//        
//        if ([appDelegate managedObjectContext].hasChanges) {
//            [appDelegate saveContext];
//        }

        
        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
            SCObjectSelectionSection *objectsSelectionSection=(SCObjectSelectionSection*)section;
            
            [objectsSelectionSection commitCellChanges];
            if (allowMultipleSelection) {
                NSInteger sectionCount=self.tableViewModel.sectionCount;
                //NSLog(@"section count is %i",sectionCount);
                if (sectionCount&& !currentlySelectedCliniciansArray) {
                    currentlySelectedCliniciansArray=[NSMutableArray array];
                }
                else {
                    [currentlySelectedCliniciansArray removeAllObjects];
                }
                for (NSInteger i=0; i<sectionCount ; i++ ) {
                    SCObjectSelectionSection *sectionAtIndex=(SCObjectSelectionSection *)[self.tableViewModel sectionAtIndex:i];
                    
                    
                    
                    NSEnumerator *enumerator = [sectionAtIndex.selectedItemsIndexes objectEnumerator];
                    id setObject;
                    while ((setObject = [enumerator nextObject]) != nil)
                    {
                        if(![setObject isEqualToNumber:[NSNumber numberWithInteger:-1]]&&[setObject integerValue]<sectionAtIndex.cellCount){
                        SCTableViewCell *selectedCell=(SCTableViewCell *)[sectionAtIndex cellAtIndex:(NSUInteger)[(NSNumber *)setObject integerValue]];
                        
                        if ([selectedCell.boundObject isKindOfClass:[ClinicianEntity class]]) {
                            ClinicianEntity *clinicianObject=(ClinicianEntity *)selectedCell.boundObject;
                            [currentlySelectedCliniciansArray addObject:clinicianObject];
                            
                            //NSLog(@"currently selected clinicians array is %@",currentlySelectedCliniciansArray);
                            
                        }
                        
                        }
                    }
                        
                        
                       
                        
                }
                        
               
            //NSLog(@"currently selected clinicians array is %@",currentlySelectedCliniciansArray);
                
                        
                        //NSLog(@"object selection section selected itemsindexes %@",objectsSelectionSection.selectedItemsIndexes);                    
               
                       
                [clinicianObjectSelectionCell  doneButtonTappedInDetailView:nil selectedItems: currentlySelectedCliniciansArray withValue:TRUE];
                        
                   
                
                
            }else {
//                NSIndexPath *cellIndexPath=objectsSelectionSection.selectedCellIndexPath;
                
//                if (cellIndexPath.row) {
//                    <#statements#>
//                }
//                SCTableViewCell *cell=(SCTableViewCell *)[self.tableViewModel cellAtIndexPath:cellIndexPath];
//                //NSLog(@"cell bound object in clients view controller at done %@",cell.boundObject);
                
                
                
                //NSLog(@"selected item index%@",objectsSelectionSection.selectedItemIndex);
                
                
                if (objectsSelectionSection.selectedItemIndex&&![objectsSelectionSection.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]] && [objectsSelectionSection.selectedItemIndex intValue]< objectsSelectionSection.items.count) {
                    currentlySelectedClinician=(ClinicianEntity *)[objectsSelectionSection.items objectAtIndex:[objectsSelectionSection.selectedItemIndex intValue]];
                    
                }
                else {
                    currentlySelectedClinician=nil;
                }
                    [clinicianObjectSelectionCell  doneButtonTappedInDetailView:currentlySelectedClinician selectedItems:nil withValue:TRUE];
                    
            
                currentlySelectedClinician=nil;

            }
            //            //NSLog(@"test valie changed at index with cell index selected %i",[objectsSelectionSection.selectedItemIndex integerValue]) ;
            //            if (clientObjectSelectionCell) {
            
            //                //NSLog(@"objectsSelectionSection.selectedItemsIndexes.count %i",objectsSelectionSection.items.count);
            
            //                if ([objectsSelectionSection.selectedItemIndex integerValue]>=0&&[objectsSelectionSection.selectedItemIndex integerValue]<=objectsSelectionSection.items.count) {
            //                    
                           
                
                     
            
            
            
            
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


//-(void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    
//    SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
////     
//
//    if ([tableViewModel isKindOfClass:[SCArrayOfObjectsModel class]]) {
//        SCArrayOfObjectsModel *arrayOfObjectsModel=(SCArrayOfObjectsModel *)tableViewModel;
//        
//        [arrayOfObjectsModel dispatchEventSelectRowAtIndexPath:indexPath];
//        return;
//    }
//
//    if ([section isKindOfClass:[SCArrayOfObjectsSection class]]) {
//        SCArrayOfObjectsSection *selectionSection=(SCArrayOfObjectsSection *)section;
//        
//        [selectionSection dispatchEventSelectRowAtIndexPath:indexPath];
//        return;
//    }
//    if ([section isKindOfClass:[SCSelectionSection class]]) {
//        SCSelectionSection *selectionSection=(SCSelectionSection *)section;
//        [selectionSection dispatchEventSelectRowAtIndexPath:indexPath];
//        return;
//    }
//    
//    
//    
//   NSLog(@"tablemodel class is %@",tableViewModel.class);
//    
//    NSLog(@"section class %@",[section class]);
////    
////    
//}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    [super tableViewModel:tableViewModel willConfigureCell:cell forRowAtIndexPath:indexPath];

    
    if (tableViewModel.tag==0) {
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
       
        SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection*)section;
        //            int objectSelectionSectionItemsCount=(NSInteger ) objectSelectionSection.cellCount;
        
        
        
        if (currentlySelectedClinician&&[cell.boundObject isEqual:currentlySelectedClinician]) {
            //NSLog(@"currently selected client is %@",currentlySelectedClinician);
            //NSLog(@"cell bound object is %@",cell.boundObject);
            //NSLog(@"they are equal section cell count is %i", section.cellCount);
            //            [objectSelectionSection setSelectedCellIndexPath:indexPath];
            [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:currentlySelectedClinician]]];
            
            //NSLog(@"index integer of object %i",[objectSelectionSection.items indexOfObject:currentlySelectedClinician]);
            
        }
        //        [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:currentlySelectedClient]]];
        
        
        
        //            [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:(NSInteger)[objectSelectionSection.items indexOfObject:managedObject]]]; 
      
        
            
        }
        
    }


}

#pragma mark -
#pragma SCTableViewModelDelegate methods

-(void)tableViewModelSearchBarCancelButtonClicked:(SCArrayOfItemsModel *)tableViewModel{


    [self updateClinicianTotalLabel];

}

-(void)setSelectedClinicians{
    if (isInDetailSubview) {
        SCTableViewSection *section=(SCTableViewSection *)[self.tableViewModel sectionAtIndex:0];
        //NSLog(@"section class is %@",[section class]);
        //        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        //        
        //        if ([appDelegate managedObjectContext].hasChanges) {
        //            [appDelegate saveContext];
        //        }
        
        if ([section isKindOfClass:[SCObjectSelectionSection class]]) 
        {
            for (int i=0; i<self.tableViewModel.sectionCount; i++) {
           
                SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection*)[self.tableViewModel sectionAtIndex:i];
            
            if (allowMultipleSelection) 
            {
                //NSLog(@"currentlyselected clinicians in set selected are %@",currentlySelectedCliniciansArray);
                if (currentlySelectedCliniciansArray.count) {
                    
                     NSMutableSet *selectedIndexesSet=objectSelectionSection.selectedItemsIndexes;
                    for (int p=0; p<currentlySelectedCliniciansArray.count; p++) {
                        int clinicianInSectionIndex;
                        ClinicianEntity *clinicianInArray=[currentlySelectedCliniciansArray objectAtIndex:p];
                        if ([objectSelectionSection.items containsObject:clinicianInArray]) {
                            clinicianInSectionIndex=(int )[objectSelectionSection.items indexOfObject:clinicianInArray];
                            
                                [selectedIndexesSet addObject:[NSNumber numberWithInt:clinicianInSectionIndex]];
                            
                            
                        }
                        
                    }

                }
            }
            }}}
}
-(void)createSelectedCliniciansArray{

    if (isInDetailSubview) {
        SCTableViewSection *section=(SCTableViewSection *)[self.tableViewModel sectionAtIndex:0];
        //NSLog(@"section class is %@",[section class]);
        //        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        //        
        //        if ([appDelegate managedObjectContext].hasChanges) {
        //            [appDelegate saveContext];
        //        }

        if ([section isKindOfClass:[SCObjectSelectionSection class]]) 
        {
            
//            SCObjectSelectionSection *objectsSelectionSection=(SCObjectSelectionSection*)section;
            
            
            if (allowMultipleSelection) 
            {
                if (currentlySelectedCliniciansArray&& currentlySelectedCliniciansArray.count) {
                    [currentlySelectedCliniciansArray removeAllObjects];
                    
                }
                else if(!currentlySelectedCliniciansArray){
                    currentlySelectedCliniciansArray=[NSMutableArray array];
                }
                            
                

                NSInteger sectionCount=self.tableViewModel.sectionCount;
                
                for (NSInteger p=0; p<sectionCount ; p++ ) {
                    SCObjectSelectionSection *sectionAtIndex=(SCObjectSelectionSection *)[self.tableViewModel sectionAtIndex:p];
                                       NSEnumerator *enumerator = [sectionAtIndex.selectedItemsIndexes objectEnumerator];
                    id setObject;
                    while ((setObject = [enumerator nextObject]) != nil)
                    {
                        SCTableViewCell *selectedCell=(SCTableViewCell *)[sectionAtIndex cellAtIndex:(NSUInteger)[(NSNumber *)setObject integerValue]];
                        
                        if ([selectedCell.boundObject isKindOfClass:[ClinicianEntity class]]) {
                            ClinicianEntity *clinicianObject=(ClinicianEntity *)selectedCell.boundObject;
                            [currentlySelectedCliniciansArray addObject:clinicianObject];
                            
                            //NSLog(@"currently selected clinicians array is %@",currentlySelectedCliniciansArray);
                            
                        }
                        
                    }
                    
                    
                    
                    
                }
            
            
            //NSLog(@"currently selected clinicians array is %@",currentlySelectedCliniciansArray);
            
            
            //NSLog(@"object selection section selected itemsindexes %@",objectsSelectionSection.selectedItemsIndexes);                    
            
                        
            }}}   
            
    

}


- (void)tableViewModel:(SCArrayOfItemsModel *)tableViewModel
searchBarSelectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self createSelectedCliniciansArray];
    //NSLog(@"scope changed");
    if([tableViewModel isKindOfClass:[SCArrayOfObjectsModel class]])
    {
        
    
        SCDataFetchOptions *dataFetchOptions=(SCDataFetchOptions *)objectsModel.dataFetchOptions;
        [self.searchBar setSelectedScopeButtonIndex:selectedScope];
        
        switch (selectedScope) {
            case 1: //All
            {
                NSPredicate *scopeFilter=nil;
                
                if (filterByPrescriber&& isInDetailSubview) {
                    
                    scopeFilter=[NSPredicate predicateWithFormat:@"isPrescriber ==%@",[NSNumber numberWithBool: YES]];
                                    }
                else
                {
                    scopeFilter= [NSPredicate predicateWithFormat:@"myCurrentSupervisor == %i OR myPastSupervisor==%i", TRUE, TRUE];
                    
                }
                
                [dataFetchOptions setFilterPredicate:scopeFilter];
               
                
                    
                //NSLog(@"case 1");
            }
                break;
            case 2: 
               [dataFetchOptions setFilterPredicate:(NSPredicate *)[NSPredicate predicateWithFormat:@"atMyCurrentSite == %i OR myInformation==%i", TRUE, TRUE]];
                
                //NSLog(@"case 2");
                break;                
  
            default:
                 [dataFetchOptions setFilterPredicate:nil];
                //NSLog(@"case default");
                
                break;
        }
        [objectsModel reloadBoundValues];
        [objectsModel.modeledTableView reloadData];   
        
        [self updateClinicianTotalLabel];
        
        [self setSelectedClinicians];
    }
}




-(void)tableViewModel:(SCTableViewModel *)tableViewModel didRemoveRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (tableViewModel.tag==0) {
    
        [self updateClinicianTotalLabel];
        
    }
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel didRemoveSectionAtIndex:(NSUInteger)index{

    if (tableViewModel.tag==0) {
        
        [self updateClinicianTotalLabel];
        
    }

   
}

-(void)updateClinicianTotalLabel{

 
    if (objectsModel.tag==0) 
    {
        int cellCount=0;
        if (objectsModel.sectionCount >0){
            
            for (int i=0; i<objectsModel.sectionCount; i++) {
                SCTableViewSection *section=(SCTableViewSection *)[objectsModel sectionAtIndex:i];
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



-(void)tableViewModel:(SCTableViewModel *)tableModel didAddSectionAtIndex:(NSUInteger)index{

    [super tableViewModel:tableModel didAddSectionAtIndex:index];
    
    SCTableViewSection *section=[tableModel sectionAtIndex:index];
    
    if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
        tableModel.delegate=self;
    }
    
    if (tableModel.tag==0) {
        NSLog(@"t %@",section.class);
    
        if ([section isKindOfClass:[SCArrayOfObjectsSection class]]) {
      
        SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)section;
        arrayOfObjectsSection.fetchItemsCell=[SCFetchItemsCell cellWithText:@"Load More..."];
        
   
    
    SCCoreDataFetchOptions *dataFetchOptions=[[SCCoreDataFetchOptions alloc]initWithSortKey:@"firstName" sortAscending:YES filterPredicate:nil];
    
    
    dataFetchOptions.batchStartingOffset=2;
    dataFetchOptions.batchSize=2;
    
    
    arrayOfObjectsSection.dataFetchOptions=dataFetchOptions;
        [arrayOfObjectsSection.dataFetchOptions sort];
            
        }
    }
    
    
    

      if (isInDetailSubview &&[section isKindOfClass:[SCObjectSelectionSection class]])
      {
        
        
            SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection *)section;
            
            objectSelectionSection.allowMultipleSelection=allowMultipleSelection;
      
    }
    


}
-(BOOL)tableViewModel:(SCTableViewModel *)tableViewModel willRemoveRowAtIndexPath:(NSIndexPath *)indexPath{

    SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
  //NSLog(@"delete sender is activated %@",cell.boundObject);
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
         //NSLog(@"client entity keys %@",boundObjectKeys);
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
                      //NSLog(@"attribute %@",attribute);
                }
          
            }
            
            
            NSArray *relationshipsByName=(NSArray *)[entityDescription relationshipsByName] ;
            //NSLog(@"client entity keys %@",relationshipsByName);
            
            for (id relationship in relationshipsByName){
             
                
                
         
                    [clinicianObject setValue:nil forKey:relationship];
                    //NSLog(@"set nil value for relationship %@",relationship);
              
                
            }
            
            
            [tableViewModel reloadBoundValues];
            [tableViewModel.modeledTableView reloadData];
            [appdelegate displayNotification:@"My Personal Information Cleared" forDuration:3.0 location:kPTTScreenLocationTop inView:notificationSuperView];
            deletePressedOnce=NO;
            //NSLog(@"client entity keys after %@",cellManagedObject);
        }
       
        return NO;
    }
    
    return YES;
}
    


@end

