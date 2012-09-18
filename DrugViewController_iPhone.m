/*
 *  DrugViewController_iPhone.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
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
#import "SCArrayOfObjectsModel+CoreData+SelectionSection.h"

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
   
    
    
    
    if([SCUtilities is_iPad]){
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:backgroundColor]; // Make the table view transparent
    }
    
    self.view.backgroundColor=backgroundColor;

    
    CGFloat localDbBytes=(CGFloat )[self getLocalDrugFileSize];
    UINavigationItem *navigationItem=(UINavigationItem *)self.navigationItem;
    
    navigationItem.title=[NSString stringWithFormat:@"Drugs %0.1f MB", localDbBytes/1048576];
    
    
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
    

    
    
    
}

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
   
    objectsModel=nil;

    NSFetchRequest *newRequewst=[[NSFetchRequest alloc]init];
       
    filterPredicate=[NSPredicate predicateWithFormat:@"drugName contains [cd] %@",searchText];
    
    [newRequewst setPredicate:filterPredicate];
    
    [newRequewst setEntity:productEntityDesc];
       
    NSError *productError = nil;
    NSArray *productFetchedObjects;
    
    if ([drugsManagedObjectContext countForFetchRequest:newRequewst error:&productError]) {
        
        productFetchedObjects = [drugsManagedObjectContext executeFetchRequest:newRequewst error:&productError];
    
        
    }
       
    
    
    [objectsModel removeAllSections];
    if (isInDetailSubview) {
         objectsModel=[[SCArrayOfObjectsModel_UseSelectionSection alloc]initWithTableView:self.tableView items:[NSMutableArray arrayWithArray:productFetchedObjects] itemsDefinition:drugDef];
    

    }
    else {
        objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView items:[NSMutableArray arrayWithArray:productFetchedObjects] itemsDefinition:drugDef];
    }
    
       
	objectsModel.searchPropertyName = @"drugName";
	objectsModel.addButtonItem = self.addButton;
    
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
    objectsModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:1];
    objectsModel.delegate=self;
    SCCoreDataFetchOptions *dataFetchOptions=[[SCCoreDataFetchOptions alloc]initWithSortKey:@"drugName" sortAscending:YES filterPredicate:nil];
    
    
    objectsModel.autoAssignDelegateForDetailModels=YES;
    objectsModel.dataStore.storeMode=SCStoreModeAsynchronous;
    
    objectsModel.dataFetchOptions=dataFetchOptions;
    //    [objectsModel reloadBoundValues];
    
    self.tableViewModel = objectsModel;
    [self.tableViewModel reloadBoundValues];
   

    [objectsModel.modeledTableView reloadData];


    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    return YES;
    
}
-(IBAction)startCheckingForUpdate:(id)sender{


    self.downloadLabel.text=@"Checking";
    downloadLabel_.alpha=1.0;
    checkingTimer_  = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                           target:self
                                                     selector:@selector(flashCheckingLabel:)
                                                         userInfo:NULL
                                                          repeats:YES];


    [self connectToRemoteDrugFile];


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
        
        [UIView beginAnimations:nil context: nil];
        [UIView setAnimationDuration:1.5];
        self.downloadLabel.alpha=(CGFloat)0.4;
        [UIView commitAnimations];
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

   
  
    
    
    NSTimeInterval timeout=10.0;
    NSURL *remoteFileURL=[NSURL URLWithString:@"https://psytrack.com/dFiles/dFile-001.zpk"];
    
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:remoteFileURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeout];

    
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:remoteFileURL cachePolicy:nsurl timeoutInterval:timeout];
    NSURLConnection *connectionToDrugFile = [NSURLConnection connectionWithRequest:request delegate:self];

    [connectionToDrugFile start];

   
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
   
    CGFloat remoteSize = [[NSString stringWithFormat:@"%lli",[response expectedContentLength]] floatValue];
    
    
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
		
		}
		else {
			/* default if last modified date doesn't exist (not an error) */
			remoteModifiedDate = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
		}
	}

    
   
    NSComparisonResult result = [remoteModifiedDate compare:localModifiedDate ];
     
   
    
    
    
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
    connection=nil;
    
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[checkingTimer_ invalidate];
    checkingTimer_=nil;
    downloadLabel_.text=@"Not Available";
    [UIView beginAnimations:nil context: nil];
    [UIView setAnimationDuration:20.0];
    self.downloadLabel.alpha=(CGFloat)0;
    [UIView commitAnimations];

    
    
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
            self.downloadBar = [[UIDownloadBar alloc] initWithURL:[NSURL URLWithString:@"http://psycheweb.com/psytrack/dFiles/dFile-001.zpk"] saveToFolderPath:[appDelegate applicationDrugsPathString] progressBarFrame:frame
                                         timeout:15 
                                        delegate:self];
        
        [self.view addSubview:self.downloadBar];
        [self.view setNeedsDisplay];
        
        downloadButton_.hidden=YES;
        downloadStopButton_.hidden=NO;
        downloadContinueButton_.hidden=YES;
        downloadCheckButton_.hidden=YES;
        
    }



}

