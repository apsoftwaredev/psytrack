/*
 *  DrugViewController_iPhone.m
 *  psyTrack Clinician Tools
 *  Version: 1.05
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on  12/19/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "DrugViewController_iPhone.h"
#import "DrugActionDateViewController.h"
#import "PTTAppDelegate.h"

#import "PTTEncryption.h"
#import "SCArrayOfObjectsModel_UseSelectionSection.h"

@implementation DrugViewController_iPhone
@synthesize searchBar;
//@synthesize tableView;
@synthesize downloadBar=downloadBar_;
@synthesize downloadButton=downloadButton_;
@synthesize downloadStopButton=downloadStopButton_;
@synthesize downloadLabel= downloadLabel_;
@synthesize downloadContinueButton=downloadContinueButton_;
@synthesize downloadCheckButton=downloadCheckButton_;
@synthesize checkingTimer=checkingTimer_;
@synthesize downloadBytesLabel=downloadBytesLabel_;
@synthesize drugObjectSelectionCell=drugObjectSelectionCell_;
@synthesize connectingToFile;
//@synthesize tableModel;
#pragma mark -
#pragma mark View lifecycle

//-(id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(ClientsSelectionCell*)objectSelectionCell sendingViewController:(UIViewController *)viewController{
//    
//    self=[super initWithNibName:nibName bundle:bundle];
//    
//    
//    isInDetailSubview=detailSubview;
////    clientObjectSelectionCell=objectSelectionCell;
//    
//    sendingViewController=viewController;
//    
//    
//    return self;
//    
//} 



-(id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(DrugNameObjectSelectionCell*)objectSelectionCell sendingViewController:(UIViewController *)viewController applNo:(NSString *)applicationNumber productNo:(NSString *)productNumber{
    
    self=[super initWithNibName:nibName bundle:bundle];
    
    drugApplNo=applicationNumber;
    drugProductNo=productNumber;
    
    isInDetailSubview=detailSubview;
    self.drugObjectSelectionCell=objectSelectionCell;
    
    sendingViewController=viewController;
    
    
    return self;
    
} 
- (void)viewDidLoad {
    [super viewDidLoad];
   
	
    // Set up the edit and add buttons.
//    self.navigationBarType = SCNavigationBarTypeAddRightEditLeft;
    
//    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
//    
//    
//    
//    
//    
//    // create a spacer
//    UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
//                                   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
//    [buttons addObject:editButton];
//    
//    [self editButtonItem];
//    
//    
//    // create a standard "add" button
//    UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
//                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:NULL];
//    addButton.style = UIBarButtonItemStyleBordered;
//    [buttons addObject:addButton];
//    
//    // stick the buttons in the toolbar
//    self.navigationItem.rightBarButtonItems=buttons;
//
    
    
//    
//    drugViewController_Shared =[[DrugViewController_Shared alloc]init];
//    
//    [drugViewController_Shared setupTheDrugsViewModelUsingSTV];    
    
    
//	self.tableView.backgroundColor=[UIColor clearColor];
    
    drugsManagedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate drugsManagedObjectContext];
    //Create a class definition for Client entity
	
    drugDef = [SCEntityDefinition definitionWithEntityName:@"DrugProductEntity" 
                                      managedObjectContext:drugsManagedObjectContext 
                                             propertyNames:[NSArray arrayWithObject:@"tECode"]];
    
    
    
    
//    //create the dictionary with the data bindings
    NSDictionary *customCellDrugNameDataBindings = [NSDictionary 
                                                    dictionaryWithObjects:[NSArray arrayWithObjects:@"drugName",@"Drug Name", @"drugName",    nil] 
                                                    forKeys:[NSArray arrayWithObjects:@"1" ,@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag
	
    //create the custom property definition
    SCCustomPropertyDefinition *drugNameDataDataProperty = [SCCustomPropertyDefinition definitionWithName:@"DrugNameData"
                                                                                     uiElementNibName:@"CustomSCTextViewCell_iPhone" 
                                                                                       objectBindings:customCellDrugNameDataBindings];
	
    
    
    //insert the custom property definition into the drugsDef class at index 0
    [drugDef insertPropertyDefinition:drugNameDataDataProperty atIndex:0];
    
    //create the dictionary with the data bindings
    NSDictionary *customCellActiveIngredientDataBindings = [NSDictionary 
                                                            dictionaryWithObjects:[NSArray arrayWithObjects:@"activeIngredient",@"Active Ingredient", @"activeIngredient",    nil] 
                                                            forKeys:[NSArray arrayWithObjects:@"1" ,@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag
	
    //create the custom property definition
    SCCustomPropertyDefinition *activeIngredientDataProperty = [SCCustomPropertyDefinition definitionWithName:@"ActiveIngredientData"
                                                                                         uiElementNibName:@"CustomSCTextViewCell_iPhone" 
                                                                                           objectBindings:customCellActiveIngredientDataBindings];
	
    
    
    //insert the custom property definition into the drugsDef class at index 1
    [drugDef insertPropertyDefinition:activeIngredientDataProperty atIndex:1];
    
    //create the dictionary with the data bindings
    NSDictionary *dosageDataBindings = [NSDictionary 
                                        dictionaryWithObjects:[NSArray arrayWithObjects:@"dosage",@"Dosage", @"dosage",    nil] 
                                        forKeys:[NSArray arrayWithObjects:@"1" ,@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag
	
    //create the custom property definition
    SCCustomPropertyDefinition *dosageDataProperty = [SCCustomPropertyDefinition definitionWithName:@"dosageData"
                                                                               uiElementNibName:@"CustomSCTextViewCell_iPhone" 
                                                                                 objectBindings:dosageDataBindings];
	
    
    
    //insert the custom property definition into the drugsDef class at index 3
    [drugDef insertPropertyDefinition:dosageDataProperty atIndex:2];
    
    
    //create the dictionary with the data bindings
    NSDictionary *formDataBindings = [NSDictionary 
                                      dictionaryWithObjects:[NSArray arrayWithObjects:@"form",@"Form", @"form",    nil] 
                                      forKeys:[NSArray arrayWithObjects:@"1" ,@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag
	
    //create the custom property definition
    SCCustomPropertyDefinition *formDataProperty = [SCCustomPropertyDefinition definitionWithName:@"FormData"
                                                                             uiElementNibName:@"CustomSCTextViewCell_iPhone" 
                                                                               objectBindings:formDataBindings];
	
    
    
    //insert the custom property definition into the drugsDef class at index 3
    [drugDef insertPropertyDefinition:formDataProperty atIndex:3];
    
    
    
    int indexofTECode=[drugDef indexOfPropertyDefinitionWithName:@"tECode"];
    [drugDef removePropertyDefinitionAtIndex:indexofTECode];
    
    //
    //
    //    //Create the property definition for the active ingredent property in the drugDef class
    //    SCPropertyDefinition *sponsorPropertyDef = [drugDef propertyDefinitionWithName:@"appl.sponsorApplicant"];
    //    
    //    sponsorPropertyDef.title=@"Made By";
    //    
    //    sponsorPropertyDef.type=SCPropertyTypeTextView;
    
    
    drugDef.titlePropertyName=@"drugName;dosage"; 
    
    drugDef.keyPropertyName=@"drugName";
//    if (drugsManagedObjectContext) {
//   
    productEntityDesc=[NSEntityDescription entityForName:@"DrugProductEntity" inManagedObjectContext:drugsManagedObjectContext];
    
    
    productFetchRequest = [[NSFetchRequest alloc] init];
  filterPredicate=[NSPredicate predicateWithFormat:@"drugName== nil"];
    
    [productFetchRequest setPredicate:filterPredicate];
    
    
    [productFetchRequest setEntity:productEntityDesc];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"drugName"
                                                                   ascending:YES];
   NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    
    [productFetchRequest setSortDescriptors:sortDescriptors];

   
    NSError *productError = nil;
        NSArray *productFetchedObjects;
        
        if ([drugsManagedObjectContext countForFetchRequest:productFetchRequest error:&productError]) {
       
        productFetchedObjects = [drugsManagedObjectContext executeFetchRequest:productFetchRequest error:&productError];
            
        }
    NSMutableArray *mutableDrugsArray=nil;
    if (productFetchedObjects) {
        mutableDrugsArray= [NSMutableArray arrayWithArray:productFetchedObjects];
    }
   
        
//    
    // Instantiate the tabel model
    
//    tableModel = [[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView withViewController:self];    
//    
//    
//
    if (objectsModel) {
        objectsModel=nil;
    }
   
    if (!isInDetailSubview) {
        
    objectsModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView];
    
   
	        
    }else if (isInDetailSubview) {
    
        objectsModel = [[SCArrayOfObjectsModel_UseSelectionSection alloc] initWithTableView:self.tableView];
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
        
        
        UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(myDoneButtonTapped)];
        [buttons addObject:doneButton];
        
        // create a spacer
        UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
        [buttons addObject:editButton];
        
        [self editButtonItem];
        
        
        
        
        // stick the buttons in the toolbar
        self.navigationItem.rightBarButtonItems=buttons;
        objectsModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:1];
        
        
        UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(myCancelButtonTapped)];
        
        self.navigationItem.leftBarButtonItem=cancelButton;

        
    }
       
     
   
	objectsModel.searchPropertyName = @"drugName";

    
    //	self.searchBar.delegate=self;
    
    // Replace the default model with the new objectsModel
    //    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"drugName Matches %@",@"a"];
    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    objectsModel.delegate=self;
    
    objectsModel.allowAddingItems=NO;
    objectsModel.allowDeletingItems=NO;
    objectsModel.allowEditDetailView=YES;
    objectsModel.allowMovingItems=YES;
    objectsModel.allowRowSelection=YES;
    
    objectsModel.delegate=self;
    SCCoreDataFetchOptions *dataFetchOptions=[[SCCoreDataFetchOptions alloc]initWithSortKey:@"drugName" sortAscending:YES filterPredicate:nil];
    
    
    objectsModel.autoAssignDelegateForDetailModels=YES;
    objectsModel.dataStore.storeMode=SCStoreModeAsynchronous;
    
    objectsModel.dataFetchOptions=dataFetchOptions;
    //    [objectsModel reloadBoundValues];
   
    objectsModel.autoAssignDelegateForDetailModels=YES;
    
    
    self.tableViewModel = objectsModel;
    [self.tableViewModel reloadBoundValues];
    self.searchBar.delegate=self;

    if (isInDetailSubview) {
    
//    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
////        
////        
//        UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(myDoneButtonTapped)];
//        [buttons addObject:doneButton];
//        
//        // create a spacer
//        UIBarButtonItem* viewButton = [[UIBarButtonItem alloc]
//                                       initWithTitle:@"View" style:UIBarButtonItemStylePlain target:self action:@selector(viewButtonTapped)];
//        
//      
//        [buttons addObject:viewButton];
//        
////        [self editButtonItem];
//        
//        
////        // create a standard "add" button
////        UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
////                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:NULL];
////        addButton.style = UIBarButtonItemStyleBordered;
////        [buttons addObject:addButton];
//////        
//        
//        
//        // stick the buttons in the toolbar
//        self.navigationItem.rightBarButtonItems=buttons;
////        objectsModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:1];
////        
//        
//        UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped)];
////        
////        self.navigationItem.leftBarButtonItem=cancelButton;
////        
        //so you can tell that the it is in view mode
        objectsModel.allowMovingItems=YES;
        
//        self.navigationItem.rightBarButtonItem=doneButton;
        
    
//        
//        if (self.navigationItem.rightBarButtonItems.count >0)
//        {
//            objectsModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:0];
//        }
//        

        
    }
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIColor * backgroundColor=nil;
    if (isInDetailSubview) {
      backgroundColor  =(UIColor *)(UIWindow *)appDelegate.window.backgroundColor;
    }
    else{
        backgroundColor=[UIColor clearColor];
    }
   
    
    
    
    if([SCUtilities is_iPad]||[SCUtilities systemVersion]>=6){
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:backgroundColor]; // Make the table view transparent
    }
    
    self.view.backgroundColor=backgroundColor;

    
    CGFloat localDbBytes=(CGFloat )[self getLocalDrugFileSize];
    UINavigationItem *navigationItem=(UINavigationItem *)self.navigationItem;
    
    navigationItem.title=[NSString stringWithFormat:@"Drugs %0.1f MB", localDbBytes/1048576];
    
    
    NSString *imageNameStr=nil;
    if ([SCUtilities is_iPad]||[SCUtilities systemVersion]>=6) {
        imageNameStr=@"ipad-menubar-full.png";
    }
    else{
        
        imageNameStr=@"menubar.png";
    }
    
    UIImage *menueBarImage=[UIImage imageNamed:imageNameStr];
    [self.searchBar setBackgroundImage:menueBarImage];
    [self.searchBar setScopeBarBackgroundImage:menueBarImage];
    
    productFetchRequest=nil;
    sortDescriptor=nil;
    sortDescriptors=nil;
    
    
}
//-(void)didReceiveMemoryWarning{
//
//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    if (!appDelegate.drugViewControllerIsInDetailSubview) {
//       objectsModel=nil;
//    
//     NSArray *productFetchedObjects=[NSArray array];
//    if (isInDetailSubview) {
//        objectsModel=[[SCArrayOfObjectsModel_UseSelectionSection alloc]initWithTableView:self.tableView items:[NSMutableArray arrayWithArray:productFetchedObjects] itemsDefinition:drugDef];
//        
//        
//    }
//    else {
//        objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView items:[NSMutableArray arrayWithArray:productFetchedObjects] itemsDefinition:drugDef];
//    }
//    self.tableViewModel = objectsModel;
//    [self.tableViewModel reloadBoundValues];
//    drugsManagedObjectContext=nil;
//
//[objectsModel.modeledTableView reloadData];
//    CGFloat localDbBytes=(CGFloat )0.1;
//    UINavigationItem *navigationItem=(UINavigationItem *)self.navigationItem;
//    
//    navigationItem.title=[NSString stringWithFormat:@"Drugs %0.1f MB", localDbBytes/1048576];
//    
//    }
//
//}
//-()sea
-(void)viewButtonTapped{

    SCArrayOfObjectsSection *section=(SCArrayOfObjectsSection *)[objectsModel sectionAtIndex:0];
    section.allowEditDetailView=YES;
    section.allowRowSelection=YES;
    [section dispatchEventSelectRowAtIndexPath:[objectsModel indexPathForCell:objectsModel.activeCell]];

}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{

    [self.searchBar resignFirstResponder];


}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{


    [self.searchBar resignFirstResponder];


}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length>2) {
        objectsModel.enablePullToRefresh=NO;
        objectsModel.tableView.userInteractionEnabled=NO;
        
        
        if (objectsModel ) {
        
          
            NSFetchRequest *newRequewst=[[NSFetchRequest alloc]init];
            
            filterPredicate=[NSPredicate predicateWithFormat:@"drugName contains [cd] %@ OR activeIngredient contains [cd] %@",searchText,searchText];
            
            [newRequewst setPredicate:filterPredicate];
            
            [newRequewst setEntity:productEntityDesc];
            NSError *productError = nil;
            NSArray *productFetchedObjects=[NSArray array];
            if (!drugsManagedObjectContext) {
                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                
                
                drugsManagedObjectContext=[appDelegate drugsManagedObjectContext];
            }
            if ([drugsManagedObjectContext countForFetchRequest:newRequewst error:&productError]) {
                
                productFetchedObjects = [drugsManagedObjectContext executeFetchRequest:newRequewst error:&productError];
                
                NSMutableArray *productFetchedObjectsMutableArray=[NSMutableArray arrayWithArray:productFetchedObjects];
                [objectsModel removeAllSections];
                
                
                SCMemoryStore *memoryStore=[SCMemoryStore storeWithObjectsArray:productFetchedObjectsMutableArray defaultDefiniton:drugDef];
                
               
                [objectsModel setDataStore:memoryStore];
               
                [objectsModel reloadBoundValues];
                //
                //
                [objectsModel.modeledTableView reloadData];
                newRequewst=nil;
                objectsModel.enablePullToRefresh=YES;
                objectsModel.tableView.userInteractionEnabled=YES;
                

                
            }
                       
        }
        

 
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    return YES;
    
}
-(IBAction)startCheckingForUpdate:(id)sender{
    
    self.downloadLabel.text=@"Checking";
    
    if (!self.connectingToFile) {
   
       
        downloadLabel_.alpha=1.0;
        checkingTimer_  = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                           target:self
                                                         selector:@selector(flashCheckingLabel:)
                                                         userInfo:NULL
                                                          repeats:YES];
        
   
    

       


        [self connectToRemoteDrugFile];

    }
    
 
    
    
}

-(void)myCancelButtonTapped{
    
    
    
    
    
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

-(void)myDoneButtonTapped{
    
    
    if (isInDetailSubview) {
        SCTableViewSection *section=(SCTableViewSection *)[self.tableViewModel sectionAtIndex:0];
        
        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
            SCObjectSelectionSection *objectsSelectionSection=(SCObjectSelectionSection*)section;
            
            //            //DLog(@"test valie changed at index with cell index selected %i",[objectsSelectionSection.selectedItemIndex integerValue]) ;
            //            if (clientObjectSelectionCell) {
            
            //                
            
            //                if ([objectsSelectionSection.selectedItemIndex integerValue]>=0&&[objectsSelectionSection.selectedItemIndex integerValue]<=objectsSelectionSection.items.count) {
            //                    
//            NSIndexPath *cellIndexPath=objectsSelectionSection.selectedCellIndexPath;
            
//            SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:cellIndexPath];
            
            
            
            
            
            
            if (objectsSelectionSection.cellCount>0) {
                if (currentlySelectedDrug) {
                    drugObjectSelectionCell_.drugProduct= currentlySelectedDrug;
                    [drugObjectSelectionCell_  doneButtonTappedInDetailView:currentlySelectedDrug withValue:TRUE];
                    
                    
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
            
            
           
            
        } 
         [self myCancelButtonTapped];
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

-(IBAction)flashCheckingLabel:(id)sender{

    if (self.downloadLabel.alpha==(CGFloat)1.0) {
        
        [self fadeCheckingLabel];
        NSInteger downloadLabelLength=downloadLabel_.text.length;
       
        if (downloadLabelLength>7 && downloadLabelLength<12) {
            downloadLabel_.text=[downloadLabel_.text stringByAppendingString:@"."];
        }
        else {
            if (downloadLabelLength!=8) {
                self.downloadLabel.text=@"Checking";
            }
        }
        
        
    }
    else
    {
        [self checkingLabelToNormalState];
    }





}
-(void)fadeCheckingLabel{

    [UIView beginAnimations:nil context: nil];
    [UIView setAnimationDuration:1.5];
    self.downloadLabel.alpha=(CGFloat)0.4;
    [UIView commitAnimations];


}
-(void)checkingLabelToNormalState{

    if (self.downloadLabel.alpha!=(CGFloat)1.0){
        [UIView beginAnimations:nil context: nil];
        [UIView setAnimationDuration:1.5];
        self.downloadLabel.alpha=(CGFloat)1.0;
        [UIView commitAnimations];

    }


}
-(NSDate *)getTheLastModifiedDateLocal{

    NSDate *lastModifiedDate;
    
    /* default date if file doesn't exist (not an error) */
	
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    NSURL *drugFileURL=[appDelegate applicationDrugsFileURL];
    
    
    
	if ([[NSFileManager defaultManager] fileExistsAtPath:drugFileURL.path]) {
		/* retrieve file attributes */
		NSError *error=nil;
        
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:drugFileURL.path error:&error];
		
        
        if (attributes != nil) {
			lastModifiedDate = [attributes fileModificationDate];
            
            
		}
		else {
			error=[NSError errorWithDomain:@"Error Getting Drug File Size" code:1 userInfo:nil];
		}
	}
   
    
    
    




    return lastModifiedDate;


}

