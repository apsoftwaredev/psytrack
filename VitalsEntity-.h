//
//  VitalsEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 3/24/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientEntity;

@interface VitalsEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * diastolicPressure;
@property (nonatomic, retain) NSNumber * heightTall;
@property (nonatomic, retain) NSString * heightUnit;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSString * weightUnit;
@property (nonatomic, retain) NSNumber * systolicPressure;
@property (nonatomic, retain) NSDate * dateTaken;
@property (nonatomic, retain) NSNumber * heartRate;
@property (nonatomic, retain) NSNumber * temperature;
@property (nonatomic, retain) ClientEntity *client;

@end
