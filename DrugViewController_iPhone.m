/*
 *  DrugViewController_iPhone.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.2
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
#import "ButtonCell.h"
#import "PTTEncryption.h"
#import "SCArrayOfObjectsModel_UseSelectionSection.h"

@implementation DrugViewController_iPhone
@synthesize searchBar;

@synthesize downloadBar = downloadBar_;
@synthesize downloadButton = downloadButton_;
@synthesize downloadStopButton = downloadStopButton_;
@synthesize downloadLabel = downloadLabel_;
@synthesize downloadContinueButton = downloadContinueButton_;
@synthesize downloadCheckButton = downloadCheckButton_;
@synthesize checkingTimer = checkingTimer_;
@synthesize downloadBytesLabel = downloadBytesLabel_;
@synthesize drugObjectSelectionCell = drugObjectSelectionCell_;
@synthesize connectingToFile;

NSString *const kRemoteFileDownloadLinkStr_USStandard = @"https://s3.amazonaws.com/psytrack-for-usstandard-AKIAJQSJKX3M6UKHR3RA/dFile-001.zpk";

NSString *const kBucketName = @"psytrack";

NSString *const kRemoteFileName = @"dFile-001.zpk";

#pragma mark -
#pragma mark View lifecycle

- (id) initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(DrugNameObjectSelectionCell *)objectSelectionCell sendingViewController:(UIViewController *)viewController applNo:(NSString *)applicationNumber productNo:(NSString *)productNumber
{
    self = [super initWithNibName:nibName bundle:bundle];

    drugApplNo = applicationNumber;
    drugProductNo = productNumber;

    isInDetailSubview = detailSubview;
    self.drugObjectSelectionCell = objectSelectionCell;

    sendingViewController = viewController;

    return self;
}


- (void) viewDidLoad
{
    [super viewDidLoad];

    drugsManagedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate drugsManagedObjectContext];
    //Create a class definition for Client entity

    drugDef = [SCEntityDefinition definitionWithEntityName:@"DrugProductEntity"
                                      managedObjectContext:drugsManagedObjectContext
                                             propertyNames:[NSArray arrayWithObject:@"tECode"]];

//    //create the dictionary with the data bindings
    NSDictionary *customCellDrugNameDataBindings = [NSDictionary
                                                    dictionaryWithObjects:[NSArray arrayWithObjects:@"drugName",@"Drug Name", @"drugName",    nil]
                                                                  forKeys:[NSArray arrayWithObjects:@"1",@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag

    //create the custom property definition
    SCCustomPropertyDefinition *drugNameDataDataProperty = [SCCustomPropertyDefinition definitionWithName:@"DrugNameData"
                                                                                         uiElementNibName:@"CustomSCTextViewCell_iPhone"
                                                                                           objectBindings:customCellDrugNameDataBindings];

    //insert the custom property definition into the drugsDef class at index 0
    [drugDef insertPropertyDefinition:drugNameDataDataProperty atIndex:0];

    //create the dictionary with the data bindings
    NSDictionary *customCellActiveIngredientDataBindings = [NSDictionary
                                                            dictionaryWithObjects:[NSArray arrayWithObjects:@"activeIngredient",@"Active Ingredient", @"activeIngredient",    nil]
                                                                          forKeys:[NSArray arrayWithObjects:@"1",@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag

    //create the custom property definition
    SCCustomPropertyDefinition *activeIngredientDataProperty = [SCCustomPropertyDefinition definitionWithName:@"ActiveIngredientData"
                                                                                             uiElementNibName:@"CustomSCTextViewCell_iPhone"
                                                                                               objectBindings:customCellActiveIngredientDataBindings];

    //insert the custom property definition into the drugsDef class at index 1
    [drugDef insertPropertyDefinition:activeIngredientDataProperty atIndex:1];

    SCCustomPropertyDefinition *lookUpActivieIngredientButtonProperty = [SCCustomPropertyDefinition definitionWithName:@"LookUpActiveIngredientButton" uiElementClass:[ButtonCell class] objectBindings:nil];

    lookUpActivieIngredientButtonProperty.cellActions.willConfigure = ^(SCTableViewCell *cell, NSIndexPath *indexPath)
    {
        if ([cell isKindOfClass:[ButtonCell class]])
        {
            ButtonCell *buttonCell = (ButtonCell *)cell;

            buttonCell.buttonText = @"Look Up Drugs with Active Ingredient";

            [buttonCell reloadBoundValue];
        }

        cell.tag = 400;
    };

    [drugDef insertPropertyDefinition:lookUpActivieIngredientButtonProperty atIndex:2];

    //create the dictionary with the data bindings
    NSDictionary *dosageDataBindings = [NSDictionary
                                        dictionaryWithObjects:[NSArray arrayWithObjects:@"dosage",@"Dosage", @"dosage",    nil]
                                                      forKeys:[NSArray arrayWithObjects:@"1",@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag

    //create the custom property definition
    SCCustomPropertyDefinition *dosageDataProperty = [SCCustomPropertyDefinition definitionWithName:@"dosageData"
                                                                                   uiElementNibName:@"CustomSCTextViewCell_iPhone"
                                                                                     objectBindings:dosageDataBindings];

    //insert the custom property definition into the drugsDef class at index 3
    [drugDef insertPropertyDefinition:dosageDataProperty atIndex:3];

    //create the dictionary with the data bindings
    NSDictionary *formDataBindings = [NSDictionary
                                      dictionaryWithObjects:[NSArray arrayWithObjects:@"form",@"Form", @"form",    nil]
                                                    forKeys:[NSArray arrayWithObjects:@"1",@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag

    //create the custom property definition
    SCCustomPropertyDefinition *formDataProperty = [SCCustomPropertyDefinition definitionWithName:@"FormData"
                                                                                 uiElementNibName:@"CustomSCTextViewCell_iPhone"
                                                                                   objectBindings:formDataBindings];

    //insert the custom property definition into the drugsDef class at index 3
    [drugDef insertPropertyDefinition:formDataProperty atIndex:4];

    int indexofTECode = [drugDef indexOfPropertyDefinitionWithName:@"tECode"];
    [drugDef removePropertyDefinitionAtIndex:indexofTECode];

    drugDef.titlePropertyName = @"drugName;dosage";

    drugDef.keyPropertyName = @"drugName";
    productEntityDesc = [NSEntityDescription entityForName:@"DrugProductEntity" inManagedObjectContext:drugsManagedObjectContext];

    productFetchRequest = [[NSFetchRequest alloc] init];
    filterPredicate = [NSPredicate predicateWithFormat:@"drugName== nil"];

    [productFetchRequest setPredicate:filterPredicate];

    [productFetchRequest setEntity:productEntityDesc];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"drugName"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];

    [productFetchRequest setSortDescriptors:sortDescriptors];

    NSError *productError = nil;
    NSArray *productFetchedObjects;

    if ([drugsManagedObjectContext countForFetchRequest:productFetchRequest error:&productError])
    {
        productFetchedObjects = [drugsManagedObjectContext executeFetchRequest:productFetchRequest error:&productError];
    }

    NSMutableArray *mutableDrugsArray = nil;
    if (productFetchedObjects)
    {
        mutableDrugsArray = [NSMutableArray arrayWithArray:productFetchedObjects];
    }

    if (objectsModel)
    {
        objectsModel = nil;
    }

    if (!isInDetailSubview)
    {
        objectsModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView];
    }
    else if (isInDetailSubview)
    {
        objectsModel = [[SCArrayOfObjectsModel_UseSelectionSection alloc] initWithTableView:self.tableView];
        NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:2];

        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(myDoneButtonTapped)];
        [buttons addObject:doneButton];

        // create a spacer
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
        [buttons addObject:editButton];

        [self editButtonItem];

        // stick the buttons in the toolbar
        self.navigationItem.rightBarButtonItems = buttons;
        objectsModel.editButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:1];

        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(myCancelButtonTapped)];

        self.navigationItem.leftBarButtonItem = cancelButton;
    }

    drugDef.cellActions.customButtonTapped = ^(SCTableViewCell *cell, NSIndexPath *indexPath, UIButton *button)
    {
        if (button.tag == 300)
        {
            SCViewController *scViewController = (SCViewController *)cell.ownerTableViewModel.viewController;
            objectsModel.modeledTableView.userInteractionEnabled = NO;
            self.searchBar.userInteractionEnabled = NO;
            [scViewController cancelButtonAction];

            //give it time to complete the animations
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,
                                                    1.0f * NSEC_PER_SEC);

            dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                           {
                               NSString *activeIngredientStr = (NSString *)[cell.boundObject valueForKey:@"activeIngredient"];

                               [self.searchBar setText:activeIngredientStr];
                               [self searchBar:self.searchBar textDidChange:activeIngredientStr];
                               self.searchBar.userInteractionEnabled = YES;
                           }


                           );
        }
    };

    objectsModel.searchPropertyName = @"drugName";

    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    objectsModel.allowAddingItems = NO;
    objectsModel.allowDeletingItems = NO;
    objectsModel.allowEditDetailView = YES;
    objectsModel.allowMovingItems = YES;
    objectsModel.allowRowSelection = YES;

    SCCoreDataFetchOptions *dataFetchOptions = [[SCCoreDataFetchOptions alloc]initWithSortKey:@"drugName" sortAscending:YES filterPredicate:nil];

    objectsModel.autoAssignDelegateForDetailModels = YES;
    objectsModel.dataStore.storeMode = SCStoreModeAsynchronous;

    objectsModel.dataFetchOptions = dataFetchOptions;

    objectsModel.autoAssignDelegateForDetailModels = YES;

    self.tableViewModel = objectsModel;
    [self.tableViewModel reloadBoundValues];
    self.searchBar.delegate = self;

    if (isInDetailSubview)
    {
        objectsModel.allowMovingItems = YES;
    }

    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    UIColor *backgroundColor = nil;
    if (isInDetailSubview)
    {
        backgroundColor = (UIColor *)(UIWindow *)appDelegate.window.backgroundColor;
    }
    else
    {
        backgroundColor = [UIColor clearColor];
    }

    if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
    {
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:backgroundColor]; // Make the table view transparent
    }

    self.view.backgroundColor = backgroundColor;

    CGFloat localDbBytes = (CGFloat)[self getLocalDrugFileSize];
    UINavigationItem *navigationItem = (UINavigationItem *)self.navigationItem;

    navigationItem.title = [NSString stringWithFormat:@"Drugs %0.1f MB", localDbBytes / 1048576];

    if ([SCUtilities systemVersion] > 7)
    {
        NSString *imageNameStr = nil;
        if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
        {
            imageNameStr = @"ipad-menubar-full.png";
        }
        else
        {
            imageNameStr = @"menubar.png";
        }

        UIImage *menueBarImage = [UIImage imageNamed:imageNameStr];
        [self.searchBar setBackgroundImage:menueBarImage];
        [self.searchBar setScopeBarBackgroundImage:menueBarImage];
    }
    productFetchRequest = nil;
    sortDescriptor = nil;
    sortDescriptors = nil;
}


- (void) viewButtonTapped
{
    SCArrayOfObjectsSection *section = (SCArrayOfObjectsSection *)[objectsModel sectionAtIndex:0];
    section.allowEditDetailView = YES;
    section.allowRowSelection = YES;
    [section dispatchEventSelectRowAtIndexPath:[objectsModel indexPathForCell:objectsModel.activeCell]];
}


- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}


- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}


- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length > 2)
    {
        objectsModel.enablePullToRefresh = NO;
        objectsModel.tableView.userInteractionEnabled = NO;

        if (objectsModel )
        {
            NSFetchRequest *newRequewst = [[NSFetchRequest alloc]init];

            filterPredicate = [NSPredicate predicateWithFormat:@"drugName contains [cd] %@ OR activeIngredient contains [cd] %@",searchText,searchText];

            [newRequewst setPredicate:filterPredicate];

            [newRequewst setEntity:productEntityDesc];
            NSError *productError = nil;
            NSArray *productFetchedObjects = [NSArray array];
            if (!drugsManagedObjectContext)
            {
                PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

                drugsManagedObjectContext = [appDelegate drugsManagedObjectContext];
            }

            if ([drugsManagedObjectContext countForFetchRequest:newRequewst error:&productError])
            {
                productFetchedObjects = [drugsManagedObjectContext executeFetchRequest:newRequewst error:&productError];
            }

            NSMutableArray *productFetchedObjectsMutableArray = nil;
            if (productFetchedObjects && productFetchedObjects.count)
            {
                productFetchedObjectsMutableArray = [NSMutableArray arrayWithArray:productFetchedObjects];
            }

            [objectsModel removeAllSections];

            SCMemoryStore *memoryStore = [SCMemoryStore storeWithObjectsArray:productFetchedObjectsMutableArray defaultDefiniton:drugDef];

            [objectsModel setDataStore:memoryStore];

            [objectsModel reloadBoundValues];
            //
            //
            [objectsModel.modeledTableView reloadData];
            newRequewst = nil;
            objectsModel.enablePullToRefresh = YES;
            objectsModel.tableView.userInteractionEnabled = YES;
        }

        objectsModel.enablePullToRefresh = YES;
        objectsModel.tableView.userInteractionEnabled = YES;
    }
    else if (searchText == nil || searchText.length == 0)
    {
        SCMemoryStore *memoryStore = [SCMemoryStore storeWithObjectsArray:nil defaultDefiniton:drugDef];

        [objectsModel setDataStore:memoryStore];
        [objectsModel removeAllSections];
        [objectsModel reloadBoundValues];
        [objectsModel.modeledTableView reloadData];
    }
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations

    return YES;
}


- (IBAction) startCheckingForUpdate:(id)sender
{
    self.downloadLabel.text = @"Checking";

    if (!self.connectingToFile)
    {
        downloadLabel_.alpha = 1.0;
        checkingTimer_ = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                          target:self
                                                        selector:@selector(flashCheckingLabel:)
                                                        userInfo:NULL
                                                         repeats:YES];

        [self connectToRemoteDrugFile];
    }
}


- (void) myCancelButtonTapped
{
    if (self.navigationController)
    {
        // check if self is the rootViewController
        if ([self.navigationController.viewControllers objectAtIndex:0] == self)
        {
            [self dismissModalViewControllerAnimated:YES];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [self dismissModalViewControllerAnimated:YES];
    }
}


- (void) myDoneButtonTapped
{
    if (isInDetailSubview)
    {
        SCTableViewSection *section = (SCTableViewSection *)[self.tableViewModel sectionAtIndex:0];

        if ([section isKindOfClass:[SCObjectSelectionSection class]])
        {
            SCObjectSelectionSection *objectsSelectionSection = (SCObjectSelectionSection *)section;

            if (objectsSelectionSection.cellCount > 0)
            {
                if (currentlySelectedDrug)
                {
                    drugObjectSelectionCell_.drugProduct = currentlySelectedDrug;
                    [drugObjectSelectionCell_ doneButtonTappedInDetailView:currentlySelectedDrug withValue:TRUE];
                }
            }
        }

        [self myCancelButtonTapped];
    }
}


- (IBAction) flashCheckingLabel:(id)sender
{
    if (self.downloadLabel.alpha == (CGFloat)1.0)
    {
        [self fadeCheckingLabel];
        NSInteger downloadLabelLength = downloadLabel_.text.length;

        if (downloadLabelLength > 7 && downloadLabelLength < 12)
        {
            downloadLabel_.text = [downloadLabel_.text stringByAppendingString:@"."];
        }
        else
        {
            if (downloadLabelLength != 8)
            {
                self.downloadLabel.text = @"Checking";
            }
        }
    }
    else
    {
        [self checkingLabelToNormalState];
    }
}


- (void) fadeCheckingLabel
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    self.downloadLabel.alpha = (CGFloat)0.4;
    [UIView commitAnimations];
}


- (void) checkingLabelToNormalState
{
    if (self.downloadLabel.alpha != (CGFloat)1.0)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.5];
        self.downloadLabel.alpha = (CGFloat)1.0;
        [UIView commitAnimations];
    }
}


- (NSDate *) getTheLastModifiedDateLocal
{
    NSDate *lastModifiedDate;

    /* default date if file doesn't exist (not an error) */

    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    NSURL *drugFileURL = [appDelegate applicationDrugsFileURL];

    if ([[NSFileManager defaultManager] fileExistsAtPath:drugFileURL.path])
    {
        /* retrieve file attributes */
        NSError *error = nil;

        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:drugFileURL.path error:&error];

        if (attributes != nil)
        {
            lastModifiedDate = [attributes fileModificationDate];
        }
        else
        {
            error = [NSError errorWithDomain:@"Error Getting Drug File Size" code:1 userInfo:nil];
        }
    }

    return lastModifiedDate;
}


