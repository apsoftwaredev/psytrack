//
//  CertificationEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class ClinicianEntity;

@interface CertificationEntity : NSManagedObject

@property (nonatomic, retain) NSDate * completeDate;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * updatedTimeStamp;
@property (nonatomic, retain) NSManagedObject *certifiedBy;
@property (nonatomic, retain) NSSet *clinicians;
@property (nonatomic, retain) NSManagedObject *certificationName;
@end

@interface CertificationEntity (CoreDataGeneratedAccessors)

- (void)addCliniciansObject:(ClinicianEntity *)value;
- (void)removeCliniciansObject:(ClinicianEntity *)value;
- (void)addClinicians:(NSSet *)values;
- (void)removeClinicians:(NSSet *)values;

@end
