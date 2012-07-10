//
//  AssessmentTypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AssessmentEntity;

@interface AssessmentTypeEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * assessmentType;
@property (nonatomic, retain) NSSet *existingAssessments;
@property (nonatomic, retain) NSSet *assessments;
@end

@interface AssessmentTypeEntity (CoreDataGeneratedAccessors)

- (void)addExistingAssessmentsObject:(NSManagedObject *)value;
- (void)removeExistingAssessmentsObject:(NSManagedObject *)value;
- (void)addExistingAssessments:(NSSet *)values;
- (void)removeExistingAssessments:(NSSet *)values;

- (void)addAssessmentsObject:(AssessmentEntity *)value;
- (void)removeAssessmentsObject:(AssessmentEntity *)value;
- (void)addAssessments:(NSSet *)values;
- (void)removeAssessments:(NSSet *)values;

@end