/* get modification date of the current cached image */

- (CGFloat) getLocalDrugFileSize
{
    /* default date if file doesn't exist (not an error) */

    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    NSURL *drugFileURL = [appDelegate applicationDrugsFileURL];

    CGFloat drugFileSize = 0;
    if ([[NSFileManager defaultManager] fileExistsAtPath:drugFileURL.path])
    {
        /* retrieve file attributes */
        NSError *error = nil;

        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:drugFileURL.path error:&error];

        if (attributes != nil)
        {
            drugFileSize = [attributes fileSize];
        }
        else
        {
            error = [NSError errorWithDomain:@"Error Getting Drug File Size" code:1 userInfo:nil];
        }
    }

    return drugFileSize;
}


- (AmazonS3Client *) getAWSConnection
{
    if (!credentials)
    {
        credentials = [[AmazonCredentials alloc] initWithAccessKey:ACCESS_KEY_ID withSecretKey:SECRET_KEY];
    }

    if (!awsConnection)
    {
        awsConnection = [[AmazonS3Client alloc] initWithCredentials:credentials];
    }

    return awsConnection;
}


- (S3GetObjectRequest *) getObjectRequest
{
    if (!objectRequest)
    {
        objectRequest = [[S3GetObjectRequest alloc] initWithKey:keyName withBucket:bucketName];
        objectRequest.endpoint = @"https://s3.amazonaws.com";
        [objectRequest setDelegate:self];
    }

    return objectRequest;
}


