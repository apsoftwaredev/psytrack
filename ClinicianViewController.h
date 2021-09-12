/*
 *  ClinicianViewController.h
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
 *  Created by Daniel Boice on 6/19/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ClinicianEntity.h"
#import "CliniciansViewController_Shared.h"
#import "ClinicianSelectionCell.h"
@interface ClinicianViewController : CliniciansViewController_Shared <SCTableViewModelDataSource, SCTableViewModelDelegate,SCViewControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate,ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate, ABNewPersonViewControllerDelegate> {
    UISearchBar *searchBar;

    SCArrayOfObjectsModel *objectsModel;
    UILabel *totalCliniciansLabel;

    BOOL filterByPrescriber;
    BOOL allowMultipleSelection;
    ClinicianSelectionCell *clinicianObjectSelectionCell;
    UIViewController *sendingViewController;

    ClinicianEntity *currentlySelectedClinician;
    NSMutableArray *currentlySelectedCliniciansArray;
    NSPredicate *filterPredicate;
}

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) IBOutlet UILabel *totalCliniciansLabel;

- (void) updateClinicianTotalLabel;
- (id) initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(ClinicianSelectionCell *)objectSelectionCell sendingViewController:(UIViewController *)viewController withPredicate:(NSPredicate *)startPredicate usePrescriber:(BOOL)usePresciberBool allowMultipleSelection:(BOOL)allowMultiSelect;

- (void) selectMyInformation;
- (void) setSelectedClinicians;
- (void) createSelectedCliniciansArray;

#define degreesToRadian(x) (M_PI * (x) / 180.0)

@end
