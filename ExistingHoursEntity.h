//
//  ExistingHoursEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity, ExistingInterventionEntity;

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


@property (nonatomic, strong) NSString *tempNotes;


@end

@interface ExistingHoursEntity (CoreDataGeneratedAccessors)

- (void)addSupportActivitiesObject:(NSManagedObject *)value;
- (void)removeSupportActivitiesObject:(NSManagedObject *)value;
- (void)addSupportActivities:(NSSet *)values;
- (void)removeSupportActivities:(NSSet *)values;

- (void)addAssessmentsObject:(NSManagedObject *)value;
- (void)removeAssessmentsObject:(NSManagedObject *)value;
- (void)addAssessments:(NSSet *)values;
- (void)removeAssessments:(NSSet *)values;

- (void)addDirectInterventionsObject:(ExistingInterventionEntity *)value;
- (void)removeDirectInterventionsObject:(ExistingInterventionEntity *)value;
- (void)addDirectInterventions:(NSSet *)values;
- (void)removeDirectInterventions:(NSSet *)values;

- (void)addSupervisionReceivedObject:(NSManagedObject *)value;
- (void)removeSupervisionReceivedObject:(NSManagedObject *)value;
- (void)addSupervisionReceived:(NSSet *)values;
- (void)removeSupervisionReceived:(NSSet *)values;

- (void)addSupervisionGivenObject:(NSManagedObject *)value;
- (void)removeSupervisionGivenObject:(NSManagedObject *)value;
- (void)addSupervisionGiven:(NSSet *)values;
- (void)removeSupervisionGiven:(NSSet *)values;

@end
