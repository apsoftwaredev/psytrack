//
//  ClientsViewController_iPhone.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/26/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"
#import "ClientsViewController_Shared.h"
#import "ClientsSelectionCell.h"
#import "ClientEntity.h"

@interface ClientsViewController_iPhone : UIViewController <  SCTableViewModelDataSource, SCTableViewModelDelegate,SCTableViewCellDelegate, SCTableViewControllerDelegate, UIAlertViewDelegate> {
    
//    UISearchDisplayController *searchDisplayController;
  	 UISearchBar *searchBar;
    UITableView *tableView;
	 SCArrayOfObjectsModel *tableModel;
     UILabel *totalClientsLabel;

    NSManagedObjectContext *managedObjectContext;
    ClientsViewController_Shared *clientsViewController_Shared;
    BOOL isInDetailSubview;
     ClientsSelectionCell *clientObjectSelectionCell;
     UIViewController *sendingViewController;
     NSMutableSet *alreadySelectedClients;
     NSManagedObject *clientCurrentlySelectedInReferringDetailview;
    SCTableViewModel *medicationReviewTableViewModel;
    int searchStringLength;
    BOOL reloadTableView;
    
    ClientEntity *currentlySelectedClient;
}

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
//@property (nonatomic, strong) IBOutlet UITableView *searchResultsTableView;

//@property (nonatomic, strong)IBOutlet UISearchDisplayController *searchDisplayController;
@property (nonatomic, strong) IBOutlet UILabel *totalClientsLabel;
@property (nonatomic, strong)  SCArrayOfObjectsModel *tableModel;
@property (nonatomic, strong)  ClientsViewController_Shared *clientsViewController_Shared;
@property (nonatomic, readwrite) BOOL isInDetailSubview;
@property (nonatomic,strong) IBOutlet ClientsSelectionCell *clientObjectSelectionCell;
@property (nonatomic, strong)IBOutlet  UIViewController *sendingViewController;
@property (nonatomic,strong) IBOutlet NSMutableSet *alreadySelectedClients;
@property (nonatomic,strong) IBOutlet NSManagedObject *clientCurrentlySelectedInReferringDetailview;
-(void)updateClientsTotalLabel;

-(void)addWechlerAgeCellToSection:(SCTableViewSection *)section;
-(id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(SCObjectSelectionCell*)objectSelectionCell sendingViewController:(UIViewController *)viewController;

-(void)cancelButtonTapped;



@end

