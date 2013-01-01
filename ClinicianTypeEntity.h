//
//  ClinicianTypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class ClinicianEntity;

@interface ClinicianTypeEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * clinicianType;
@property (nonatomic, retain) NSSet *clinician;
@end

@interface ClinicianTypeEntity (CoreDataGeneratedAccessors)

- (void)addClinicianObject:(ClinicianEntity *)value;
- (void)removeClinicianObject:(ClinicianEntity *)value;
- (void)addClinician:(NSSet *)values;
- (void)removeClinician:(NSSet *)values;

@end
