//
//  AssessmentTypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class AssessmentEntity, ExistingAssessmentEntity;

@interface AssessmentTypeEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * assessmentType;
@property (nonatomic, retain) NSSet *existingAssessments;
@property (nonatomic, retain) NSSet *assessments;
@end

@interface AssessmentTypeEntity (CoreDataGeneratedAccessors)

- (void)addExistingAssessmentsObject:(ExistingAssessmentEntity *)value;
- (void)removeExistingAssessmentsObject:(ExistingAssessmentEntity *)value;
- (void)addExistingAssessments:(NSSet *)values;
- (void)removeExistingAssessments:(NSSet *)values;

- (void)addAssessmentsObject:(AssessmentEntity *)value;
- (void)removeAssessmentsObject:(AssessmentEntity *)value;
- (void)addAssessments:(NSSet *)values;
- (void)removeAssessments:(NSSet *)values;

@end
