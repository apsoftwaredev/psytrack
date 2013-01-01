//
//  EmploymentEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity;

@interface EmploymentEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * dateStarted;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * dateEnded;
@property (nonatomic, retain) NSSet *positions;
@property (nonatomic, retain) NSSet *clinician;
@property (nonatomic, retain) NSManagedObject *employer;
@end

@interface EmploymentEntity (CoreDataGeneratedAccessors)

- (void)addPositionsObject:(NSManagedObject *)value;
- (void)removePositionsObject:(NSManagedObject *)value;
- (void)addPositions:(NSSet *)values;
- (void)removePositions:(NSSet *)values;

- (void)addClinicianObject:(ClinicianEntity *)value;
- (void)removeClinicianObject:(ClinicianEntity *)value;
- (void)addClinician:(NSSet *)values;
- (void)removeClinician:(NSSet *)values;

@end
