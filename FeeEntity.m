//
//  FeeEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.1
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "FeeEntity.h"
#import "ClientEntity.h"
#import "ConsultationEntity.h"
#import "FeeTypeEntity.h"

@implementation FeeEntity

@dynamic amount;
@dynamic dateCharged;
@dynamic order;
@dynamic paid;
@dynamic feeName;
@dynamic client;
@dynamic feeType;
@dynamic consultation;

@end
