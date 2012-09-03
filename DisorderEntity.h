//
//  DisorderEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/3/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DiagnosisHistoryEntity;

@interface DisorderEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * disorderName;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSManagedObject *category;
@property (nonatomic, retain) NSManagedObject *classificationSystem;
@property (nonatomic, retain) NSSet *symptoms;
@property (nonatomic, retain) NSSet *diagnoses;
@property (nonatomic, retain) NSManagedObject *subCategory;
@property (nonatomic, retain) NSSet *specifiers;
@end

@interface DisorderEntity (CoreDataGeneratedAccessors)

- (void)addSymptomsObject:(NSManagedObject *)value;
- (void)removeSymptomsObject:(NSManagedObject *)value;
- (void)addSymptoms:(NSSet *)values;
- (void)removeSymptoms:(NSSet *)values;

- (void)addDiagnosesObject:(DiagnosisHistoryEntity *)value;
- (void)removeDiagnosesObject:(DiagnosisHistoryEntity *)value;
- (void)addDiagnoses:(NSSet *)values;
- (void)removeDiagnoses:(NSSet *)values;

- (void)addSpecifiersObject:(NSManagedObject *)value;
- (void)removeSpecifiersObject:(NSManagedObject *)value;
- (void)addSpecifiers:(NSSet *)values;
- (void)removeSpecifiers:(NSSet *)values;

@end
