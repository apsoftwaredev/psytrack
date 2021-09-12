/*
 *  CliniciansViewController_Shared.h
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