- (BOOL) isConcurrent
{
    return YES;
}


- (BOOL) isExecuting
{
    return isExecuting;
}


- (BOOL) isFinished
{
    return isFinished;
}


#pragma mark - AmazonServiceRequestDelegate Implementations

- (void) request:(AmazonServiceRequest *)request didCompleteWithResponse:(AmazonServiceResponse *)response
{
    operationFinished = YES;
    //NSLog(@"Connection did finish loading...%@",localFilename);

    [self finish];
}


- (void) request:(AmazonServiceRequest *)request didFailWithError:(NSError *)error
{
    self.downloadCheckButton.enabled = YES;
    downloadCheckButton_.hidden = NO;
    downloadButton_.hidden = YES;
    downloadStopButton_.hidden = YES;
    downloadContinueButton_.hidden = YES;
    [checkingTimer_ invalidate];
    checkingTimer_ = nil;
    downloadLabel_.text = @"Not Available";
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:20.0];
    self.downloadLabel.alpha = (CGFloat)0;
    [UIView commitAnimations];
    connectionToDrugFile = nil;
    drugFileRequest = nil;
    self.connectingToFile = NO;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    operationFailed = YES;

    [self finish];
}


- (void) request:(AmazonServiceRequest *)request didFailWithServiceException:(NSException *)exception
{
    DLog(@"logging exception%@", exception);

    [self finish];
}


