//
//  FeeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 11/22/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ConsultationEntity,FeeTypeEntity;

@interface FeeEntity : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSString * feeName;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * dateCharged;
@property (nonatomic, retain) ConsultationEntity *consultation;
@property (nonatomic, retain) FeeTypeEntity *feeType;

@end
