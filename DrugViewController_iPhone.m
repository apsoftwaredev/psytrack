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
#import "CustomSCSelectonCellWithLoading.h"


@implementation DrugViewController_iPhone
@synthesize searchBar;
@synthesize tableView;
@synthesize downloadBar=downloadBar_;
@synthesize downloadButton=downloadButton_;
@synthesize downloadStopButton=downloadStopButton_;
@synthesize downloadLabel= downloadLabel_;
@synthesize downloadContinueButton=downloadContinueButton_;
@synthesize downloadCheckButton=downloadCheckButton_;
@synthesize checkingTimer=checkingTimer_;
@synthesize downloadBytesLabel=downloadBytesLabel_;
@synthesize drugObjectSelectionCell=drugObjectSelectionCell_;
@synthesize tableModel;
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



-(id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(DrugNameObjectSelectionCell*)objectSelectionCell sendingViewController:(UIViewController *)viewController{
    
    self=[super initWithNibName:nibName bundle:bundle];
    
    
    isInDetailSubview=detailSubview;
    self.drugObjectSelectionCell=objectSelectionCell;
    
    sendingViewController=viewController;
    
    
    return self;
    
} 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Gracefully handle reloading the view controller after a memory warning
    tableModel = (SCArrayOfObjectsModel *)[[SCModelCenter sharedModelCenter] modelForViewController:self];
    if(tableModel)
    {
        [tableModel replaceModeledTableViewWith:self.tableView];
        return;
   }
   
	
    // Set up the edit and add buttons.
    
    
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
    
    
	self.tableView.backgroundColor=[UIColor clearColor];
    
    drugsManagedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate drugsManagedObjectContext];
    //Create a class definition for Client entity
	
    SCClassDefinition *drugDef = [SCClassDefinition definitionWithEntityName:@"DrugProductEntity" 
                                      withManagedObjectContext:drugsManagedObjectContext 
                                             withPropertyNames:[NSArray arrayWithObject: @"tECode"]];
    
    
    
    
    //create the dictionary with the data bindings
    NSDictionary *customCellDrugNameDataBindings = [NSDictionary 
                                                    dictionaryWithObjects:[NSArray arrayWithObjects:@"drugName",@"Drug Name", @"drugName",    nil] 
                                                    forKeys:[NSArray arrayWithObjects:@"1" ,@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag
	
    //create the custom property definition
    SCCustomPropertyDefinition *drugNameDataDataProperty = [SCCustomPropertyDefinition definitionWithName:@"DrugNameData"
                                                                                     withuiElementNibName:@"CustomSCTextViewCell_iPhone" 
                                                                                       withObjectBindings:customCellDrugNameDataBindings];
	
    
    
    //insert the custom property definition into the drugsDef class at index 0
    [drugDef insertPropertyDefinition:drugNameDataDataProperty atIndex:0];
    
    //create the dictionary with the data bindings
    NSDictionary *customCellActiveIngredientDataBindings = [NSDictionary 
                                                            dictionaryWithObjects:[NSArray arrayWithObjects:@"activeIngredient",@"Active Ingredient", @"activeIngredient",    nil] 
                                                            forKeys:[NSArray arrayWithObjects:@"1" ,@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag
	
    //create the custom property definition
    SCCustomPropertyDefinition *activeIngredientDataProperty = [SCCustomPropertyDefinition definitionWithName:@"ActiveIngredientData"
                                                                                         withuiElementNibName:@"CustomSCTextViewCell_iPhone" 
                                                                                           withObjectBindings:customCellActiveIngredientDataBindings];
	
    
    
    //insert the custom property definition into the drugsDef class at index 1
    [drugDef insertPropertyDefinition:activeIngredientDataProperty atIndex:1];
    
    //create the dictionary with the data bindings
    NSDictionary *dosageDataBindings = [NSDictionary 
                                        dictionaryWithObjects:[NSArray arrayWithObjects:@"dosage",@"Dosage", @"dosage",    nil] 
                                        forKeys:[NSArray arrayWithObjects:@"1" ,@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag
	
    //create the custom property definition
    SCCustomPropertyDefinition *dosageDataProperty = [SCCustomPropertyDefinition definitionWithName:@"dosageData"
                                                                               withuiElementNibName:@"CustomSCTextViewCell_iPhone" 
                                                                                 withObjectBindings:dosageDataBindings];
	
    
    
    //insert the custom property definition into the drugsDef class at index 3
    [drugDef insertPropertyDefinition:dosageDataProperty atIndex:2];
    
    
    //create the dictionary with the data bindings
    NSDictionary *formDataBindings = [NSDictionary 
                                      dictionaryWithObjects:[NSArray arrayWithObjects:@"form",@"Form", @"form",    nil] 
                                      forKeys:[NSArray arrayWithObjects:@"1" ,@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag
	
    //create the custom property definition
    SCCustomPropertyDefinition *formDataProperty = [SCCustomPropertyDefinition definitionWithName:@"FormData"
                                                                             withuiElementNibName:@"CustomSCTextViewCell_iPhone" 
                                                                               withObjectBindings:formDataBindings];
	
    
    
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
    if (drugsManagedObjectContext) {
   
    NSEntityDescription *productEntityDesc=[NSEntityDescription entityForName:@"DrugProductEntity" inManagedObjectContext:drugsManagedObjectContext];
    
    
    NSFetchRequest *productFetchRequest = [[NSFetchRequest alloc] init];
   
    
    
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
    drugsMutableArray=[NSMutableArray arrayWithArray:productFetchedObjects];
    productFetchedObjects=nil;
    } 
    
    // Instantiate the tabel model
    
//    tableModel = [[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView withViewController:self];    
//    
//    
//    
//    
   
    
    
    
    if (isInDetailSubview) {
        
//         NSPredicate *currentClientsPredicate=[NSPredicate predicateWithFormat:@"applNo MATCHES %@",drugObjectSelectionCell_.d];
//        
//        tableModel=[[SCArrayOfObjectsModel alloc]tableViewModelWithTableView:(UITableView *)self.tableView
//                                                          withViewController:(UIViewController *)self
//                                                                   withItems:(NSMutableArray *)drugsMutableArray
//                                                         withClassDefinition:(SCClassDefinition *)classDefinition
//                                                       useSCSelectionSection:(BOOL)_useSCSelectionSection];
//        
       tableModel = [[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView withViewController:self withItems:drugsMutableArray withClassDefinition:drugDef useSCSelectionSection:YES];	
        
//        [self.searchBar setSelectedScopeButtonIndex:1];
       
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
        
        
        UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped)];
        [buttons addObject:doneButton];
        
        // create a spacer
        UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
        [buttons addObject:editButton];
        
//        [self editButtonItem];
        
        
        // create a standard "add" button
//        UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
//                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:NULL];
//        addButton.style = UIBarButtonItemStyleBordered;
//        [buttons addObject:addButton];
//        
        
        
        // stick the buttons in the toolbar
        self.navigationItem.rightBarButtonItems=buttons;
        self.tableModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:1];
        
        
        UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped)];
        
        self.navigationItem.leftBarButtonItem=cancelButton;
        
        
    }
    else
    {
        
       	tableModel = [[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView withViewController:self withItems:drugsMutableArray withClassDefinition:drugDef];	
	
//        self.navigationItem.leftBarButtonItem = self.editButtonItem;
//        self.tableModel.editButtonItem = self.navigationItem.leftBarButtonItem;
////        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
//        self.navigationItem.rightBarButtonItem = self.editButtonItem;
//        self.tableModel.addButtonItem = self.navigationItem.rightBarButtonItem;
        
    }

    tableModel.searchBar = self.searchBar;
	tableModel.searchPropertyName = @"drugName;activeIngredient";
    
    tableModel.allowAddingItems=FALSE;
    tableModel.allowDeletingItems=FALSE;
    tableModel.allowMovingItems=FALSE;
    
    tableModel.autoAssignDelegateForDetailModels=TRUE;
    tableModel.autoAssignDataSourceForDetailModels=TRUE;
    
//    
//     // Initialize tableModel
//       
    //	
    
    // Initialize tableModel
//    if (isInDetailSubview) {
//        
//        
//        
//        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
//        
//        
//        UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped)];
//        [buttons addObject:doneButton];
//        
//        // create a spacer
//        UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
//                                       initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
//        [buttons addObject:editButton];
//        
//        [self editButtonItem];
//        
//        
//        // create a standard "add" button
//        UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
//                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:NULL];
//        addButton.style = UIBarButtonItemStyleBordered;
//        [buttons addObject:addButton];
//        
//        
//        
//        // stick the buttons in the toolbar
//        self.navigationItem.rightBarButtonItems=buttons;
//        self.tableModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:1];
//        self.tableModel.addButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:2];
//        
//        UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped)];
//        
//        self.navigationItem.leftBarButtonItem=cancelButton;
//        
//        
//    }
//    else
//    {
//        if (self.navigationItem.rightBarButtonItems.count>1) {
//            
//            tableModel.addButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:1];
//        }
//        
//        
//        
//        if (self.navigationItem.rightBarButtonItems.count >0)
//        {
//            tableModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:0];
//        }
//        
//
//        
//    }
    
    
    
    if([SCHelper is_iPad]){
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    }
    
    
//    [self updateClientsTotalLabel];
    
//    [(PTTAppDelegate *)[UIApplication sharedApplication].delegate application:[UIApplication sharedApplication]
//                                               willChangeStatusBarOrientation:[[UIApplication sharedApplication] statusBarOrientation]
//                                                                     duration:5];
//    
    
//    [self startCheckingForUpdate];
    
    
//    self.downloadLabel.text=@"Checking...";
//   
//    [checkingTimer_ invalidate];
//    checkingTimer_=nil;
//    checkingTimer_  = [NSTimer scheduledTimerWithTimeInterval:2.5
//                                                           target:self
//                                                     selector:@selector(flashCheckingLabel:)
//                                                         userInfo:NULL
//                                                          repeats:YES];
 

    
//   self.downloadBytesLabel.hidden=NO;
//   self.downloadBytesLabel.text=@"100\%";
//    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:1];
//    // create a spacer
//    //    UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
//    //                                   initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
//    
//    
//    
//    // create a standard "add" button
//    [buttons addObject:self.downloadBytesLabel];
//    
//    self.navigationItem.rightBarButtonItems=buttons;

    
    CGFloat localDbBytes=(CGFloat )[self getLocalDrugFileSize];
    UINavigationItem *navigationItem=(UINavigationItem *)self.navigationItem;
    
    navigationItem.title=[NSString stringWithFormat:@"Drugs %0.1f MB", localDbBytes/1048576];;
    

    
    
    
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
        SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:0];
        NSLog(@"section class is %@",[section class]);
        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
            SCObjectSelectionSection *objectsSelectionSection=(SCObjectSelectionSection*)section;
            
            //            NSLog(@"test valie changed at index with cell index selected %i",[objectsSelectionSection.selectedItemIndex integerValue]) ;
            //            if (clientObjectSelectionCell) {
            
            //                NSLog(@"objectsSelectionSection.selectedItemsIndexes.count %i",objectsSelectionSection.items.count);
            
            //                if ([objectsSelectionSection.selectedItemIndex integerValue]>=0&&[objectsSelectionSection.selectedItemIndex integerValue]<=objectsSelectionSection.items.count) {
            //                    
            NSIndexPath *cellIndexPath=objectsSelectionSection.selectedCellIndexPath;
            
            SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:cellIndexPath];
            NSLog(@"cell bound object in clients view controller at done %@",cell.boundObject);
            
            
            
            NSLog(@"selected item index%@",objectsSelectionSection.selectedItemIndex);
            
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
            
            NSLog(@"drugFile Size %@",lastModifiedDate);
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
            
            NSLog(@"drugFile Size %f",drugFileSize);
		}
		else {
			error=[NSError errorWithDomain:@"Error Getting Drug File Size" code:1 userInfo:nil];
		}
	}
    return drugFileSize;
}