#pragma mark - Helper Methods

- (void) finish
{
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];

    isExecuting = NO;
    isFinished = YES;

    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}


- (S3GetObjectMetadataResponse *) getObjectMetadata
{
    [self willChangeValueForKey:@"isExecuting"];
    isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];

    /********************************************/

    awsConnection = [self getAWSConnection];
    S3GetObjectMetadataResponse *getMetadataResponse = nil;
    if (awsConnection )
    {
        S3GetObjectMetadataRequest *getMetadataRequest = [[S3GetObjectMetadataRequest alloc] initWithKey:kRemoteFileName withBucket:kBucketName];

        NSArray *objectsInBucket = [awsConnection listObjectsInBucket:kBucketName];
        BOOL objExistsInBucket = NO;
        for (id obj in objectsInBucket)
        {
            if ([obj isKindOfClass:[S3ObjectSummary class]])
            {
                S3ObjectSummary *objSummary = (S3ObjectSummary *)obj;

                NSString *objectStr = (NSString *)objSummary.key;

                if (objectStr && kRemoteFileName && [objectStr isEqualToString:kRemoteFileName])
                {
                    objExistsInBucket = YES;
                    break;
                }
            }
        }

        if (objExistsInBucket)
        {
            getMetadataResponse = [awsConnection getObjectMetadata:getMetadataRequest];
        }
    }

    return getMetadataResponse;
}


