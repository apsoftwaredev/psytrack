//
//  RateChargeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/28/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ConsultationEntity;

@interface RateChargeEntity : NSManagedObject

@property (nonatomic, retain) NSDate * hours;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * dateCharged;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSManagedObject *rate;
@property (nonatomic, retain) ConsultationEntity *consultation;

@end
