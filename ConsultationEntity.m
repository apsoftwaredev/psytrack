//
//  ConsultationEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ConsultationEntity.h"
#import "FeeEntity.h"
#import "LogEntity.h"
#import "OrganizationEntity.h"
#import "PaymentEntity.h"
#import "ReferralEntity.h"

@implementation ConsultationEntity

@dynamic proBono;
@dynamic hours;
@dynamic endDate;
@dynamic notes;
@dynamic startDate;
@dynamic paid;
@dynamic organization;
@dynamic payments;
@dynamic rateCharges;
@dynamic logs;
@dynamic fees;
@dynamic referrals;

@end
