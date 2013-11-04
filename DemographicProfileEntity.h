//
//  DemographicProfileEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AdditionalVariableEntity, ClientEntity, ClinicianEntity, CultureGroupEntity, DisabilityEntity, EducationLevelEntity, EthnicityEntity, GenderEntity, InterpersonalEntity, LanguageSpokenEntity, MigrationHistoryEntity, MilitaryServiceEntity, RaceEntity, SpiritualBeliefEntity;

@interface DemographicProfileEntity : NSManagedObject

@property (nonatomic, retain) NSString *vision;
@property (nonatomic, retain) NSString *sex;
@property (nonatomic, retain) NSString *keyString;
@property (nonatomic, retain) NSString *hearing;
@property (nonatomic, retain) NSString *sexualOrientation;
@property (nonatomic, retain) NSString *profileNotes;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) MilitaryServiceEntity *militaryService;
@property (nonatomic, retain) MigrationHistoryEntity *migrationHistory;
@property (nonatomic, retain) EducationLevelEntity *educationLevel;
@property (nonatomic, retain) ClientEntity *client;
@property (nonatomic, retain) NSSet *disabilities;
@property (nonatomic, retain) NSSet *spiritualBeliefs;
@property (nonatomic, retain) ClinicianEntity *clinician;
@property (nonatomic, retain) NSSet *interpersonal;
@property (nonatomic, retain) GenderEntity *gender;
@property (nonatomic, retain) NSSet *languagesSpoken;
@property (nonatomic, retain) NSManagedObject *employmentStatus;
@property (nonatomic, retain) NSSet *cultureGroups;
@property (nonatomic, retain) NSSet *ethnicities;
@property (nonatomic, retain) NSSet *additionalVariables;
@property (nonatomic, retain) NSSet *developmental;
@property (nonatomic, retain) NSSet *significantLifeEvents;
@property (nonatomic, retain) NSSet *races;
@end

@interface DemographicProfileEntity (CoreDataGeneratedAccessors)

- (void) addDisabilitiesObject:(DisabilityEntity *)value;
- (void) removeDisabilitiesObject:(DisabilityEntity *)value;
- (void) addDisabilities:(NSSet *)values;
- (void) removeDisabilities:(NSSet *)values;

- (void) addSpiritualBeliefsObject:(SpiritualBeliefEntity *)value;
- (void) removeSpiritualBeliefsObject:(SpiritualBeliefEntity *)value;
- (void) addSpiritualBeliefs:(NSSet *)values;
- (void) removeSpiritualBeliefs:(NSSet *)values;

- (void) addInterpersonalObject:(InterpersonalEntity *)value;
- (void) removeInterpersonalObject:(InterpersonalEntity *)value;
- (void) addInterpersonal:(NSSet *)values;
- (void) removeInterpersonal:(NSSet *)values;

- (void) addLanguagesSpokenObject:(LanguageSpokenEntity *)value;
- (void) removeLanguagesSpokenObject:(LanguageSpokenEntity *)value;
- (void) addLanguagesSpoken:(NSSet *)values;
- (void) removeLanguagesSpoken:(NSSet *)values;

- (void) addCultureGroupsObject:(CultureGroupEntity *)value;
- (void) removeCultureGroupsObject:(CultureGroupEntity *)value;
- (void) addCultureGroups:(NSSet *)values;
- (void) removeCultureGroups:(NSSet *)values;

- (void) addEthnicitiesObject:(EthnicityEntity *)value;
- (void) removeEthnicitiesObject:(EthnicityEntity *)value;
- (void) addEthnicities:(NSSet *)values;
- (void) removeEthnicities:(NSSet *)values;

- (void) addAdditionalVariablesObject:(AdditionalVariableEntity *)value;
- (void) removeAdditionalVariablesObject:(AdditionalVariableEntity *)value;
- (void) addAdditionalVariables:(NSSet *)values;
- (void) removeAdditionalVariables:(NSSet *)values;

- (void) addDevelopmentalObject:(NSManagedObject *)value;
- (void) removeDevelopmentalObject:(NSManagedObject *)value;
- (void) addDevelopmental:(NSSet *)values;
- (void) removeDevelopmental:(NSSet *)values;

- (void) addSignificantLifeEventsObject:(NSManagedObject *)value;
- (void) removeSignificantLifeEventsObject:(NSManagedObject *)value;
- (void) addSignificantLifeEvents:(NSSet *)values;
- (void) removeSignificantLifeEvents:(NSSet *)values;

- (void) addRacesObject:(RaceEntity *)value;
- (void) removeRacesObject:(RaceEntity *)value;
- (void) addRaces:(NSSet *)values;
- (void) removeRaces:(NSSet *)values;

@end
