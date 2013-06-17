//
//  ClinicianGroupEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ClinicianEntity;

@interface ClinicianGroupEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *addressBookSync;
@property (nonatomic, retain) NSString *groupName;
@property (nonatomic, retain) NSNumber *addNewClinicians;
@property (nonatomic, retain) NSNumber *recordID;
@property (nonatomic, retain) ClinicianEntity *clinician;

@end