- (void) connectToRemoteDrugFile
{
    self.connectingToFile = YES;
    // Create a URL Request and set the URL

    // Display the network activity indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    // Perform the request on a new thread so we don't block the UI
    dispatch_queue_t downloadQueue = dispatch_queue_create("Download queue", NULL);
    dispatch_async(downloadQueue, ^{
                       S3GetObjectMetadataResponse *rsp = [self getObjectMetadata];

                       // Once a response is received, handle it on the main thread in case we do any UI updates
                       dispatch_async(dispatch_get_main_queue(), ^{
                                          // Hide the network activity indicator
                                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                                          if ( rsp.body == nil || (rsp.error != nil && [rsp.error code] != noErr) )
                                          {
                                              // If there was a no data received, or an error...
                                              self.downloadLabel.text = @"Not Reachable";
                                              [checkingTimer_ invalidate];
                                              checkingTimer_ = nil;
                                              self.connectingToFile = NO;
                                              [self checkingLabelToNormalState];
                                          }
                                          else
                                          {
                                              self.downloadCheckButton.enabled = YES;

                                              [checkingTimer_ invalidate];
                                              checkingTimer_ = nil;

                                              NSFileManager *fileManager = [[NSFileManager alloc]init];

                                              PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

                                              NSString *savedDrugHeaderPlist = [[appDelegate applicationDrugsDirectory].path stringByAppendingPathComponent:@"drugFileHeaderData.plist" ];
                                              BOOL plistDictionaryExists = [fileManager fileExistsAtPath:savedDrugHeaderPlist];

                                              NSString *savedETag = nil;
                                              NSDictionary *drugDataDataPlistRootDic = nil;

                                              if (plistDictionaryExists)
                                              {
                                                  drugDataDataPlistRootDic = [[NSDictionary alloc] initWithContentsOfFile:savedDrugHeaderPlist];
                                                  if ([drugDataDataPlistRootDic objectForKey:@"eTag"])
                                                  {
                                                      savedETag = [drugDataDataPlistRootDic valueForKey:@"eTag"];
                                                  }
                                              }

                                              remoteFileETag = rsp.etag;

                                              [self fadeCheckingLabel];
                                              [self checkingLabelToNormalState];

                                              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                                              if (!savedETag || (remoteFileETag && savedETag && ![savedETag isEqualToString:remoteFileETag]) || [self getLocalDrugFileSize] < 1048576)
                                              {
                                                  downloadLabel_.text = @"Update Available.";
                                                  downloadCheckButton_.hidden = YES;
                                                  downloadButton_.hidden = NO;
                                                  downloadStopButton_.hidden = YES;
                                                  downloadContinueButton_.hidden = YES;
                                              }
                                              else
                                              {
                                                  downloadLabel_.text = @"Current Version";
                                                  downloadCheckButton_.hidden = NO;
                                                  downloadButton_.hidden = YES;
                                                  downloadStopButton_.hidden = YES;
                                                  downloadContinueButton_.hidden = YES;
                                                  [UIView beginAnimations:nil context:nil];
                                                  [UIView setAnimationDuration:20.0];
                                                  self.downloadLabel.alpha = (CGFloat)0;
                                                  [UIView commitAnimations];
                                              }

                                              [checkingTimer_ invalidate];

                                              connectionToDrugFile = nil;
                                              drugFileRequest = nil;

                                              self.connectingToFile = NO;
                                              [self checkingLabelToNormalState];
                                              // Do whatever else you want with the data...
                                          }
                                      }


                                      );
                   }


                   );
}


