//
//  RateChargeEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ConsultationEntity, RateEntity;

@interface RateChargeEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *hours;
@property (nonatomic, retain) NSNumber *paid;
@property (nonatomic, retain) NSDate *dateCharged;
@property (nonatomic, retain) ConsultationEntity *consultation;
@property (nonatomic, retain) RateEntity *rate;

@end
