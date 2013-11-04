//
//  DisorderEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AdditionalSymptomNameEntity, DiagnosisHistoryEntity, DisorderSpecifierEntity, DisorderSubCategoryEntity, DisorderSystemEntity;

@interface DisorderEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *disorderName;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSManagedObject *category;
@property (nonatomic, retain) DisorderSystemEntity *classificationSystem;
@property (nonatomic, retain) NSSet *symptoms;
@property (nonatomic, retain) NSSet *diagnoses;
@property (nonatomic, retain) NSSet *specifiers;
@property (nonatomic, retain) DisorderSubCategoryEntity *subCategory;
@end

@interface DisorderEntity (CoreDataGeneratedAccessors)

- (void) addSymptomsObject:(AdditionalSymptomNameEntity *)value;
- (void) removeSymptomsObject:(AdditionalSymptomNameEntity *)value;
- (void) addSymptoms:(NSSet *)values;
- (void) removeSymptoms:(NSSet *)values;

- (void) addDiagnosesObject:(DiagnosisHistoryEntity *)value;
- (void) removeDiagnosesObject:(DiagnosisHistoryEntity *)value;
- (void) addDiagnoses:(NSSet *)values;
- (void) removeDiagnoses:(NSSet *)values;

- (void) addSpecifiersObject:(DisorderSpecifierEntity *)value;
- (void) removeSpecifiersObject:(DisorderSpecifierEntity *)value;
- (void) addSpecifiers:(NSSet *)values;
- (void) removeSpecifiers:(NSSet *)values;

@end
