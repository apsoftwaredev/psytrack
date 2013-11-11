//
//  ExistingAssessmentEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AssessmentTypeEntity, ExistingBatteryEntity, ExistingDemographicsEntity, ExistingHoursEntity, ExistingInstrumentEntity;

@interface ExistingAssessmentEntity : NSManagedObject

@property (nonatomic, retain) NSString *monthlyLogNotes;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *hours;
@property (nonatomic, retain) NSSet *instruments;
@property (nonatomic, retain) AssessmentTypeEntity *assessmentType;
@property (nonatomic, retain) ExistingDemographicsEntity *demographics;
@property (nonatomic, retain) ExistingHoursEntity *existingHours;
@property (nonatomic, retain) NSSet *batteries;
@end

@interface ExistingAssessmentEntity (CoreDataGeneratedAccessors)

- (void) addInstrumentsObject:(ExistingInstrumentEntity *)value;
- (void) removeInstrumentsObject:(ExistingInstrumentEntity *)value;
- (void) addInstruments:(NSSet *)values;
- (void) removeInstruments:(NSSet *)values;

- (void) addBatteriesObject:(ExistingBatteryEntity *)value;
- (void) removeBatteriesObject:(ExistingBatteryEntity *)value;
- (void) addBatteries:(NSSet *)values;
- (void) removeBatteries:(NSSet *)values;

@end
