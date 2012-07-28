//
//  ConsultationEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/28/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LogEntity, ReferralEntity;

@interface ConsultationEntity : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * hours;
@property (nonatomic, retain) NSNumber * proBono;
@property (nonatomic, retain) NSNumber * paid;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSManagedObject *organization;
@property (nonatomic, retain) NSSet *referrals;
@property (nonatomic, retain) NSManagedObject *rate;
@property (nonatomic, retain) NSSet *fees;
@end

@interface ConsultationEntity (CoreDataGeneratedAccessors)

- (void)addLogsObject:(LogEntity *)value;
- (void)removeLogsObject:(LogEntity *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

- (void)addReferralsObject:(ReferralEntity *)value;
- (void)removeReferralsObject:(ReferralEntity *)value;
- (void)addReferrals:(NSSet *)values;
- (void)removeReferrals:(NSSet *)values;

- (void)addFeesObject:(NSManagedObject *)value;
- (void)removeFeesObject:(NSManagedObject *)value;
- (void)addFees:(NSSet *)values;
- (void)removeFees:(NSSet *)values;

@end
