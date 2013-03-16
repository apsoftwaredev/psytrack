//
//  DiagnosisLogEntity.h
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

@class AdditionalSymptomNameEntity, DiagnosisHistoryEntity;

@interface DiagnosisLogEntity : PTManagedObject

@property (nonatomic, retain) NSString *frequency;
@property (nonatomic, retain) NSDate *onset;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *prognosis;
@property (nonatomic, retain) NSDate *logDate;
@property (nonatomic, retain) NSNumber *severity;
@property (nonatomic, retain) NSSet *symptoms;
@property (nonatomic, retain) DiagnosisHistoryEntity *diagnosisHistory;
@end

@interface DiagnosisLogEntity (CoreDataGeneratedAccessors)

- (void) addSymptomsObject:(AdditionalSymptomNameEntity *)value;
- (void) removeSymptomsObject:(AdditionalSymptomNameEntity *)value;
- (void) addSymptoms:(NSSet *)values;
- (void) removeSymptoms:(NSSet *)values;

@end