- (void) connectToRemoteDrugFile{

   
  
    
    
    NSTimeInterval timeout=10.0;
    NSURL *remoteFileURL=[NSURL URLWithString:@"http://psycheweb.com/psytrack/dFiles/dFile-001.zpk"];
    
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:remoteFileURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeout];

    
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:remoteFileURL cachePolicy:nsurl timeoutInterval:timeout];
    NSURLConnection *connectionToDrugFile = [NSURLConnection connectionWithRequest:request delegate:self];

    [connectionToDrugFile start];

   
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
   
    CGFloat remoteSize = [[NSString stringWithFormat:@"%lli",[response expectedContentLength]] floatValue];
    NSLog(@"Remote Size : %f",remoteSize);
    
    [checkingTimer_ invalidate];
    checkingTimer_=nil;
    CGFloat localFileSize=[self getLocalDrugFileSize];
    NSLog(@"local size %f",localFileSize);
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
     NSLog(@"remote modified date islocal modifire date is %d",result);
   NSLog(@"remote date is %@",remoteModifiedDate);
    NSLog(@"local date is %@",localModifiedDate);
    
    
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
//    NSLog(@"cancel button Tapped");
//    
//    NSLog(@"parent controller %@",[super parentViewController]);
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
//    NSLog(@"done Button tapped");
//    if (isInDetailSubview) {
//        SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:0];
//        NSLog(@"section class is %@",[section class]);
//        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
//            SCObjectSelectionSection *objectsSelectionSection=(SCObjectSelectionSection*)section;
//            
//            NSLog(@"test valie changed at index with cell index selected %i",[objectsSelectionSection.selectedItemIndex integerValue]) ;
//            if (clientObjectSelectionCell) {
//                
//                NSLog(@"objectsSelectionSection.selectedItemsIndexes.count %i",objectsSelectionSection.items.count);
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
        
        if ([SCHelper is_iPad]) {
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
	NSLog(@"%@", filename);
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    [appDelegate displayNotification:@"Drug Database Download Complete." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];

   NSURL *drugsStoreURL = [[appDelegate applicationDrugsDirectory] URLByAppendingPathComponent:@"drugs.sqlite"];
    NSLog(@"drugsstore url is %@",drugsStoreURL);
    
    NSString *symetricString=@"8qfnbyfalVvdjf093uPmsdj30mz98fI6";
    NSData *symetricData=[symetricString dataUsingEncoding: [NSString defaultCStringEncoding] ];
    
    NSData *decryptedData=[appDelegate decryptDataToPlainData:fileData usingSymetricKey:symetricData];
    
    if (decryptedData.length) {
         [decryptedData writeToURL:drugsStoreURL atomically:YES];
    }
   
    

    if (drugsManagedObjectContext) {
//        drugsManagedObjectContext=nil;
        NSLog(@"drugs persistent stores %@",drugsManagedObjectContext.persistentStoreCoordinator.persistentStores);
        
//        NSPersistentStore *persistentStore=(NSPersistentStore *)[appDelegate.drugsPersistentStoreCoordinator.persistentStores objectAtIndex:0];
//        
//        NSError *error;
//        [appDelegate.drugsPersistentStoreCoordinator removePersistentStore:(NSPersistentStore *)persistentStore error:&error ];
//        
//        if (![drugsManagedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"DrugsConfig" URL:drugsStoreURL options:nil error:&error])
//        {
//            NSLog(@"unalbe to load persistent store");
//        }   
//        drugsManagedObjectContext=nil;
//        NSManagedObjectModel *drugModel=(NSManagedObjectModel *)[appDelegate drugsManagedObjectModel];
//        drugModel=nil;
//        
////        drugsManagedObjectContext=nil;
        drugsManagedObjectContext=(NSManagedObjectContext *)[appDelegate drugsManagedObjectContext];
//        [drugModel awakeFromNib];
//        [appDelegate drugsManagedObjectModel]=nil;
//        [drugsManagedObjectContext setMergePolicy:NSMergeByPropertyStoreTrumpMergePolicy];

        [appDelegate resetDrugsModel];
        
        drugsManagedObjectContext=(NSManagedObjectContext *)[appDelegate drugsManagedObjectContext];
        NSEntityDescription *productEntityDesc=[NSEntityDescription entityForName:@"DrugProductEntity" inManagedObjectContext:drugsManagedObjectContext];
        
        
        NSFetchRequest *productFetchRequest = [[NSFetchRequest alloc] init];
        
        
        
        [productFetchRequest setEntity:productEntityDesc];
    
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"drugName"
                                                                       ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        [productFetchRequest setSortDescriptors:sortDescriptors];
//        
        
        NSError *productError = nil;
        NSArray *productFetchedObjects = [drugsManagedObjectContext executeFetchRequest:productFetchRequest error:&productError];
        
        drugsMutableArray=[NSMutableArray arrayWithArray:productFetchedObjects];
        productFetchedObjects=nil;
        
        
        
        tableModel.items=drugsMutableArray;
        NSLog(@"drugsMutable array count is %i",drugsMutableArray.count);
    } 
    
    
     
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




- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSInteger)index
{
    
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
    
    NSLog(@"cell count is %i",section.cellCount);
    if (tableViewModel.tag==1 &&index==0) {
        if (section.cellCount<5) {
     
        CustomSCSelectonCellWithLoading *drugActionDatesCell=[CustomSCSelectonCellWithLoading cellWithText:@"Drug Documents" withBoundKey:@"drugActionDates" withValue:nil];
        drugActionDatesCell.delegate=self;
        drugActionDatesCell.tag=14;
        
        
        [section insertCell:drugActionDatesCell atIndex:4];
        
            
        }
    }
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
    if (tableViewModel.tag==0&&[section isKindOfClass:[SCObjectSelectionSection class]]) {
        
        //        SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection *)section;
        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        
        currentlySelectedDrug=(DrugProductEntity *)cell.boundObject;
        NSLog(@"currently selected client is %@",currentlySelectedDrug);
        
        SCObjectSelectionSection *selectionSection=(SCObjectSelectionSection *)section;
        
        [selectionSection dispatchSelectRowAtIndexPathEvent:indexPath];
        return;

    }
  
    
    SCTableViewCell *cell =(SCTableViewCell *) [tableViewModel cellAtIndexPath:indexPath];
    
    switch (cell.tag) {
                case 14:
        {
            
            if ([cell isKindOfClass:[CustomSCSelectonCellWithLoading class]]) {
                CustomSCSelectonCellWithLoading * loadingCell=(CustomSCSelectonCellWithLoading *)cell;
                loadingCell.imageView.hidden=FALSE;
            }
            
            
            
            
            
            
            
            
            
            
//            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
//            dispatch_async(queue, ^{
                
                NSLog(@"beginning dispach 2");
                
                self.tableView.userInteractionEnabled=FALSE;
                UITabBar *tabBar=(UITabBar *) [(PTTAppDelegate *)[UIApplication sharedApplication].delegate tabBar];
                tabBar.userInteractionEnabled=FALSE;               
                
                SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
                
                NSManagedObject *sectionManagedObject=(NSManagedObject *)section.boundObject;
                NSLog(@"section managed object%@",sectionManagedObject);
                
                NSString *drugApplNo=(NSString *)[section.boundObject valueForKey:@"applNo"];
                
                NSLog(@"applNo is %@",drugApplNo);
                DrugActionDateViewController * drugActionDateViewController_iPhone = [[DrugActionDateViewController alloc] initWithNibName:@"DrugActionDateViewController" bundle:[NSBundle mainBundle] withApplNo:drugApplNo];
                
                
                
                [self.navigationController pushViewController:drugActionDateViewController_iPhone animated:YES];
                
                if ([cell isKindOfClass:[CustomSCSelectonCellWithLoading class]]) {
                    CustomSCSelectonCellWithLoading * loadingCell=(CustomSCSelectonCellWithLoading *)cell;
                    loadingCell.imageView.hidden=TRUE;
                    [loadingCell setSelected:FALSE];
                    [loadingCell setHighlighted:FALSE animated:YES];
                    
                }
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
            SCTableViewSection *section = [tableModel sectionAtIndex:0];
            if([section isKindOfClass:[SCArrayOfObjectsSection class]])
            {
                [(SCArrayOfObjectsSection *)section dispatchSelectRowAtIndexPathEvent:indexPath];
            }
            
        }
            break;
    }
    
    
    
    
 
}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{

    if([SCHelper is_iPad]&&detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
        

        [detailTableViewModel.modeledTableView setBackgroundView:nil];
        [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
        [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    }



}

@end
