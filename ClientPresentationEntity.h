//
//  ClientPresentationEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class AdditionalVariableEntity, AssessmentEntity, ClientEntity, ClientInstrumentScoresEntity, InterventionDeliveredEntity;

@interface ClientPresentationEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *paid;
@property (nonatomic, retain) NSString *psychomotor;
@property (nonatomic, retain) NSString *eyeContact;
@property (nonatomic, retain) NSString *speechLanguage;
@property (nonatomic, retain) NSNumber *depth;
@property (nonatomic, retain) NSString *perception;
@property (nonatomic, retain) NSNumber *suicidePlan;
@property (nonatomic, retain) NSString *homework;
@property (nonatomic, retain) NSNumber *suicideMeans;
@property (nonatomic, retain) NSString *psychosocial;
@property (nonatomic, retain) NSString *affect;
@property (nonatomic, retain) NSString *judgement;
@property (nonatomic, retain) NSNumber *orientedToTime;
@property (nonatomic, retain) NSString *imagery;
@property (nonatomic, retain) NSNumber *stressLevel;
@property (nonatomic, retain) NSString *attention;
@property (nonatomic, retain) NSNumber *orientedToBody;
@property (nonatomic, retain) NSString *interpersonal;
@property (nonatomic, retain) NSNumber *homicidePlan;
@property (nonatomic, retain) NSNumber *homicideIdeation;
@property (nonatomic, retain) NSString *appearance;
@property (nonatomic, retain) NSNumber *liabilityRisk;
@property (nonatomic, retain) NSString *assessment;
@property (nonatomic, retain) NSString *cultural;
@property (nonatomic, retain) NSNumber *communicativeAbility;
@property (nonatomic, retain) NSString *otherNotes;
@property (nonatomic, retain) NSString *behaviors;
@property (nonatomic, retain) NSString *plan;
@property (nonatomic, retain) NSString *intellect;
@property (nonatomic, retain) NSNumber *happinessLevel;
@property (nonatomic, retain) NSString *concentration;
@property (nonatomic, retain) NSString *sensory;
@property (nonatomic, retain) NSString *mood;
@property (nonatomic, retain) NSNumber *openness;
@property (nonatomic, retain) NSNumber *painLevel;
@property (nonatomic, retain) NSNumber *sexualSatisfaction;
@property (nonatomic, retain) NSNumber *suicideHistory;
@property (nonatomic, retain) NSNumber *alliance;
@property (nonatomic, retain) NSNumber *orientedToPlace;
@property (nonatomic, retain) NSNumber *comfortLevel;
@property (nonatomic, retain) NSString *memory;
@property (nonatomic, retain) NSString *insight;
@property (nonatomic, retain) NSNumber *progressClient;
@property (nonatomic, retain) NSString *attitude;
@property (nonatomic, retain) NSNumber *copingLevel;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSNumber *symptomSeverity;
@property (nonatomic, retain) NSNumber *energyLevel;
@property (nonatomic, retain) NSNumber *hopeLevel;
@property (nonatomic, retain) NSNumber *orientedToPerson;
@property (nonatomic, retain) NSNumber *homicideMeans;
@property (nonatomic, retain) NSNumber *homicideHistory;
@property (nonatomic, retain) NSNumber *suicideIdeation;
@property (nonatomic, retain) NSString *clientsDesc;
@property (nonatomic, retain) NSString *medical;
@property (nonatomic, retain) NSString *rapport;
@property (nonatomic, retain) NSNumber *progressClinician;
@property (nonatomic, retain) NSNumber *proBono;
@property (nonatomic, retain) NSDecimalNumber *sleepHoursNightly;
@property (nonatomic, retain) NSString *thoughtContent;
@property (nonatomic, retain) NSString *sleepQuality;
@property (nonatomic, retain) NSNumber *safetyRisk;
@property (nonatomic, retain) NSSet *additionalVariables;
@property (nonatomic, retain) NSManagedObject *hourlyRate;
@property (nonatomic, retain) NSSet *instrumentScores;
@property (nonatomic, retain) InterventionDeliveredEntity *interventionDelivered;
@property (nonatomic, retain) AssessmentEntity *testSessionDelivered;
@property (nonatomic, retain) ClientEntity *client;
@property (nonatomic, retain) NSSet *batteries;
@end

@interface ClientPresentationEntity (CoreDataGeneratedAccessors)

- (void) addAdditionalVariablesObject:(AdditionalVariableEntity *)value;
- (void) removeAdditionalVariablesObject:(AdditionalVariableEntity *)value;
- (void) addAdditionalVariables:(NSSet *)values;
- (void) removeAdditionalVariables:(NSSet *)values;

- (void) addInstrumentScoresObject:(ClientInstrumentScoresEntity *)value;
- (void) removeInstrumentScoresObject:(ClientInstrumentScoresEntity *)value;
- (void) addInstrumentScores:(NSSet *)values;
- (void) removeInstrumentScores:(NSSet *)values;

- (void) addBatteriesObject:(NSManagedObject *)value;
- (void) removeBatteriesObject:(NSManagedObject *)value;
- (void) addBatteries:(NSSet *)values;
- (void) removeBatteries:(NSSet *)values;

@end
