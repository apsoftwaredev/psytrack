//
//  ExistingDemographicsEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class ExistingAssessmentEntity, ExistingEthnicityEntity, ExistingInterventionEntity;

@interface ExistingDemographicsEntity : NSManagedObject

@property (nonatomic, retain) ExistingInterventionEntity *otherIntervention;
@property (nonatomic, retain) NSSet *individualsWithDisabilities;
@property (nonatomic, retain) NSSet *sexualOrientations;
@property (nonatomic, retain) NSSet *races;
@property (nonatomic, retain) NSSet *ageGroups;
@property (nonatomic, retain) NSSet *genders;
@property (nonatomic, retain) ExistingAssessmentEntity *existingAssessment;
@property (nonatomic, retain) NSSet *ethnicities;
@end

@interface ExistingDemographicsEntity (CoreDataGeneratedAccessors)

- (void)addIndividualsWithDisabilitiesObject:(NSManagedObject *)value;
- (void)removeIndividualsWithDisabilitiesObject:(NSManagedObject *)value;
- (void)addIndividualsWithDisabilities:(NSSet *)values;
- (void)removeIndividualsWithDisabilities:(NSSet *)values;

- (void)addSexualOrientationsObject:(NSManagedObject *)value;
- (void)removeSexualOrientationsObject:(NSManagedObject *)value;
- (void)addSexualOrientations:(NSSet *)values;
- (void)removeSexualOrientations:(NSSet *)values;

- (void)addRacesObject:(NSManagedObject *)value;
- (void)removeRacesObject:(NSManagedObject *)value;
- (void)addRaces:(NSSet *)values;
- (void)removeRaces:(NSSet *)values;

- (void)addAgeGroupsObject:(NSManagedObject *)value;
- (void)removeAgeGroupsObject:(NSManagedObject *)value;
- (void)addAgeGroups:(NSSet *)values;
- (void)removeAgeGroups:(NSSet *)values;

- (void)addGendersObject:(NSManagedObject *)value;
- (void)removeGendersObject:(NSManagedObject *)value;
- (void)addGenders:(NSSet *)values;
- (void)removeGenders:(NSSet *)values;

- (void)addEthnicitiesObject:(ExistingEthnicityEntity *)value;
- (void)removeEthnicitiesObject:(ExistingEthnicityEntity *)value;
- (void)addEthnicities:(NSSet *)values;
- (void)removeEthnicities:(NSSet *)values;

@end
