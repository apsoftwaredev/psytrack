//
//  ClientBatteryNotesEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class BatteryEntity, ClientPresentationEntity;

@interface ClientBatteryNotesEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *countAsTrainingBattery;
@property (nonatomic, retain) ClientPresentationEntity *clientPresentations;
@property (nonatomic, retain) BatteryEntity *battery;

@end
