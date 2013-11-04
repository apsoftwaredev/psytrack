//
//  LicenseTypeEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface LicenseTypeEntity : NSManagedObject

@property (nonatomic, retain) NSString *licenseType;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSSet *licenseName;
@end

@interface LicenseTypeEntity (CoreDataGeneratedAccessors)

- (void) addLicenseNameObject:(NSManagedObject *)value;
- (void) removeLicenseNameObject:(NSManagedObject *)value;
- (void) addLicenseName:(NSSet *)values;
- (void) removeLicenseName:(NSSet *)values;

@end
