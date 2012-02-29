//
//  DrugViewController_iPhone.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 12/19/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"
#import "DrugViewController_Shared.h"
#import "UIDownloadBar.h"


@interface DrugViewController_iPhone : UIViewController <SCTableViewModelDelegate, SCTableViewCellDelegate,UIDownloadBarDelegate> {
    
    
  	UISearchBar *searchBar;
    UITableView *tableView;
    
	SCArrayOfObjectsModel *tableModel;
 
    DrugViewController_Shared *drugViewController_Shared;
    NSManagedObjectContext * drugsManagedObjectContext;
    UIDownloadBar *downloadBar_;
     UILabel *downloadLabel_;
     UILabel *downloadBytesLabel_;
     UIButton *downloadButton_;
    UIButton *downloadStopButton_;
     UIButton *downloadContinueButton_;
    UIButton *downloadCheckButton_;
    NSMutableArray *drugsMutableArray;
    NSTimer *checkingTimer_;
    
}

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIDownloadBar *downloadBar;
@property (nonatomic, strong) IBOutlet UILabel *downloadLabel;
@property (nonatomic, strong) IBOutlet UILabel *downloadBytesLabel;
@property (nonatomic, strong) IBOutlet UIButton *downloadButton;
@property (nonatomic, strong) IBOutlet UIButton *downloadStopButton;
@property (nonatomic,strong) IBOutlet UIButton *downloadContinueButton;
@property (nonatomic,strong) IBOutlet UIButton *downloadCheckButton;
@property (nonatomic, strong) NSTimer *checkingTimer;


-(IBAction)downloadButtonTapped:(id)sender;
-(IBAction)CancelDownloadTapped:(id)sender;
- (CGFloat ) getLocalDrugFileSize;
- (void) connectToRemoteDrugFile;
-(IBAction)startCheckingForUpdate:(id)sender;
-(IBAction)flashCheckingLabel:(id)sender;

@end
