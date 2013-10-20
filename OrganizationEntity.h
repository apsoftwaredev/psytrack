//
//  OrganizationEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ConferenceEntity, ConsultationEntity, ExpertTestemonyEntity, LeadershipRoleEntity;

@interface OrganizationEntity : PTManagedObject

@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *size;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSSet *expertTestemony;
@property (nonatomic, retain) NSSet *conferences;
@property (nonatomic, retain) NSSet *leadershipRoles;
@property (nonatomic, retain) NSSet *consultations;
@end

@interface OrganizationEntity (CoreDataGeneratedAccessors)

- (void) addExpertTestemonyObject:(ExpertTestemonyEntity *)value;
- (void) removeExpertTestemonyObject:(ExpertTestemonyEntity *)value;
- (void) addExpertTestemony:(NSSet *)values;
- (void) removeExpertTestemony:(NSSet *)values;

- (void) addConferencesObject:(ConferenceEntity *)value;
- (void) removeConferencesObject:(ConferenceEntity *)value;
- (void) addConferences:(NSSet *)values;
- (void) removeConferences:(NSSet *)values;

- (void) addLeadershipRolesObject:(LeadershipRoleEntity *)value;
- (void) removeLeadershipRolesObject:(LeadershipRoleEntity *)value;
- (void) addLeadershipRoles:(NSSet *)values;
- (void) removeLeadershipRoles:(NSSet *)values;

- (void) addConsultationsObject:(ConsultationEntity *)value;
- (void) removeConsultationsObject:(ConsultationEntity *)value;
- (void) addConsultations:(NSSet *)values;
- (void) removeConsultations:(NSSet *)values;

@end
