//
//  GoverningBodyEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class CountryEntity, LicenseEntity;

@interface GoverningBodyEntity : PTManagedObject

@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) CountryEntity *country;
@property (nonatomic, retain) NSSet *licenses;
@end

@interface GoverningBodyEntity (CoreDataGeneratedAccessors)

- (void) addLicensesObject:(LicenseEntity *)value;
- (void) removeLicensesObject:(LicenseEntity *)value;
- (void) addLicenses:(NSSet *)values;
- (void) removeLicenses:(NSSet *)values;

@end
