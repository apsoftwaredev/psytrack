//
//  InterventionDeliveredEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "InterventionDeliveredEntity.h"
#import "ClientPresentationEntity.h"
#import "InterventionModelEntity.h"
#import "InterventionTypeEntity.h"
#import "InterventionTypeSubtypeEntity.h"
#import "SupportActivityDeliveredEntity.h"
#import "TimeEntity.h"

@implementation InterventionDeliveredEntity

@dynamic clientPresentations;
@dynamic relatedToIndirect;
@dynamic interventionType;
@dynamic modelsUsed;
@dynamic subtype;
@dynamic time;

@end
