//
//  PaymentEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "PaymentEntity.h"
#import "ClientEntity.h"
#import "ConsultationEntity.h"

@implementation PaymentEntity

@dynamic amount;
@dynamic order;
@dynamic notes;
@dynamic dateCleared;
@dynamic dateReceived;
@dynamic client;
@dynamic paymentType;
@dynamic paymentSource;
@dynamic consultation;

@end
