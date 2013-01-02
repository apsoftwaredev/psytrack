//
//  ExistingHoursEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class ClinicianEntity, ExistingAssessmentEntity, ExistingInterventionEntity, ExistingSupervisionGivenEntity, ExistingSupervisionReceivedEntity, ExistingSupportActivityEntity, SiteEntity, TrainingProgramEntity;

@interface ExistingHoursEntity : PTManagedObject

@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSSet *supportActivities;
@property (nonatomic, retain) NSSet *directInterventions;
@property (nonatomic, retain) ClinicianEntity *supervisor;
@property (nonatomic, retain) NSSet *assessments;
@property (nonatomic, retain) TrainingProgramEntity *programCourse;
@property (nonatomic, retain) SiteEntity *site;
@property (nonatomic, retain) NSSet *supervisionReceived;
@property (nonatomic, retain) NSSet *supervisionGiven;
@end

@interface ExistingHoursEntity (CoreDataGeneratedAccessors)

- (void)addSupportActivitiesObject:(ExistingSupportActivityEntity *)value;
- (void)removeSupportActivitiesObject:(ExistingSupportActivityEntity *)value;
- (void)addSupportActivities:(NSSet *)values;
- (void)removeSupportActivities:(NSSet *)values;

- (void)addDirectInterventionsObject:(ExistingInterventionEntity *)value;
- (void)removeDirectInterventionsObject:(ExistingInterventionEntity *)value;
- (void)addDirectInterventions:(NSSet *)values;
- (void)removeDirectInterventions:(NSSet *)values;

- (void)addAssessmentsObject:(ExistingAssessmentEntity *)value;
- (void)removeAssessmentsObject:(ExistingAssessmentEntity *)value;
- (void)addAssessments:(NSSet *)values;
- (void)removeAssessments:(NSSet *)values;

- (void)addSupervisionReceivedObject:(ExistingSupervisionReceivedEntity *)value;
- (void)removeSupervisionReceivedObject:(ExistingSupervisionReceivedEntity *)value;
- (void)addSupervisionReceived:(NSSet *)values;
- (void)removeSupervisionReceived:(NSSet *)values;

- (void)addSupervisionGivenObject:(ExistingSupervisionGivenEntity *)value;
- (void)removeSupervisionGivenObject:(ExistingSupervisionGivenEntity *)value;
- (void)addSupervisionGiven:(NSSet *)values;
- (void)removeSupervisionGiven:(NSSet *)values;

@end
