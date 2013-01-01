//
//  GrantEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity, LogEntity, OtherReferralSourceEntity;

@interface GrantEntity : NSManagedObject

@property (nonatomic, retain) NSDate * submissionDeadline;
@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * grantTitle;
@property (nonatomic, retain) NSString * impact;
@property (nonatomic, retain) NSDate * dateAwarded;
@property (nonatomic, retain) NSDate * dateSubmitted;
@property (nonatomic, retain) NSNumber * awarded;
@property (nonatomic, retain) NSSet *otherSources;
@property (nonatomic, retain) NSManagedObject *setting;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *otherClinicians;
@end

@interface GrantEntity (CoreDataGeneratedAccessors)

- (void)addOtherSourcesObject:(OtherReferralSourceEntity *)value;
- (void)removeOtherSourcesObject:(OtherReferralSourceEntity *)value;
- (void)addOtherSources:(NSSet *)values;
- (void)removeOtherSources:(NSSet *)values;

- (void)addLogsObject:(LogEntity *)value;
- (void)removeLogsObject:(LogEntity *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

- (void)addOtherCliniciansObject:(ClinicianEntity *)value;
- (void)removeOtherCliniciansObject:(ClinicianEntity *)value;
- (void)addOtherClinicians:(NSSet *)values;
- (void)removeOtherClinicians:(NSSet *)values;

@end
