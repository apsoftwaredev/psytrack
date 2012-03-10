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
#import "SCTableViewModel.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ClinicianEntity.h"


@interface ClinicianViewController : UIViewController <SCTableViewModelDataSource, SCTableViewModelDelegate,SCTableViewCellDelegate,UIAlertViewDelegate, UINavigationControllerDelegate ,ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate, ABNewPersonViewControllerDelegate> {
     
 
  	__weak UISearchBar *searchBar;
    __weak UITableView *tableView;
	 SCArrayOfObjectsModel *tableModel;
     UILabel *totalCliniciansLabel;
    NSManagedObjectContext *managedObjectContext;
    

    BOOL deletePressedOnce;
    SCTableViewModel *currentDetailTableViewModel;
   

//    ABRecordRef existingPersonRef;
    BOOL addExistingAfterPromptBool;
    int existingPersonRecordID;
  
     ABPersonViewController *personVCFromSelectionList;
     ABNewPersonViewController *personAddNewViewController;
    ClinicianEntity *clinician;
//      ABAddressBookRef addressBook;
}

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UILabel *totalCliniciansLabel;
@property (nonatomic, strong) IBOutlet SCArrayOfObjectsModel *tableModel;
@property (nonatomic, strong) IBOutlet ABPersonViewController *personVCFromSelectionList;
@property (nonatomic, strong) IBOutlet ABNewPersonViewController *personAddNewViewController;


@property (nonatomic, strong) IBOutlet  SCTableViewModel *currentDetailTableViewModel;

-(void)updateClinicianTotalLabel;

-(void)evaluateWhichABViewControllerToShow;
//-(void)showPersonViewControllerForABRecordRef:(ABRecordRef)recordRef;
//-(void)showUnknownPersonViewControllerWithABRecordRef:(ABRecordRef )recordRef;
-(void)showPeoplePickerController;
-(IBAction)cancelAddNewAddressBookPerson:(id)sender;
-(IBAction)cancelButtonTappedInABPersonViewController:(id)sender;
-(IBAction)selectButtonTappedInABPersonController:(id)sender;
//-(IBAction)doneButtonTappedInABPersonViewController:(id)sender;
-(void)resetABVariablesToNil;

-(void)changeABGroupNameTo:(NSString *)groupName  addNew:(BOOL)addNew;

-(void)showPersonViewControllerForRecordID:(int)recordID;
-(BOOL)checkIfRecordIDInAddressBook:(int)recordID;


-(void)setSectionHeaderColorWithSection:(SCTableViewSection *)section color:(UIColor *)color;


#define degreesToRadian(x) (M_PI * (x) / 180.0)

@end
