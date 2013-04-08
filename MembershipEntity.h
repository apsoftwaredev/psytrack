//
//  MembershipEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.1
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ClinicianEntity;

@interface MembershipEntity : PTManagedObject

@property (nonatomic, retain) NSDate *memberSince;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSDate *renewDate;
@property (nonatomic, retain) NSManagedObject *organization;
@property (nonatomic, retain) NSSet *clinician;
@end

@interface MembershipEntity (CoreDataGeneratedAccessors)

- (void) addClinicianObject:(ClinicianEntity *)value;
- (void) removeClinicianObject:(ClinicianEntity *)value;
- (void) addClinician:(NSSet *)values;
- (void) removeClinician:(NSSet *)values;

@end
