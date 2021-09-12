/*
 *  ClientsViewController_iPhone.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 *  Created by Daniel Boice on 9/26/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "AdditionalVariableNameEntity.h"
#import <UIKit/UIKit.h>
#import "ClientsViewController_Shared.h"
#import "ClientsSelectionCell.h"
#import "ClientEntity.h"
#import "DisorderEntity.h"

@interface ClientsViewController_iPhone : SCViewController <  SCTableViewModelDataSource, SCTableViewModelDelegate, SCTableViewControllerDelegate, UIAlertViewDelegate> {
    UISearchBar *searchBar;
    UILabel *totalClientsLabel;

    NSManagedObjectContext *managedObjectContext;
    ClientsViewController_Shared *clientsViewController_Shared;
    BOOL isInDetailSubview;
    ClientsSelectionCell *clientObjectSelectionCell;
    BOOL allowMultipleSelection;
    UIViewController *sendingViewController;
    NSMutableSet *alreadySelectedClients;

    int searchStringLength;
    BOOL reloadTableView;
    SCArrayOfObjectsModel *objectsModel;
    ClientEntity *currentlySelectedClient;
    NSMutableArray *currentlySelectedClientsArray;

    DisorderEntity *selectedDisorder;

    AdditionalVariableNameEntity *selectedVariableName;
}

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UILabel *totalClientsLabel;
@property (nonatomic, strong)  ClientsViewController_Shared *clientsViewController_Shared;
@property (nonatomic, readwrite) BOOL isInDetailSubview;
@property (nonatomic,strong) IBOutlet ClientsSelectionCell *clientObjectSelectionCell;
@property (nonatomic, strong) IBOutlet UIViewController *sendingViewController;
@property (nonatomic,strong) IBOutlet NSMutableSet *alreadySelectedClients;
@property (nonatomic,strong) IBOutlet NSManagedObject *clientCurrentlySelectedInReferringDetailview;
- (void) updateClientsTotalLabel;

- (void) addWechlerAgeCellToSection:(SCTableViewSection *)section;
- (id) initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(SCObjectSelectionCell *)objectSelectionCell sendingViewController:(UIViewController *)viewController allowMultipleSelection:(BOOL)allowMultiSelect;
- (BOOL) checkStringIsNumber:(NSString *)str;
- (void) refreshData;

@end
