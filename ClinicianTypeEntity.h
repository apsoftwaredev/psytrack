//
//  ClinicianTypeEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ClinicianEntity;

@interface ClinicianTypeEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *clinicianType;
@property (nonatomic, retain) NSSet *clinician;
@end

@interface ClinicianTypeEntity (CoreDataGeneratedAccessors)

- (void) addClinicianObject:(ClinicianEntity *)value;
- (void) removeClinicianObject:(ClinicianEntity *)value;
- (void) addClinician:(NSSet *)values;
- (void) removeClinician:(NSSet *)values;

@end
