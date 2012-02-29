//
//  RootViewController.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


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
   

    ABRecordRef existingPersonRef;
    BOOL addExistingAfterPromptBool;
  
     ABPersonViewController *personVCFromSelectionList;
     ABNewPersonViewController *personAddNewViewController;
    ClinicianEntity *clinician;
      ABAddressBookRef addressBook;
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
-(void)showPersonViewControllerForABRecordRef:(ABRecordRef)recordRef;
//-(void)showUnknownPersonViewControllerWithABRecordRef:(ABRecordRef )recordRef;
-(void)showPeoplePickerController;
-(IBAction)cancelAddNewAddressBookPerson:(id)sender;
-(IBAction)cancelButtonTappedInABPersonViewController:(id)sender;
-(IBAction)selectButtonTappedInABPersonController:(id)sender;
//-(IBAction)doneButtonTappedInABPersonViewController:(id)sender;
-(void)resetABVariablesToNil;





#define degreesToRadian(x) (M_PI * (x) / 180.0)

@end
