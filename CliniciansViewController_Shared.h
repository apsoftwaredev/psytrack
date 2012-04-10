/*
 *  CliniciansViewController_Shared.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/23/11.
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
#import "ABGroupSelectionCell.h"
static NSInteger const kAlertTagFoundExistingPersonWithName = 1;
static NSInteger const kAlertTagFoundExistingPeopleWithName = 2;


@interface CliniciansViewController_Shared :  UIViewController <SCTableViewModelDataSource, SCTableViewModelDelegate,SCTableViewCellDelegate,UIAlertViewDelegate, UINavigationControllerDelegate ,ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate, ABNewPersonViewControllerDelegate> {

   

NSManagedObjectContext *managedObjectContext;
 
      __weak UITableView *tableView;
    BOOL deletePressedOnce;
    SCTableViewModel *currentDetailTableViewModel_;
    UINavigationController *rootNavigationController;
    UIViewController *rootViewController_;
     int existingPersonRecordID;
//    ABRecordRef existingPersonRef;
    BOOL addExistingAfterPromptBool;
    
     SCArrayOfObjectsModel *tableModel_;
     ABPersonViewController *personVCFromSelectionList;
     ABNewPersonViewController *personAddNewViewController;
    ABPersonViewController *personViewController_;
    ABPeoplePickerNavigationController *peoplePickerNavigationController_;
    ClinicianEntity *clinician;
//      ABAddressBookRef addressBook;

    ABGroupSelectionCell *abGroupObjectSelectionCell_;
    
    UIView *iPadPersonBackgroundView_;
}


@property (strong ,nonatomic)IBOutlet SCClassDefinition *clinicianDef;


@property (strong ,nonatomic)UIView *iPadPersonBackgroundView;

@property (nonatomic, strong) IBOutlet ABPersonViewController *personVCFromSelectionList;
@property (nonatomic, strong) IBOutlet ABNewPersonViewController *personAddNewViewController;
@property (nonatomic, strong) IBOutlet ABPersonViewController *personViewController;
@property (nonatomic, strong) IBOutlet ABPeoplePickerNavigationController *peoplePickerNavigationController;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet SCArrayOfObjectsModel *tableModel;
@property (nonatomic, strong)  UIViewController *rootViewController;
@property (nonatomic, strong) IBOutlet  SCTableViewModel *currentDetailTableViewModel;
@property (nonatomic, strong)ABGroupSelectionCell *abGroupObjectSelectionCell;
//@property (strong, nonatomic)IBOutlet SCArrayOfStringsSection *objectsSection;




//-(void)showPersonViewControllerWithRecordIdentifier:(NSString *)recordIdentifier firstName:(NSString *)firstName lastName:(NSString *)lastName;

-(void)evaluateWhichABViewControllerToShow;
//-(void)showPersonViewControllerForABRecordRef:(ABRecordRef)recordRef;
//-(void)showUnknownPersonViewControllerWithABRecordRef:(ABRecordRef )recordRef;
-(void)showPeoplePickerController;
-(IBAction)cancelAddNewAddressBookPerson:(id)sender;
-(IBAction)cancelButtonTappedInABPersonViewController:(id)sender;
-(IBAction)selectButtonTappedInABPersonController:(id)sender;
//-(IBAction)doneButtonTappedInABPersonViewController:(id)sender;
-(void)resetABVariablesToNil;



-(void)showPersonViewControllerForRecordID:(int)recordID;

-(BOOL)checkIfRecordIDInAddressBook:(int)recordID;


-(void)setSectionHeaderColorWithSection:(SCTableViewSection *)section color:(UIColor *)color;


-(IBAction)abGroupsDoneButtonTapped:(id)sender;



-(int )defaultABSourceID;
-(void)changeABGroupNameTo:(NSString *)groupName  addNew:(BOOL)addNew checkExisting:(BOOL)checkExisting;
@end