- (IBAction) downloadButtonTapped:(id)sender
{
    downloadLabel_.text = @"0\%";

    if (!self.downloadBar)
    {
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        CGRect frame;

        if ([SCUtilities is_iPad])
        {
            frame = CGRectMake(0, 12, 400, 30);
        }
        else
        {
            frame = CGRectMake(0, 12, 115, 20);
        }

//        NSURL *drugsDirectory=(NSURL*)[appDelegate applicationDrugsDirectory];
//            self.downloadBar = [[UIDownloadBar alloc] initWithURL:[NSURL URLWithString:@"http://psycheweb.com/psytrack/dFiles/dFile-001.zpk"] saveToFolderPath:[appDelegate applicationDrugsPathString] progressBarFrame:frame
//                                         timeout:15
//                                        delegate:self];

        objectsModel.enablePullToRefresh = NO;
        objectsModel.tableView.userInteractionEnabled = NO;
        self.searchBar.userInteractionEnabled = NO;

        self.connectingToFile = YES;
        // Create a URL Request and set the URL

        // Display the network activity indicator
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

        // Perform the request on a new thread so we don't block the UI
        dispatch_queue_t downloadQueue = dispatch_queue_create("Download queue", NULL);
        dispatch_async(downloadQueue, ^{
                           S3GetObjectMetadataResponse *rsp = [self getObjectMetadata];

                           // Once a response is received, handle it on the main thread in case we do any UI updates
                           dispatch_async(dispatch_get_main_queue(), ^{
                                              // Hide the network activity indicator
                                              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                                              if ( rsp.body == nil || (rsp.error != nil && [rsp.error code] != noErr) )
                                              {
                                                  // If there was a no data received, or an error...
                                                  self.downloadLabel.text = @"Not Reachable";
                                                  [checkingTimer_ invalidate];
                                                  checkingTimer_ = nil;
                                                  self.connectingToFile = NO;
                                                  [self checkingLabelToNormalState];
                                              }
                                              else
                                              {
                                                  self.downloadBar = [[UIDownloadBar alloc] initWithSaveToFolderPath:[appDelegate applicationDrugsPathString] progressBarFrame:frame
                                                                                                             timeout:15
                                                                                                            delegate:self bucketNameGiven:(NSString *)kBucketName remoteFileName:(NSString *)kRemoteFileName ];

                                                  [self.view addSubview:self.downloadBar];
                                                  [self.view setNeedsDisplay];
                                                  [self.downloadBar start];
                                                  downloadButton_.hidden = YES;
                                                  downloadStopButton_.hidden = NO;
                                                  downloadContinueButton_.hidden = YES;
                                                  downloadCheckButton_.hidden = YES;
                                              }
                                          }


                                          );
                       }


                       );
    }
}


