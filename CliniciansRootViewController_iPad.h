//
//  ClinicianRootViewController_iPad.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/9/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//


#import <CoreData/CoreData.h>
#import "SCTableViewModel.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ClinicianEntity.h"


#import "CliniciansViewController_Shared.h"

#define addSmNr 338

@class CliniciansDetailViewController_iPad;
@interface CliniciansRootViewController_iPad : UIViewController <SCTableViewModelDataSource, SCTableViewModelDelegate , UINavigationControllerDelegate ,ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate, ABNewPersonViewControllerDelegate,UITableViewDelegate> {

    

    NSManagedObjectContext *managedObjectContext;
     CliniciansViewController_Shared *cliniciansViewController_Shared;

     SCArrayOfObjectsModel *tableModel;
    BOOL deletePressedOnce;
     SCTableViewModel *currentDetailTableViewModel;
    
    
    ABRecordRef existingPersonRef;
    BOOL addExistingAfterPromptBool;
    
    ABPersonViewController *personVCFromSelectionList;
     ABNewPersonViewController *personAddNewViewController;
    ClinicianEntity *clinician;
    ABAddressBookRef addressBook;
 
}


@property (nonatomic, strong) IBOutlet CliniciansDetailViewController_iPad *cliniciansDetailViewController_iPad;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet SCArrayOfObjectsModel *tableModel;
@property (nonatomic, strong) CliniciansViewController_Shared *cliniciansViewController_Shared;
@property (nonatomic, strong) IBOutlet ABPersonViewController *personVCFromSelectionList;
@property (nonatomic, strong) IBOutlet ABNewPersonViewController *personAddNewViewController;


@property (nonatomic, strong) IBOutlet  SCTableViewModel *currentDetailTableViewModel;


// Method called by DetailViewController
- (void)addButtonTapped;


//-(void)showPersonViewControllerWithRecordIdentifier:(NSString *)recordIdentifier firstName:(NSString *)firstName lastName:(NSString *)lastName;


-(void)evaluateWhichABViewControllerToShow;
-(void)showPersonViewControllerForABRecordRef:(ABRecordRef)recordRef;
//-(void)showUnknownPersonViewControllerWithABRecordRef:(ABRecordRef )recordRef;
-(void)showPeoplePickerController;
-(IBAction)cancelAddNewAddressBookPerson:(id)sender;
-(IBAction)cancelButtonTappedInABPersonViewController:(id)sender;
-(IBAction)selectButtonTappedInABPersonController:(id)sender;
//-(IBAction)doneButtonTappedInABPersonViewController:(id)sender;
-(void)resetABVariablesToNil;





@end


