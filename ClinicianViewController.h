/*
 *  ClinicianViewController.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
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
@interface ClinicianViewController : CliniciansViewController_Shared <SCTableViewModelDataSource, SCTableViewModelDelegate,UIAlertViewDelegate, UINavigationControllerDelegate ,ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate, ABNewPersonViewControllerDelegate> {
     
 
  	__weak UISearchBar *searchBar;
  
//	 SCArrayOfObjectsModel *tableModel;
     UILabel *totalCliniciansLabel;
       

    BOOL filterByPrescriber;
    BOOL isInDetailSubview;
    ClinicianSelectionCell *clinicianObjectSelectionCell;
    UIViewController *sendingViewController;
    
    ClinicianEntity *currentlySelectedClinician;
    NSMutableArray *currentlySelectedCliniciansArray;
    NSPredicate *filterPredicate;
}

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) IBOutlet UILabel *totalCliniciansLabel;





-(void)updateClinicianTotalLabel;
-(id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle isInDetailSubView:(BOOL)detailSubview objectSelectionCell:(ClinicianSelectionCell*)objectSelectionCell sendingViewController:(UIViewController *)viewController withPredicate:(NSPredicate *)startPredicate  usePrescriber:(BOOL)usePresciberBool;

    
    
-(void)cancelButtonTapped;
    
-(void)setSelectedClinicians;
-(void)createSelectedCliniciansArray;

#define degreesToRadian(x) (M_PI * (x) / 180.0)

@end
