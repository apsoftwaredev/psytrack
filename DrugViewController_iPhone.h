/*
 *  DrugViewController_iPhone.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 *  Created by Daniel Boice on  12/19/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <UIKit/UIKit.h>

#import "DrugViewController_Shared.h"
#import "UIDownloadBar.h"
#import "DrugNameObjectSelectionCell.h"
#import "DrugProductEntity.h"
#import <AWSRuntime/AWSRuntime.h>
#import <AWSRuntime/AmazonServiceRequest.h>

@interface DrugViewController_iPhone : SCViewController <SCTableViewModelDataSource, SCTableViewModelDelegate, UIDownloadBarDelegate,UISearchBarDelegate,AmazonServiceRequestDelegate> {
    SCArrayOfObjectsModel *objectsModel;

    UISearchBar *searchBar;

    NSString *drugApplNo;
    NSString *drugProductNo;
    BOOL isInDetailSubview;
    DrugNameObjectSelectionCell *drugObjectSelectionCell_;
    UIViewController *sendingViewController;

    NSManagedObject *drugCurrentlySelectedInReferringDetailview;

    DrugViewController_Shared *drugViewController_Shared;
    NSManagedObjectContext *drugsManagedObjectContext;
    UIDownloadBar *downloadBar_;
    UILabel *downloadLabel_;
    UILabel *downloadBytesLabel_;
    UIButton *downloadButton_;
    UIButton *downloadStopButton_;
    UIButton *downloadContinueButton_;
    UIButton *downloadCheckButton_;
    NSMutableArray *drugsMutableArray;
    NSTimer *checkingTimer_;

    DrugProductEntity *currentlySelectedDrug;
    SCEntityDefinition *drugDef;

    NSEntityDescription *productEntityDesc;

    NSFetchRequest *productFetchRequest;
    NSPredicate *filterPredicate;

    NSURLRequest *drugFileRequest;
    NSURLConnection *connectionToDrugFile;

    NSString *remoteFileETag;

    BOOL isExecuting;
    BOOL isFinished;
    BOOL operationFinished, operationFailed, operationBreaked;
    NSString *bucketName;
    NSString *keyName;
    S3GetObjectRequest *objectRequest;

    AmazonS3Client *awsConnection;
    AmazonCredentials *credentials;
}

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) IBOutlet UIDownloadBar *downloadBar;
@property (nonatomic, strong) IBOutlet UILabel *downloadLabel;
@property (nonatomic, strong) IBOutlet UILabel *downloadBytesLabel;
@property (nonatomic, strong) IBOutlet UIButton *downloadButton;
@property (nonatomic, strong) IBOutlet UIButton *downloadStopButton;
@property (nonatomic,strong) IBOutlet UIButton *downloadContinueButton;
@property (nonatomic,strong) IBOutlet UIButton *downloadCheckButton;
@property (nonatomic, strong) NSTimer *checkingTimer;
@property (nonatomic, assign) BOOL connectingToFile;

@property (nonatomic, strong) DrugNameObjectSelectionCell *drugObjectSelectionCell;

- (IBAction) downloadButtonTapped:(id)sender;

- (CGFloat) getLocalDrugFileSize;
- (void) connectToRemoteDrugFile;
- (IBAction) startCheckingForUpdate:(id)sender;
- (IBAction) flashCheckingLabel:(id)sender;
- (IBAction) StopDownloadTapped:(id)sender;
- (IBAction) ContinueDownloadTapped:(id)sender;
- (id) initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(DrugNameObjectSelectionCell *)objectSelectionCell sendingViewController:(UIViewController *)viewController applNo:(NSString *)applicationNumber productNo:(NSString *)productNumber;
- (void) myDoneButtonTapped;
- (void) myCancelButtonTapped;
@end