/* get modification date of the current cached image */

- (CGFloat ) getLocalDrugFileSize
{
	/* default date if file doesn't exist (not an error) */
	
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    
    NSURL *drugFileURL=[appDelegate applicationDrugsFileURL];
    
    
   
    CGFloat  drugFileSize=0;
	if ([[NSFileManager defaultManager] fileExistsAtPath:drugFileURL.path]) {
		/* retrieve file attributes */
		NSError *error=nil;
        
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:drugFileURL.path error:&error];
		
        
        if (attributes != nil) {
			drugFileSize = [attributes fileSize];
            
            
		}
		else {
			error=[NSError errorWithDomain:@"Error Getting Drug File Size" code:1 userInfo:nil];
		}
	}
    return drugFileSize;
}


- (void) connectToRemoteDrugFile{

    self.connectingToFile=YES;
    // Create a URL Request and set the URL
    NSURL *url = [NSURL URLWithString:@"https://www.dropbox.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
     [request setHTTPMethod: @"HEAD"];
    // Display the network activity indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // Perform the request on a new thread so we don't block the UI
    dispatch_queue_t downloadQueue = dispatch_queue_create("Download queue", NULL);
    dispatch_async(downloadQueue, ^{
        
        NSError* err = nil;
        NSHTTPURLResponse* rsp = nil;
        
        // Perform the request synchronously on this thread
        NSData *rspData = [NSURLConnection sendSynchronousRequest:request returningResponse:&rsp error:&err];
        
        // Once a response is received, handle it on the main thread in case we do any UI updates
        dispatch_async(dispatch_get_main_queue(), ^{
            // Hide the network activity indicator
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            if (rspData == nil || (err != nil && [err code] != noErr)) {
                // If there was a no data received, or an error...
                self.downloadLabel.text=@"Not Reachable";
                [checkingTimer_ invalidate];
                checkingTimer_=nil;
                self.connectingToFile=NO;
                [self checkingLabelToNormalState];
            } else {
                NSTimeInterval timeout=10.0;
                NSURL *remoteFileURL=[NSURL URLWithString:@"http://dl.dropbox.com/u/96148802/pt/dFile-001.zpk"];
                
                drugFileRequest=  [[NSURLRequest alloc] initWithURL:remoteFileURL cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:timeout];
                
                connectionToDrugFile = [NSURLConnection connectionWithRequest:drugFileRequest delegate:self];
                
                [connectionToDrugFile start];
                 [self checkingLabelToNormalState];
                // Do whatever else you want with the data...
            }
        });
    });
    
   
   
        
    
   
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
   
    CGFloat remoteSize = [[NSString stringWithFormat:@"%lli",[response expectedContentLength]] floatValue];
    self.downloadCheckButton.enabled=YES;
    
    [checkingTimer_ invalidate];
    checkingTimer_=nil;
    CGFloat localFileSize=[self getLocalDrugFileSize];
    
    /* Try to retrieve last modified date from HTTP header. If found, format
	 date so it matches format of cached image file modification date. */
    
    NSDate *remoteModifiedDate;
    NSDate *localModifiedDate=[self getTheLastModifiedDateLocal];

	if ([response isKindOfClass:[NSHTTPURLResponse self]]) {
		NSDictionary *headers = [(NSHTTPURLResponse *)response allHeaderFields];
		NSString *modified = [headers objectForKey:@"Last-Modified"];
		if (modified) {
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
			/* avoid problem if the user's locale is incompatible with HTTP-style dates */
			[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
            
			[dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
			remoteModifiedDate = [dateFormatter dateFromString:modified];
            dateFormatter=nil;
		}
		else {
			/* default if last modified date doesn't exist (not an error) */
			remoteModifiedDate = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
		}
	}

    
   
    NSComparisonResult result = [remoteModifiedDate compare:localModifiedDate ];
     
   
    [self fadeCheckingLabel];
    [self checkingLabelToNormalState];
    
    if ((result == NSOrderedDescending) ||(remoteSize && (localFileSize<remoteSize))) {
        
        downloadLabel_.text=@"Update Available.";
        downloadCheckButton_.hidden=YES;
        downloadButton_.hidden=NO;
        downloadStopButton_.hidden=YES;
        downloadContinueButton_.hidden=YES;
 
    }
    else 
    {
         
        downloadLabel_.text=@"Current Version";
        downloadCheckButton_.hidden=NO;
        downloadButton_.hidden=YES;
        downloadStopButton_.hidden=YES;
        downloadContinueButton_.hidden=YES;
        [UIView beginAnimations:nil context: nil];
        [UIView setAnimationDuration:20.0];
        self.downloadLabel.alpha=(CGFloat)0;
        [UIView commitAnimations];
        
        
    }
    [checkingTimer_ invalidate];
    [connection cancel];
    connectionToDrugFile=nil;
    drugFileRequest=nil;
    
    self.connectingToFile=NO;
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.downloadCheckButton.enabled=YES;
    downloadCheckButton_.hidden=NO;
    downloadButton_.hidden=YES;
    downloadStopButton_.hidden=YES;
    downloadContinueButton_.hidden=YES;
	[checkingTimer_ invalidate];
    checkingTimer_=nil;
    downloadLabel_.text=@"Not Available";
    [UIView beginAnimations:nil context: nil];
    [UIView setAnimationDuration:20.0];
    self.downloadLabel.alpha=(CGFloat)0;
    [UIView commitAnimations];
    connectionToDrugFile=nil;
    drugFileRequest=nil;
    self.connectingToFile=NO;
    
}

//-(void)cancelButtonTapped{
//    
//    
//    
//    
//    
//    if(self.navigationController)
//	{
//		// check if self is the rootViewController
//		if([self.navigationController.viewControllers objectAtIndex:0] == self)
//		{
//			[self dismissModalViewControllerAnimated:YES];
//		}
//		else
//			[self.navigationController popViewControllerAnimated:YES];
//	}
//	else
//		[self dismissModalViewControllerAnimated:YES];
//    
//    
//}
//
//-(void)doneButtonTapped{
//    
//    
//    if (isInDetailSubview) {
//        SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:0];
//        
//        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
//            SCObjectSelectionSection *objectsSelectionSection=(SCObjectSelectionSection*)section;
//            
//            //DLog(@"test valie changed at index with cell index selected %i",[objectsSelectionSection.selectedItemIndex integerValue]) ;
//            if (clientObjectSelectionCell) {
//                
//                
//                
//                if ([objectsSelectionSection.selectedItemIndex integerValue]>=0&&[objectsSelectionSection.selectedItemIndex integerValue]<=objectsSelectionSection.items.count) {
//                    
//                    [clientObjectSelectionCell doneButtonTappedInDetailView:(NSManagedObject *)[objectsSelectionSection.items objectAtIndex:(NSInteger )[objectsSelectionSection.selectedItemIndex integerValue]] withValue:YES];
//                    clientObjectSelectionCell.hasChangedClients=TRUE;
//                }
//                else{
//                    
//                    [clientObjectSelectionCell doneButtonTappedInDetailView:nil withValue:NO];
//                    
//                }
//                
//                [clientObjectSelectionCell.ownerTableViewModel.viewController.view setNeedsDisplay];
//                
//                
//            } 
//        }
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
//    
//    
//}



-(IBAction)downloadButtonTapped:(id)sender{

   downloadLabel_.text=@"0\%";

    if (!self.downloadBar) {
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        CGRect frame;
        
        if ([SCUtilities is_iPad]) {
           frame=CGRectMake(0, 12, 400, 30);
        }
        else {
            frame=CGRectMake(0, 12, 115, 20);
        }
        
        
//        NSURL *drugsDirectory=(NSURL*)[appDelegate applicationDrugsDirectory];
//            self.downloadBar = [[UIDownloadBar alloc] initWithURL:[NSURL URLWithString:@"http://psycheweb.com/psytrack/dFiles/dFile-001.zpk"] saveToFolderPath:[appDelegate applicationDrugsPathString] progressBarFrame:frame
//                                         timeout:15 
//                                        delegate:self];
        
        
        objectsModel.enablePullToRefresh=NO;
        objectsModel.tableView.userInteractionEnabled=NO;
        self.searchBar.userInteractionEnabled=NO;
        
        self.connectingToFile=YES;
        // Create a URL Request and set the URL
        NSURL *url = [NSURL URLWithString:@"http://dl.dropbox.com/u/96148802/pt/dFile-001.zpk"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod: @"HEAD"];
        // Display the network activity indicator
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        // Perform the request on a new thread so we don't block the UI
        dispatch_queue_t downloadQueue = dispatch_queue_create("Download queue", NULL);
        dispatch_async(downloadQueue, ^{
            
            NSError* err = nil;
            NSHTTPURLResponse* rsp = nil;
            
            // Perform the request synchronously on this thread
            NSData *rspData = [NSURLConnection sendSynchronousRequest:request returningResponse:&rsp error:&err];
            
            // Once a response is received, handle it on the main thread in case we do any UI updates
            dispatch_async(dispatch_get_main_queue(), ^{
                // Hide the network activity indicator
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                
                if (rspData == nil || (err != nil && [err code] != noErr)) {
                    // If there was a no data received, or an error...
                    self.downloadLabel.text=@"Not Reachable";
                    [checkingTimer_ invalidate];
                    checkingTimer_=nil;
                    self.connectingToFile=NO;
                    [self checkingLabelToNormalState];
                    
                    downloadButton_.hidden=YES;
                    downloadStopButton_.hidden=YES;
                    downloadContinueButton_.hidden=YES;
                    downloadCheckButton_.hidden=NO;
                } else {
                    self.downloadBar = [[UIDownloadBar alloc] initWithURL:[NSURL URLWithString:@"http://dl.dropbox.com/u/96148802/pt/dFile-001.zpk"] saveToFolderPath:[appDelegate applicationDrugsPathString] progressBarFrame:frame
                                                                  timeout:15
                                                                 delegate:self];
                    
                    
                    
                    [self.view addSubview:self.downloadBar];
                    [self.view setNeedsDisplay];
                    
                    downloadButton_.hidden=YES;
                    downloadStopButton_.hidden=NO;
                    downloadContinueButton_.hidden=YES;
                    downloadCheckButton_.hidden=YES;
                    
                }
            });
        });
        

        
       
        
    }



}

-(IBAction)StopDownloadTapped:(id)sender{

   
    [self.downloadBar forceStop];
    objectsModel.enablePullToRefresh=YES;
    objectsModel.tableView.userInteractionEnabled=YES;
    self.searchBar.userInteractionEnabled=YES;
    downloadButton_.hidden=YES;
    downloadStopButton_.hidden=YES;
    downloadContinueButton_.hidden=NO;
    downloadCheckButton_.hidden=YES;
    [self.view setNeedsDisplay];

}

-(IBAction)ContinueDownloadTapped:(id)sender{
    objectsModel.enablePullToRefresh=NO;
    objectsModel.tableView.userInteractionEnabled=NO;
    self.searchBar.userInteractionEnabled=NO;
    
    [self.downloadBar forceContinue];
    
    downloadButton_.hidden=YES;
    downloadStopButton_.hidden=NO;
    downloadContinueButton_.hidden=YES;
    downloadCheckButton_.hidden=YES;
}





- (void)downloadBar:(UIDownloadBar *)downloadBar didFinishWithData:(NSData *)fileData suggestedFilename:(NSString *)filename {
	
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    [appDelegate displayNotification:@"Drug Database Download Complete." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];

   NSURL *drugsStoreURL = [[appDelegate applicationDrugsDirectory] URLByAppendingPathComponent:@"drugs.sqlite"];
    
    
    NSString *symetricString=@"8qfnbyfalVvdjf093uPmsdj30mz98fI6";
    NSData *symetricData=[symetricString dataUsingEncoding: [NSString defaultCStringEncoding] ];
    
    PTTEncryption *encryption=[[PTTEncryption alloc]init];
    NSData *decryptedData=nil;
    
    if (symetricData.length==32) {
         decryptedData=(NSData *) [encryption doCipher:fileData key:symetricData context:kCCDecrypt padding:(CCOptions *) kCCOptionECBMode];;
    }
   
    
        

    if ( decryptedData.length) {
        
        NSPersistentStoreCoordinator *drugsPersistentStoreCoordinator=(NSPersistentStoreCoordinator *)appDelegate.drugsPersistentStoreCoordinator;
        
        NSPersistentStore *drugsPersistentStore=[drugsPersistentStoreCoordinator persistentStoreForURL:drugsStoreURL];
        
        BOOL proceedWithAddingStore=YES;
        if (drugsPersistentStore) {
              NSError *error = nil;
            if (![drugsPersistentStoreCoordinator removePersistentStore:drugsPersistentStore error:&error]) {
                
                proceedWithAddingStore=NO;
               [appDelegate displayNotification:@"Unable to remove old drug database at this time. Try resarting the app or try again later."];
                
            }
            
            
        }
        BOOL fileWritten=   [decryptedData writeToURL:drugsStoreURL atomically:YES];
        NSFileManager *fileManager=[NSFileManager defaultManager];
        NSError *removeError=nil;
        if (fileWritten  && proceedWithAddingStore) {
            
            NSError *excludeBackupError = nil;
            
            BOOL result = [drugsStoreURL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&excludeBackupError];
            
            if (!result) { [appDelegate displayNotification:@"Error setting file attribute"]; }
            
            
            NSError *drugError = nil;
           
           
            if (result && ![drugsPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"DrugsConfig" URL:drugsStoreURL options:nil error:&drugError])
            {
                                if([appDelegate.managedObjectContext hasChanges]){
                
                    [appDelegate saveContext];
                
                
                }
               
                if (![fileManager removeItemAtURL:drugsStoreURL error:&removeError]){
                
                    [appDelegate displayNotification:[NSString stringWithFormat:@"Error Setting Up the Drug Database and removing bad file %@",removeError.description]];
                
                }
                else{
                    [appDelegate displayNotification:@"Error Setting Up the Drug Database, please restart"];
                }
            }
            else{
                for (NSManagedObject *managedObject in drugsManagedObjectContext.registeredObjects) {
                    [drugsManagedObjectContext refreshObject:managedObject mergeChanges:NO];
                }
            }
        
        }
            else
            {
            
                if (![fileManager removeItemAtURL:drugsStoreURL error:&removeError]){
                    
                    [appDelegate displayNotification:[NSString stringWithFormat:@"Error Setting Up the Drug Database and removing bad file %@",removeError.description]];
                    
                }
                else{
                    [appDelegate displayNotification:@"Problem with setting up drug database occured.  Please try again later or contact suppor"];
                }
                
            
            }
       
    }


else
{
    
[appDelegate displayNotification:@"Problem with setting up drug database occured.  Please try again later or contact suppor"];
    
}
    
   
    
    [self searchBar:(UISearchBar *)self.searchBar textDidChange:(NSString *)self.searchBar.text];
   
    self.downloadCheckButton.enabled=YES;
    
    self.searchBar.userInteractionEnabled=YES;
    downloadButton_.hidden=YES;
    downloadStopButton_.hidden=YES;
    downloadContinueButton_.hidden=YES;
    downloadCheckButton_.hidden=NO;
    self.connectingToFile=NO;
    [self.view setNeedsDisplay];
    [UIView beginAnimations:nil context: nil];
    [UIView setAnimationDuration:4.0];
    self.downloadLabel.alpha=(CGFloat)0;
    self.downloadBar.hidden=YES;
 
    [UIView commitAnimations];
    
    self.downloadBar=nil;
    
    encryption=nil;
}

- (void)downloadBar:(UIDownloadBar *)downloadBar didFailWithError:(NSError *)error {
	
    
    if (downloadBar_) {
        downloadBar.hidden=YES;
        self.downloadBar=nil;
    }
    
    downloadLabel_.text=@"Download Failed.";
    downloadButton_.hidden=YES;
    downloadStopButton_.hidden=YES;
    downloadContinueButton_.hidden=YES;
    downloadCheckButton_.hidden=NO;
    self.connectingToFile=NO;
    objectsModel.enablePullToRefresh=YES;
    objectsModel.tableView.userInteractionEnabled=YES;
    self.searchBar.userInteractionEnabled=YES;
    [self.view setNeedsDisplay];
    [UIView beginAnimations:nil context: nil];
    [UIView setAnimationDuration:20.0];
    self.downloadLabel.alpha=(CGFloat)0;
    [UIView commitAnimations];
    
    
}

- (void)downloadBarUpdated:(UIDownloadBar *)downloadBar {

   
  
   
    UINavigationItem *navigationItem=(UINavigationItem *)self.navigationItem;
    
    navigationItem.title=[NSString stringWithFormat:@"Drugs %0.1f MB", downloadBar.bytesReceived/1048576];;
    downloadLabel_.text=[NSString stringWithFormat:@"%0.0f \%%", downloadBar.percentComplete];



}




- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
   
    
    if (tableViewModel.tag==1 &&index==0) {
        if (section.cellCount<5) {
     
        SCObjectSelectionCell *drugActionDatesCell=[SCObjectSelectionCell cellWithText:@"USFDA Documents"];
//        drugActionDatesCell.delegate=self;
        drugActionDatesCell.tag=14;
        
        
        [section insertCell:drugActionDatesCell atIndex:4];
        
            
        }
    }
    
       
   
    
    if(section.headerTitle !=nil)
    {
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
        
        
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.text=section.headerTitle;
        [containerView addSubview:headerLabel];
        
        section.headerView = containerView;
        
        
        
    }
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
    if (tableViewModel.tag==0&&[section isKindOfClass:[SCObjectSelectionSection class]]) {
        
        //        SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection *)section;
        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        
        currentlySelectedDrug=(DrugProductEntity *)cell.boundObject;
        
        
        SCObjectSelectionSection *selectionSection=(SCObjectSelectionSection *)section;
        
        [selectionSection dispatchEventSelectRowAtIndexPath:indexPath];
        return;

    }
  
    
    SCTableViewCell *cell =(SCTableViewCell *) [tableViewModel cellAtIndexPath:indexPath];
    
    switch (cell.tag) {
                case 14:
        {
            
            
             
                
                
                
                
               
                
                
            
            
            
            
            
            
            
            
            
//            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
//            dispatch_async(queue, ^{
                
                
                
                self.tableView.userInteractionEnabled=FALSE;
                UITabBar *tabBar=(UITabBar *) [(PTTAppDelegate *)[UIApplication sharedApplication].delegate tabBar];
                tabBar.userInteractionEnabled=FALSE;               
                
                SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
            
            SCObjectSection *objectSection=nil;
                if ([section isKindOfClass:[SCObjectSection class]])
                    objectSection =(SCObjectSection *)section;
            
            
           
            if (objectSection) {
                NSManagedObject *drugObject=(NSManagedObject *)objectSection.boundObject;
                
                [drugObject willAccessValueForKey:@"applNo"];
                 drugApplNo=(NSString *)[objectSection.boundObject valueForKey:@"applNo"];
            }
            
            
                
                
                DrugActionDateViewController * drugActionDateViewController_iPhone = [[DrugActionDateViewController alloc] initWithNibName:@"DrugActionDateViewController" bundle:[NSBundle mainBundle] withApplNo:drugApplNo];
                
            PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
            
            
            
            if ([SCUtilities is_iPad]||[SCUtilities systemVersion]>=6) {
                //        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                
                
                UIColor *backgroundColor=nil;
                
                if(isInDetailSubview)
                {
                    //            backgroundImage=[UIImage imageNamed:@"iPad-background-blue.png"];
                    backgroundColor=(UIColor *)(UIWindow *)appDelegate.window.backgroundColor;
                    
                    
                    
                }
                else {
                    
                    
                    
                    backgroundColor=[UIColor clearColor];
                    
                    
                }
                
                if (drugActionDateViewController_iPhone.tableView.backgroundColor!=backgroundColor) {
                    
                    [drugActionDateViewController_iPhone.tableView setBackgroundView:nil];
                    UIView *view=[[UIView alloc]init];
                    [drugActionDateViewController_iPhone.tableView setBackgroundView:view];
                    [drugActionDateViewController_iPhone.tableView setBackgroundColor:backgroundColor];
                    
                    
                    
                    
                }
                
                
            }
                
                [self.navigationController pushViewController:drugActionDateViewController_iPhone animated:YES];
                
                tabBar.userInteractionEnabled=TRUE;
                self.tableView.userInteractionEnabled=TRUE;
                
                
//            });
            
            break;
        }    
            //        case 3:
            //        {
            //            TimeViewController *timeViewController_iPad = [[TimeViewController alloc] initWithNibName:@"TimeViewController" bundle:nil];
            //            
            //            [self.navigationController pushViewController:timeViewController_iPad animated:YES];
            //            break;
            //        }    
            
            
        default:
        {
            SCTableViewSection *section = [self.tableViewModel sectionAtIndex:0];
            if([section isKindOfClass:[SCArrayOfObjectsSection class]])
            {
                [(SCArrayOfObjectsSection *)section dispatchEventSelectRowAtIndexPath:indexPath];
            }
            
        }
            break;
    }
    
    
    
    
 
}

-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewDidDismissForRowAtIndexPath:(NSIndexPath *)indexPath{


    if (tableModel.tag==0) {
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        appDelegate.drugViewControllerIsInDetailSubview=NO;
    }

}
-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.drugViewControllerIsInDetailSubview=YES;
    
    if ([SCUtilities is_iPad]||[SCUtilities systemVersion]>=6) {
        //        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        UIColor *backgroundColor=nil;
        
        if(indexPath.row==NSNotFound|| tableModel.tag>0||isInDetailSubview)
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
