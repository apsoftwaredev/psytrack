/*
 *  TrainTrackViewController.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/28/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"
#import "CliniciansViewController_Shared.h"
//#import "IASKAppSettingsViewController.h"
#import "DTAboutViewController.h"
@interface TrainTrackViewController : CliniciansViewController_Shared <SCTableViewModelDelegate,DTAboutViewControllerDelegate/*,IASKSettingsDelegate*/> {
    
//     SCArrayOfObjectsModel *tableModel_;
//   
//    CliniciansViewController_Shared *cliniciansViewController_Shared_;
//    IASKAppSettingsViewController *appSettingsViewController;
}

//@property (strong, nonatomic) SCArrayOfObjectsModel *tableModel;
@property (strong, nonatomic) IBOutlet UIView *messageView;
//@property (nonatomic, strong)CliniciansViewController_Shared *cliniciansViewController_Shared;
//@property (nonatomic, retain) IASKAppSettingsViewController *appSettingsViewController;
- (void)loadTableModel:(id)sender;

@end



