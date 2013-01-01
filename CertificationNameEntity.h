//
//  CertificationNameEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class CertificationEntity;

@interface CertificationNameEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * certName;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSSet *certifications;
@end

@interface CertificationNameEntity (CoreDataGeneratedAccessors)

- (void)addCertificationsObject:(CertificationEntity *)value;
- (void)removeCertificationsObject:(CertificationEntity *)value;
- (void)addCertifications:(NSSet *)values;
- (void)removeCertifications:(NSSet *)values;

@end