-(IBAction)StopDownloadTapped:(id)sender{


    [self.downloadBar forceStop];
    
    downloadButton_.hidden=YES;
    downloadStopButton_.hidden=YES;
    downloadContinueButton_.hidden=NO;
    downloadCheckButton_.hidden=YES;
    [self.view setNeedsDisplay];

}

-(IBAction)ContinueDownloadTapped:(id)sender{
    
    
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
   
    
    if (decryptedData.length) {
         [decryptedData writeToURL:drugsStoreURL atomically:YES];
    }
   
    

    if (drugsManagedObjectContext) {
        drugsManagedObjectContext=nil;


//        NSPersistentStore *persistentStore=(NSPersistentStore *)[appDelegate.drugsPersistentStoreCoordinator.persistentStores objectAtIndex:0];
        
//        NSError *error;
//        [appDelegate.drugsPersistentStoreCoordinator removePersistentStore:(NSPersistentStore *)persistentStore error:&error ];
//        
//        if (![drugsManagedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"DrugsConfig" URL:drugsStoreURL options:nil error:&error])
//        {
//            
//        }   
//        drugsManagedObjectContext=nil;
//        NSManagedObjectModel *drugModel=(NSManagedObjectModel *)[appDelegate drugsManagedObjectModel];
//        drugModel=nil;
//        
//        drugsManagedObjectContext=nil;
//        drugsManagedObjectContext=(NSManagedObjectContext *)[appDelegate drugsManagedObjectContext];
//        [drugModel awakeFromNib];
//        [appDelegate drugsManagedObjectModel]=nil;
//        [drugsManagedObjectContext setMergePolicy:NSMergeByPropertyStoreTrumpMergePolicy];

        [appDelegate resetDrugsModel];
        
        drugsManagedObjectContext=(NSManagedObjectContext *)[appDelegate drugsManagedObjectContext];
//        NSEntityDescription *productEntityDesc=[NSEntityDescription entityForName:@"DrugProductEntity" inManagedObjectContext:drugsManagedObjectContext];
        
       
//        NSFetchRequest *productFetchRequest = [[NSFetchRequest alloc] init];
//        
//        
//        
//        [productFetchRequest setEntity:productEntityDesc];
//    
//        
//        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"drugName"
//                                                                       ascending:YES];
//        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//        [productFetchRequest setSortDescriptors:sortDescriptors];
////        
//        
//        NSError *productError = nil;
//        NSArray *productFetchedObjects = [drugsManagedObjectContext executeFetchRequest:productFetchRequest error:&productError];
//        
//        drugsMutableArray=[NSMutableArray arrayWithArray:productFetchedObjects];
//        productFetchedObjects=nil;
//        
//        
//        NSArray *itemsArray=(NSArray *)tableModel.items;
//        itemsArray=drugsMutableArray;
        
    } 
    objectsModel=nil;
    self.tableViewModel=nil;
    [self viewDidLoad];
    [objectsModel reloadBoundValues];
    [self.tableView reloadData];
    
    downloadButton_.hidden=YES;
    downloadStopButton_.hidden=YES;
    downloadContinueButton_.hidden=YES;
    downloadCheckButton_.hidden=NO;
    [self.view setNeedsDisplay];
    [UIView beginAnimations:nil context: nil];
    [UIView setAnimationDuration:4.0];
    self.downloadLabel.alpha=(CGFloat)0;
    self.downloadBar.hidden=YES;
 
    [UIView commitAnimations];
    self.downloadBar=nil;
    
    
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
     
        SCObjectSelectionCell *drugActionDatesCell=[SCObjectSelectionCell cellWithText:@"Drug Documents"];
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
                
                drugApplNo=(NSString *)[section.boundObject valueForKey:@"applNo"];
                
                
                DrugActionDateViewController * drugActionDateViewController_iPhone = [[DrugActionDateViewController alloc] initWithNibName:@"DrugActionDateViewController" bundle:[NSBundle mainBundle] withApplNo:drugApplNo];
                
            PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
            
            
            
            if ([SCUtilities is_iPad]) {
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
-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    if ([SCUtilities is_iPad]) {
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
