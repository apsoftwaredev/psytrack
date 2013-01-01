//
//  ClinicianGroupEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity;

@interface ClinicianGroupEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * addressBookSync;
@property (nonatomic, retain) NSString * groupName;
@property (nonatomic, retain) NSNumber * addNewClinicians;
@property (nonatomic, retain) NSNumber * recordID;
@property (nonatomic, retain) ClinicianEntity *clinician;

@end
