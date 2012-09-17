//
//  ConsultationEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LogEntity, PaymentEntity, ReferralEntity;

@interface ConsultationEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * proBono;
@property (nonatomic, retain) NSDate * hours;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSNumber * paid;
@property (nonatomic, retain) NSManagedObject *organization;
@property (nonatomic, retain) NSSet *payments;
@property (nonatomic, retain) NSSet *rateCharges;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *fees;
@property (nonatomic, retain) NSSet *referrals;
@end

@interface ConsultationEntity (CoreDataGeneratedAccessors)

- (void)addPaymentsObject:(PaymentEntity *)value;
- (void)removePaymentsObject:(PaymentEntity *)value;
- (void)addPayments:(NSSet *)values;
- (void)removePayments:(NSSet *)values;

- (void)addRateChargesObject:(NSManagedObject *)value;
- (void)removeRateChargesObject:(NSManagedObject *)value;
- (void)addRateCharges:(NSSet *)values;
- (void)removeRateCharges:(NSSet *)values;

- (void)addLogsObject:(LogEntity *)value;
- (void)removeLogsObject:(LogEntity *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

- (void)addFeesObject:(NSManagedObject *)value;
- (void)removeFeesObject:(NSManagedObject *)value;
- (void)addFees:(NSSet *)values;
- (void)removeFees:(NSSet *)values;

- (void)addReferralsObject:(ReferralEntity *)value;
- (void)removeReferralsObject:(ReferralEntity *)value;
- (void)addReferrals:(NSSet *)values;
- (void)removeReferrals:(NSSet *)values;

@end
