//
//  SubstanceUseEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ClientEntity, FrequencyEntity, SubstanceNameEntity;

@interface SubstanceUseEntity : PTManagedObject

@property (nonatomic, retain) NSDate *lastUse;
@property (nonatomic, retain) NSNumber *currentTreatmentIssue;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSNumber *ageOfFirstUse;
@property (nonatomic, retain) NSNumber *historyOfDependence;
@property (nonatomic, retain) NSNumber *historyOfTreatment;
@property (nonatomic, retain) NSNumber *currentDrugOfChoice;
@property (nonatomic, retain) NSNumber *historyOfAbuse;
@property (nonatomic, retain) SubstanceNameEntity *substance;
@property (nonatomic, retain) NSSet *substanceUseLogs;
@property (nonatomic, retain) ClientEntity *client;
@property (nonatomic, retain) FrequencyEntity *frequency;
@end

@interface SubstanceUseEntity (CoreDataGeneratedAccessors)

- (void) addSubstanceUseLogsObject:(NSManagedObject *)value;
- (void) removeSubstanceUseLogsObject:(NSManagedObject *)value;
- (void) addSubstanceUseLogs:(NSSet *)values;
- (void) removeSubstanceUseLogs:(NSSet *)values;

@end
