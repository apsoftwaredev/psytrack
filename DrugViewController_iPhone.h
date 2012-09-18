/*
 *  DrugViewController_iPhone.h
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
#import <UIKit/UIKit.h>

#import "DrugViewController_Shared.h"
#import "UIDownloadBar.h"
#import "DrugNameObjectSelectionCell.h"
#import "DrugProductEntity.h"
@interface DrugViewController_iPhone : SCViewController <SCTableViewModelDataSource, SCTableViewModelDelegate, UIDownloadBarDelegate,UISearchBarDelegate > {
    
    SCArrayOfObjectsModel *objectsModel;
    
  	__weak UISearchBar *searchBar;
//    UITableView *tableView;
    
//	SCArrayOfObjectsModel *tableModel;
    NSString *drugApplNo;
    NSString *drugProductNo;
    BOOL isInDetailSubview;
    DrugNameObjectSelectionCell *drugObjectSelectionCell_;
    UIViewController *sendingViewController;
  
    NSManagedObject *drugCurrentlySelectedInReferringDetailview;
    
    
    DrugViewController_Shared *drugViewController_Shared;
    NSManagedObjectContext * drugsManagedObjectContext;
    UIDownloadBar *downloadBar_;
    __weak UILabel *downloadLabel_;
    __weak UILabel *downloadBytesLabel_;
    __weak UIButton *downloadButton_;
    __weak UIButton *downloadStopButton_;
    __weak UIButton *downloadContinueButton_;
    __weak UIButton *downloadCheckButton_;
    NSMutableArray *drugsMutableArray;
    NSTimer *checkingTimer_;
    
    DrugProductEntity *currentlySelectedDrug;
    SCEntityDefinition *drugDef;
    
    
    NSEntityDescription *productEntityDesc;    
   
    NSFetchRequest *productFetchRequest;
    NSPredicate *filterPredicate;
    
        
    
}
//@property (nonatomic, strong)  SCArrayOfObjectsModel *tableModel;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
//@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIDownloadBar *downloadBar;
@property (nonatomic, weak) IBOutlet UILabel *downloadLabel;
@property (nonatomic, weak) IBOutlet UILabel *downloadBytesLabel;
@property (nonatomic, weak) IBOutlet UIButton *downloadButton;
@property (nonatomic, weak) IBOutlet UIButton *downloadStopButton;
@property (nonatomic,weak) IBOutlet UIButton *downloadContinueButton;
@property (nonatomic,weak) IBOutlet UIButton *downloadCheckButton;
@property (nonatomic, strong) NSTimer *checkingTimer;


@property (nonatomic, strong) DrugNameObjectSelectionCell *drugObjectSelectionCell;

-(IBAction)downloadButtonTapped:(id)sender;
//-(IBAction)CancelDownloadTapped:(id)sender;
- (CGFloat ) getLocalDrugFileSize;
- (void) connectToRemoteDrugFile;
-(IBAction)startCheckingForUpdate:(id)sender;
-(IBAction)flashCheckingLabel:(id)sender;
-(IBAction)StopDownloadTapped:(id)sender;
-(IBAction)ContinueDownloadTapped:(id)sender;
-(id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(DrugNameObjectSelectionCell*)objectSelectionCell sendingViewController:(UIViewController *)viewController applNo:(NSString *)applicationNumber productNo:(NSString *)productNumber;
-(void)myDoneButtonTapped;
-(void)myCancelButtonTapped;
@end

