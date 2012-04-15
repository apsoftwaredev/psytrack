/*
 *  ABGroupSelectionCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 3/7/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <UIKit/UIKit.h>

#import <AddressBook/AddressBook.h>

#import "ClinicianEntity.h"

@interface ABGroupSelectionCell : SCObjectSelectionCell {


 NSArray *abGroupsArray;

    ClinicianEntity *clinician_;
    BOOL synchWithABBeforeLoadBool_;
}



@property (nonatomic, strong)ClinicianEntity *clinician;
@property (nonatomic, assign)BOOL synchWithABBeforeLoadBool;

-(NSArray *)addressBookGroupsArray;
-(void)changeABGroupNameTo:(NSString *)groupName  addNew:(BOOL)addNew checkExisting:(BOOL)checkExisting;


-(id)initWithClinician:(ClinicianEntity *)clinicianObject;
-(BOOL)personContainedInGroupWithID:(int)groupID;
-(void)addPersonToGroupWithID:(int)groupID;
-(void)removePersonFromGroupWithID:(int)groupID;
-(void)syncryonizeWithAddressBookGroups;
-(void)addPersonToSelectedGroups;
-(int )defaultABSourceID;
@end
