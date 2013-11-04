//
//  ExistingSupervisionEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity, SupervisionTypeEntity, SupervisionTypeSubtypeEntity;

@interface ExistingSupervisionEntity : NSManagedObject

@property (nonatomic, retain) NSDate *hours;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *monthlyLogNotes;
@property (nonatomic, retain) NSSet *supervisors;
@property (nonatomic, retain) SupervisionTypeEntity *supervisionType;
@property (nonatomic, retain) SupervisionTypeSubtypeEntity *subType;
@end

@interface ExistingSupervisionEntity (CoreDataGeneratedAccessors)

- (void) addSupervisorsObject:(ClinicianEntity *)value;
- (void) removeSupervisorsObject:(ClinicianEntity *)value;
- (void) addSupervisors:(NSSet *)values;
- (void) removeSupervisors:(NSSet *)values;

@end
