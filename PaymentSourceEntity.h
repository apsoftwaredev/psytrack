//
//  PaymentSourceEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PaymentEntity;

@interface PaymentSourceEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) NSSet *payments;
@end

@interface PaymentSourceEntity (CoreDataGeneratedAccessors)

- (void) addPaymentsObject:(PaymentEntity *)value;
- (void) removePaymentsObject:(PaymentEntity *)value;
- (void) addPayments:(NSSet *)values;
- (void) removePayments:(NSSet *)values;

@end
