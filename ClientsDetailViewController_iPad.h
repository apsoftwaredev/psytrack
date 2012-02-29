//
//  ClientsDetailViewController_iPad1.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/24/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class ClientsRootViewController_iPad;

@interface ClientsDetailViewController_iPad : UITableViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, SCTableViewModelDelegate> {
    
	ClientsRootViewController_iPad *clientsRootViewController_iPad;
    UIPopoverController *popoverController;
    UITableView *tableView;
	UIBarButtonItem *addButtonItem;
    
}

@property (nonatomic,strong) IBOutlet ClientsRootViewController_iPad *clientsRootViewController_iPad;

@property (nonatomic, strong) UIBarButtonItem *addButtonItem;

@end