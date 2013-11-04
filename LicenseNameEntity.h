//
//  LicenseNameEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LicenseEntity, LicenseTypeEntity;

@interface LicenseNameEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSSet *licenses;
@property (nonatomic, retain) LicenseTypeEntity *licenseType;
@end

@interface LicenseNameEntity (CoreDataGeneratedAccessors)

- (void) addLicensesObject:(LicenseEntity *)value;
- (void) removeLicensesObject:(LicenseEntity *)value;
- (void) addLicenses:(NSSet *)values;
- (void) removeLicenses:(NSSet *)values;

@end
