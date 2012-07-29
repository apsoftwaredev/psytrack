//
//  LicenseEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/28/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity, LicenseRenewalEntity, LogEntity;

@interface LicenseEntity : NSManagedObject

@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * renewDate;
@property (nonatomic, retain) NSString * licenseNumber;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSManagedObject *licenseName;
@property (nonatomic, retain) NSManagedObject *governingBody;
@property (nonatomic, retain) ClinicianEntity *clinician;
@property (nonatomic, retain) NSSet *renewals;
@end

@interface LicenseEntity (CoreDataGeneratedAccessors)

- (void)addLogsObject:(LogEntity *)value;
- (void)removeLogsObject:(LogEntity *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

- (void)addRenewalsObject:(LicenseRenewalEntity *)value;
- (void)removeRenewalsObject:(LicenseRenewalEntity *)value;
- (void)addRenewals:(NSSet *)values;
- (void)removeRenewals:(NSSet *)values;

@end
