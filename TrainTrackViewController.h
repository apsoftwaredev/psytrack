//
//  TrainTrackViewController_iPhone.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/28/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"
#import "CliniciansViewController_Shared.h"
//#import "IASKAppSettingsViewController.h"
#import "DTAboutViewController.h"
@interface TrainTrackViewController : UIViewController <SCTableViewModelDelegate,DTAboutViewControllerDelegate/*,IASKSettingsDelegate*/> {
    
     SCArrayOfObjectsModel *tableModel_;
   UITableView *tableView;
    NSManagedObjectContext * managedObjectContext;
    CliniciansViewController_Shared *cliniciansViewController_Shared;
//    IASKAppSettingsViewController *appSettingsViewController;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) SCArrayOfObjectsModel *tableModel;
@property (strong, nonatomic) IBOutlet UIView *messageView;
@property (nonatomic, strong)CliniciansViewController_Shared *cliniciansViewController_Shared;
//@property (nonatomic, retain) IASKAppSettingsViewController *appSettingsViewController;


@end



