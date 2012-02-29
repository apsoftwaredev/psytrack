//
//  CliniciansViewController_Shared.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/23/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//


#import "SCTableViewModel.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ClinicianEntity.h"

static NSInteger const kAlertTagFoundExistingPersonWithName = 1;
static NSInteger const kAlertTagFoundExistingPeopleWithName = 2;


@interface CliniciansViewController_Shared : NSObject < SCTableViewModelDataSource, SCTableViewModelDelegate , UINavigationControllerDelegate ,ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate, ABNewPersonViewControllerDelegate> {

   

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


@property (strong ,nonatomic)IBOutlet SCClassDefinition *clinicianDef;
@property (nonatomic, strong) IBOutlet ABPersonViewController *personVCFromSelectionList;
@property (nonatomic, strong) IBOutlet ABNewPersonViewController *personAddNewViewController;


@property (nonatomic, strong) IBOutlet  SCTableViewModel *currentDetailTableViewModel;

//@property (strong, nonatomic)IBOutlet SCArrayOfStringsSection *objectsSection;


-(id)setupTheCliniciansViewUsingSTV;

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
