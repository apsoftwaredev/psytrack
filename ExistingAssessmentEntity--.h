//
//  ExistingAssessmentEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/11/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AssessmentTypeEntity, ExistingHoursEntity;

@interface ExistingAssessmentEntity : NSManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * hours;
@property (nonatomic, retain) NSSet *instruments;
@property (nonatomic, retain) AssessmentTypeEntity *assessmentType;
@property (nonatomic, retain) NSManagedObject *demographics;
@property (nonatomic, retain) ExistingHoursEntity *existingHours;
@property (nonatomic, retain) NSSet *batteries;
@property (nonatomic, retain )NSString *monthlyLogNotes;
@end

@interface ExistingAssessmentEntity (CoreDataGeneratedAccessors)

- (void)addInstrumentsObject:(NSManagedObject *)value;
- (void)removeInstrumentsObject:(NSManagedObject *)value;
- (void)addInstruments:(NSSet *)values;
- (void)removeInstruments:(NSSet *)values;

- (void)addBatteriesObject:(NSManagedObject *)value;
- (void)removeBatteriesObject:(NSManagedObject *)value;
- (void)addBatteries:(NSSet *)values;
- (void)removeBatteries:(NSSet *)values;

@end
