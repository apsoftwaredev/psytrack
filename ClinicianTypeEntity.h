//
//  ClinicianTypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 11/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

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
