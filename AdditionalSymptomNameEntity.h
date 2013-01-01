//
//  AdditionalSymptomNameEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class AdditionalSymptomEntity, DisorderEntity;

@interface AdditionalSymptomNameEntity : NSManagedObject

@property (nonatomic, retain) NSString * symptomDescription;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * symptomName;
@property (nonatomic, retain) NSSet *additionalSypmtoms;
@property (nonatomic, retain) NSSet *possibleDisorders;
@property (nonatomic, retain) NSSet *diagnosisLog;
@end

@interface AdditionalSymptomNameEntity (CoreDataGeneratedAccessors)

- (void)addAdditionalSypmtomsObject:(AdditionalSymptomEntity *)value;
- (void)removeAdditionalSypmtomsObject:(AdditionalSymptomEntity *)value;
- (void)addAdditionalSypmtoms:(NSSet *)values;
- (void)removeAdditionalSypmtoms:(NSSet *)values;

- (void)addPossibleDisordersObject:(DisorderEntity *)value;
- (void)removePossibleDisordersObject:(DisorderEntity *)value;
- (void)addPossibleDisorders:(NSSet *)values;
- (void)removePossibleDisorders:(NSSet *)values;

- (void)addDiagnosisLogObject:(NSManagedObject *)value;
- (void)removeDiagnosisLogObject:(NSManagedObject *)value;
- (void)addDiagnosisLog:(NSSet *)values;
- (void)removeDiagnosisLog:(NSSet *)values;

@end
