//
//  SupportActivityClientEntity.h
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

@class ClientEntity, SupportActivityDeliveredEntity;

@interface SupportActivityClientEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *proBono;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *paid;
@property (nonatomic, retain) NSManagedObject *hourlyRate;
@property (nonatomic, retain) ClientEntity *client;
@property (nonatomic, retain) SupportActivityDeliveredEntity *supportActivityDelivered;

@end
