/*
 *  CliniciansViewController_Shared.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.3
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
#import "AdditionalVariableNameEntity.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ClinicianEntity.h"
#import "ABGroupSelectionCell.h"

static NSInteger const kAlertTagFoundExistingPersonWithName = 1;
static NSInteger const kAlertTagFoundExistingPeopleWithName = 2;

@interface CliniciansViewController_Shared :  SCViewController <SCTableViewModelDataSource,SCTableViewModelDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate, ABNewPersonViewControllerDelegate,UITableViewDelegate> {
    NSManagedObjectContext *managedObjectContext;

    BOOL deletePressedOnce;
    SCTableViewModel *currentDetailTableViewModel_;
    UINavigationController *rootNavigationController;
    UIViewController *rootViewController_;
    int existingPersonRecordID;
    BOOL addExistingAfterPromptBool;

    ABPersonViewController *personVCFromSelectionList;
    ABNewPersonViewController *personAddNewViewController;
    ABPersonViewController *personViewController_;
    ABPeoplePickerNavigationController *peoplePickerNavigationController_;
    ABRecordRef selectedRecordInPeoplePicker_;
    ClinicianEntity *clinician;
//    ABGroupSelectionCell *abGroupObjectSelectionCell_;

    UIView *iPadPersonBackgroundView_;
    BOOL addingClinician;
    BOOL isInDetailSubview;

    AdditionalVariableNameEntity *selectedVariableName;
}

@property (strong,nonatomic) IBOutlet SCEntityDefinition *clinicianDef;

@property (strong,nonatomic) UIView *iPadPersonBackgroundView;

@property (nonatomic, strong) IBOutlet ABPersonViewController *personVCFromSelectionList;
@property (nonatomic, strong) IBOutlet ABNewPersonViewController *personAddNewViewController;
@property (nonatomic, strong) IBOutlet ABPersonViewController *personViewController;
@property (nonatomic, strong) IBOutlet ABPeoplePickerNavigationController *peoplePickerNavigationController;

@property (nonatomic,assign) BOOL selectMyInformationOnLoad;

@property (nonatomic, strong)  UIViewController *rootViewController;

//@property (nonatomic, strong) ABGroupSelectionCell *abGroupObjectSelectionCell;

- (void) showPeoplePickerController;
- (IBAction) cancelAddNewAddressBookPerson:(id)sender;
- (IBAction) cancelButtonTappedInABPersonViewController:(id)sender;
- (IBAction) selectButtonTappedInABPersonController:(id)sender;

- (void) resetABVariablesToNil;

- (void) setSectionHeaderColorWithSection:(SCTableViewSection *)section color:(UIColor *)color;

- (int) defaultABSourceID;
- (void) changeABGroupNameTo:(NSString *)groupName addNew:(BOOL)addNew checkExisting:(BOOL)checkExisting;
@end