- (IBAction) StopDownloadTapped:(id)sender
{
    [self.downloadBar forceStop];
    objectsModel.enablePullToRefresh = YES;
    objectsModel.tableView.userInteractionEnabled = YES;
    self.searchBar.userInteractionEnabled = YES;
    downloadButton_.hidden = YES;
    downloadStopButton_.hidden = YES;
    downloadContinueButton_.hidden = NO;
    downloadCheckButton_.hidden = YES;
    [self.view setNeedsDisplay];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (IBAction) ContinueDownloadTapped:(id)sender
{
    objectsModel.enablePullToRefresh = NO;
    objectsModel.tableView.userInteractionEnabled = NO;
    self.searchBar.userInteractionEnabled = NO;
    downloadButton_.hidden = YES;
    downloadStopButton_.hidden = NO;
    downloadContinueButton_.hidden = YES;
    downloadCheckButton_.hidden = YES;

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    [self.downloadBar forceContinue];
}


- (void) downloadBar:(UIDownloadBar *)downloadBar didFinishWithData:(NSData *)fileData suggestedFilename:(NSString *)filename
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    [appDelegate displayNotification:@"Drug Database Download Complete." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    NSURL *drugsStoreURL = [[appDelegate applicationDrugsDirectory] URLByAppendingPathComponent:@"drugs.sqlite"];

    NSString *symetricString = @"8qfnbyfalVvdjf093uPmsdj30mz98fI6";
    NSData *symetricData = [symetricString dataUsingEncoding:[NSString defaultCStringEncoding] ];

    PTTEncryption *encryption = [[PTTEncryption alloc]init];
    NSData *decryptedData = nil;

    if (symetricData.length == 32)
    {
        decryptedData = (NSData *)[encryption doCipher:fileData key:symetricData context:kCCDecrypt padding:(CCOptions *)kCCOptionECBMode];
    }

    if ( decryptedData.length)
    {
        NSPersistentStoreCoordinator *drugsPersistentStoreCoordinator = (NSPersistentStoreCoordinator *)appDelegate.drugsPersistentStoreCoordinator;

        NSPersistentStore *drugsPersistentStore = [drugsPersistentStoreCoordinator persistentStoreForURL:drugsStoreURL];

        BOOL proceedWithAddingStore = YES;
        if (drugsPersistentStore)
        {
            NSError *error = nil;
            if (![drugsPersistentStoreCoordinator removePersistentStore:drugsPersistentStore error:&error])
            {
                proceedWithAddingStore = NO;
                [appDelegate displayNotification:@"Unable to remove old drug database at this time. Try resarting the app or try again later."];
            }
        }

        BOOL fileWritten = [decryptedData writeToURL:drugsStoreURL atomically:YES];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *removeError = nil;
        if (fileWritten && proceedWithAddingStore)
        {
            NSError *excludeBackupError = nil;

            BOOL result = [drugsStoreURL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&excludeBackupError];

            if (!result)
            {
                [appDelegate displayNotification:@"Error setting file attribute"];
            }

            NSError *drugError = nil;

            if (result && ![drugsPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"DrugsConfig" URL:drugsStoreURL options:nil error:&drugError])
            {
                if ([appDelegate.managedObjectContext hasChanges])
                {
                    [appDelegate saveContext];
                }

                if (![fileManager removeItemAtURL:drugsStoreURL error:&removeError])
                {
                    [appDelegate displayNotification:[NSString stringWithFormat:@"Error Setting Up the Drug Database and removing bad file %@",removeError.description]];
                }
                else
                {
                    [appDelegate displayNotification:@"Error Setting Up the Drug Database, please restart"];
                }
            }
            else
            {
                for (NSManagedObject *managedObject in drugsManagedObjectContext.registeredObjects)
                {
                    [drugsManagedObjectContext refreshObject:managedObject mergeChanges:NO];
                }

                if (remoteFileETag)
                {
                    NSMutableDictionary *drugDataDataPlistRootDic = [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObject:remoteFileETag] forKeys:[NSArray arrayWithObject:@"eTag"]];

                    [drugDataDataPlistRootDic setValue:remoteFileETag forKey:@"eTag"];
                    NSURL *drugFileDataPlistURL=[[appDelegate applicationDrugsDirectory] URLByAppendingPathComponent:@"drugFileHeaderData.plist" ];
                    
                    [drugDataDataPlistRootDic writeToURL:drugFileDataPlistURL atomically:YES];
                    
                    [appDelegate addSkipBackupAttributeToItemAtURL:drugFileDataPlistURL];
                    
                    
                }
            }
        }
        else
        {
            if (![fileManager removeItemAtURL:drugsStoreURL error:&removeError])
            {
                [appDelegate displayNotification:[NSString stringWithFormat:@"Error Setting Up the Drug Database and removing bad file %@",removeError.description]];
            }
            else
            {
                [appDelegate displayNotification:@"Problem with setting up drug database occured.  Please try again later or contact suppor"];
            }
        }
    }
    else
    {
        [appDelegate displayNotification:@"Problem with setting up drug database occured.  Please try again later or contact support"];
    }

    [self searchBar:(UISearchBar *)self.searchBar textDidChange:(NSString *)self.searchBar.text];

    self.downloadCheckButton.enabled = YES;

    self.searchBar.userInteractionEnabled = YES;
    downloadButton_.hidden = YES;
    downloadStopButton_.hidden = YES;
    downloadContinueButton_.hidden = YES;
    downloadCheckButton_.hidden = NO;
    self.connectingToFile = NO;
    [self.view setNeedsDisplay];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:4.0];
    self.downloadLabel.alpha = (CGFloat)0;
    self.downloadBar.hidden = YES;

    [UIView commitAnimations];

    self.downloadBar = nil;

    encryption = nil;
}


