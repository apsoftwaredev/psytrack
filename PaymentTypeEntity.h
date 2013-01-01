//
//  PaymentTypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class PaymentEntity;

@interface PaymentTypeEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * paymentType;
@property (nonatomic, retain) NSSet *payments;
@end

@interface PaymentTypeEntity (CoreDataGeneratedAccessors)

- (void)addPaymentsObject:(PaymentEntity *)value;
- (void)removePaymentsObject:(PaymentEntity *)value;
- (void)addPayments:(NSSet *)values;
- (void)removePayments:(NSSet *)values;

@end
