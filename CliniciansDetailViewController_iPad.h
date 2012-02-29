//
//  CliniciansDetailViewController_iPad.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/9/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class CliniciansRootViewController_iPad;

@interface CliniciansDetailViewController_iPad : UITableViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, SCTableViewModelDelegate> {
    
    CliniciansRootViewController_iPad *cliniciansRootViewController_iPad;
    UIPopoverController *popoverController;
    UITableView *tableView;
	UIBarButtonItem *addButtonItem;

}

@property (nonatomic,strong) IBOutlet CliniciansRootViewController_iPad *cliniciansRootViewController_iPad;

@property (nonatomic, strong) UIBarButtonItem *addButtonItem;

@end