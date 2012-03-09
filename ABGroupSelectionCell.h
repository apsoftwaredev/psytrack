//
//  ABGroupSelectionCell.h
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "SCTableViewCell.h"
#import <AddressBook/AddressBook.h>
#import "SCTableViewModel.h"
#import "ClinicianEntity.h"

@interface ABGroupSelectionCell : SCObjectSelectionCell {


 NSArray *abGroupsArray;

    ClinicianEntity *clinician_;
}



@property (nonatomic, strong)ClinicianEntity *clinician;


-(NSArray *)addressBookGroupsArray;
-(void)changeABGroupNameTo:(NSString *)groupName  addNew:(BOOL)addNew;


-(id)initWithClinician:(ClinicianEntity *)clinicianObject;
-(BOOL)personContainedInGroupWithID:(int)groupID;
-(void)addPersonToGroupWithID:(int)groupID;


@end
