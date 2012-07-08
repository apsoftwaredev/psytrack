//
//  ExistingHoursEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/8/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ExistingHoursEntity : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSData * notes;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) NSSet *supportActivities;
@property (nonatomic, retain) NSSet *assessments;
@property (nonatomic, retain) NSManagedObject *supervisionGiven;
@property (nonatomic, retain) NSSet *directInterventions;
@property (nonatomic, retain) NSManagedObject *supervisionReceived;

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

- (void)addDirectInterventionsObject:(NSManagedObject *)value;
- (void)removeDirectInterventionsObject:(NSManagedObject *)value;
- (void)addDirectInterventions:(NSSet *)values;
- (void)removeDirectInterventions:(NSSet *)values;

@end
