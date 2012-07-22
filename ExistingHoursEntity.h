//
//  ExistingHoursEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/22/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity, ExistingAssessmentEntity, ExistingInterventionEntity, ExistingSupervisionReceivedEntity, ExistingSupportActivityEntity, SiteEntity, TrainingProgramEntity;

@interface ExistingHoursEntity : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSData * notes;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) NSSet *supportActivities;
@property (nonatomic, retain) NSSet *assessments;
@property (nonatomic, retain) ClinicianEntity *supervisor;
@property (nonatomic, retain) NSSet *directInterventions;
@property (nonatomic, retain) NSSet *supervisionReceived;
@property (nonatomic, retain) NSSet *supervisionGiven;
@property (nonatomic, retain) TrainingProgramEntity *programCourse;
@property (nonatomic, retain) SiteEntity *site;



@property (nonatomic, strong) NSString *tempNotes;

@end
@interface ExistingHoursEntity (CoreDataGeneratedAccessors)

- (void)addSupportActivitiesObject:(ExistingSupportActivityEntity *)value;
- (void)removeSupportActivitiesObject:(ExistingSupportActivityEntity *)value;
- (void)addSupportActivities:(NSSet *)values;
- (void)removeSupportActivities:(NSSet *)values;

- (void)addAssessmentsObject:(ExistingAssessmentEntity *)value;
- (void)removeAssessmentsObject:(ExistingAssessmentEntity *)value;
- (void)addAssessments:(NSSet *)values;
- (void)removeAssessments:(NSSet *)values;

- (void)addDirectInterventionsObject:(ExistingInterventionEntity *)value;
- (void)removeDirectInterventionsObject:(ExistingInterventionEntity *)value;
- (void)addDirectInterventions:(NSSet *)values;
- (void)removeDirectInterventions:(NSSet *)values;

- (void)addSupervisionReceivedObject:(ExistingSupervisionReceivedEntity *)value;
- (void)removeSupervisionReceivedObject:(ExistingSupervisionReceivedEntity *)value;
- (void)addSupervisionReceived:(NSSet *)values;
- (void)removeSupervisionReceived:(NSSet *)values;

- (void)addSupervisionGivenObject:(NSManagedObject *)value;
- (void)removeSupervisionGivenObject:(NSManagedObject *)value;
- (void)addSupervisionGiven:(NSSet *)values;
- (void)removeSupervisionGiven:(NSSet *)values;

@end
