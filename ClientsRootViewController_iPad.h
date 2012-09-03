/*
 *  ClientViewController_iPad.h
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

#import "ClientsViewController_Shared.h"
#import "DemographicDetailViewController_Shared.h"

#import "ClientsSelectionCell.h"
#import "DisorderEntity.h"
//@class ClientsDetailViewController_iPad;
@interface ClientsRootViewController_iPad : SCViewController </*SCTableViewModelDataSource */SCTableViewModelDelegate> {
    
    
    
    NSManagedObjectContext *managedObjectContext;
    DemographicDetailViewController_Shared *demographicDetailViewController_Shared;
    ClientsViewController_Shared *clientsViewController_Shared;
//    SCArrayOfObjectsModel *tableModel;
     SCArrayOfObjectsModel *objectsModel;
    
    DisorderEntity *selectedDisorder;
}


//@property (nonatomic, strong) IBOutlet ClientsDetailViewController_iPad *clientsDetailViewController_iPad;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
//@property (nonatomic, weak) IBOutlet UITableView *tableView;
//@property (nonatomic, strong) IBOutlet SCArrayOfObjectsModel *tableModel;

// Method called by DetailViewController

-(void)addWechlerAgeCellToSection:(SCTableViewSection *)section;
-(BOOL)checkStringIsNumber:(NSString *)str;
@end




