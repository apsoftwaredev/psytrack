//
//  FeeEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientEntity, ConsultationEntity, FeeTypeEntity;

@interface FeeEntity : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber *amount;
@property (nonatomic, retain) NSDate *dateCharged;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSNumber *paid;
@property (nonatomic, retain) NSString *feeName;
@property (nonatomic, retain) ClientEntity *client;
@property (nonatomic, retain) FeeTypeEntity *feeType;
@property (nonatomic, retain) ConsultationEntity *consultation;

@end
