/*
 *  ClinicianRootViewController_iPad.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/9/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */



#import "ClinicianViewController.h"

#import "CliniciansViewController_Shared.h"



#define addSmNr 338

@class CliniciansDetailViewController_iPad;
@interface CliniciansRootViewController_iPad : ClinicianViewController <SCTableViewModelDataSource, SCTableViewModelDelegate , UINavigationControllerDelegate ,ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate, ABNewPersonViewControllerDelegate,UITableViewDelegate > {

    

    SCTableViewCell *currentTableViewCell;
    

    BOOL addingClinician;
    
    
  //    ABAddressBookRef addressBook;
 
}


@property (nonatomic, strong) IBOutlet CliniciansDetailViewController_iPad *cliniciansDetailViewController_iPad;










// Method called by DetailViewController
- (void)addButtonTapped;


//-(void)showPersonViewControllerWithRecordIdentifier:(NSString *)recordIdentifier firstName:(NSString *)firstName lastName:(NSString *)lastName;


@end


