//
//  PaymentEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 8/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PaymentEntity : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * dateCleared;
@property (nonatomic, retain) NSDate * dateReceived;
@property (nonatomic, retain) NSManagedObject *paymentType;
@property (nonatomic, retain) NSManagedObject *paymentSource;
@property (nonatomic, retain) NSManagedObject *consultation;

@end
