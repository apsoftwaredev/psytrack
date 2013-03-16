//
//  LicenseRenewalEntity.h
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

@class ContinuingEducationEntity, LicenseEntity;

@interface LicenseRenewalEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *renewalDate;
@property (nonatomic, retain) LicenseEntity *license;
@property (nonatomic, retain) NSSet *continuingEducation;
@end

@interface LicenseRenewalEntity (CoreDataGeneratedAccessors)

- (void) addContinuingEducationObject:(ContinuingEducationEntity *)value;
- (void) removeContinuingEducationObject:(ContinuingEducationEntity *)value;
- (void) addContinuingEducation:(NSSet *)values;
- (void) removeContinuingEducation:(NSSet *)values;

@end
