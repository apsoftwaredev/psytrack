//
//  CertificationNameEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class CertificationEntity;

@interface CertificationNameEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *certName;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSSet *certifications;
@end

@interface CertificationNameEntity (CoreDataGeneratedAccessors)

- (void) addCertificationsObject:(CertificationEntity *)value;
- (void) removeCertificationsObject:(CertificationEntity *)value;
- (void) addCertifications:(NSSet *)values;
- (void) removeCertifications:(NSSet *)values;

@end