- (void) downloadBar:(UIDownloadBar *)downloadBar didFailWithError:(NSError *)error
{
    if (downloadBar_)
    {
        downloadBar.hidden = YES;
        self.downloadBar = nil;
    }

    downloadLabel_.text = @"Download Failed.";
    downloadButton_.hidden = YES;
    downloadStopButton_.hidden = YES;
    downloadContinueButton_.hidden = YES;
    downloadCheckButton_.hidden = NO;
    self.connectingToFile = NO;
    objectsModel.enablePullToRefresh = YES;
    objectsModel.tableView.userInteractionEnabled = YES;
    self.searchBar.userInteractionEnabled = YES;
    [self.view setNeedsDisplay];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:20.0];
    self.downloadLabel.alpha = (CGFloat)0;
    [UIView commitAnimations];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void) downloadBarUpdated:(UIDownloadBar *)downloadBar
{
    UINavigationItem *navigationItem = (UINavigationItem *)self.navigationItem;

    navigationItem.title = [NSString stringWithFormat:@"Drugs %0.1f MB", downloadBar.bytesReceived / 1048576];
    downloadLabel_.text = [NSString stringWithFormat:@"%0.0f \%%", downloadBar.percentComplete];
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];

    if (tableViewModel.tag == 1 && index == 0)
    {
        if (section.cellCount < 6)
        {
            SCObjectSelectionCell *drugActionDatesCell = [SCObjectSelectionCell cellWithText:@"USFDA Documents"];
//        drugActionDatesCell.delegate=self;
            drugActionDatesCell.tag = 14;

            [section insertCell:drugActionDatesCell atIndex:5];
        }
    }

    if (section.headerTitle != nil)
    {
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];

        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.text = section.headerTitle;
        [containerView addSubview:headerLabel];

        section.headerView = containerView;
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTableViewSection *section = (SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
    if (tableViewModel.tag == 0 && [section isKindOfClass:[SCObjectSelectionSection class]])
    {
        SCTableViewCell *cell = (SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];

        currentlySelectedDrug = (DrugProductEntity *)cell.boundObject;

        SCObjectSelectionSection *selectionSection = (SCObjectSelectionSection *)section;

        [selectionSection dispatchEventSelectRowAtIndexPath:indexPath];
        return;
    }

    SCTableViewCell *cell = (SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];

    switch (cell.tag)
    {
        case 14:
        {
            self.tableView.userInteractionEnabled = FALSE;
            UITabBar *tabBar = (UITabBar *)[(PTTAppDelegate *)[UIApplication sharedApplication].delegate tabBar];
            tabBar.userInteractionEnabled = FALSE;

            SCTableViewSection *section = (SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];

            SCObjectSection *objectSection = nil;
            if ([section isKindOfClass:[SCObjectSection class]])
            {
                objectSection = (SCObjectSection *)section;
            }

            if (objectSection)
            {
                NSManagedObject *drugObject = (NSManagedObject *)objectSection.boundObject;

                [drugObject willAccessValueForKey:@"applNo"];
                drugApplNo = (NSString *)[objectSection.boundObject valueForKey:@"applNo"];
            }

            DrugActionDateViewController *drugActionDateViewController_iPhone = [[DrugActionDateViewController alloc] initWithNibName:@"DrugActionDateViewController" bundle:[NSBundle mainBundle] withApplNo:drugApplNo];

            PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

            if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
            {
                //        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;

                UIColor *backgroundColor = nil;

                if (isInDetailSubview)
                {
                    //            backgroundImage=[UIImage imageNamed:@"iPad-background-blue.png"];
                    backgroundColor = (UIColor *)(UIWindow *)appDelegate.window.backgroundColor;
                }
                else
                {
                    backgroundColor = [UIColor clearColor];
                }

                if (drugActionDateViewController_iPhone.tableView.backgroundColor != backgroundColor)
                {
                    [drugActionDateViewController_iPhone.tableView setBackgroundView:nil];
                    UIView *view = [[UIView alloc]init];
                    [drugActionDateViewController_iPhone.tableView setBackgroundView:view];
                    [drugActionDateViewController_iPhone.tableView setBackgroundColor:backgroundColor];
                }
            }

            [self.navigationController pushViewController:drugActionDateViewController_iPhone animated:YES];

            tabBar.userInteractionEnabled = TRUE;
            self.tableView.userInteractionEnabled = TRUE;

            break;
        }
        case 400:
        {
            //do nothing
            break;
        }
        default:
        {
            SCTableViewSection *section = [self.tableViewModel sectionAtIndex:0];
            if ([section isKindOfClass:[SCArrayOfObjectsSection class]])
            {
                [(SCArrayOfObjectsSection *)section dispatchEventSelectRowAtIndexPath : indexPath];
            }
        }
        break;
    } /* switch */
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailViewDidDismissForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableModel.tag == 0)
    {
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        appDelegate.drugViewControllerIsInDetailSubview = NO;
    }
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    appDelegate.drugViewControllerIsInDetailSubview = YES;

    if ([SCUtilities is_iPad] || [SCUtilities systemVersion] >= 6)
    {
        UIColor *backgroundColor = nil;

        if (indexPath.row == NSNotFound || tableModel.tag > 0 || isInDetailSubview)
        {
            //            backgroundImage=[UIImage imageNamed:@"iPad-background-blue.png"];
            backgroundColor = (UIColor *)(UIWindow *)appDelegate.window.backgroundColor;
        }
        else
        {
            backgroundColor = [UIColor clearColor];
        }

        if (detailTableViewModel.modeledTableView.backgroundColor != backgroundColor)
        {
            [detailTableViewModel.modeledTableView setBackgroundView:nil];
            UIView *view = [[UIView alloc]init];
            [detailTableViewModel.modeledTableView setBackgroundView:view];
            [detailTableViewModel.modeledTableView setBackgroundColor:backgroundColor];
        }
    }
}


@end
