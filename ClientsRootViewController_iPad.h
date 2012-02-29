//
//  ClientViewController_iPad.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/24/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SCTableViewModel.h"
#import "ClientsViewController_Shared.h"
#import "DemographicDetailViewController_Shared.h"

#import "ClientsSelectionCell.h"
@class ClientsDetailViewController_iPad;
@interface ClientsRootViewController_iPad : UIViewController <SCTableViewModelDataSource, SCTableViewModelDelegate> {
    
    
    
    NSManagedObjectContext *managedObjectContext;
    DemographicDetailViewController_Shared *demographicDetailViewController_Shared;
    ClientsViewController_Shared *clientsViewController_Shared;
    SCArrayOfObjectsModel *tableModel;
    
       
}


@property (nonatomic, strong) IBOutlet ClientsDetailViewController_iPad *clientsDetailViewController_iPad;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet SCArrayOfObjectsModel *tableModel;

// Method called by DetailViewController
- (void)addButtonTapped;
-(void)addWechlerAgeCellToSection:(SCTableViewSection *)section;

@end




