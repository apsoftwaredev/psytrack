//
//  ReferralEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ReferralEntity.h"
#import "ClientEntity.h"
#import "ClinicianEntity.h"
#import "ConsultationEntity.h"
#import "OtherReferralSourceEntity.h"


@implementation ReferralEntity

@dynamic dateReferred;
@dynamic order;
@dynamic notes;
@dynamic referralInOrOut;
@dynamic keyString;
@dynamic client;
@dynamic consultation;
@dynamic otherSource;
@dynamic clinician;

@end
