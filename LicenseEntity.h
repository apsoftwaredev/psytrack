//
//  LicenseEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ClinicianEntity, LogEntity;

@interface LicenseEntity : PTManagedObject

@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *renewDate;
@property (nonatomic, retain) NSString *licenseNumber;
@property (nonatomic, retain) NSManagedObject *governingBody;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSManagedObject *licenseName;
@property (nonatomic, retain) NSSet *renewals;
@property (nonatomic, retain) ClinicianEntity *clinician;
@end

@interface LicenseEntity (CoreDataGeneratedAccessors)

- (void) addLogsObject:(LogEntity *)value;
- (void) removeLogsObject:(LogEntity *)value;
- (void) addLogs:(NSSet *)values;
- (void) removeLogs:(NSSet *)values;

- (void) addRenewalsObject:(NSManagedObject *)value;
- (void) removeRenewalsObject:(NSManagedObject *)value;
- (void) addRenewals:(NSSet *)values;
- (void) removeRenewals:(NSSet *)values;

@end
