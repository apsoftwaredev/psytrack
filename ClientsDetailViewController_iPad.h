/*
 *  ClientsDetailViewController_iPad1.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/24/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
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